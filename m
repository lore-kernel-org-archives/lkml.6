Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B716C5ACCC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 21:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A568221471
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 21:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UVDdKmZM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A568221471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbeJQFjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 01:39:09 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:41803 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbeJQFjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 01:39:09 -0400
Received: by mail-yw1-f67.google.com with SMTP id 135-v6so9531955ywo.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 14:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SdIQz/x2n2d/L63t9KIx+V7SDDvriDItPjXA/s9tEF4=;
        b=UVDdKmZMuO8FAaZ/NPPkOAYyaHFq7qZP/rYpLfwWHGaLgfDJHT5bM1AfjUV52KwotK
         MeEjZuWepEF9qXpjU1VxkL7ghDcVvrBQw0BE0XQdCR8xtVsymfoe/SKKp7aJG2+4F01G
         bAvT4Feycq0djf3PWk5GgTFz48qnDYS/G1MhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SdIQz/x2n2d/L63t9KIx+V7SDDvriDItPjXA/s9tEF4=;
        b=o5H3kMFPLgQ8jhcHCe6uAdXQrnkcyMB/nIX2EMuLLQ2RNB4p/EVgb5Oi4eqQ6b7/NE
         7ALQ9S+4owMwldZPMPFjCAwZW9myL/anZjrmztEDq21Ro3h/AZeO7MBssUFj+zpsbMow
         rGHiUOlIN6/5ZcmnFKEG7HqS1LPoXKVQKD6xMS3GVV7azQaDZrCzZL9zBhWXJ33tnFng
         VojX1kKlWoAnkC4OiWm7TxxL7Ee0/IW7jl0A3h2vn4e+Nqq8G+PX2UpU88KNpArm2Pfg
         3DU7F2XOn7s4Iw9sOWg6EiJ90MdrQQPUi7UBBVZsmGyaQVPX4VyfljmqmJBn0rCrYKsg
         Z/mA==
X-Gm-Message-State: ABuFfojxHiA8q3gkcLYJE9bW73E8/jRqqcVbyzelQ1HpIzMGujlaxXuU
        aFHEL2iak2qnYBGYAQk48L4pfquWK88=
X-Google-Smtp-Source: ACcGV60MwmKqG0XyJP1S/yXit7IwkpErp5ayT+7FtB8PIfVnKNSx+rr853SPsc5jvus2ZCIyTX3Stg==
X-Received: by 2002:a81:eb08:: with SMTP id n8-v6mr12862770ywm.138.1539726406401;
        Tue, 16 Oct 2018 14:46:46 -0700 (PDT)
Received: from mail-yw1-f52.google.com (mail-yw1-f52.google.com. [209.85.161.52])
        by smtp.gmail.com with ESMTPSA id u143-v6sm5498924ywc.28.2018.10.16.14.46.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 14:46:44 -0700 (PDT)
Received: by mail-yw1-f52.google.com with SMTP id a197-v6so9531683ywh.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 14:46:44 -0700 (PDT)
X-Received: by 2002:a0d:cd84:: with SMTP id p126-v6mr13400776ywd.288.1539726404075;
 Tue, 16 Oct 2018 14:46:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Tue, 16 Oct 2018 14:46:43
 -0700 (PDT)
In-Reply-To: <20181016195337.2440-2-christian@brauner.io>
References: <20181016195337.2440-1-christian@brauner.io> <20181016195337.2440-2-christian@brauner.io>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 16 Oct 2018 14:46:43 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLJi0bb8pGH=H_+TvBYs5QjT2=uwTo1bbZF0iQ=i4U7Kw@mail.gmail.com>
Message-ID: <CAGXu5jLJi0bb8pGH=H_+TvBYs5QjT2=uwTo1bbZF0iQ=i4U7Kw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] sysctl: handle overflow in proc_get_long
To:     Christian Brauner <christian@brauner.io>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 12:53 PM, Christian Brauner
<christian@brauner.io> wrote:
> proc_get_long() is a funny function. It uses simple_strtoul() and for a
> good reason. proc_get_long() wants to always succeed the parse and return
> the maybe incorrect value and the trailing characters to check against a
> pre-defined list of acceptable trailing values.
> However, simple_strtoul() explicitly ignores overflows which can cause
> funny things like the following to happen:
>
> echo 18446744073709551616 > /proc/sys/fs/file-max
> cat /proc/sys/fs/file-max
> 0
>
> (Which will cause your system to silently die behind your back.)
>
> On the other hand kstrtoul() does do overflow detection but does not return
> the trailing characters, and also fails the parse when anything other than
> '\n' is a trailing character whereas proc_get_long() wants to be more
> lenient.
>
> Now, before adding another kstrtoul() function let's simply add a static
> parse strtoul_lenient() which:
> - fails on overflow with -ERANGE
> - returns the trailing characters to the caller

Can you add this as kerndoc above strtoul_lenient()? (New people
reading this code should be able to tell quickly what it's lenient
about, and how it behaves without have to know the internals of
kstrtox.h.)

> The reason why we should fail on ERANGE is that we already do a partial
> fail on overflow right now. Namely, when the TMPBUFLEN is exceeded. So we
> already reject values such as 184467440737095516160 (21 chars) but accept
> values such as 18446744073709551616 (20 chars) but both are overflows. So
> we should just always reject 64bit overflows and not special-case this
> based on the number of chars.

Yup -- I think this makes a lot of sense.

>
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Christian Brauner <christian@brauner.io>
> ---
> v1->v2:
> - s/sysctl_cap_erange/sysctl_lenient/g
> - consistenly fail on overflow
> v0->v1:
> - s/sysctl_strtoul_lenient/strtoul_cap_erange/g
> - (Al) remove bool overflow return argument from strtoul_cap_erange
> - (Al) return ULONG_MAX on ERANGE from strtoul_cap_erange
> - (Dominik) fix spelling in commit message
> ---
>  kernel/sysctl.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index cc02050fd0c4..7d98e02e5d72 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -67,6 +67,7 @@
>  #include <linux/bpf.h>
>  #include <linux/mount.h>
>  #include <linux/pipe_fs_i.h>
> +#include <../lib/kstrtox.h>

Should this be "../lib/kstrtox.h" instead of <>?

>
>  #include <linux/uaccess.h>
>  #include <asm/processor.h>
> @@ -2065,6 +2066,26 @@ static void proc_skip_char(char **buf, size_t *size, const char v)
>         }
>  }
>
> +static int strtoul_lenient(const char *cp, char **endp, unsigned int base,
> +                          unsigned long *res)
> +{
> +       unsigned long long result;
> +       unsigned int rv;
> +
> +       cp = _parse_integer_fixup_radix(cp, &base);
> +       rv = _parse_integer(cp, base, &result);
> +       if ((rv & KSTRTOX_OVERFLOW) || (result != (unsigned long)result))
> +               return -ERANGE;
> +
> +       cp += rv;
> +
> +       if (endp)
> +               *endp = (char *)cp;
> +
> +       *res = (unsigned long)result;
> +       return 0;
> +}
> +
>  #define TMPBUFLEN 22
>  /**
>   * proc_get_long - reads an ASCII formatted integer from a user buffer
> @@ -2108,7 +2129,8 @@ static int proc_get_long(char **buf, size_t *size,
>         if (!isdigit(*p))
>                 return -EINVAL;
>
> -       *val = simple_strtoul(p, &p, 0);
> +       if (strtoul_lenient(p, &p, 0, val))
> +               return -EINVAL;
>
>         len = p - tmp;
>
> --
> 2.17.1
>

With kerndoc added, please consider this acked by me:

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
