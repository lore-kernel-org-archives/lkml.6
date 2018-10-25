Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDBCC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 23:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9958D20848
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 23:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="et3o8djl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9958D20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbeJZHqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 03:46:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:52622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727793AbeJZHqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 03:46:21 -0400
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F04B020856
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 23:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540509106;
        bh=CM/Nl0VPUQI8qC91xY5PGwE571W56V8606PGttUWoJk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=et3o8djlunCQ5mavVssWVdkag5z/Sejrvoj0j7guHdElnxTXlzj2K6y4RsFwYaSJk
         +u9pJh8mGCBAwooSvdTwm3GEaUFLIGmO3yfDOJl+pJSjlkDz++VfFSLf65824eCNFm
         eWcfCcuy0dFOFnMo4CJN0b57T8eflqVGAzyKfzKQ=
Received: by mail-wm1-f54.google.com with SMTP id y144-v6so3031176wmd.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 16:11:45 -0700 (PDT)
X-Gm-Message-State: AGRZ1gLPpa+s8WAhRrvtMynW7+Y5+ziexs2IJkDihctl7YGEwFWZdV1X
        zCGcsgjgiEVcXcEmsoYael5t7YefTe7Rz0lqeMhqhg==
X-Google-Smtp-Source: AJdET5fzzoVdQfxLVJUze1Md+GEhSgzMOp7eq2Vqqj/lPYMIbkS7yw+mW7+DA+yUVohecjBn0Snz0TtKWP0hme779AM=
X-Received: by 2002:a1c:1fcd:: with SMTP id f196-v6mr3539129wmf.19.1540509104348;
 Thu, 25 Oct 2018 16:11:44 -0700 (PDT)
MIME-Version: 1.0
References: <20181023184234.14025-1-chang.seok.bae@intel.com>
 <20181023184234.14025-5-chang.seok.bae@intel.com> <CALCETrVcJ08c6yf6y3ruOA_Hx_7srkHw5iYfx1c2p8_ySiL2WA@mail.gmail.com>
 <0d64fe9d-0cc3-5901-0d6f-4bcb94aa9ee4@citrix.com> <9b0a8b86-6949-837e-8a20-a5e934ed2b63@suse.com>
 <9b8b66e4-6a47-7320-be00-c75fed725878@citrix.com>
