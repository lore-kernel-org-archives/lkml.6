Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7145C6783B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 801E320851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mw2kRr4s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 801E320851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbeLLAbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 19:31:52 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:45215 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbeLLAbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 19:31:51 -0500
Received: by mail-yb1-f194.google.com with SMTP id r11so2595229ybp.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 16:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j8ts+gucq0UHeMYdMIMna56AdBnlohhBuEtc41v8++Q=;
        b=mw2kRr4sAltkOx1oqvk4L7RXihTL6RP1a6bZPhhSxLTQxJHBUAPAtFuzwbd/9T4Ukq
         /M+GEdPobFMgnJubzMIucbiUFEiFf7j3YWJvAv5CSB3NdZrKBvt+Xe5ws7J9gz0xhQ4r
         3J7GCGKOS7y5JjjkLOeAWQ1pUGR3m9tqI9k5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j8ts+gucq0UHeMYdMIMna56AdBnlohhBuEtc41v8++Q=;
        b=UwBt6MdD78aWjK+54K1xIanSUNFLwFvjtz2p/V140NKNEkPrH/j+eUtowrcmvnNg5e
         Eq9w5sP1DPFPKGDFGuG90Ow3KCPp9DBK+CqURyZLyJqLTmnIqvWD8DZajaQUQwUirpTb
         JIx9G2/P5wmF4XXQworrsw+a9IylB9W7dsxd1QPTMdoBw0wXYfPH5oVC/pCm/p6EjnDi
         tYtKPoo+H1W8QMnzXpkbE3rQ+zznFs2Eetjp8OtGK/eYDpo5kPGL4dg6hJ14d7Q24K7n
         fTbBX1xsdAG7jUtYQ2oEm38L7voDLY3OpucrTaDWw1oJLULqOm0QsETuW1rJmBaHRr+s
         N2yQ==
X-Gm-Message-State: AA+aEWbjNwpwf68VR4Td/9He7D6P+I3kiDnLH9EaI96HXUmLiX6sSHju
        jyDLGmax63ft7nHniKaL0H2UV4Vq/nc=
X-Google-Smtp-Source: AFSGD/VkZcVc2VicP6U7Mqno31+8ui2292pJHui8IuNAmaJu/+LI+Lhz+9fhFVYODCDpKX0j3hE/aQ==
X-Received: by 2002:a25:cbd8:: with SMTP id b207mr14107223ybg.1.1544574710046;
        Tue, 11 Dec 2018 16:31:50 -0800 (PST)
Received: from mail-yw1-f51.google.com (mail-yw1-f51.google.com. [209.85.161.51])
        by smtp.gmail.com with ESMTPSA id y125sm4829514ywc.97.2018.12.11.16.31.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 16:31:49 -0800 (PST)
Received: by mail-yw1-f51.google.com with SMTP id x2so6255385ywc.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 16:31:48 -0800 (PST)
X-Received: by 2002:a81:c446:: with SMTP id s6mr19511201ywj.237.1544574708200;
 Tue, 11 Dec 2018 16:31:48 -0800 (PST)
MIME-Version: 1.0
References: <20181209182414.30862-1-tycho@tycho.ws> <20181209182414.30862-3-tycho@tycho.ws>
In-Reply-To: <20181209182414.30862-3-tycho@tycho.ws>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 11 Dec 2018 16:31:37 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJ8dPnnwFVV9qyhDmaVqEuF-7hAtv8-vZzuqyWnk1A33Q@mail.gmail.com>
Message-ID: <CAGXu5jJ8dPnnwFVV9qyhDmaVqEuF-7hAtv8-vZzuqyWnk1A33Q@mail.gmail.com>
Subject: Re: [PATCH v10 2/4] seccomp: switch system call argument type to void *
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian@brauner.io>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Aleksa Sarai <asarai@suse.de>, Jann Horn <jannh@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 9, 2018 at 10:24 AM Tycho Andersen <tycho@tycho.ws> wrote:
>
> The const qualifier causes problems for any code that wants to write to the
> third argument of the seccomp syscall, as we will do in a future patch in
> this series.
>
> The third argument to the seccomp syscall is documented as void *, so
> rather than just dropping the const, let's switch everything to use void *
> as well.
>
> I believe this is safe because of 1. the documentation above, 2. there's no
> real type information exported about syscalls anywhere besides the man
> pages.
>
> Signed-off-by: Tycho Andersen <tycho@tycho.ws>

