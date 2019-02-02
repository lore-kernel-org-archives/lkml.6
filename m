Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8800C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 17:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 990E62083B
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 17:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549127858;
	bh=24a0LauQNznepneUW/7Bv/Md29M2ImLAc3+uQJbDo5M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fVqDJe/+vqqFdaW6fL67yc/xtfWSA3k/O/RRiGWsIw7pvEieYYW8814tkKUtARDU+
	 2v1UJ+IXdaVMMW6yLemJltaxuQp1u15Fs57Db8X8yK0HfqXkgVaQTyFE2ASWnwbdK0
	 3H+YZdo/M/0AOeng9DnIOPYkxahN9CtvgNlfJhLw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbfBBRRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 12:17:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:54956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbfBBRRg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 12:17:36 -0500
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A00321736
        for <linux-kernel@vger.kernel.org>; Sat,  2 Feb 2019 17:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549127855;
        bh=24a0LauQNznepneUW/7Bv/Md29M2ImLAc3+uQJbDo5M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sOCvd+cKddkbA1YOlmfHa12qphRCFfJcCDk4P/zS+HvDdiIsKErmFy3xJxYsqsSAa
         njZkiVS/Wv9EibeXzuvLFFPfyKIZHkGyW7j6xhTbIY7WPQjNpDUa+kesMaDja80A39
         YajAHrbiUx3vO5j8SDtuPHzkQ+zH2ur5DThgy4TM=
Received: by mail-wm1-f42.google.com with SMTP id g67so9252043wmd.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Feb 2019 09:17:35 -0800 (PST)
X-Gm-Message-State: AHQUAuaCjGtxm0TMvfuEFgHRLUFaZjY+UDfqBopyFYGd0BAFjbPlPxLe
        nT0K0cjZxw7zsZV5ZPOtek2TjzCMfIo80QadPL899g==
X-Google-Smtp-Source: AHgI3Ib/rrukX2o+2ynnHgmyBoKxoh4veyjphtV7vr0eNDtf5UaOG+u9/VUZ5ObK3ejINXFknVW2BJnOcFyzUOYo25U=
X-Received: by 2002:a1c:b1d5:: with SMTP id a204mr7296202wmf.32.1549127854036;
 Sat, 02 Feb 2019 09:17:34 -0800 (PST)
MIME-Version: 1.0
References: <20190201205319.15995-1-chang.seok.bae@intel.com> <20190201205319.15995-10-chang.seok.bae@intel.com>
In-Reply-To: <20190201205319.15995-10-chang.seok.bae@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 2 Feb 2019 09:17:22 -0800
X-Gmail-Original-Message-ID: <CALCETrU0LD_sZOM2d6dSbnvEbs=zsVxEiy6dPp0w+AJO2JZf3A@mail.gmail.com>
Message-ID: <CALCETrU0LD_sZOM2d6dSbnvEbs=zsVxEiy6dPp0w+AJO2JZf3A@mail.gmail.com>
Subject: Re: [PATCH v5 08/13] x86/fsgsbase/64: Introduce the FIND_PERCPU_BASE macro
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 1, 2019 at 12:55 PM Chang S. Bae <chang.seok.bae@intel.com> wrote:
>
> GSBASE is used to find per-CPU data in the kernel. But when it is unknown,
> the per-CPU base can be found from the per_cpu_offset table with a CPU NR.
> The CPU NR is extracted from the limit field of the CPUNODE entry in GDT,
> or by the RDPID instruction.
>
> Also, add the GAS-compatible RDPID macro.
>
> The new macro will be used on a following patch.
>
> Suggested-by: H. Peter Anvin <hpa@zytor.com>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> ---
>  arch/x86/include/asm/fsgsbase.h | 46 +++++++++++++++++++++++++++++++++
>  arch/x86/include/asm/inst.h     | 15 +++++++++++
>  2 files changed, 61 insertions(+)
>
> diff --git a/arch/x86/include/asm/fsgsbase.h b/arch/x86/include/asm/fsgsbase.h
> index aefd53767a5d..eecca2250748 100644
> --- a/arch/x86/include/asm/fsgsbase.h
> +++ b/arch/x86/include/asm/fsgsbase.h
> @@ -78,6 +78,52 @@ extern void x86_gsbase_write_cpu_inactive(unsigned long gsbase);
>
>  #endif /* CONFIG_X86_64 */
>
> +#else /* __ASSEMBLY__ */
> +
> +#ifdef CONFIG_X86_64
> +
> +#include <asm/inst.h>
> +
> +#if CONFIG_SMP

ifdef?

> +
> +/*
> + * CPU/node NR is loaded from the limit (size) field of a special segment
> + * descriptor entry in GDT.
> + */
> +.macro LOAD_CPU_AND_NODE_SEG_LIMIT reg:req
> +       movq    $__CPUNODE_SEG, \reg
> +       lsl     \reg, \reg
> +.endm
> +

Please put the alternative in here instead of in FIND_PERCPU_BASE.

> +/*
> + * Fetch the per-CPU GSBASE value for this processor and put it in @reg.
> + * We normally use %gs for accessing per-CPU data, but we are setting up
> + * %gs here and obviously can not use %gs itself to access per-CPU data.
> + */
> +.macro FIND_PERCPU_BASE reg:req
> +       /*
> +        * The CPU/node NR is initialized earlier, directly in cpu_init().
> +        * The CPU NR is extracted from it.
> +        */

This comment is unnecessary.

> +       ALTERNATIVE \
> +               "LOAD_CPU_AND_NODE_SEG_LIMIT \reg", \
> +               "RDPID  \reg", \
> +               X86_FEATURE_RDPID
> +       andq    $VDSO_CPUNODE_MASK, \reg
> +       movq    __per_cpu_offset(, \reg, 8), \reg
> +.endm
> +
> +#else
> +
> +.macro FIND_PERCPU_BASE reg:req
> +       /* Tracking the base offset value */

I don't understand this comment at all.  Please just remove it.
