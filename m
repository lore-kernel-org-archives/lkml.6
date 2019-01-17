Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01C1C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FEED20855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G4aRN9aV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbfAQQiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 11:38:06 -0500
Received: from mail-vs1-f44.google.com ([209.85.217.44]:44839 "EHLO
        mail-vs1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbfAQQiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 11:38:06 -0500
Received: by mail-vs1-f44.google.com with SMTP id u11so6581595vsp.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 08:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E1IrF3eis0mCvRuWvGulZ/N1BHfT3unQZ7rTHyNT+LI=;
        b=G4aRN9aVt1IeppwYJ6Jmw3SAnbYPLD9exZ/liY0Rgi3TwaGRWiHXros7hg7/GClG29
         +0FHZP83arKaIhMa2DXCSSToKbUjqBnT8MKpUBXDtmUEAns0OKGr4wjrBqxkZ3RETl0o
         u66kTHtT/0hcUPhVSuImLbWsrXwCVzQaeU6uU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E1IrF3eis0mCvRuWvGulZ/N1BHfT3unQZ7rTHyNT+LI=;
        b=qJ/Oms8ohrMN1A2MDkHykP9lWuyemG0ENnEW3Jbf2TKnZSBa6Wt7Tis0b0D5qPVrPa
         a3KyQyq/g1lielgzX3LONs6ZELwDu/6v/p/xDd3ogD4RK+5lsD+Hk63EfJAKRqRva6id
         Q581TOTK0lJYpKnA5kI1mYGSoj2jHUIeFkUNibHnE46G/vPOylpnS9LXK/r54YIG1slj
         VxG8bX0UcgGLk6P1a6alI3V29/r3LkoxRmsUI4bIWusPsV0XoSQlOj/xPkPbFRbTro/m
         RKl7uqkwHlvvASrzgR6xz21a00I7BzPU2WQ51W5onb8YB9NdxCrjSyeWZTExgze3rqUn
         kfnw==
X-Gm-Message-State: AJcUukfm9nLTIVTtOTZK6ouDyt9+HftlC+M3Jf+i7GH3M8a0KLn7PLb4
        YOIaOqEZ899pirrpsmnByn4WvJg1SB4=
X-Google-Smtp-Source: ALg8bN68xfGB+gd0aEFPnfgJqSShPJtUd0SXIB8HAycrSvMdR1cN7B0Kw/fOX3GQXcwyqV6SlRQkOg==
X-Received: by 2002:a67:e28a:: with SMTP id g10mr6659157vsf.178.1547743084564;
        Thu, 17 Jan 2019 08:38:04 -0800 (PST)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id x20sm3113893uan.12.2019.01.17.08.38.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 08:38:03 -0800 (PST)
Received: by mail-ua1-f52.google.com with SMTP id z24so3665201ual.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 08:38:02 -0800 (PST)
X-Received: by 2002:a9f:2709:: with SMTP id a9mr6155293uaa.10.1547743082325;
 Thu, 17 Jan 2019 08:38:02 -0800 (PST)
MIME-Version: 1.0
References: <20190117071734.7792-1-yuehaibing@huawei.com>
In-Reply-To: <20190117071734.7792-1-yuehaibing@huawei.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 17 Jan 2019 08:37:50 -0800
X-Gmail-Original-Message-ID: <CAGXu5jK3b7YwHpgv5XtNUFHcrxcndNWpiZdWaoQR1LKO34Or-w@mail.gmail.com>
Message-ID: <CAGXu5jK3b7YwHpgv5XtNUFHcrxcndNWpiZdWaoQR1LKO34Or-w@mail.gmail.com>
Subject: Re: [PATCH -next] security: remove duplicated include from security.h
To:     james.morris@microsoft.com, YueHaibing <yuehaibing@huawei.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 11:17 PM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Remove duplicated include.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Acked-by: Kees Cook <keescook@chromium.org>

James, can you take this?

-Kees

> ---
>  include/linux/security.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/include/linux/security.h b/include/linux/security.h
> index b10866b..7ed03c6 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -30,7 +30,6 @@
>  #include <linux/err.h>
>  #include <linux/string.h>
>  #include <linux/mm.h>
> -#include <linux/fs.h>
>
>  struct linux_binprm;
>  struct cred;
> --
> 2.7.0
>
>


-- 
Kees Cook
