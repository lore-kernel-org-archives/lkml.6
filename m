Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E83DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 180642186A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oKSufvvY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbfBZU7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 15:59:50 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33087 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728673AbfBZU7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 15:59:50 -0500
Received: by mail-pf1-f194.google.com with SMTP id i19so6832397pfd.0;
        Tue, 26 Feb 2019 12:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4ROOQgm57M6IUGQOGqpLaHEld2dBenAjbQzA1hoWXvI=;
        b=oKSufvvYgWPLinHjWawbFjBdVn3YmZicCxcQen0Ii7O2nqky9V8ZS26F5Kz97Xn5l8
         0zwKqmrWnj3ur/zvIMYbH8DDEdBohL7PBXlOAhzf+OWNN+XUkXTtXBBvOcsZcCPIWIFf
         H0RiBmmw4VhB9NlCjUw1VyA4lZbdv9T4ZLWoZpnIJWQ9ZpyKFkL8Agpy+uY8ZL4jPBBF
         fsDuU8cMj5Y6fRMknWEIg/stQZtP+LFbQ1L5YZsgnA2cWNBEIkRj8cXU/QeO6QttJjZ4
         fSLtpKIGZYDa8Fws62uy3WPmJryXJ0Kb7PjvWvW6HASGynM7iZ8T3bSHPI1Ep+o6IGo0
         08pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=4ROOQgm57M6IUGQOGqpLaHEld2dBenAjbQzA1hoWXvI=;
        b=rTXcZUIH4ulxxuIhZrHpdPsSRUIXSnQulfK3QAb7YWuftlFdBOsWkpzaMWl850ipiJ
         CD9/pluh6VTnoNwHw75oKtRvCa/18kUUcjKW+eXXiWZf4daCimFEs043+P/jx0Z6AfCg
         s69CwAO+ciiFGV1FmURXPTtwT62tuYK72lAT7ukwx5QrvjNF/7eWhZhuw9l08QCNKCyA
         l+3sLbcno/MZvzTvMZVxcBkY8RA7PrjvIyWXZ3tilkYwMbRLfeY1UnRJElrilc1QhkR9
         VLKzM4QZUltmHS+vr7B5h79eJk5uT+kV8gCQogHSMEd+xhZKdlQ9IO/5Vha5ls72WA55
         A/Dg==
X-Gm-Message-State: AHQUAubZVNwWJl/oS7vuZrpWqodAYNVbDWLzJ4PswZN1ZeO75WCgjSYG
        vnEAwTzliAB2W9JCoPz2jic=
X-Google-Smtp-Source: AHgI3Ib5t4W3uu2BAMQmEfryNuurC7ghLJiEdZyB7Ah4c3wATrbVli2FU30sjaps+06eF83weto2kw==
X-Received: by 2002:a62:f5c8:: with SMTP id b69mr27681460pfm.128.1551214789044;
        Tue, 26 Feb 2019 12:59:49 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s80sm7800283pgs.4.2019.02.26.12.59.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 12:59:47 -0800 (PST)
Date:   Tue, 26 Feb 2019 12:59:46 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] watchdog: sbc60xxwdt: Mark expected switch fall-through
Message-ID: <20190226205946.GA21115@roeck-us.net>
References: <20190226175835.GA12199@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190226175835.GA12199@embeddedor>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 11:58:35AM -0600, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
> 
> This patch fixes the following warning:
> 
> drivers/watchdog/sbc60xxwdt.c: In function ‘fop_ioctl’:
> drivers/watchdog/sbc60xxwdt.c:272:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    wdt_keepalive();
>    ^~~~~~~~~~~~~~~
> drivers/watchdog/sbc60xxwdt.c:275:2: note: here
>   case WDIOC_GETTIMEOUT:
>   ^~~~
> 
> Notice that, in this particular case, the code comment is modified
> in accordance with what GCC is expecting to find.
> 
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/sbc60xxwdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/sbc60xxwdt.c b/drivers/watchdog/sbc60xxwdt.c
> index 87333a41f753..72d15fd1f183 100644
> --- a/drivers/watchdog/sbc60xxwdt.c
> +++ b/drivers/watchdog/sbc60xxwdt.c
> @@ -270,8 +270,8 @@ static long fop_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  
>  		timeout = new_timeout;
>  		wdt_keepalive();
> -		/* Fall through */
>  	}
> +		/* Fall through */
>  	case WDIOC_GETTIMEOUT:
>  		return put_user(timeout, p);
>  	default:
> -- 
> 2.20.1
> 
