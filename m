Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51325C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1340020865
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:14:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1340020865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389778AbeKVSxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 13:53:18 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:46613 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733142AbeKVSxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 13:53:18 -0500
Received: from p4fea46ac.dip0.t-ipconnect.de ([79.234.70.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gPk8O-0008RQ-6c; Thu, 22 Nov 2018 09:14:48 +0100
Date:   Thu, 22 Nov 2018 09:14:47 +0100 (CET)
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
In-Reply-To: <20181121234312.GI27559@zn.tnic>
Message-ID: <alpine.DEB.2.21.1811220048080.1665@nanos.tec.linutronix.de>
References: <20181121201430.559770965@linutronix.de> <20181121201723.764150349@linutronix.de> <20181121234312.GI27559@zn.tnic>
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

On Thu, 22 Nov 2018, Borislav Petkov wrote:
> > +
> > +	/* Initialize Indirect Branch Prediction Barrier */
> > +	if (boot_cpu_has(X86_FEATURE_IBPB)) {
> > +		setup_force_cpu_cap(X86_FEATURE_USE_IBPB);
> > +		pr_info("Spectre v2 mitigation: Enabling Indirect Branch Prediction Barrier\n");
> > +	}
> 
> So AFAICT, if coming in here with AUTO, we won't enable IBPB and I
> *think* AMD wants IBPB enabled. At least the whitepaper says:
> 
> "IBPB combined with Reptoline software support is the AMD recommended
> setting for Linux mitigation of Google Project Zero Variant 2
> (Spectre)."

Ok. That's indeed a step backwards, because we don't do IBPB in KVM
anymore. I'll fix that tomorrow morning when brain is more awake.

IBPB on context switch is controlled separately anyway now, so that's a
nobrainer to sort out.

Though I wait for Toms answer whether we really want IBPB on context switch
for AMD by default.

Thanks,

	tglx
