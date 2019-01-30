Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA21FC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D6820833
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548843559;
	bh=vRx06fUlConj2xK/3BjttDMmHNSAQBWU8KS/doGHuc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qYVAHnxrT3xzEemrllspQPXt0fzqoW+Y+MP8QBXpLPjiikzGtXKMPApPpxpQsOw8M
	 kdwbAzzlKfKTLGvRCq/pCD1fd6Wa0jSwwKE8LQzzAizLw5wJsQdpOLnj/d47wPOIqZ
	 j30u9BHXwaM3yB9XhXxX8leEUMi8cWA9YW13BPZc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730103AbfA3KTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 05:19:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:39878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbfA3KTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 05:19:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 632A420833;
        Wed, 30 Jan 2019 10:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548843556;
        bh=vRx06fUlConj2xK/3BjttDMmHNSAQBWU8KS/doGHuc4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IrpH1aTECYaK4fmQAh8NWZof1VcBOgtfp14ar3PuVp8mGMSG64K04XOP3a72/1Cka
         eJcTgXZKWq7itrJ+SnDE/KiyA1Fem0m2BvBE0PqozFppwH0B4J/WKhB0f2w9lI0bNQ
         4Dmloc+t9isiPsvJ1tXdKyFD7HguSkmwAlPq+W0c=
Date:   Wed, 30 Jan 2019 11:19:14 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Li RongQing <lirongqing@baidu.com>
Cc:     jslaby@suse.com, linux-kernel@vger.kernel.org,
        gkohli@codeaurora.org
Subject: Re: [PATCH][v4] tty: fix race between flush_to_ldisc and tty_open
Message-ID: <20190130101914.GA30587@kroah.com>
References: <1547803637-29135-1-git-send-email-lirongqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547803637-29135-1-git-send-email-lirongqing@baidu.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 05:27:17PM +0800, Li RongQing wrote:
> There still is a race window after the commit b027e2298bd588
> ("tty: fix data race between tty_init_dev and flush of buf"),
> and we encountered this crash issue if receive_buf call comes
> before tty initialization completes in n_tty_open and
> tty->driver_data may be NULL.
> 
> CPU0                                    CPU1
> ----                                    ----
>                                  n_tty_open
>                                    tty_init_dev
>                                      tty_ldisc_unlock
>                                        schedule
> flush_to_ldisc
>  receive_buf
>   tty_port_default_receive_buf
>    tty_ldisc_receive_buf
>     n_tty_receive_buf_common
>       __receive_buf
>        uart_flush_chars
>         uart_start
>         /*tty->driver_data is NULL*/
>                                    tty->ops->open
>                                    /*init tty->driver_data*/
> 
> it can be fixed by extending ldisc semaphore lock in tty_init_dev
> to driver_data initialized completely after tty->ops->open(), but
> this will lead to put lock on one function and unlock in some other
> function, and hard to maintain, so fix this race only by checking
> tty->driver_data when receiving, and return if tty->driver_data
> is NULL
> 
> Signed-off-by: Wang Li <wangli39@baidu.com>
> Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
> V4: add version information
> V3: not used ldisc semaphore lock, only checking tty->driver_data with NULL
> V2: fix building error by EXPORT_SYMBOL tty_ldisc_unlock
> V1: extend ldisc lock to protect that tty->driver_data is inited 
> 
> drivers/tty/tty_port.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
> index 044c3cbdcfa4..86d0bec38322 100644
> --- a/drivers/tty/tty_port.c
> +++ b/drivers/tty/tty_port.c
> @@ -31,6 +31,9 @@ static int tty_port_default_receive_buf(struct tty_port *port,
>  	if (!tty)
>  		return 0;
>  
> +	if (!tty->driver_data)
> +		return 0;
> +

How is this working?  What is setting driver_data to NULL to "stop" this
race?

There's no requirement that a tty driver set this field to NULL when it
is "done" with the tty device, so I think you are just getting lucky in
that your specific driver happens to be doing this.

What driver are you testing this against?

thanks,

greg k-h
