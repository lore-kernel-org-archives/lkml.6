Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66467C65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 00:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 052952075B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 00:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EPmYJ1qG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 052952075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbeLNAuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 19:50:21 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:44509 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbeLNAuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 19:50:21 -0500
Received: by mail-yw1-f66.google.com with SMTP id i22so1612626ywa.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 16:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DKPlm4DeOFUA7OoblqX8RiiBGqoqfWRpgrxzY4aNv7c=;
        b=EPmYJ1qGzaGFx1id26LipzajxPU4MwWSzmpXIS2/MQ+xNlEDHmMU8MGSljiTTCYXAm
         nrAqSD4bu8j5YhYtYhyVKewNiT1gLfle1NEuNt6RtN7F1SlSlWpSIzfdH2KgAmJtXHJG
         VTkvTvLqpK2z5wRP2jjrcw4Hdy8Slg6fklEGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DKPlm4DeOFUA7OoblqX8RiiBGqoqfWRpgrxzY4aNv7c=;
        b=Ca/df//OQXsew+gyGX8oQx52uoxBD/YnScvT/w3hXSn2LNAzrlMXI/FbHc8qf3MVX9
         wKvhTcM5wKLMZkUtx5gvdgWgf9FBMPvuVH18u7O+JsOoz0fejfbSdHY4mgt7njy+foXJ
         zYypQFvFCwPAYcyaszlEiDkwImUOLeTOlYLPP6S2Fc9P2fnw09S91ifpEp0jgIz2OJw/
         zjWGm7tTLW/CHzE3vk1TSNO+4hmL2UQsWVHfpqm5i02/TkPlU9q9dKPSo098hfgwO+R+
         ZInp6kYFRpHDYq49WIALxBBJeNK14D+Ywf5vkBR37jjwDUqjYXNOjNWGYA3moEwifuDy
         DoDA==
X-Gm-Message-State: AA+aEWadFXQ+Hm8bzV1pHRno7A3V0sWLS5fytc1/zSav81zCBU+CVgtO
        Kh4hSQLcQG4+VU1SYszVHefcs2LFtgI=
X-Google-Smtp-Source: AFSGD/XHeON9t+TdUN9GwXkyN92yLIOq4wz+P+/uh0hVHEkGEcNKkY7H+SAZVhdKPImyitY9rxo7Rw==
X-Received: by 2002:a81:27c9:: with SMTP id n192mr1052336ywn.504.1544748619638;
        Thu, 13 Dec 2018 16:50:19 -0800 (PST)
Received: from mail-yw1-f50.google.com (mail-yw1-f50.google.com. [209.85.161.50])
        by smtp.gmail.com with ESMTPSA id d204sm1012865ywa.68.2018.12.13.16.50.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 16:50:18 -0800 (PST)
Received: by mail-yw1-f50.google.com with SMTP id d190so1613345ywd.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 16:50:18 -0800 (PST)
X-Received: by 2002:a81:2f0f:: with SMTP id v15mr1159867ywv.124.1544748618265;
 Thu, 13 Dec 2018 16:50:18 -0800 (PST)
MIME-Version: 1.0
References: <20181213201030.4072-1-tycho@tycho.ws>
In-Reply-To: <20181213201030.4072-1-tycho@tycho.ws>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 13 Dec 2018 16:50:06 -0800
X-Gmail-Original-Message-ID: <CAGXu5jLY16CjNZZ0QvkyaKep-qD8kEVZEnTQ7JqfozqAm=so_Q@mail.gmail.com>
Message-ID: <CAGXu5jLY16CjNZZ0QvkyaKep-qD8kEVZEnTQ7JqfozqAm=so_Q@mail.gmail.com>
Subject: Re: [PATCH] seccomp, s390: fix build for syscall type change
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        prudo@linux.vnet.ibm.com, linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 12:10 PM Tycho Andersen <tycho@tycho.ws> wrote:
>
> A recent patch landed in the security tree [1] that changed the type of the
> seccomp syscall. Unfortunately, I didn't quite get every instance of the
> forward declarations, and thus there is a build failure. Here's the last
> one that I could find, for s390. It should go through the security tree,
> although hopefully some s390 people can check and make sure it looks
> reasonable?
>
> The only oddity is the trailing semicolon; some lines around this patch
> have it, and some lines don't. I've left this one as-is.
>
> [1]: https://lore.kernel.org/lkml/20181212231630.GA31584@beast/T/#u
>
> Signed-off-by: Tycho Andersen <tycho@tycho.ws>

Thanks! Added to my -next tree.

-Kees

> ---
>  arch/s390/kernel/compat_wrapper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/s390/kernel/compat_wrapper.c b/arch/s390/kernel/compat_wrapper.c
> index 2ce28bf0c5ec..48c4ce668244 100644
> --- a/arch/s390/kernel/compat_wrapper.c
> +++ b/arch/s390/kernel/compat_wrapper.c
> @@ -164,7 +164,7 @@ COMPAT_SYSCALL_WRAP3(finit_module, int, fd, const char __user *, uargs, int, fla
>  COMPAT_SYSCALL_WRAP3(sched_setattr, pid_t, pid, struct sched_attr __user *, attr, unsigned int, flags);
>  COMPAT_SYSCALL_WRAP4(sched_getattr, pid_t, pid, struct sched_attr __user *, attr, unsigned int, size, unsigned int, flags);
>  COMPAT_SYSCALL_WRAP5(renameat2, int, olddfd, const char __user *, oldname, int, newdfd, const char __user *, newname, unsigned int, flags);
> -COMPAT_SYSCALL_WRAP3(seccomp, unsigned int, op, unsigned int, flags, const char __user *, uargs)
> +COMPAT_SYSCALL_WRAP3(seccomp, unsigned int, op, unsigned int, flags, void __user *, uargs)
>  COMPAT_SYSCALL_WRAP3(getrandom, char __user *, buf, size_t, count, unsigned int, flags)
>  COMPAT_SYSCALL_WRAP2(memfd_create, const char __user *, uname, unsigned int, flags)
>  COMPAT_SYSCALL_WRAP3(bpf, int, cmd, union bpf_attr *, attr, unsigned int, size);
> --
> 2.19.1
>


-- 
Kees Cook
