Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B980C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D2F8218DA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548932133;
	bh=daEJmqzCPi2B5RpDdN2XBf3HLO4Bjp7et4ARW9cajKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Gj3PHnwcMsFnfiyMPpnQUvJqd3gM17Bae1G6mwOxWG57QIrj0c1f1u9PNXnAlyDZJ
	 JHzi0Ta1USHdgjYRIzCr5n4VuvuPLb/EEjrkzoy1QF87WxU458wE9hUGDMozGMebqg
	 XrMpQ6sxy/4HijcKCVsvs0lb/sNri9VvJPIbebdk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbfAaKzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 05:55:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:57900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbfAaKzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 05:55:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 982E920881;
        Thu, 31 Jan 2019 10:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548932130;
        bh=daEJmqzCPi2B5RpDdN2XBf3HLO4Bjp7et4ARW9cajKE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NhpJUlqm5RMoSImLy2JJYLNPPnOcwadiagBrwkLDQpAFsjfd6BrPM4THjMJJKb780
         rADmWGQ2EiA/k7z9rVX70zMWB04Wrsrg8OBUmm1ZbTK3R7eGkIRxZMrL8eFeTxktD1
         ZjK7LBVAdxKbzRviLrzJ0eTsCXmedLwIzPLP+JoI=
Date:   Thu, 31 Jan 2019 11:55:27 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Li RongQing <lirongqing@baidu.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        jslaby@suse.com, gkohli@codeaurora.org
Subject: Re: [PATCH][V5] tty: fix race between flush_to_ldisc and tty_open
Message-ID: <20190131105527.GB8271@kroah.com>
References: <1548927796-11348-1-git-send-email-lirongqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548927796-11348-1-git-send-email-lirongqing@baidu.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 05:43:16PM +0800, Li RongQing wrote:
> There still is a race window after the commit b027e2298bd588
> ("tty: fix data race between tty_init_dev and flush of buf"),
> and we encountered this crash issue if receive_buf call comes
> before tty initialization completes in tty_open and
> tty->driver_data may be NULL.
> 
> CPU0                                    CPU1
> ----                                    ----
>                                   tty_open
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
> this will lead to get lock on one function and unlock in some other
> function, and hard to maintain, so fix this race only by checking
> tty->driver_data when receiving, and return if tty->driver_data
> is NULL, and n_tty_receive_buf_common maybe calls uart_unthrottle,
> so add the same check
> 
> Signed-off-by: Wang Li <wangli39@baidu.com>
> Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
> V5: move check into uart_start from n_tty_receive_buf_common
> V4: add version information
> V3: not used ldisc semaphore lock, only checking tty->driver_data with NULL
> V2: fix building error by EXPORT_SYMBOL tty_ldisc_unlock
> V1: extend ldisc lock to protect that tty->driver_data is inited
> 
>  drivers/tty/serial/serial_core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 5c01bb6d1c24..556f50aa1b58 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -130,6 +130,9 @@ static void uart_start(struct tty_struct *tty)
>  	struct uart_port *port;
>  	unsigned long flags;
>  
> +	if (!state)
> +		return;
> +
>  	port = uart_port_lock(state, flags);
>  	__uart_start(tty);
>  	uart_port_unlock(port, flags);
> @@ -727,6 +730,9 @@ static void uart_unthrottle(struct tty_struct *tty)
>  	upstat_t mask = UPSTAT_SYNC_FIFO;
>  	struct uart_port *port;
>  
> +	if (!state)
> +		return;
> +
>  	port = uart_port_ref(state);
>  	if (!port)
>  		return;
> -- 
> 2.16.2


Hm, I wrote this patch, not you, right?  So shouldn't I get the
credit/blame for it?  :)

Also, this is a bug in the serial code, not necessarily the tty layer,
so the subject should change...

And you did test this, right?

thanks,

greg k-h
