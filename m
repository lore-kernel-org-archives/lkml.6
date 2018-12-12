Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA878C6783B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF6BF20851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jAZGVVdX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF6BF20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbeLLAnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 19:43:46 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:45968 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbeLLAnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 19:43:46 -0500
Received: by mail-yb1-f196.google.com with SMTP id r11so2604671ybp.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 16:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d3xtEvXqceq0DWNNuQWIHebgEuqqjFWJeyB4z6u7I0w=;
        b=jAZGVVdXh+CMm1g4gkxz0pwI2W1lVXEYVHesinO0tIgfC7s223mQx1MTXVyOtOcsLo
         u8EYM2Am3U2dhoPVh74+AwyzzVfj8xDrquU4jmdliKIYN6QiVasgjXTApeg9hROHU8pt
         FRbZ8PVyojdLEtLU9r1ZXu8+V7NjOMnFbZouo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d3xtEvXqceq0DWNNuQWIHebgEuqqjFWJeyB4z6u7I0w=;
        b=hXZ28bYL/4PIA6bKnc2DDsHmGe5t+Cjft4FVYTNDyokb0J2SM7CkoY/lLEAw9nxRlK
         +r5V0uaCRdEmZ6/zWrV7BeIDorsaFCveHqHrWu/lOEQZ+hl/ce0hc97Qj8Jgcbb33WRd
         MQKhR7ozXyd6BN5sR7n8rGCWnk+aMAp0Myw3fIScqoUwJ8Eh4rJGwEeNG8Qoho2gpaxN
         yTn3808U/YmbnHDQkrBwjOiM6QSudztCRhnEqQgNMyidOuWV2PLd70J0wgUcNcELO943
         SvnTnWfMLSptG8bUpTixnQO5Pq4L6gGJTOIBBoXsEuepVggL9OsNuHPkr9d4m2VRj4MW
         sxuw==
X-Gm-Message-State: AA+aEWa7TwoPxiXvqgqzo3/LAFAKeRzUdrdpmrFI1BwXSGqOYeXz7+FE
        YVkQCGcPELiZDReEgHv1dygSCs+OnRw=
X-Google-Smtp-Source: AFSGD/XVfoX2e+bLAfRcqZ80zSNevczMSa/paYz21nf2aWbAme0p6x7RJKlK5crKVuBDb67/Cry/GA==
X-Received: by 2002:a25:6f86:: with SMTP id k128-v6mr18107381ybc.235.1544575424945;
        Tue, 11 Dec 2018 16:43:44 -0800 (PST)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id q185sm4902591ywe.87.2018.12.11.16.43.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 16:43:43 -0800 (PST)
Received: by mail-yb1-f179.google.com with SMTP id m129so821278ybf.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 16:43:43 -0800 (PST)
X-Received: by 2002:a25:a445:: with SMTP id f63-v6mr17723349ybi.171.1544575423429;
 Tue, 11 Dec 2018 16:43:43 -0800 (PST)
MIME-Version: 1.0
References: <20181206235038.GA18273@beast>
In-Reply-To: <20181206235038.GA18273@beast>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 11 Dec 2018 16:43:31 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJ-OZho9Ft7imNuayNjr0Rnz3p4sKg-yZp2_d4go=G9fA@mail.gmail.com>
Message-ID: <CAGXu5jJ-OZho9Ft7imNuayNjr0Rnz3p4sKg-yZp2_d4go=G9fA@mail.gmail.com>
Subject: Re: [PATCH] selftests/seccomp: Remove SIGSTOP si_pid check
To:     Shuah Khan <shuah@kernel.org>
Cc:     Tycho Andersen <tycho@tycho.ws>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 3:50 PM Kees Cook <keescook@chromium.org> wrote:
>
> Commit f149b3155744 ("signal: Never allocate siginfo for SIGKILL or SIGSTOP")
> means that the seccomp selftest cannot check si_pid under SIGSTOP anymore.
> Since it's believed[1] there are no other userspace things depending on the
> old behavior, this removes the behavioral check in the selftest, since it's
> more a "extra" sanity check (which turns out, maybe, not to have been
> useful to test).
>
> [1] https://lkml.kernel.org/r/CAGXu5jJaZAOzP1qFz66tYrtbuywqb+UN2SOA1VLHpCCOiYvYeg@mail.gmail.com
>
> Reported-by: Tycho Andersen <tycho@tycho.ws>
> Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> Shuah, can you make sure that Linus gets this before v4.20 is released? Thanks!

Ping. Shuah, can you get this to Linus (or should I send it directly?)

Thanks!

-Kees


> ---
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> index e1473234968d..c9a2abf8be1b 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -2731,9 +2731,14 @@ TEST(syscall_restart)
>         ASSERT_EQ(child_pid, waitpid(child_pid, &status, 0));
>         ASSERT_EQ(true, WIFSTOPPED(status));
>         ASSERT_EQ(SIGSTOP, WSTOPSIG(status));
> -       /* Verify signal delivery came from parent now. */
>         ASSERT_EQ(0, ptrace(PTRACE_GETSIGINFO, child_pid, NULL, &info));
> -       EXPECT_EQ(getpid(), info.si_pid);
> +       /*
> +        * There is no siginfo on SIGSTOP any more, so we can't verify
> +        * signal delivery came from parent now (getpid() == info.si_pid).
> +        * https://lkml.kernel.org/r/CAGXu5jJaZAOzP1qFz66tYrtbuywqb+UN2SOA1VLHpCCOiYvYeg@mail.gmail.com
> +        * At least verify the SIGSTOP via PTRACE_GETSIGINFO.
> +        */
> +       EXPECT_EQ(SIGSTOP, info.si_signo);
>
>         /* Restart nanosleep with SIGCONT, which triggers restart_syscall. */
>         ASSERT_EQ(0, kill(child_pid, SIGCONT));
> --
> 2.17.1
>
>
> --
> Kees Cook



-- 
Kees Cook
