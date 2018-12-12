Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67910C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03F762084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oFoFpTP8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03F762084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbeLLAbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 19:31:09 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:41347 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbeLLAbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 19:31:09 -0500
Received: by mail-yw1-f65.google.com with SMTP id f65so6251586ywc.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 16:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RRJ3aClqjNq3nazn5+LQNCLFoj999J+Fr6uYi7oCn74=;
        b=oFoFpTP8277RJxPueoPf0oRSmiqtk4Nuk97wt2I6CbM4viOw0kbXKdJv40enlrLGM9
         dTi7htQen5Lb7+xWyd+1okfzCZ8eLj1hhfC0emOeERebZX3A8tTiaeBT2Ixn5EE7Zw5t
         ffEM1O+Z6Lb68/ZOz1GbIt2N2t3y20gyBy/dQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RRJ3aClqjNq3nazn5+LQNCLFoj999J+Fr6uYi7oCn74=;
        b=DyLtfRQez4n4Cynel46XPfZ4Krn0Hy/AST2f6MlrY91oh/jWpRB3e3YGXZ5ObpvcBE
         1+zjG/T7/MoLGw/AWvFU9gHLP1nzZ/BHZsrZu0/kg5oEMh7JPelWX37Au3JJIzwZxL3t
         uLKO7SjoG+KobmesPgjSeZmVy8180RlWnuELo1GRKNol95dOBToJvk2Qg4S8jdrCJ0Ey
         X+r9MWrkEuG4qHjwG8QOtoU+VkEFeuU07bAAksZTN6+HPbXmeyj7ogVnXr71rRFSdC4r
         zKdxWVFxiItryWLAMhC97y0ebRME17L3lQ2O1NZF3BC35cZdEbYvm7iCnwXNTsCwo+5v
         V7oQ==
X-Gm-Message-State: AA+aEWYVISi0/mTihZSvwrFU0S4a/oca0UV8hDFB2s2OYJrAIbxRk7+v
        HFi4Ct5LLvksFr7weEO8IrzTL6WWYCU=
X-Google-Smtp-Source: AFSGD/XojX0KHQgOjm42HHh133TMUYh2o7X4ZJDvin+SKRWmSC+4cxO0il38fNHf0p9+1hJYJsGb8w==
X-Received: by 2002:a81:2848:: with SMTP id o69mr19306809ywo.225.1544574666616;
        Tue, 11 Dec 2018 16:31:06 -0800 (PST)
Received: from mail-yw1-f45.google.com (mail-yw1-f45.google.com. [209.85.161.45])
        by smtp.gmail.com with ESMTPSA id y83sm5156122ywd.65.2018.12.11.16.31.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 16:31:05 -0800 (PST)
Received: by mail-yw1-f45.google.com with SMTP id g75so6261794ywb.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 16:31:04 -0800 (PST)
X-Received: by 2002:a81:71c5:: with SMTP id m188mr19049918ywc.353.1544574664125;
 Tue, 11 Dec 2018 16:31:04 -0800 (PST)
MIME-Version: 1.0
References: <20181209182414.30862-1-tycho@tycho.ws> <20181209182414.30862-2-tycho@tycho.ws>
In-Reply-To: <20181209182414.30862-2-tycho@tycho.ws>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 11 Dec 2018 16:30:52 -0800
X-Gmail-Original-Message-ID: <CAGXu5jK_PCh8np-473yG2A5oTBcPpeAefOQnSc3x_mTp5T4c6w@mail.gmail.com>
Message-ID: <CAGXu5jK_PCh8np-473yG2A5oTBcPpeAefOQnSc3x_mTp5T4c6w@mail.gmail.com>
Subject: Re: [PATCH v10 1/4] seccomp: hoist struct seccomp_data recalculation higher
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
> In the next patch, we're going to use the sd pointer passed to
> __seccomp_filter() as the data to pass to userspace. Except that in some
> cases (__seccomp_filter(SECCOMP_RET_TRACE), emulate_vsyscall(), every time
> seccomp is inovked on power, etc.) the sd pointer will be NULL in order to
> force seccomp to recompute the register data. Previously this recomputation
> happened one level lower, in seccomp_run_filters(); this patch just moves
> it up a level higher to __seccomp_filter().
>
> Thanks Oleg for spotting this.
>
> Signed-off-by: Tycho Andersen <tycho@tycho.ws>

This is fine. :) Applied for -next.

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
>  kernel/seccomp.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index f2ae2324c232..96afc32e041d 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -188,7 +188,6 @@ static int seccomp_check_filter(struct sock_filter *filter, unsigned int flen)
>  static u32 seccomp_run_filters(const struct seccomp_data *sd,
>                                struct seccomp_filter **match)
>  {
> -       struct seccomp_data sd_local;
>         u32 ret = SECCOMP_RET_ALLOW;
>         /* Make sure cross-thread synced filter points somewhere sane. */
>         struct seccomp_filter *f =
> @@ -198,11 +197,6 @@ static u32 seccomp_run_filters(const struct seccomp_data *sd,
>         if (WARN_ON(f == NULL))
>                 return SECCOMP_RET_KILL_PROCESS;
>
> -       if (!sd) {
> -               populate_seccomp_data(&sd_local);
> -               sd = &sd_local;
> -       }
> -
>         /*
>          * All filters in the list are evaluated and the lowest BPF return
>          * value always takes priority (ignoring the DATA).
> @@ -658,6 +652,7 @@ static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd,
>         u32 filter_ret, action;
>         struct seccomp_filter *match = NULL;
>         int data;
> +       struct seccomp_data sd_local;
>
>         /*
>          * Make sure that any changes to mode from another thread have
> @@ -665,6 +660,11 @@ static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd,
>          */
>         rmb();
>
> +       if (!sd) {
> +               populate_seccomp_data(&sd_local);
> +               sd = &sd_local;
> +       }
> +
>         filter_ret = seccomp_run_filters(sd, &match);
>         data = filter_ret & SECCOMP_RET_DATA;
>         action = filter_ret & SECCOMP_RET_ACTION_FULL;
> --
> 2.19.1
>


-- 
Kees Cook
