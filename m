Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574EDC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 21:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED9ED20827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 21:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPSLuxBk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED9ED20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbeJaGUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 02:20:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:44776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725743AbeJaGUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 02:20:48 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B33920831
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 21:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540934739;
        bh=wrTslx3KZcPhdljO+1fui3lSwwMIBVeO1v7vcggfBbc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RPSLuxBkRGYRn3QwPpzvcZgZFdnxnHNnlnRW394HWGpX/tjAQ9s9KrZwpWtmVSXuB
         X7kZDqWwSvDdRXgNpHIltnTRZQjyaxOb3g1pgkhT31bjeuSZBcvjkNdjJya6GLfqtE
         V5i6hktkAYqWmusduf4iIgg8/v/2WX9oK01LeJGo=
Received: by mail-wr1-f44.google.com with SMTP id i17-v6so14165130wre.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 14:25:39 -0700 (PDT)
X-Gm-Message-State: AGRZ1gLZgrr9x1KJUqnq2Jl/2yYJX4AsO+9uz5OFm1VYPLDOyOukeBjL
        aaQAF9XIKqpgpueyeArvMlV6XFhK9N8AeMmu9B1t/Q==
X-Google-Smtp-Source: AJdET5e/gvd+woUlC9FKeBvnA3owBrDQZyovHphnDgZPuErBEUhlOom9OKCLSd5pr6lJ4P6lEwMtRw884kidyzpgsYM=
X-Received: by 2002:adf:82c9:: with SMTP id 67-v6mr286417wrc.131.1540934737862;
 Tue, 30 Oct 2018 14:25:37 -0700 (PDT)
MIME-Version: 1.0
References: <20181030172719.6753-1-chang.seok.bae@intel.com>
In-Reply-To: <20181030172719.6753-1-chang.seok.bae@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 30 Oct 2018 14:25:25 -0700
X-Gmail-Original-Message-ID: <CALCETrUddNZYHKgRarNkHANTnahUCtO5o5YrrNfwCqTmFKGefw@mail.gmail.com>
Message-ID: <CALCETrUddNZYHKgRarNkHANTnahUCtO5o5YrrNfwCqTmFKGefw@mail.gmail.com>
Subject: Re: [PATCH] x86/fsgsbase/64: Fix the base write helper functions
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

On Tue, Oct 30, 2018 at 10:28 AM Chang S. Bae <chang.seok.bae@intel.com> wrote:
>
> Factor out the code to change index from x86_fsbase_write_cpu() and
> x86_gsbase_write_cpu_inactive(). Now the code is located in
> do_arch_prctl_64().
>

> @@ -359,9 +351,7 @@ unsigned long x86_fsbase_read_task(struct task_struct *task)
>  {
>         unsigned long fsbase;
>
> -       if (task == current)
> -               fsbase = x86_fsbase_read_cpu();
> -       else if (task->thread.fsindex == 0)
> +       if (task->thread.fsindex == 0)

I'm okay with this change but, if you do it, please add:

WARN_ON_ONCE(task == current);

and make it be in a separate patch.

>                 fsbase = task->thread.fsbase;
>         else
>                 fsbase = x86_fsgsbase_read_task(task, task->thread.fsindex);
> @@ -373,9 +363,7 @@ unsigned long x86_gsbase_read_task(struct task_struct *task)
>  {
>         unsigned long gsbase;
>
> -       if (task == current)
> -               gsbase = x86_gsbase_read_cpu_inactive();
> -       else if (task->thread.gsindex == 0)
> +       if (task->thread.gsindex == 0)

Same here.

>                 gsbase = task->thread.gsbase;
>         else
>                 gsbase = x86_fsgsbase_read_task(task, task->thread.gsindex);
> @@ -392,12 +380,8 @@ int x86_fsbase_write_task(struct task_struct *task, unsigned long fsbase)
>         if (unlikely(fsbase >= TASK_SIZE_MAX))
>                 return -EPERM;
>
> -       preempt_disable();
>         task->thread.fsbase = fsbase;
> -       if (task == current)
> -               x86_fsbase_write_cpu(fsbase);
>         task->thread.fsindex = 0;

I'm confused.  You're still setting fsindex to zero here.

> -       preempt_enable();
>
>         return 0;
>  }
> @@ -407,12 +391,8 @@ int x86_gsbase_write_task(struct task_struct *task, unsigned long gsbase)
>         if (unlikely(gsbase >= TASK_SIZE_MAX))
>                 return -EPERM;
>
> -       preempt_disable();
>         task->thread.gsbase = gsbase;
> -       if (task == current)
> -               x86_gsbase_write_cpu_inactive(gsbase);
>         task->thread.gsindex = 0;

Same here.

> @@ -757,22 +737,53 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
>         int ret = 0;
>
>         switch (option) {
> -       case ARCH_SET_GS: {
> -               ret = x86_gsbase_write_task(task, arg2);
> -               break;
> -       }
>         case ARCH_SET_FS: {
> +               preempt_disable();
>                 ret = x86_fsbase_write_task(task, arg2);
> +               if (task == current && ret == 0) {
> +                       /*
> +                        * Set the selector to 0, implying that the base is
> +                        * overwritten. The index value will be checked
> +                        * during context switch for skipping segment reload.
> +                        */
> +                       loadseg(FS, 0);
> +                       x86_fsbase_write_cpu(arg2);
> +               }
> +               preempt_enable();
> +               break;
> +       }
> +       case ARCH_SET_GS: {
> +               preempt_disable();
> +               ret = x86_gsbase_write_task(task, arg2);

This would trip the warning that I'm asking you to add.  This makes me
think you should not make that change.

> +               if (task == current && ret == 0) {
> +                       /*
> +                        * Set the selector to 0 for the same reason
> +                        * as %fs above.
> +                        */
> +                       loadseg(GS, 0);
> +                       x86_gsbase_write_cpu_inactive(arg2);
> +               }

Why only if task == current?

I think this code should be:

ret = x86_gsbase_write_task(task, arg);
if (ret == 0) {
  /* ARCH_SET_GS has always overwritten the index and the base.  Zero
is the most sensible value to put in the index, and is the only value
that makes any sense if FSGSBASE is unavailable. */
  if (task == current)
    loadseg(GS, 0);
  else
    task->thread.gsindex = 0;
}
