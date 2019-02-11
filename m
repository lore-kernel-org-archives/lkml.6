Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAD1C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 07:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 995E321479
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 07:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549871262;
	bh=sVBRQV2k44Dhe6ooxQF01v1Zkwy7vbnQqxFc1JgYoJ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=J9K+0MOoSFE+FAq6KRV9DIqBmKBL2IJAYCCNwN3hwUUD182xQORH7pbzyJMGhYpQf
	 3Q74ml4nwUxrjGFlAO3tKqB1ouA/QKwvuxx8PPbpsszkUVm9Q6eni1Rscm5GrMP1w6
	 CcFNr+hBap7UztgHrN6Nh5kXbLWXwuUQhX/sI/p0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfBKHrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 02:47:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:33514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725931AbfBKHrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 02:47:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC65A20811;
        Mon, 11 Feb 2019 07:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549871260;
        bh=sVBRQV2k44Dhe6ooxQF01v1Zkwy7vbnQqxFc1JgYoJ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r8rWSRNS4CwXLIdrzyoqSvhg59TyjTERexgkPpZE5gUi01y0D8CZCeNkzPFzePIt9
         eBqbgvBtmJnIuqjnWkh4NGmI/gZ6/RC1OViBG39qLYMjEMPeR3WODQuBJKcHwZ4MvY
         9EuaO3gg99jX+sS5RPxqUlhLji3ACOYEelbkm0Ww=
Date:   Mon, 11 Feb 2019 08:47:37 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     kpark3469@gmail.com
Cc:     linux-kernel@vger.kernel.org, keun-o.park@darkmatter.ae,
        peter@hurleysoftware.com, jslaby@suse.com, maninder1.s@samsung.com
Subject: Re: [PATCH] tty: pty: Fix race condition between release_one_tty and
 pty_write
Message-ID: <20190211074737.GA7719@kroah.com>
References: <1549868955-13528-1-git-send-email-kpark3469@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549868955-13528-1-git-send-email-kpark3469@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 11:09:15AM +0400, kpark3469@gmail.com wrote:
> From: Sahara <keun-o.park@darkmatter.ae>

I need a "real" name here, one you use to sign legal documents please.

> Especially when a linked tty is used such as pty, the linked tty
> port's buf works have not been cancelled while master tty port's
> buf work has been cancelled. Since release_one_tty and flush_to_ldisc
> run in workqueue threads separately, when pty_cleanup happens and
> link tty port is freed, flush_to_ldisc tries to access freed port
> and port->itty, eventually it causes a panic.
> This patch utilizes the magic value with holding the tty_mutex to
> check if the tty->link is valid.
> 
> Fixes: 2b022ab7542d ("pty: cancel pty slave port buf's work in tty_release")
> Signed-off-by: Sahara <keun-o.park@darkmatter.ae>
> ---
>  drivers/tty/pty.c    | 7 +++++++
>  drivers/tty/tty_io.c | 3 +++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
> index 00099a84..ef72031 100644
> --- a/drivers/tty/pty.c
> +++ b/drivers/tty/pty.c
> @@ -116,6 +116,12 @@ static int pty_write(struct tty_struct *tty, const unsigned char *buf, int c)
>  	if (tty->stopped)
>  		return 0;
>  
> +	mutex_lock(&tty_mutex);
> +	if (to->magic != TTY_MAGIC) {

Checking the "magic" field is odd, are you sure about this?  Usually
this means that memory that is already freed is still being used, right?

And have you tried the 5.0-rc6 release?  I thought I fixed much this
same issue there already, but for a serial port, not a pty.  Is the same
problem still present?




> +		mutex_unlock(&tty_mutex);
> +		return -EIO;
> +	}
> +
>  	if (c > 0) {
>  		spin_lock_irqsave(&to->port->lock, flags);
>  		/* Stuff the data into the input queue of the other end */
> @@ -125,6 +131,7 @@ static int pty_write(struct tty_struct *tty, const unsigned char *buf, int c)
>  			tty_flip_buffer_push(to->port);
>  		spin_unlock_irqrestore(&to->port->lock, flags);
>  	}
> +	mutex_unlock(&tty_mutex);
>  	return c;
>  }
>  
> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> index 23c6fd2..6c4a206 100644
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -1446,10 +1446,13 @@ static void release_one_tty(struct work_struct *work)
>  	struct tty_driver *driver = tty->driver;
>  	struct module *owner = driver->owner;
>  
> +	mutex_lock(&tty_mutex);
>  	if (tty->ops->cleanup)
>  		tty->ops->cleanup(tty);
>  
>  	tty->magic = 0;

Using the "magic" field as a flag isn't the best thing for us to rely
on, because this structure should be freed now, right?

thanks,

greg k-h
