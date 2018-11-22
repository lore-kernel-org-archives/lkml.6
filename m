Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78D3C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 09:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4D3C20663
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 09:07:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4D3C20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393411AbeKVTqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 14:46:16 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:46763 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730412AbeKVTqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 14:46:15 -0500
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gPkxR-00019k-VJ; Thu, 22 Nov 2018 10:07:34 +0100
Date:   Thu, 22 Nov 2018 10:07:33 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Borislav Petkov <bp@alien8.de>
cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>,
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
Subject: Re: [patch 15/24] x86/speculation: Add command line control for
 indirect branch speculation
In-Reply-To: <alpine.DEB.2.21.1811220048080.1665@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1811221002560.1571@nanos.tec.linutronix.de>
References: <20181121201430.559770965@linutronix.de> <20181121201723.764150349@linutronix.de> <20181121234312.GI27559@zn.tnic> <alpine.DEB.2.21.1811220048080.1665@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Nov 2018, Thomas Gleixner wrote:
> On Thu, 22 Nov 2018, Borislav Petkov wrote:
> > > +
> > > +	/* Initialize Indirect Branch Prediction Barrier */
> > > +	if (boot_cpu_has(X86_FEATURE_IBPB)) {
> > > +		setup_force_cpu_cap(X86_FEATURE_USE_IBPB);
> > > +		pr_info("Spectre v2 mitigation: Enabling Indirect Branch Prediction Barrier\n");
> > > +	}
> > 
> > So AFAICT, if coming in here with AUTO, we won't enable IBPB and I
> > *think* AMD wants IBPB enabled. At least the whitepaper says:
> > 
> > "IBPB combined with Reptoline software support is the AMD recommended
> > setting for Linux mitigation of Google Project Zero Variant 2
> > (Spectre)."
> 
> Ok. That's indeed a step backwards, because we don't do IBPB in KVM
> anymore. I'll fix that tomorrow morning when brain is more awake.

OTOH, off means that all of it is disabled. Which was the case already
before this when spectre_v2=off is on the command line.

Now with the default to prctl/seccomp the IBPB in KVM is enabled. So no
change there.

> IBPB on context switch is controlled separately anyway now, so that's a
> nobrainer to sort out.
> 
> Though I wait for Toms answer whether we really want IBPB on context switch
> for AMD by default.

That still stands. But if we want to do that, then we need to optimize it a
bit. Isn't that hard, but ...

Thanks,

	tglx
