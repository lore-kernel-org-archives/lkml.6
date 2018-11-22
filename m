Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9028C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 23:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CCC820818
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 23:17:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CCC820818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392630AbeKWJ7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 04:59:21 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:49203 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731444AbeKWJ7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 04:59:21 -0500
Received: from p4fea46ac.dip0.t-ipconnect.de ([79.234.70.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gPyE0-000647-Ts; Fri, 23 Nov 2018 00:17:33 +0100
Date:   Fri, 23 Nov 2018 00:17:32 +0100 (CET)
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
Subject: Re: [patch 21/24] x86/speculation: Prepare arch_smt_update() for
 PRCTL mode
In-Reply-To: <20181122073447.GD41788@gmail.com>
Message-ID: <alpine.DEB.2.21.1811230012530.1665@nanos.tec.linutronix.de>
References: <20181121201430.559770965@linutronix.de> <20181121201724.320605317@linutronix.de> <20181122073447.GD41788@gmail.com>
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
> * Thomas Gleixner <tglx@linutronix.de> wrote:
> > +static void update_stibp_msr(void *info)
> >  {
> > -	/* Enhanced IBRS makes using STIBP unnecessary. */
> > -	if (spectre_v2_enabled == SPECTRE_V2_IBRS_ENHANCED)
> > -		return false;
> > -
> > -	/* Check for strict app2app mitigation mode */
> > -	return spectre_v2_app2app == SPECTRE_V2_APP2APP_STRICT;
> > +	wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
> >  }
> 
> 
> Does Sparse or other tooling warn about unused function parameters? If 
> yes then it might make sense to mark it __used?

That would be __useless :)

> So I'm wondering, shouldn't firmware_restrict_branch_speculation_start()/_end()
> also enable/disable STIBP? It already enabled/disables IBRS.

IBRS includes STIBP. We don't use IBRS in the kernel otherwise because
you'd have to do more MSR writes on the protection boundaries.

We only use ENHANCED IBRS if it's available, which also makes STIBP
redundant.

Thanks,

	tglx
