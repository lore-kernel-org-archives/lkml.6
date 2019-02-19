Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB4EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA39D217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550580079;
	bh=CMxfW5mJnetzlYhN6HLPDyFQBHZhMYWfeGNdmCx/rRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XPUkZb8FvyRpnhybdEhLZcg1ra2/yjQ6kYTlyny6oI/f0OP/xd/PzPYndyQoB/h2U
	 jm60y3C7YQSsmOjX3MfCorp+o+lBTGCe+kDiVPsUqtMrtqDCG0vu2I/VSO0f8lzfBL
	 /YI9BmzS4yxPzbEFGeVMAadDS8+VC/kiiLDOCKKs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbfBSMlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 07:41:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:44064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbfBSMlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 07:41:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3402821736;
        Tue, 19 Feb 2019 12:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550580077;
        bh=CMxfW5mJnetzlYhN6HLPDyFQBHZhMYWfeGNdmCx/rRU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x8zRox7r8g/Srdcdr/Ybmk3E41EOcvzbMpdGfzDphbBFI+Z4Mfj5SUZ28Jg4mN8/p
         qgur2cSJUxdUgzUtmp5UUo2pQtAwViJ1q8gHaLj3CzU0PRMf0NqGFviGI9OGcrCjvj
         7F3P0xaKtIw1HUjpX8Fq523RBAc2zQurh0EySVZQ=
Date:   Tue, 19 Feb 2019 13:41:15 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     yes@kroah.com
Cc:     robh@kernel.org, jslaby@suse.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: not call tty close in fallback
Message-ID: <20190219124115.GB4867@kroah.com>
References: <5c3c3289.1c69fb81.c1953.0900SMTPIN_ADDED_BROKEN@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c3c3289.1c69fb81.c1953.0900SMTPIN_ADDED_BROKEN@mx.google.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 02:56:01PM +0800, yes wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> when fail to open tty, tty is not in open status and not need
> to call close
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  drivers/tty/serdev/serdev-ttyport.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
> index fa1672993b4c..bcc1e27d00de 100644
> --- a/drivers/tty/serdev/serdev-ttyport.c
> +++ b/drivers/tty/serdev/serdev-ttyport.c
> @@ -121,7 +121,7 @@ static int ttyport_open(struct serdev_controller *ctrl)
>  
>  	ret = tty->ops->open(serport->tty, NULL);
>  	if (ret)
> -		goto err_close;
> +		goto err_unlock;
>  
>  	tty_unlock(serport->tty);
>  
> @@ -142,8 +142,6 @@ static int ttyport_open(struct serdev_controller *ctrl)
>  
>  	return 0;
>  
> -err_close:
> -	tty->ops->close(tty, NULL);

No, close is always called after open, even if open fails.

thanks,

greg k-h
