Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C656CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AA7D21019
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XzrTuyKd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AA7D21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbeK2Ch7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 21:37:59 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:32962 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728832AbeK2Ch6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 21:37:58 -0500
Received: by mail-it1-f193.google.com with SMTP id m8so4947576itk.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 07:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/x5HTFbylUTQo2gox/IxMzj3Fj4DaEZbjQxKd+BKtQQ=;
        b=XzrTuyKdhCLiBzYnWTeCya2J/d48mrIG5NpjlFmnF0XBtxRJP1Y5o7cMkBfg8kpxI+
         dokbZSGvtq1nS0p5zIgRl3rVFV1nOxKGCihA5+sClJL0Fyx5plEuGGj3VqE1Gy+lY0f2
         bkcTuvTqVouxuobGkQWx0z/w7nBKnNuygPjpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/x5HTFbylUTQo2gox/IxMzj3Fj4DaEZbjQxKd+BKtQQ=;
        b=Am3NV9nB+RkDj919GaS3pvjDg6kyI1SygEMSpWZsWMD1t99AV5nMJhhEJtgUF+TH6a
         iniCxTX4undP8WL3p8sEG6WNXYaessE/tdwVfNua0cmhhT0o/ZQ534MkUubHlTBC2cGa
         y8PIa5hAJLSaJqTkJ0RZiR0ZI6FwB2m1fNGnGFsgJ1zAgokuk5mc0HpqkDV/RbXHlduJ
         Ykn/auqCn0m84rqlNGcZlF3c5i4PywOtW4JVRmTyRUa+/jUn+3P5xokE56cyRSMrmo/r
         E4hdKK+HVxgMDMundQ+3ersIB7IDdUrzqW/BPkHTHJugbRynVSzRW7+HoRIEr2kx/RCU
         PCHg==
X-Gm-Message-State: AA+aEWY+9RTR9L6bAu5h2sMn/kdtInukcjL6QyHYaV/B3hk6eKq79QnC
        1iERJkbXig0qOrdBs0S/tF5ZTkVaBNhlTxfpIvHqxw==
X-Google-Smtp-Source: AFSGD/VG8z8PdoBRWjS+4jtE6+NgFklZ2ZhfxMps1cqaCQgca5gOZaxSe1k5PIgybuYQvpFeU8mifMkcHDOY3G1XcnI=
X-Received: by 2002:a24:710:: with SMTP id f16mr2982371itf.121.1543419354065;
 Wed, 28 Nov 2018 07:35:54 -0800 (PST)
MIME-Version: 1.0
References: <1543347902-21170-1-git-send-email-will.deacon@arm.com> <1543347902-21170-3-git-send-email-will.deacon@arm.com>
In-Reply-To: <1543347902-21170-3-git-send-email-will.deacon@arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 28 Nov 2018 16:35:42 +0100
Message-ID: <CAKv+Gu9s-=M-mU+249-X1jQ7_Z60vWO1cXK1AP0CwKCmaQQSdg@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: preempt: Provide our own implementation of asm/preempt.h
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>, rml@tech9.net,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Nov 2018 at 20:44, Will Deacon <will.deacon@arm.com> wrote:
>
> The asm-generic/preempt.h implementation doesn't make use of the
> PREEMPT_NEED_RESCHED flag, since this can interact badly with load/store
> architectures which rely on the preempt_count word being unchanged across
> an interrupt.
>
> However, since we're a 64-bit architecture and the preempt count is
> only 32 bits wide, we can simply pack it next to the resched flag and
> load the whole thing in one go, so that a dec-and-test operation doesn't
> need to load twice.
>

Since the actual preempt count is a lot narrower than 32 bits, x86
just uses bit 31.

So what is the reason for using two different words?


> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/Kbuild        |  1 -
>  arch/arm64/include/asm/preempt.h     | 78 ++++++++++++++++++++++++++++++++++++
>  arch/arm64/include/asm/thread_info.h | 13 +++++-
>  3 files changed, 90 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm64/include/asm/preempt.h
>
> diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
> index 6cd5d77b6b44..33498f900390 100644
> --- a/arch/arm64/include/asm/Kbuild
> +++ b/arch/arm64/include/asm/Kbuild
> @@ -14,7 +14,6 @@ generic-y += local64.h
>  generic-y += mcs_spinlock.h
>  generic-y += mm-arch-hooks.h
>  generic-y += msi.h
> -generic-y += preempt.h
>  generic-y += qrwlock.h
>  generic-y += qspinlock.h
>  generic-y += rwsem.h
> diff --git a/arch/arm64/include/asm/preempt.h b/arch/arm64/include/asm/preempt.h
> new file mode 100644
> index 000000000000..832227d5ebc0
> --- /dev/null
> +++ b/arch/arm64/include/asm/preempt.h
> @@ -0,0 +1,78 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_PREEMPT_H
> +#define __ASM_PREEMPT_H
> +
> +#include <linux/thread_info.h>
> +
> +#define PREEMPT_NEED_RESCHED   BIT(32)
> +#define PREEMPT_ENABLED        (PREEMPT_NEED_RESCHED)
> +
> +static inline int preempt_count(void)
> +{
> +       return READ_ONCE(current_thread_info()->preempt.count);
> +}
> +
> +static inline void preempt_count_set(u64 pc)
> +{
> +       /* Preserve existing value of PREEMPT_NEED_RESCHED */
> +       WRITE_ONCE(current_thread_info()->preempt.count, pc);
> +}
> +
> +#define init_task_preempt_count(p) do { \
> +       task_thread_info(p)->preempt_count = FORK_PREEMPT_COUNT; \
> +} while (0)
> +
> +#define init_idle_preempt_count(p, cpu) do { \
> +       task_thread_info(p)->preempt_count = PREEMPT_ENABLED; \
> +} while (0)
> +
> +static inline void set_preempt_need_resched(void)
> +{
> +       current_thread_info()->preempt.need_resched = 0;
> +}
> +
> +static inline void clear_preempt_need_resched(void)
> +{
> +       current_thread_info()->preempt.need_resched = 1;
> +}
> +
> +static inline bool test_preempt_need_resched(void)
> +{
> +       return !current_thread_info()->preempt.need_resched;
> +}
> +
> +static inline void __preempt_count_add(int val)
> +{
> +       u32 pc = READ_ONCE(current_thread_info()->preempt.count);
> +       pc += val;
> +       WRITE_ONCE(current_thread_info()->preempt.count, pc);
> +}
> +
> +static inline void __preempt_count_sub(int val)
> +{
> +       u32 pc = READ_ONCE(current_thread_info()->preempt.count);
> +       pc -= val;
> +       WRITE_ONCE(current_thread_info()->preempt.count, pc);
> +}
> +
> +static inline bool __preempt_count_dec_and_test(void)
> +{
> +       u64 pc = READ_ONCE(current_thread_info()->preempt_count);
> +       WRITE_ONCE(current_thread_info()->preempt.count, --pc);
> +       return !pc;
> +}
> +
> +static inline bool should_resched(int preempt_offset)
> +{
> +       u64 pc = READ_ONCE(current_thread_info()->preempt_count);
> +       return pc == preempt_offset;
> +}
> +
> +#ifdef CONFIG_PREEMPT
> +void preempt_schedule(void);
> +#define __preempt_schedule() preempt_schedule()
> +void preempt_schedule_notrace(void);
> +#define __preempt_schedule_notrace() preempt_schedule_notrace()
> +#endif /* CONFIG_PREEMPT */
> +
> +#endif /* __ASM_PREEMPT_H */
> diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
> index cb2c10a8f0a8..bbca68b54732 100644
> --- a/arch/arm64/include/asm/thread_info.h
> +++ b/arch/arm64/include/asm/thread_info.h
> @@ -42,7 +42,18 @@ struct thread_info {
>  #ifdef CONFIG_ARM64_SW_TTBR0_PAN
>         u64                     ttbr0;          /* saved TTBR0_EL1 */
>  #endif
> -       int                     preempt_count;  /* 0 => preemptable, <0 => bug */
> +       union {
> +               u64             preempt_count;  /* 0 => preemptible, <0 => bug */
> +               struct {
> +#ifdef CONFIG_CPU_BIG_ENDIAN
> +                       u32     need_resched;
> +                       u32     count;
> +#else
> +                       u32     count;
> +                       u32     need_resched;
> +#endif
> +               } preempt;
> +       };
>  };
>
>  #define thread_saved_pc(tsk)   \
> --
> 2.1.4
>