Yeah, this can be void *, as you've found. I think it was just an
artifact of the old filter code to use const char *.

Applied for -next.

-Kees

> CC: Kees Cook <keescook@chromium.org>
> CC: Andy Lutomirski <luto@amacapital.net>
> CC: Oleg Nesterov <oleg@redhat.com>
> CC: Eric W. Biederman <ebiederm@xmission.com>
> CC: "Serge E. Hallyn" <serge@hallyn.com>
> Acked-by: Serge Hallyn <serge@hallyn.com>
> CC: Christian Brauner <christian@brauner.io>
> CC: Tyler Hicks <tyhicks@canonical.com>
> CC: Akihiro Suda <suda.akihiro@lab.ntt.co.jp>
> ---
> v10: change type in include/linux/syscalls.h too to avoid compilation error
>      in the !CONFIG_ARCH_HAS_SYSCALL_WRAPPER case
> ---
>  include/linux/seccomp.h  | 2 +-
>  include/linux/syscalls.h | 2 +-
>  kernel/seccomp.c         | 8 ++++----
>  3 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
> index e5320f6c8654..b5103c019cf4 100644
> --- a/include/linux/seccomp.h
> +++ b/include/linux/seccomp.h
> @@ -43,7 +43,7 @@ extern void secure_computing_strict(int this_syscall);
>  #endif
>
>  extern long prctl_get_seccomp(void);
> -extern long prctl_set_seccomp(unsigned long, char __user *);
> +extern long prctl_set_seccomp(unsigned long, void __user *);
>
>  static inline int seccomp_mode(struct seccomp *s)
>  {
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 2ac3d13a915b..a60694fb0f58 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -879,7 +879,7 @@ asmlinkage long sys_renameat2(int olddfd, const char __user *oldname,
>                               int newdfd, const char __user *newname,
>                               unsigned int flags);
>  asmlinkage long sys_seccomp(unsigned int op, unsigned int flags,
> -                           const char __user *uargs);
> +                           void __user *uargs);
>  asmlinkage long sys_getrandom(char __user *buf, size_t count,
>                               unsigned int flags);
>  asmlinkage long sys_memfd_create(const char __user *uname_ptr, unsigned int flags);
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index 96afc32e041d..393e029f778a 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -924,7 +924,7 @@ static long seccomp_get_action_avail(const char __user *uaction)
>
>  /* Common entry point for both prctl and syscall. */
>  static long do_seccomp(unsigned int op, unsigned int flags,
> -                      const char __user *uargs)
> +                      void __user *uargs)
>  {
>         switch (op) {
>         case SECCOMP_SET_MODE_STRICT:
> @@ -944,7 +944,7 @@ static long do_seccomp(unsigned int op, unsigned int flags,
>  }
>
>  SYSCALL_DEFINE3(seccomp, unsigned int, op, unsigned int, flags,
> -                        const char __user *, uargs)
> +                        void __user *, uargs)
>  {
>         return do_seccomp(op, flags, uargs);
>  }
> @@ -956,10 +956,10 @@ SYSCALL_DEFINE3(seccomp, unsigned int, op, unsigned int, flags,
>   *
>   * Returns 0 on success or -EINVAL on failure.
>   */
> -long prctl_set_seccomp(unsigned long seccomp_mode, char __user *filter)
> +long prctl_set_seccomp(unsigned long seccomp_mode, void __user *filter)
>  {
>         unsigned int op;
> -       char __user *uargs;
> +       void __user *uargs;
>
>         switch (seccomp_mode) {
>         case SECCOMP_MODE_STRICT:
> --
> 2.19.1
>


-- 
Kees Cook
