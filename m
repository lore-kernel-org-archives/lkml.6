Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028A1C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C34DB2080C
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:22:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C34DB2080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732085AbeKTKsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 05:48:51 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:40092 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbeKTKsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 05:48:50 -0500
Received: from p4fea46ac.dip0.t-ipconnect.de ([79.234.70.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gOtnz-0006MG-4g; Tue, 20 Nov 2018 01:22:15 +0100
Date:   Tue, 20 Nov 2018 01:22:14 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andrea Arcangeli <aarcange@redhat.com>
cc:     Dave Hansen <dave.hansen@intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: Re: [Patch v5 11/16] x86/speculation: Add Spectre v2 app to app
 protection modes
In-Reply-To: <20181119231649.GI29258@redhat.com>
Message-ID: <alpine.DEB.2.21.1811200105250.1669@nanos.tec.linutronix.de>
References: <cover.1542418936.git.tim.c.chen@linux.intel.com> <ca5dd01c12789d3f75ab1b73bfcac3bdaea93dd6.1542418937.git.tim.c.chen@linux.intel.com> <nycvar.YFH.7.76.1811171044510.21108@cbobk.fhfr.pm> <nycvar.YFH.7.76.1811182358370.21108@cbobk.fhfr.pm>
 <alpine.DEB.2.21.1811191433100.1537@nanos.tec.linutronix.de> <nycvar.YFH.7.76.1811191438290.21108@cbobk.fhfr.pm> <20181119193253.GE29258@redhat.com> <4d102977-f516-e0b3-b728-e318e36c1449@intel.com> <20181119231649.GI29258@redhat.com>
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

On Mon, 19 Nov 2018, Andrea Arcangeli wrote:
> On Mon, Nov 19, 2018 at 01:33:08PM -0800, Dave Hansen wrote:
> > Here's the current description:
> > 
> > > Setting ... STIBP ... on a logical processor prevents the predicted
> > > targets of indirect branches on any logical processor of that core
>                                     ^^^
> > > from being controlled by software that executes (or executed
> > > previously) on another logical processor of the same core.
>                    ^^^^^^^
> > 
> > 1.
> > https://software.intel.com/security-software-guidance/insights/deep-dive-single-thread-indirect-branch-predictors
> 
> I'm not used to official specs in a "insight & deep dive"
> blog-post-like webpage, so I didn't notice this deep dive detail.

But you might have noticed the wording in:

  Speculative Execution Side Channel Mitigations
  Revision 2.0
  May 2018

which says:

  Setting bit 1 (STIBP) of the IA32_SPEC_CTRL MSR on a logical processor
  prevents the predicted targets of indirect branches on any logical
  processor of that core from being controlled by software that executes (or
  executed previously) on another logical processor of the same core.

i.e. exactly what Dave quoted from the deep dive thingy.

> You use "any" vs "any" but the spec you quoted still says "any" vs
> "another".
>
> If I shall take the above literally it still means that if I set STIBP
> inside SECCOMP, as long as it's set, it prevents indirect branches of
> all siblings to be controlled from code outside the SECCOMP jail
> running in another sibling (or that run previously in another
> sibling). I.e. the "deep dive" stronger semantics of STIBP just mean
> the code outside SECCOMP cannot attack itself while the code inside
> SECCOMP runs and keeps STIBP set.

The point is that when you enable STIBP on any sibling then all siblings of
the same core are protected against each other simply because the predictor
is shared. Otherwise you would hardly have sibling to sibling influence.

Yes, I agree the documentation is lousy, but I also agree with the
interpretation from Dave, Andi and Tim.

> If this is clarified the concern that remains is that lots of
> potentially performance critical stuff runs under SECCOMP but of
> course it changes everything in terms of possibly enabling STIBP under
> SECCOMP by default, it certainly would make more sense then.

Right. If this holds, which I assume, then enabling it for seccomp tasks
would make sense.

Thanks,

	tglx
