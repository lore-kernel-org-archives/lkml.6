Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BF4C4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 01:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 075E32085B
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 01:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbfBXBMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 20:12:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60122 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728044AbfBXBMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 20:12:31 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 157383097033;
        Sun, 24 Feb 2019 01:12:31 +0000 (UTC)
Received: from laptop.jcline.org (ovpn-120-84.rdu2.redhat.com [10.10.120.84])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 39BAA1DB;
        Sun, 24 Feb 2019 01:12:30 +0000 (UTC)
Received: from laptop.jcline.org (localhost [IPv6:::1])
        by laptop.jcline.org (Postfix) with ESMTPS id 3BD5C7045B3B;
        Sat, 23 Feb 2019 20:12:29 -0500 (EST)
Date:   Sat, 23 Feb 2019 20:12:28 -0500
From:   Jeremy Cline <jcline@redhat.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        syzbot+899a33dc0fa0dbaf06a6@syzkaller.appspotmail.com
Subject: Re: [PATCH] Bluetooth: hci_ldisc: Postpone HCI_UART_PROTO_READY bit
 set in hci_uart_set_proto()
Message-ID: <20190224011228.GB32385@laptop.jcline.org>
References: <20190223043327.45424-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190223043327.45424-1-wangkefeng.wang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Sun, 24 Feb 2019 01:12:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 23, 2019 at 12:33:27PM +0800, Kefeng Wang wrote:
> task A:                                task B:
> hci_uart_set_proto                     flush_to_ldisc
>  - p->open(hu) -> h5_open  //alloc h5  - receive_buf
>  - set_bit HCI_UART_PROTO_READY         - tty_port_default_receive_buf
>  - hci_uart_register_dev                 - tty_ldisc_receive_buf
>                                           - hci_uart_tty_receive
> 				           - test_bit HCI_UART_PROTO_READY
> 				            - h5_recv
>  - clear_bit HCI_UART_PROTO_READY             while() {
>  - p->open(hu) -> h5_close //free h5

I think commit 32a7b4cbe93b ("Bluetooth: hci_ldisc: Initialize hci_dev
before open()") in made this worse by inadvertently changing this from

- clear_bit HCI_UART_PROTO_READY
- p->close(hu) -> h5_close //free h5

to

- p->close(hu) -> h5_close //free h5
- clear_bit HCI_UART_PROTO_READY

because the close call got moved into hci_uart_register_dev(). I guess
that made the race window sufficiently wide to be easily reproducible,
but it looks like it was present even before that commit.

> 				              - h5_rx_3wire_hdr
> 				               - h5_reset()  //use-after-free
>                                               }
> 
> It could use ioctl to set hci uart proto, but there is
> a use-after-free issue when hci_uart_register_dev() fail in
> hci_uart_set_proto(), see stack above, fix this by setting
> HCI_UART_PROTO_READY bit only when hci_uart_register_dev()
> return success.
> 
> Reported-by: syzbot+899a33dc0fa0dbaf06a6@syzkaller.appspotmail.com
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  drivers/bluetooth/hci_ldisc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
> index 4918fefc4a6f..9562e72c1ae5 100644
> --- a/drivers/bluetooth/hci_ldisc.c
> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -696,14 +696,13 @@ static int hci_uart_set_proto(struct hci_uart *hu, int id)
>  		return -EPROTONOSUPPORT;
>  
>  	hu->proto = p;
> -	set_bit(HCI_UART_PROTO_READY, &hu->flags);
>  
>  	err = hci_uart_register_dev(hu);
>  	if (err) {
> -		clear_bit(HCI_UART_PROTO_READY, &hu->flags);
>  		return err;
>  	}
>  
> +	set_bit(HCI_UART_PROTO_READY, &hu->flags);
>  	return 0;
>  }
>  
> -- 
> 2.20.1
> 

For what it's worth:

Reviewed-by: Jeremy Cline <jcline@redhat.com>
