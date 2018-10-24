Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02427ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 19:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A216A2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 19:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1Q/3yNr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A216A2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbeJYDqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 23:46:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:51090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726433AbeJYDqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 23:46:12 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BD5B2084A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 19:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540408614;
        bh=6Jj0roqAEQx2ASP0o35natrHoQiitq11zKCVsJwB8JA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=f1Q/3yNr31lbZsnbGPGQFbD9Fig7yXhLzvxHtMZP33c57AAttwUmbAoeI3dEs0W9Y
         YVz/dBxNeRMGYTTQAc1/54i8PwDC2xshnJlkLTCN3EJvfdXTItV455SLhbje1WFptx
         ZSfRtSDzd7jJDu1KlPMBlV2qLFuDrsyGVVGjBO38=
Received: by mail-wr1-f41.google.com with SMTP id q6-v6so6782512wrw.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 12:16:54 -0700 (PDT)
X-Gm-Message-State: AGRZ1gJgkEku9vOyPloul5QKpSGMoLwikEPFuyLxPplxd1BzDTyPwlIV
        w6qhrwPyVTaSF4miaSNgD1mf+4Xsictkgps6KaNFFw==
X-Google-Smtp-Source: AJdET5eE0HtpQ3Y58R2RGYox6V1bx5VZKprdEZ3hkJg6spNtZVe/ZlrEXbjjmxvY6+/fLWr7ItLdw0SwRKijPi/tTTo=
X-Received: by 2002:adf:b1db:: with SMTP id r27-v6mr1049320wra.95.1540408612532;
 Wed, 24 Oct 2018 12:16:52 -0700 (PDT)
MIME-Version: 1.0
References: <20181023184234.14025-1-chang.seok.bae@intel.com> <20181023184234.14025-5-chang.seok.bae@intel.com>
In-Reply-To: <20181023184234.14025-5-chang.seok.bae@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 24 Oct 2018 12:16:40 -0700
X-Gmail-Original-Message-ID: <CALCETrVcJ08c6yf6y3ruOA_Hx_7srkHw5iYfx1c2p8_ySiL2WA@mail.gmail.com>
Message-ID: <CALCETrVcJ08c6yf6y3ruOA_Hx_7srkHw5iYfx1c2p8_ySiL2WA@mail.gmail.com>
Subject: Re: [v3 04/12] x86/fsgsbase/64: Enable FSGSBASE instructions in the
 helper functions
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        xen-devel <xen-devel@lists.xenproject.org>
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
> The helper functions will switch on faster accesses to FSBASE and GSBASE
> when the FSGSBASE feature is enabled.
>
> Accessing user GSBASE needs a couple of SWAPGS operations. It is avoidable
> if the user GSBASE is saved at kernel entry, being updated as changes, and
> restored back at kernel exit. However, it seems to spend more cycles for
> savings and restorations. Little or no benefit was measured from
> experiments.
>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Cc: Any Lutomirski <luto@kernel.org>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> ---
>  arch/x86/include/asm/fsgsbase.h | 17 +++----
>  arch/x86/kernel/process_64.c    | 82 +++++++++++++++++++++++++++------
>  2 files changed, 75 insertions(+), 24 deletions(-)
>
> diff --git a/arch/x86/include/asm/fsgsbase.h b/arch/x86/include/asm/fsgsbase.h
> index b4d4509b786c..e500d771155f 100644
> --- a/arch/x86/include/asm/fsgsbase.h
> +++ b/arch/x86/include/asm/fsgsbase.h
> @@ -57,26 +57,23 @@ static __always_inline void wrgsbase(unsigned long gsbase)
>                         : "memory");
>  }
>
> +#include <asm/cpufeature.h>
> +
>  /* Helper functions for reading/writing FS/GS base */
>
>  static inline unsigned long x86_fsbase_read_cpu(void)
>  {
>         unsigned long fsbase;
>
> -       rdmsrl(MSR_FS_BASE, fsbase);
> +       if (static_cpu_has(X86_FEATURE_FSGSBASE))
> +               fsbase = rdfsbase();
> +       else
> +               rdmsrl(MSR_FS_BASE, fsbase);
>
>         return fsbase;
>  }
>
> -static inline unsigned long x86_gsbase_read_cpu_inactive(void)
> -{
> -       unsigned long gsbase;
> -
> -       rdmsrl(MSR_KERNEL_GS_BASE, gsbase);
> -
> -       return gsbase;
> -}
> -
> +extern unsigned long x86_gsbase_read_cpu_inactive(void);
>  extern void x86_fsbase_write_cpu(unsigned long fsbase);
>  extern void x86_gsbase_write_cpu_inactive(unsigned long gsbase);
>
> diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
> index 31b4755369f0..fcf18046c3d6 100644
> --- a/arch/x86/kernel/process_64.c
> +++ b/arch/x86/kernel/process_64.c
> @@ -159,6 +159,36 @@ enum which_selector {
>         GS
>  };
>
> +/*
> + * Interrupts are disabled here. Out of line to be protected from kprobes.
> + */
> +static noinline __kprobes unsigned long rd_inactive_gsbase(void)
> +{
> +       unsigned long gsbase, flags;
> +
> +       local_irq_save(flags);
> +       native_swapgs();
> +       gsbase = rdgsbase();
> +       native_swapgs();
> +       local_irq_restore(flags);
> +
> +       return gsbase;
> +}

Please fold this into its only caller and make *that* noinline.

Also, this function, and its "write" equivalent, will access the
*active* gsbase.  So it either needs to be fixed for Xen PV or some
clear comment and careful auditing needs to be added to ensure that
it's not used on Xen PV.  Or it needs to be renamed
native_x86_fsgsbase_... and add paravirt hooks, since Xen PV allows a
very efficient but different implementation, I think.  The latter is
probably the right solution.

(Hi Xen people -- how does CR4.FSGSBASE work on Xen?  Is it always
set?  Never set?  Set only if the guest tries to set it?)

>  void x86_fsbase_write_cpu(unsigned long fsbase)
>  {
> -       /*
> -        * Set the selector to 0 as a notion, that the segment base is
> -        * overwritten, which will be checked for skipping the segment load
> -        * during context switch.
> -        */
> -       loadseg(FS, 0);
> -       wrmsrl(MSR_FS_BASE, fsbase);
> +       if (static_cpu_has(X86_FEATURE_FSGSBASE)) {
> +               wrfsbase(fsbase);
> +       } else {
> +               /*
> +                * Set the selector to 0 as a notion, that the segment base is
> +                * overwritten, which will be checked for skipping the segment load
> +                * during context switch.
> +                */
> +               loadseg(FS, 0);
> +               wrmsrl(MSR_FS_BASE, fsbase);
> +       }
>  }
>
>  void x86_gsbase_write_cpu_inactive(unsigned long gsbase)
>  {
> -       /* Set the selector to 0 for the same reason as %fs above. */
> -       loadseg(GS, 0);
> -       wrmsrl(MSR_KERNEL_GS_BASE, gsbase);
> +       if (static_cpu_has(X86_FEATURE_FSGSBASE)) {
> +               wr_inactive_gsbase(gsbase);
> +       } else {
> +               /* Set the selector to 0 for the same reason as %fs above. */
> +               loadseg(GS, 0);
> +               wrmsrl(MSR_KERNEL_GS_BASE, gsbase);

I still don't get what this code is trying to do.  See other email.  I
think it will straight up crash the kernel on some CPUs, since writing
0 to %%gs will zero out the *active* base on some CPUs.

I think that, if you really want some fancy optimization for the
non-FSGSBASE case, you need to pull that out into the callers of these
helpers.
