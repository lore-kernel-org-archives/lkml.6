Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B91CC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 20:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC7FD208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 20:30:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC7FD208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbeK1H34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 02:29:56 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:58262 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbeK1H34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 02:29:56 -0500
Received: from p4fea46ac.dip0.t-ipconnect.de ([79.234.70.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gRk0I-0002aP-VR; Tue, 27 Nov 2018 21:30:43 +0100
Date:   Tue, 27 Nov 2018 21:30:29 +0100 (CET)
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
Subject: Re: [patch V2 24/28] x86/speculation: Prepare arch_smt_update() for
 PRCTL mode
In-Reply-To: <070bd6a5-fd27-2b6d-efea-6d883ba1f8ec@amd.com>
Message-ID: <alpine.DEB.2.21.1811272125160.1875@nanos.tec.linutronix.de>
References: <20181125183328.318175777@linutronix.de> <20181125185005.759457117@linutronix.de> <070bd6a5-fd27-2b6d-efea-6d883ba1f8ec@amd.com>
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
> > +/* Update x86_spec_ctrl_base in case SMT state changed. */
> > +static void update_stibp_strict(void)
> >  {
> > -	wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
> > +	u64 mask = x86_spec_ctrl_base & ~SPEC_CTRL_STIBP;
> > +
> > +	if (sched_smt_active())
> > +		mask |= SPEC_CTRL_STIBP;
> > +
> > +	if (mask == x86_spec_ctrl_base)
> > +		return;
> > +
> > +	pr_info("Spectre v2 user space SMT mitigation: STIBP %s\n",
> > +		mask & SPEC_CTRL_STIBP ? "always-on" : "off");
> > +	x86_spec_ctrl_base = mask;
> > +	on_each_cpu(update_stibp_msr, NULL, 1);
> 
> Some more testing using spectre_v2_user=on and I've found that during boot
> up, once the first SMT thread is encountered no more updates to MSRs for
> STIBP are done for any CPUs brought up after that. The first SMT thread
> will cause mask != x86_spec_ctrl_base, but then x86_spec_ctrl_base is set
> to mask and the check always causes a return for subsequent CPUs that are
> brought up.

The above code merily handles the switch between SMT and non-SMT mode,
because there all other online CPUs need to be updated, but after that each
upcoming CPU calls x86_spec_ctrl_setup_ap() which will write the MSR. So
it's all good.

Thanks,

	tglx