In-Reply-To: <9b8b66e4-6a47-7320-be00-c75fed725878@citrix.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 25 Oct 2018 16:11:30 -0700
X-Gmail-Original-Message-ID: <CALCETrVenqa1erKJFxcafPHVvLnMLJj-QO_ntDWd-X27OXRhwQ@mail.gmail.com>
Message-ID: <CALCETrVenqa1erKJFxcafPHVvLnMLJj-QO_ntDWd-X27OXRhwQ@mail.gmail.com>
Subject: Re: [Xen-devel] [v3 04/12] x86/fsgsbase/64: Enable FSGSBASE
 instructions in the helper functions
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Andrew Lutomirski <luto@kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel <xen-devel@lists.xenproject.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 4:09 PM Andrew Cooper <andrew.cooper3@citrix.com> wrote:
>
> On 25/10/2018 07:09, Juergen Gross wrote:
> > On 24/10/2018 21:41, Andrew Cooper wrote:
> >> On 24/10/18 20:16, Andy Lutomirski wrote:
> >>> On Tue, Oct 23, 2018 at 11:43 AM Chang S. Bae <chang.seok.bae@intel.com> wrote:
> >>>> The helper functions will switch on faster accesses to FSBASE and GSBASE
> >>>> when the FSGSBASE feature is enabled.
> >>>>
> >>>> Accessing user GSBASE needs a couple of SWAPGS operations. It is avoidable
> >>>> if the user GSBASE is saved at kernel entry, being updated as changes, and
> >>>> restored back at kernel exit. However, it seems to spend more cycles for
> >>>> savings and restorations. Little or no benefit was measured from
> >>>> experiments.
> >>>>
> >>>> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> >>>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> >>>> Cc: Any Lutomirski <luto@kernel.org>
> >>>> Cc: H. Peter Anvin <hpa@zytor.com>
> >>>> Cc: Thomas Gleixner <tglx@linutronix.de>
> >>>> Cc: Ingo Molnar <mingo@kernel.org>
> >>>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> >>>> ---
> >>>>  arch/x86/include/asm/fsgsbase.h | 17 +++----
> >>>>  arch/x86/kernel/process_64.c    | 82 +++++++++++++++++++++++++++------
> >>>>  2 files changed, 75 insertions(+), 24 deletions(-)
> >>>>
> >>>> diff --git a/arch/x86/include/asm/fsgsbase.h b/arch/x86/include/asm/fsgsbase.h
> >>>> index b4d4509b786c..e500d771155f 100644
> >>>> --- a/arch/x86/include/asm/fsgsbase.h
> >>>> +++ b/arch/x86/include/asm/fsgsbase.h
> >>>> @@ -57,26 +57,23 @@ static __always_inline void wrgsbase(unsigned long gsbase)
> >>>>                         : "memory");
> >>>>  }
> >>>>
> >>>> +#include <asm/cpufeature.h>
> >>>> +
> >>>>  /* Helper functions for reading/writing FS/GS base */
> >>>>
> >>>>  static inline unsigned long x86_fsbase_read_cpu(void)
> >>>>  {
> >>>>         unsigned long fsbase;
> >>>>
> >>>> -       rdmsrl(MSR_FS_BASE, fsbase);
> >>>> +       if (static_cpu_has(X86_FEATURE_FSGSBASE))
> >>>> +               fsbase = rdfsbase();
> >>>> +       else
> >>>> +               rdmsrl(MSR_FS_BASE, fsbase);
> >>>>
> >>>>         return fsbase;
> >>>>  }
> >>>>
> >>>> -static inline unsigned long x86_gsbase_read_cpu_inactive(void)
> >>>> -{
> >>>> -       unsigned long gsbase;
> >>>> -
> >>>> -       rdmsrl(MSR_KERNEL_GS_BASE, gsbase);
> >>>> -
> >>>> -       return gsbase;
> >>>> -}
> >>>> -
> >>>> +extern unsigned long x86_gsbase_read_cpu_inactive(void);
> >>>>  extern void x86_fsbase_write_cpu(unsigned long fsbase);
> >>>>  extern void x86_gsbase_write_cpu_inactive(unsigned long gsbase);
> >>>>
> >>>> diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
> >>>> index 31b4755369f0..fcf18046c3d6 100644
> >>>> --- a/arch/x86/kernel/process_64.c
> >>>> +++ b/arch/x86/kernel/process_64.c
> >>>> @@ -159,6 +159,36 @@ enum which_selector {
> >>>>         GS
> >>>>  };
> >>>>
> >>>> +/*
> >>>> + * Interrupts are disabled here. Out of line to be protected from kprobes.
> >>>> + */
> >>>> +static noinline __kprobes unsigned long rd_inactive_gsbase(void)
> >>>> +{
> >>>> +       unsigned long gsbase, flags;
> >>>> +
> >>>> +       local_irq_save(flags);
> >>>> +       native_swapgs();
> >>>> +       gsbase = rdgsbase();
> >>>> +       native_swapgs();
> >>>> +       local_irq_restore(flags);
> >>>> +
> >>>> +       return gsbase;
> >>>> +}
> >>> Please fold this into its only caller and make *that* noinline.
> >>>
> >>> Also, this function, and its "write" equivalent, will access the
> >>> *active* gsbase.  So it either needs to be fixed for Xen PV or some
> >>> clear comment and careful auditing needs to be added to ensure that
> >>> it's not used on Xen PV.  Or it needs to be renamed
> >>> native_x86_fsgsbase_... and add paravirt hooks, since Xen PV allows a
> >>> very efficient but different implementation, I think.  The latter is
> >>> probably the right solution.
> >>>
> >>> (Hi Xen people -- how does CR4.FSGSBASE work on Xen?  Is it always
> >>> set?  Never set?  Set only if the guest tries to set it?)
> >> FML.  Seriously - whoever put this code into the hypervisor in the past
> >> did an atrocious job.  After some experimentation, you're going to be
> >> sad and I'm declaring this borderline unusable.
> >>
> >> Looks like Xen unconditionally enabled CR4.FSGSBASE if it is available.
> >> Therefore, PV guests can use the instructions, even if the bit is clear
> >> in vCR4.
> >>
> >> The CPUID bits are exposed to guests by default, and Xen will emulate
> >> vCR4.FSGSBASE being set and cleared.
> >>
> >> We don't however emulate swapgs (which is a cpl0 instruction).  The
> >> guest gets handed a #GP[0] instead.
> >>
> >> The Linux WRMSR PVop uses the set_segment_base() hypercall in instead of
> >> going through the full wrmsr emulation path.
> >>
> >> There is no equivalent get hypercall, so the only way I can see of
> >> getting the value is to actually read MSR_KERNEL_GS_BASE and take the
> >> full rdmsr emulation path.
> > Or shadow the value in a percpu variable.
>
> Hmm true, so long as no paths try to use native_rd{fs,gs}base() to
> bypass the PVop.

But *user* code can change the base.  How is the kernel supposed to
context-switch the user gsbase?
