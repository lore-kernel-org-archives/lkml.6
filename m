Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDB5C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 01:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D31D2080C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 01:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uCXIiasF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D31D2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbeKSMRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 07:17:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:54504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727033AbeKSMRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 07:17:42 -0500
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A63ED2087A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 01:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542592540;
        bh=vgst9x8m0xvOH9SlE5VeiHJKqGcUz9yB/fWjR2tUOPc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uCXIiasFH3U/iUG0oLllrG+P6pth6FE9Cg4xwdxiXvm2ZbkW4YhZLwnI/ZdN/mRKc
         zV7CNuHLUB8C57TvV+FKlq2hBaYybxIeWYo/PM1nDwWnVwPE90f/yoF9IQ7h3wanRQ
         4cr470nbbulp0kRSZjoq9NpV+iIAkFJh+C3ZNzC8=
Received: by mail-wr1-f51.google.com with SMTP id p4so21116036wrt.7
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 17:55:40 -0800 (PST)
X-Gm-Message-State: AGRZ1gLy7g6F8Fr31UImvv9KOajj/2pJ7SEN00QOGQBlx3CRrMPxuHWS
        wyolPCx6e9cOvlXtUSjBCKRcaaq3xmC2R8JYfPfsHA==
X-Google-Smtp-Source: AJdET5dLl/DISifVO/3qZb0fmSI4exEccgDXkKPGidvTCMCkyaUQcVU0mGk1x59A16I/IJoetB5c1Qq8O1OOu5jmVKk=
X-Received: by 2002:adf:e08c:: with SMTP id c12mr15614681wri.199.1542592539105;
 Sun, 18 Nov 2018 17:55:39 -0800 (PST)
MIME-Version: 1.0
References: <20181116232728.23538-1-chang.seok.bae@intel.com>
In-Reply-To: <20181116232728.23538-1-chang.seok.bae@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 18 Nov 2018 17:55:28 -0800
X-Gmail-Original-Message-ID: <CALCETrVtnkrr+t7-oXXrGDsei1Q0nudh8JstkuaE+dka4FHPEA@mail.gmail.com>
Message-ID: <CALCETrVtnkrr+t7-oXXrGDsei1Q0nudh8JstkuaE+dka4FHPEA@mail.gmail.com>
Subject: Re: [PATCH v5] x86/fsgsbase/64: Fix the base write helper functions
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 3:27 PM Chang S. Bae <chang.seok.bae@intel.com> wrote:
>
> The helper functions that purport to write the base should just write it
> only. It shouldn't have magic optimizations to change the index.
>
> Make the index explicitly changed from the caller, instead of including
> the code in the helpers.
>
> Subsequently, the task write helpers do not handle for the current task
> anymore. The range check for a base value is also factored out, to
> minimize code redundancy from the caller.
>
> v2: Fix further on the task write functions. Revert the changes on the
> task read helpers.
>
> v3: Fix putreg(). Edit the changelog.
>
> v4: Update the task write helper functions and do_arch_prctl_64(). Fix
> the comment in putreg().
>
> v5: Fix preempt_disable() calls in do_arch_prctl_64()

Reviewed-by: Andy Lutomirski <luto@kernel.org>

Ingo, Thomas: can we get this in x86/urgent, please?


> diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
> index ffae9b9740fd..4b8ee05dd6ad 100644
> --- a/arch/x86/kernel/ptrace.c
> +++ b/arch/x86/kernel/ptrace.c
> @@ -397,11 +397,12 @@ static int putreg(struct task_struct *child,
>                 if (value >= TASK_SIZE_MAX)
>                         return -EIO;
>                 /*
> -                * When changing the FS base, use the same
> -                * mechanism as for do_arch_prctl_64().
> +                * When changing the FS base, use do_arch_prctl_64()
> +                * to set the index to zero and to set the base
> +                * as requested.
>                  */
>                 if (child->thread.fsbase != value)
> -                       return x86_fsbase_write_task(child, value);
> +                       return do_arch_prctl_64(child, ARCH_SET_FS, value);

FWIW, this logic is and was nonsensical, but it matches historical
behavior, so I guess it's okay.  I suspect that gdb only works by
luck, since fs_base has a *higher* index than fs (and same for gs),
which means that SETREGS with a nonzero fs or gs likely only works
because the target almost always already has fs_base or gs_base == 0,
so we bypass this entire mess.

Sigh.  When you resubmit the full FSGSBASE series, I'll review the new
code extra carefully.
