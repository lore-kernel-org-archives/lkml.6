Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D69C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 17:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86D162085A
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 17:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549128556;
	bh=mSMfSyqTWcq1eL+kG81MzE3+doiKElMPQQUMWYz8STM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=aKGn0CmZC07ymDzYN5iqRXP1n7/BQrCS35KSqY4OX5rUlYSI2IJaHTkZCkpclO8J8
	 U7infgmZK/dFRamfR1ShDOSCrO/8kuwo5UeKLsVoTYPU/DL+fOWZC3TGAQu6rgU0yP
	 y29jWAbhwx99ZPZdAb+QUVyS/lJXI2Xkn0pnnMIQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfBBR25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 12:28:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:58344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbfBBR25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 12:28:57 -0500
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39DB72086C
        for <linux-kernel@vger.kernel.org>; Sat,  2 Feb 2019 17:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549128536;
        bh=mSMfSyqTWcq1eL+kG81MzE3+doiKElMPQQUMWYz8STM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qL19tU43pWQdyYoTie31UrETmznqnsjr97d3+Mq9wy0l5/u81X9dPAQwtjRGteZYx
         +/9/Hb2XFRs6NgxxIfm89nj0f4OIXV8HRDSo1/B74d6BhlphBmvooEqjQWrZbony8C
         0XpqYW8COozztvwzEQ2OnnwaJW/ANK6qSrmi3Nyg=
Received: by mail-wm1-f51.google.com with SMTP id p6so9277884wmc.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Feb 2019 09:28:56 -0800 (PST)
X-Gm-Message-State: AHQUAuYa9xgeh6s+NoYnfOtDAcUHEU6eFkLCrwnO6ZpwpE9C3E0xp5iC
        +WyTusB01JTbYS+XTsN86X3Ow7N7X8a0AsnJpRgMKw==
X-Google-Smtp-Source: AHgI3IYVSsRre/f6PJ3lssiLrupIKMkZnwOXRgddgn0Hzee/El3h2FrEnUkIHAXtmhCmEWquDSD08PLJDPY49SShXdM=
X-Received: by 2002:a1c:f909:: with SMTP id x9mr6897699wmh.108.1549128534667;
 Sat, 02 Feb 2019 09:28:54 -0800 (PST)
MIME-Version: 1.0
References: <20190201205319.15995-1-chang.seok.bae@intel.com> <20190201205319.15995-9-chang.seok.bae@intel.com>
In-Reply-To: <20190201205319.15995-9-chang.seok.bae@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 2 Feb 2019 09:28:42 -0800
X-Gmail-Original-Message-ID: <CALCETrV1MkgnUqpe7NELa1H0jPt3T4ifuFPUC+aMGn-fUv2rzw@mail.gmail.com>
Message-ID: <CALCETrV1MkgnUqpe7NELa1H0jPt3T4ifuFPUC+aMGn-fUv2rzw@mail.gmail.com>
Subject: Re: [PATCH v5 07/13] x86/fsgsbase/64: When copying a thread, use the
 FSGSBASE instructions if available
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 1, 2019 at 12:54 PM Chang S. Bae <chang.seok.bae@intel.com> wrote:
>
> Copy real FS/GSBASE values instead of approximation when FSGSBASE is
> enabled.
>
> Factoring out to save_fsgs() does not result in the same behavior because
> save_base_legacy() does not copy FS/GSBASE when the index is zero.
>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Andi Kleen <ak@linux.intel.com>
> ---
>  arch/x86/kernel/process_64.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
> index d8ade9530fdb..648e43b58c69 100644
> --- a/arch/x86/kernel/process_64.c
> +++ b/arch/x86/kernel/process_64.c
> @@ -477,10 +477,16 @@ int copy_thread_tls(unsigned long clone_flags, unsigned long sp,
>         p->thread.sp = (unsigned long) fork_frame;
>         p->thread.io_bitmap_ptr = NULL;
>
> -       savesegment(gs, p->thread.gsindex);
> -       p->thread.gsbase = p->thread.gsindex ? 0 : me->thread.gsbase;
>         savesegment(fs, p->thread.fsindex);
> -       p->thread.fsbase = p->thread.fsindex ? 0 : me->thread.fsbase;
> +       savesegment(gs, p->thread.gsindex);
> +       if (static_cpu_has(X86_FEATURE_FSGSBASE)) {
> +               p->thread.fsbase = rdfsbase();
> +               p->thread.gsbase = __rdgsbase_inactive();
> +       } else {
> +               /* save_base_legacy() does not set base when index is zero. */

After looking at this a bit, I propose that we just clean this up all
the way.  Can't this whole mess be changed to:

save_fsgs(me);
p->thread.fsindex = me->thread.fsindex;
p->thread.fsbase = me->thread.fsbase;
p->thread.gsindex = me->thread.gsindex;
p->thread.gsbase = me->thread.gsbase;

This will avoid all of the horrible tracing through the logic to
figure out why the code is correct.

Sure, it'll be a few cycles slower with FSGSBASE, but this isn't
really a fast path, and if we ever really care, we can optimize it
later.
