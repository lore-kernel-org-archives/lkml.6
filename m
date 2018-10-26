Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64042C46475
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 00:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC0C820848
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 00:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCOH9RGT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC0C820848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbeJZJAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 05:00:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:37364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725849AbeJZJAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 05:00:19 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F71520856
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 00:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540513531;
        bh=cRoT0wIbJUFXnXOn5R/x9mJBTNcYLM/+Yo+8yKhGZSg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QCOH9RGThf+yA4SIDis2hW2zMw66ObxsNg30dTjRjuJfDzVjL6E805H1MuPISDUxm
         Bet6Z+JmEjaE062TI39ZvlnPwZXE3gcnSGyC/L2zDrL7Zi6eNBN7wKWnEnbS0oF3j6
         hL0NfmfY4laiWt8WHagvYMlKvJXnHiAYg/GVzNCE=
Received: by mail-wr1-f44.google.com with SMTP id w5-v6so11076633wrt.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 17:25:31 -0700 (PDT)
X-Gm-Message-State: AGRZ1gL2XaPalr1au0YxopL5VpTNYe36Axab92r4QVXr+FF2ZYNio4Hy
        KYlx78k0owSHFKDCglfN+GTUkeiNW5+jmfRluJ4pWg==
X-Google-Smtp-Source: AJdET5e8twUQx9YyFjlTHl1gOoFeBSexAI5/E7J8YlPysfsPx2BGlKlod3YzEnZ6fOuDrXA4QV9is6X2SKmJXjeceeU=
X-Received: by 2002:adf:97d3:: with SMTP id t19-v6mr3921127wrb.283.1540513529521;
 Thu, 25 Oct 2018 17:25:29 -0700 (PDT)
MIME-Version: 1.0
References: <20181023184234.14025-1-chang.seok.bae@intel.com> <20181023184234.14025-8-chang.seok.bae@intel.com>
In-Reply-To: <20181023184234.14025-8-chang.seok.bae@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 25 Oct 2018 17:25:17 -0700
X-Gmail-Original-Message-ID: <CALCETrV-fmLpwsa7tXZ8J+G5PQ6s0yhYVhY3jtE=FP9gAXc+QQ@mail.gmail.com>
Message-ID: <CALCETrV-fmLpwsa7tXZ8J+G5PQ6s0yhYVhY3jtE=FP9gAXc+QQ@mail.gmail.com>
Subject: Re: [v3 07/12] x86/fsgsbase/64: Introduce the new FIND_PERCPU_BASE macro
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Nadav Amit <namit@vmware.com>
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
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> ---
>  arch/x86/include/asm/fsgsbase.h | 52 +++++++++++++++++++++++++++++++++
>  arch/x86/include/asm/inst.h     | 15 ++++++++++
>  2 files changed, 67 insertions(+)
>
> diff --git a/arch/x86/include/asm/fsgsbase.h b/arch/x86/include/asm/fsgsbase.h
> index e500d771155f..0c2d7d8a8c01 100644
> --- a/arch/x86/include/asm/fsgsbase.h
> +++ b/arch/x86/include/asm/fsgsbase.h
> @@ -111,6 +111,58 @@ extern void x86_gsbase_write_cpu_inactive(unsigned long gsbase);
>         MODRM 0xd0 wrgsbase_opd 1
>  .endm
>
> +#if CONFIG_SMP
> +
> +/*
> + * Fetch the per-CPU GSBASE value for this processor and put it in @reg.
> + * We normally use %gs for accessing per-CPU data, but we are setting up
> + * %gs here and obviously can not use %gs itself to access per-CPU data.
> + */
> +.macro FIND_PERCPU_BASE_RDPID reg:req
> +       /*
> +        * The CPU/node NR is initialized earlier, directly in cpu_init().
P
> +        */
> +       RDPID   \reg

I would suggest that you instead add a macro LOAD_CPU_AND_NODE \reg
and have that macro contain the alternative.  It can switch between
RDPID and LSL.  This way you avoid duplicating the rest of it.

This should end up in the same header as __getcpu() -- it probably
makes sense to just move __getcpu() for this purpose.

Also, hpa and Nadav, shouldn't asm/inst.h end up in macros.S?

--Andy
