Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A587DC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 20:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 751142145D
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 20:39:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 751142145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbeK1Hiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 02:38:54 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:58290 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbeK1Hiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 02:38:54 -0500
Received: from p4fea46ac.dip0.t-ipconnect.de ([79.234.70.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gRk92-0002mi-SR; Tue, 27 Nov 2018 21:39:45 +0100
Date:   Tue, 27 Nov 2018 21:39:44 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Stewart <david.c.stewart@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [patch V2 18/28] x86/speculation: Prepare for per task indirect
 branch speculation control
In-Reply-To: <7ec59a1a-4caf-24f6-3466-ee1d01594861@amd.com>
Message-ID: <alpine.DEB.2.21.1811272138290.1875@nanos.tec.linutronix.de>
References: <20181125183328.318175777@linutronix.de> <20181125185005.176917199@linutronix.de> <7ec59a1a-4caf-24f6-3466-ee1d01594861@amd.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Nov 2018, Lendacky, Thomas wrote:
> On 11/25/2018 12:33 PM, Thomas Gleixner wrote:
> > --- a/arch/x86/kernel/process.c
> > +++ b/arch/x86/kernel/process.c
> > @@ -406,6 +406,11 @@ static __always_inline void spec_ctrl_up
> >  	if (static_cpu_has(X86_FEATURE_SSBD))
> >  		msr |= ssbd_tif_to_spec_ctrl(tifn);
> 
> I did some quick testing and found my original logic was flawed. Since
> spec_ctrl_update_msr() can now be called for STIBP, an additional check
> is needed to set the SSBD MSR bit.
> 
> Both X86_FEATURE_VIRT_SSBD and X86_FEATURE_LS_CFG_SSBD cause
> X86_FEATURE_SSBD to be set. Before this patch, spec_ctrl_update_msr() was
> only called if X86_FEATURE_SSBD was set and one of the other SSBD features
> wasn't set. But now, STIBP can cause spec_ctrl_update_msr() to get called
> and cause the SSBD MSR bit to be set when it shouldn't (could result in
> a GP fault).

The below should fix that. We have the same logic in x86_virt_spec_ctrl()

Thanks,

	tglx

8<---------------
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -403,10 +403,11 @@ static __always_inline void spec_ctrl_up
 	u64 msr = x86_spec_ctrl_base;
 
 	/*
-	 * If X86_FEATURE_SSBD is not set, the SSBD bit is not to be
-	 * touched.
+	 * If SSBD is not controlled in MSR_SPEC_CTRL, the SSBD bit has not
+	 * to be touched.
 	 */
-	if (static_cpu_has(X86_FEATURE_SSBD))
+	if (static_cpu_has(X86_FEATURE_SPEC_CTRL_SSBD) ||
+	    static_cpu_has(X86_FEATURE_AMD_SSBD))
 		msr |= ssbd_tif_to_spec_ctrl(tifn);
 
 	/* Only evaluate if conditional STIBP is enabled */
