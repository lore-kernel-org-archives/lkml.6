Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35EF5C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 020E9222B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpTPUKtp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732720AbfBLVvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 16:51:08 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37410 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730224AbfBLVvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 16:51:07 -0500
Received: by mail-pg1-f196.google.com with SMTP id q206so101617pgq.4;
        Tue, 12 Feb 2019 13:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=h6nxZKv7bX6Id32eVIs5Wm/QcDwyKc6woRCbgpj57uk=;
        b=RpTPUKtpEZRusXGFrFugp0kdnE4gz738DGSDHo9et9LuToaR9rt1hdOo89f9SUJclY
         Vng1aE8BoHiIZlWJ2ATyatbor2xTKc8Eqob1LH042KVI+ysMl1yCdXHrYx+iYOScttpw
         RBmreEj8DuzXcQdqTgiduotDn7cycQygO9+OpLxXpdbVkfPQndxVH51391ND8f84mvwy
         5gKql+muCYGbHrl0YAg90mMmGeu2b9rSTxi4RnNvCgYy1yj8hkvWTKE6oQOIIJUzFdhV
         XefoWHrJkua6EdDHJgqrgd5XH7lUpd2Wn/0bT3qAjm6pNye5zpRsdcWiz2XoiINLQZ/T
         HJ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=h6nxZKv7bX6Id32eVIs5Wm/QcDwyKc6woRCbgpj57uk=;
        b=dETTnhskjLKAtsWmM6UCfmR+C1tWw/gbdbv7vop3aOF/SA00kgAv4ZPGhxRdAujld1
         hcT7F1g2xx7bFVElDF0wcyBho6JtTtCDdqcnRd/2wcCKOxb/oIlCfJHs+qOCozRTAiM0
         vErXzAtqFytbkkXhUl0qBGgLb6kLs7IyfsduYzZBRBogZ42yIQR8gpgaR+5+oC6Qhtxs
         umQHY9652JgTKlIlPxY7iWwu44Q0fEYaJBv/Mz9qlIVvUJvcgXcq5JjGucVZPzSZC1RF
         JI6JeRHMaWSTPvFebhsvGrJmv7+dHOSeRVEEGbNRLvg+dQbSizciPo8F1/igT1TJU27w
         jggw==
X-Gm-Message-State: AHQUAuYLfMu5zpKFZqxtTX/uVnY+uNRzO0M6TAZPjzhjJGY+mRVHfU1c
        0WIwg2LwwPXb7MwvNQP7Cv8+PKq3
X-Google-Smtp-Source: AHgI3IZ8gNjPJmynUGPO2hhb1MKCq4RrWAsSpMXryA+fiaYPn86LlKtLLU5R82PqJoL1KBejku2E8A==
X-Received: by 2002:a63:e410:: with SMTP id a16mr5668560pgi.28.1550008266440;
        Tue, 12 Feb 2019 13:51:06 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j3sm7398702pff.82.2019.02.12.13.51.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 13:51:05 -0800 (PST)
Date:   Tue, 12 Feb 2019 13:51:05 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] hwmon: (f71882fg) Mark expected switch fall-through
Message-ID: <20190212215105.GA17643@roeck-us.net>
References: <20190211220738.GA5955@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190211220738.GA5955@embeddedor>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 04:07:38PM -0600, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
> 
> This patch fixes the following warnings:
> 
> drivers/hwmon/f71882fg.c: In function ‘f71882fg_probe’:
> drivers/hwmon/f71882fg.c:2457:33: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     data->auto_point_temp_signed = 1;
>     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
> drivers/hwmon/f71882fg.c:2459:3: note: here
>    case f71889fg:
>    ^~~~
> 
> Warning level 3 was used: -Wimplicit-fallthrough=3
> 
> Notice that, in this particular case, the code comment is modified
> in accordance with what GCC is expecting to find.
> 
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/f71882fg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
> index ca54ce5c8e10..83023798e489 100644
> --- a/drivers/hwmon/f71882fg.c
> +++ b/drivers/hwmon/f71882fg.c
> @@ -2455,7 +2455,7 @@ static int f71882fg_probe(struct platform_device *pdev)
>  		case f71869a:
>  			/* These always have signed auto point temps */
>  			data->auto_point_temp_signed = 1;
> -			/* Fall through to select correct fan/pwm reg bank! */
> +			/* Fall through - to select correct fan/pwm reg bank! */
>  		case f71889fg:
>  		case f71889ed:
>  		case f71889a:
