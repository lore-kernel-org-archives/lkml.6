Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365E6C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 08:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 059EA2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 08:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfBZI4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 03:56:34 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:42177 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfBZI4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 03:56:33 -0500
Received: from marcel-macpro.fritz.box (p4FF9F361.dip0.t-ipconnect.de [79.249.243.97])
        by mail.holtmann.org (Postfix) with ESMTPSA id 3D358CF2A3;
        Tue, 26 Feb 2019 10:04:27 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] Bluetooth: hci_ldisc: Postpone HCI_UART_PROTO_READY bit
 set in hci_uart_set_proto()
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190223043327.45424-1-wangkefeng.wang@huawei.com>
Date:   Tue, 26 Feb 2019 09:56:31 +0100
Cc:     "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jeremy Cline <jcline@redhat.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        syzbot+899a33dc0fa0dbaf06a6@syzkaller.appspotmail.com
Content-Transfer-Encoding: 7bit
Message-Id: <D6AEF0F1-FAFF-44A1-B6B4-E037EABA1D61@holtmann.org>
References: <20190223043327.45424-1-wangkefeng.wang@huawei.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kefeng,

> task A:                                task B:
> hci_uart_set_proto                     flush_to_ldisc
> - p->open(hu) -> h5_open  //alloc h5  - receive_buf
> - set_bit HCI_UART_PROTO_READY         - tty_port_default_receive_buf
> - hci_uart_register_dev                 - tty_ldisc_receive_buf
>                                          - hci_uart_tty_receive
> 				           - test_bit HCI_UART_PROTO_READY
> 				            - h5_recv
> - clear_bit HCI_UART_PROTO_READY             while() {
> - p->open(hu) -> h5_close //free h5
> 				              - h5_rx_3wire_hdr
> 				               - h5_reset()  //use-after-free
>                                              }
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
> drivers/bluetooth/hci_ldisc.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

