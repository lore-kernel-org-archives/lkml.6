Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD168ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 19:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D6892082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 19:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="e3gm+iaj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D6892082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbeJYDuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 23:50:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:52106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726433AbeJYDuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 23:50:52 -0400
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E78220833
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 19:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540408893;
        bh=bbWQxRFX4/+vHtn9cdWuUya71diqrTPZ89hG2hsEm+w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=e3gm+iajTKAfr8zXHKImp7BgkdtHCEs1rcr6Go5uRQBsCnpoV3+0f2K+bRZzfnRyR
         gBIm/SWSj0l4+2MIY2UNxYN7+ZV4LBnfy4YKPLiFupG+bhQpSSD0g4S5AvtTSuHxIP
         8Jyc19Kze0iDdFY8JJeGxXOn0ETYk/AnaQUnCjJA=
Received: by mail-wr1-f42.google.com with SMTP id r10-v6so5901811wrv.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 12:21:33 -0700 (PDT)
X-Gm-Message-State: AGRZ1gJX7EAhCC67wDl83K97V//JRLqdAM1FckUpKuvby3hnuRrEVEYp
        CEFfaYsLIte/YgjlOsEH6/M9Lz/DRCIO2sRbiSy61Q==
X-Google-Smtp-Source: AJdET5dsaY8BbhGra9J/Fwp2KDH3DujLTXUYmks257mIL3uChbCyNdElBy/r78ZCedTvUTnE1OZN6BClJdgrdC7gYTo=
X-Received: by 2002:adf:e50f:: with SMTP id j15-v6mr1117170wrm.94.1540408891744;
 Wed, 24 Oct 2018 12:21:31 -0700 (PDT)
MIME-Version: 1.0
References: <20181023184234.14025-1-chang.seok.bae@intel.com> <20181023184234.14025-6-chang.seok.bae@intel.com>
In-Reply-To: <20181023184234.14025-6-chang.seok.bae@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 24 Oct 2018 12:21:20 -0700
X-Gmail-Original-Message-ID: <CALCETrWZZ65pzmO_OwG0x3DWtLbLykB16DB5t8r3rkjg5VmzmA@mail.gmail.com>
Message-ID: <CALCETrWZZ65pzmO_OwG0x3DWtLbLykB16DB5t8r3rkjg5VmzmA@mail.gmail.com>
Subject: Re: [v3 05/12] x86/fsgsbase/64: Preserve FS/GS state in __switch_to()
 if FSGSBASE is on
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 11:43 AM Chang S. Bae <chang.seok.bae@intel.com> wrote:
>
> From: Andy Lutomirski <luto@kernel.org>
>
> With the new FSGSBASE instructions, we can efficiently read and write
> the FSBASE and GSBASE in __switch_to().  Use that capability to preserve
> the full state.
>
> This will enable user code to do whatever it wants with the new
> instructions without any kernel-induced gotchas.  (There can still be
> architectural gotchas: movl %gs,%eax; movl %eax,%gs may change GSBASE
> if WRGSBASE was used, but users are expected to read the CPU manual
> before doing things like that.)
>
> This is a considerable speedup.  It seems to save about 100 cycles
> per context switch compared to the baseline 4.6-rc1 behavior on my
> Skylake laptop.
>
> [ chang: 5~10% performance improvements were seen by a context switch
>   benchmark that ran threads with different FS/GSBASE values. Minor
>   edit on the changelog. ]
>
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> ---
>  arch/x86/kernel/process_64.c | 34 ++++++++++++++++++++++++++++------
>  1 file changed, 28 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
> index fcf18046c3d6..1d975cadc256 100644
> --- a/arch/x86/kernel/process_64.c
> +++ b/arch/x86/kernel/process_64.c
> @@ -238,8 +238,18 @@ static __always_inline void save_fsgs(struct task_struct *task)
>  {
>         savesegment(fs, task->thread.fsindex);
>         savesegment(gs, task->thread.gsindex);
> -       save_base_legacy(task, task->thread.fsindex, FS);
> -       save_base_legacy(task, task->thread.gsindex, GS);
> +       if (static_cpu_has(X86_FEATURE_FSGSBASE)) {
> +               /*
> +                * If FSGSBASE is enabled, we can't make any useful guesses
> +                * about the base, and user code expects us to save the current
> +                * value.  Fortunately, reading the base directly is efficient.
> +                */
> +               task->thread.fsbase = rdfsbase();
> +               task->thread.gsbase = rd_inactive_gsbase();
> +       } else {
> +               save_base_legacy(task, task->thread.fsindex, FS);
> +               save_base_legacy(task, task->thread.gsindex, GS);
> +       }
>  }
>
>  #if IS_ENABLED(CONFIG_KVM)
> @@ -318,10 +328,22 @@ static __always_inline void load_seg_legacy(unsigned short prev_index,
>  static __always_inline void x86_fsgsbase_load(struct thread_struct *prev,
>                                               struct thread_struct *next)
>  {
> -       load_seg_legacy(prev->fsindex, prev->fsbase,
> -                       next->fsindex, next->fsbase, FS);
> -       load_seg_legacy(prev->gsindex, prev->gsbase,
> -                       next->gsindex, next->gsbase, GS);
> +       if (static_cpu_has(X86_FEATURE_FSGSBASE)) {
> +               /* Update the FS and GS selectors if they could have changed. */
> +               if (unlikely(prev->fsindex || next->fsindex))
> +                       loadseg(FS, next->fsindex);
> +               if (unlikely(prev->gsindex || next->gsindex))
> +                       loadseg(GS, next->gsindex);
> +
> +               /* Update the bases. */
> +               wrfsbase(next->fsbase);
> +               wr_inactive_gsbase(next->gsbase);

Aha, I see what you're doing with the FSGSBASE-optimized version being
out of line.  But it's way too unclear from the code.  You should name
the helper wrgsbase_inactive or maybe __wrgsbase_inactive() to
emphasize that you're literally using the WRGSBASE instruction.  (Or
it's Xen PV equivalent.  Hmm.)
