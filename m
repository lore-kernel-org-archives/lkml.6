Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7274C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E7432170E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Va4CRr5R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E7432170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbeI1Atb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 20:49:31 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:45970 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbeI1Atb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 20:49:31 -0400
Received: by mail-yw1-f65.google.com with SMTP id p206-v6so1483122ywg.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 11:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zSgONuYp6tg2e8iAyg1oZ0P00XxTzmZw5iahujCwZFw=;
        b=Va4CRr5R4RClmctNjO0xKnTbwWCw66ZYQSrZGqLP4mxNldhUc0Ziu0gdv6M1BIUGh4
         peUgIYcrT9g/t21ZjQmiHR1TS4862hsg/ocJbMzscylVQzw1svcwUMIsiklcfKXPfC6/
         tW6WwH1GYyzaOIUC4TM2zsbl1zeLgcMI7kYZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zSgONuYp6tg2e8iAyg1oZ0P00XxTzmZw5iahujCwZFw=;
        b=LO6J4kYoTQkuIdMxUs6qzF9MW9+v2pOX6HKnzh0sFAOPKCAoainJgFPfOu+JOVflcX
         05d4Wt2trwpdJUlvfFGPXxwXaIFoKWgZZpHXCqmAnEtf65QZ6G3yEIxQqAMvMxqfScnf
         hEU+ZLcZpvxcpggh2F0pDae/CPDzLVMW7DmZv0qB7KF3J34BWdm4y6utpwiAL0XnXL2k
         sLGLwY0JrFt2YsL5XFsoAl8gisLPKLA6kcBufkSWSBKcLgXqnBRpp3ikxn9javFCZ6ms
         iyQsYrmfJkuvTMzswZi8i4O97XzImlhumzI9M/CEp2VA2YLSLShant8RZJwrQRCu5gSi
         2c9w==
X-Gm-Message-State: ABuFfoh90fylRZPwBREA3a50yKE6XZaQxjkRAFVVEAqTw2f0v1s8E0hU
        2naa48wfJZu090IRRt7miyKCUonE+4g=
X-Google-Smtp-Source: ACcGV61V89LAEIU2dVL0+bkvOq18HOr5RIQ1xUhUPj9EtPt/3o+lYQPTIWc0SGJSEFpBi13YSbqbTQ==
X-Received: by 2002:a0d:fbc3:: with SMTP id l186-v6mr6186680ywf.446.1538072996883;
        Thu, 27 Sep 2018 11:29:56 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id x137-v6sm1836641ywx.18.2018.09.27.11.29.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 11:29:54 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id d9-v6so1511296ybr.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 11:29:54 -0700 (PDT)
X-Received: by 2002:a25:19c3:: with SMTP id 186-v6mr6564841ybz.410.1538072994039;
 Thu, 27 Sep 2018 11:29:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Thu, 27 Sep 2018 11:29:53
 -0700 (PDT)
In-Reply-To: <20180927153316.200286-1-jannh@google.com>
References: <20180927153316.200286-1-jannh@google.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 27 Sep 2018 11:29:53 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+9=6tvtynh=KLdvt6O9TkS6cj49itwZk9n0x0qDqaShg@mail.gmail.com>
Message-ID: <CAGXu5j+9=6tvtynh=KLdvt6O9TkS6cj49itwZk9n0x0qDqaShg@mail.gmail.com>
Subject: Re: [PATCH resend] proc: restrict kernel stack dumps to root
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Ken Chen <kenchen@google.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Security Officers <security@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 8:33 AM, Jann Horn <jannh@google.com> wrote:
> Restrict the ability to inspect kernel stacks of arbitrary tasks to root
> in order to prevent a local attacker from exploiting racy stack unwinding
> to leak kernel task stack contents.
> See the added comment for a longer rationale.
>
> There don't seem to be any users of this userspace API that can't
> gracefully bail out if reading from the file fails. Therefore, I believe
> that this change is unlikely to break things.
> In the case that this patch does end up needing a revert, the next-best
> solution might be to fake a single-entry stack based on wchan.
>
> Fixes: 2ec220e27f50 ("proc: add /proc/*/stack")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jann Horn <jannh@google.com>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
> Resending because I forgot to send this to akpm the first time.
>
>  fs/proc/base.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index ccf86f16d9f0..7e9f07bf260d 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -407,6 +407,20 @@ static int proc_pid_stack(struct seq_file *m, struct pid_namespace *ns,
>         unsigned long *entries;
>         int err;
>
> +       /*
> +        * The ability to racily run the kernel stack unwinder on a running task
> +        * and then observe the unwinder output is scary; while it is useful for
> +        * debugging kernel issues, it can also allow an attacker to leak kernel
> +        * stack contents.
> +        * Doing this in a manner that is at least safe from races would require
> +        * some work to ensure that the remote task can not be scheduled; and
> +        * even then, this would still expose the unwinder as local attack
> +        * surface.
> +        * Therefore, this interface is restricted to root.
> +        */
> +       if (!file_ns_capable(m->file, &init_user_ns, CAP_SYS_ADMIN))
> +               return -EACCES;
> +
>         entries = kmalloc_array(MAX_STACK_TRACE_DEPTH, sizeof(*entries),
>                                 GFP_KERNEL);
>         if (!entries)
> --
> 2.19.0.rc2.392.g5ba43deb5a-goog
>



-- 
Kees Cook
Pixel Security
