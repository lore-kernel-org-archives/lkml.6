Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1F9C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 23:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0EB120838
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 23:45:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0EB120838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439155AbeKWK1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 05:27:16 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:49249 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439142AbeKWK1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 05:27:16 -0500
Received: from p4fea46ac.dip0.t-ipconnect.de ([79.234.70.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gPyeu-0006Fr-3S; Fri, 23 Nov 2018 00:45:20 +0100
Date:   Fri, 23 Nov 2018 00:45:19 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ingo Molnar <mingo@kernel.org>
cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
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
Subject: Re: [patch 24/24] x86/speculation: Add seccomp Spectre v2 app to
 app protection mode
In-Reply-To: <20181122072619.GC41788@gmail.com>
Message-ID: <alpine.DEB.2.21.1811230042360.1665@nanos.tec.linutronix.de>
References: <20181121201430.559770965@linutronix.de> <20181121201724.602740969@linutronix.de> <20181122072619.GC41788@gmail.com>
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

On Thu, 22 Nov 2018, Ingo Molnar wrote:
> > +	[SPECTRE_V2_APP2APP_SECCOMP]	= "App-App Mitigation: seccomp and prctl opt-in",
> 
> This description is not accurate: it's not a 'seccomp and prctl opt-in', 
> the seccomp functionality is opt-out, the prctl is opt-in.
> 
> So something like:
> 
> > +	[SPECTRE_V2_APP2APP_SECCOMP]	= "App-App Mitigation: seccomp by default and prctl opt-in",

Na. I just make it: "prctl" and "seccomp + prctl" 

> >  void arch_seccomp_spec_mitigate(struct task_struct *task)
> >  {
> >  	if (ssb_mode == SPEC_STORE_BYPASS_SECCOMP)
> >  		ssb_prctl_set(task, PR_SPEC_FORCE_DISABLE);
> > +	if (spectre_v2_app2app == SPECTRE_V2_APP2APP_SECCOMP)
> > +		indir_branch_prctl_set(task, PR_SPEC_FORCE_DISABLE);
> >  }
> >  #endif
> 
> Hm, so isn't arch_seccomp_spec_mitigate() called right before untrusted 
> seccomp code is executed? So why are we disabling the mitigation here?

It disables the CPU speculation misfeature not the mitigation. And no, we
are not going to change it because the constants are user space ABI today.

Thanks,

	tglx


