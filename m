Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C61C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 20:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 753BE2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 20:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NNnWt3HJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 753BE2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbeJaFx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 01:53:56 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:37244 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbeJaFx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 01:53:56 -0400
Received: by mail-yb1-f194.google.com with SMTP id d18-v6so5676445yba.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 13:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LpIdpzRClILpUZup6nsIZl5u2kpkq/WM5ywfhwtfMF0=;
        b=NNnWt3HJOE6+qFzr1PqH+tPM5N0sTEXau1wlpeO+28TJiwXJ+iDtri2fphbAdNYSio
         t5jMRoYuskteAQHpEg0a2pBbeB9av40T7DzIfQpOPbXHpiLg+lxJdj+MYff9AV8M0vsF
         USuV/blQIcq16ulzUgBAVwlE6bcGpWktZSfJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LpIdpzRClILpUZup6nsIZl5u2kpkq/WM5ywfhwtfMF0=;
        b=KhoDDW0b0djHxxau3Nxc3UuzYtpbdPUHiD1CuU2iZiTwIvMdCVqDa1TGHqoeRdEYIF
         mgb97TgxrFq5/IoUZkEAbVR+6mNGcjZG0/Lv3F0IZzXefDUWAxPuwQVHJY2bGTJBRv2D
         GUb9y5C1UbRkW472eP/MYBlbiY+Bm4LGfPFKP9xAtLSZne/0wNetatYRdlTMJCUpu4RQ
         cvDYuxvfbZo1lizU7p23rPzT9WSkIhgRxReutLwz1jXBnhGJwOCLTqvTMT2eMzh3oOGA
         r7In3bbDsr0pXSal86Yh59CY8Ldh7PwGQS/jzYPRGbFRfNV/ZnGseAIwCZwaNpB9hsl9
         r4hw==
X-Gm-Message-State: AGRZ1gLDh4+aNGvDF5Idzo/LrGLlY1FBfHfk3Vr4qaI0D8y355IIicPS
        nHZSLt1PRA25PTKpG5FAgNwkaYG1j84=
X-Google-Smtp-Source: AJdET5e4dx0BmlxMIJ1hD0h9TN2s+dn8QaBTh/SDUZuD7B6OoJW0of61xeMZU0Q6KOztVDZWsyGZWQ==
X-Received: by 2002:a25:b98b:: with SMTP id r11-v6mr356507ybg.498.1540933131203;
        Tue, 30 Oct 2018 13:58:51 -0700 (PDT)
Received: from mail-yw1-f48.google.com (mail-yw1-f48.google.com. [209.85.161.48])
        by smtp.gmail.com with ESMTPSA id k85-v6sm6220566ywa.76.2018.10.30.13.58.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 13:58:49 -0700 (PDT)
Received: by mail-yw1-f48.google.com with SMTP id f192-v6so3930914ywh.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 13:58:49 -0700 (PDT)
X-Received: by 2002:a0d:fec6:: with SMTP id o189-v6mr341870ywf.237.1540933128893;
 Tue, 30 Oct 2018 13:58:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3990:0:0:0:0:0 with HTTP; Tue, 30 Oct 2018 13:58:48
 -0700 (PDT)
In-Reply-To: <20181026232409.16100-1-linux@rasmusvillemoes.dk>
References: <20171108223020.24487-1-linux@rasmusvillemoes.dk> <20181026232409.16100-1-linux@rasmusvillemoes.dk>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 30 Oct 2018 13:58:48 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+eGQ3oo_1qSwW-BEVSK=vcLmNLWH8E7fPiawobo=_fbQ@mail.gmail.com>
Message-ID: <CAGXu5j+eGQ3oo_1qSwW-BEVSK=vcLmNLWH8E7fPiawobo=_fbQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] runtime format string checking
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        linux-hwmon@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 27, 2018 at 12:24 AM, Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
> This is a resurrection of something I sent out about a year ago. In
> the relatively few places where we use a non-literal as format string,
> we can annotate the source with a fmtcheck() call that will (a) at
> build time, allow the compiler to check the variadic arguments against
> the template, and (b) at runtime, check that the format specifiers
> present in the actual format string match those in the template (and
> if not, WARN and use the template to ensure runtime type safety).
>
> Finding places to annotate is just
>
>   make -j8 KCFLAGS='-Wformat-nonliteral'
>
> So far, in about half the places I looked, one might as well get
> completely rid of the non-literal format string.

Agreed. When I was still updating format string sites regularly, I had
a couple "just make the build quiet" patches to do this:

https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=kspp/format-security&id=ce9b938574042d09920650cb3c63ec29658edc87
The above seemed to "noisy" to send, but perhaps we should just land
it anyway. They really _should_ be const.

https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=kspp/format-security&id=b7dcfc8f48caaafcc423e5793f7ef61b9bb5c458
This one covers cases where the pointer is pointing to a const string,
so really there's no sense in injecting the "%s", but I was collecting
them to make real ones stand out.

> Patches 5,6,7 are
> some examples of where one might add fmtcheck() calls. I don't think
> we can get to a state where we can unconditionally add
> -Wformat-nonliteral to the build, but I think there's a lot of
> low-hanging fruit.

How much work do you think it'd take to get to a
format-nonliteral-clean build? I think it's worth doing the work if
it's not totally intractable.

-Kees

>
> This is on top of Miguel's compiler attributes series [1], which I
> hope will land in mainline soon.
>
> [1] https://github.com/ojeda/linux.git tags/compiler-attributes-for-linus-4.20-rc1
>
> Rasmus Villemoes (7):
>   compiler_attributes.h: add __attribute__((format_arg)) shorthand
>   lib/vsprintf.c: add fmtcheck utility
>   kernel.h: implement fmtmatch() wrapper around fmtcheck()
>   lib/test_printf.c: add a few fmtcheck() test cases
>   kernel/kthread.c: do runtime check of format string in
>     kthread_create_on_cpu()
>   nfs: use fmtcheck() in root_nfs_data
>   drivers: hwmon: add runtime format string checking
>
>  drivers/hwmon/hwmon.c               |  3 +-
>  fs/nfs/nfsroot.c                    |  2 +-
>  include/linux/compiler_attributes.h | 13 ++++++
>  include/linux/kernel.h              | 25 +++++++++++
>  kernel/kthread.c                    |  4 +-
>  lib/Kconfig.debug                   |  9 ++++
>  lib/test_printf.c                   | 43 +++++++++++++++++++
>  lib/vsprintf.c                      | 65 +++++++++++++++++++++++++++++
>  8 files changed, 160 insertions(+), 4 deletions(-)
>
> --
> 2.19.1.6.gbde171bbf5
>



-- 
Kees Cook
