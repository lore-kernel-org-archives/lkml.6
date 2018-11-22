Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE25C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 09:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 687AF20663
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 09:08:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 687AF20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393429AbeKVTrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 14:47:08 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:46782 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730412AbeKVTrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 14:47:08 -0500
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gPkyN-0001DY-3v; Thu, 22 Nov 2018 10:08:31 +0100
Date:   Thu, 22 Nov 2018 10:08:30 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
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
        Kees Cook <keescook@chromium.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [patch 22/24] x86/speculation: Create PRCTL interface to restrict
 indirect branch speculation
In-Reply-To: <20181122090321.GI2131@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1811221008140.1571@nanos.tec.linutronix.de>
References: <20181121201430.559770965@linutronix.de> <20181121201724.414692525@linutronix.de> <20181122090321.GI2131@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Nov 2018, Peter Zijlstra wrote:

> On Wed, Nov 21, 2018 at 09:14:52PM +0100, Thomas Gleixner wrote:
> > @@ -1453,6 +1453,8 @@ static inline bool is_percpu_thread(void
> >  #define PFA_SPREAD_SLAB			2	/* Spread some slab caches over cpuset */
> >  #define PFA_SPEC_SSB_DISABLE		3	/* Speculative Store Bypass disabled */
> >  #define PFA_SPEC_SSB_FORCE_DISABLE	4	/* Speculative Store Bypass force disabled*/
> > +#define PFA_SPEC_INDIR_BRANCH_DISABLE	5	/* Indirect branch speculation restricted */
> > +#define PFA_SPEC_INDIR_BRANCH_FORCE_DISABLE 6	/* Indirect branch speculation permanentely restricted */
> >  
> >  #define TASK_PFA_TEST(name, func)					\
> >  	static inline bool task_##func(struct task_struct *p)		\
> > @@ -1484,6 +1486,13 @@ TASK_PFA_CLEAR(SPEC_SSB_DISABLE, spec_ss
> >  TASK_PFA_TEST(SPEC_SSB_FORCE_DISABLE, spec_ssb_force_disable)
> >  TASK_PFA_SET(SPEC_SSB_FORCE_DISABLE, spec_ssb_force_disable)
> >  
> > +TASK_PFA_TEST(SPEC_INDIR_BRANCH_DISABLE, spec_indir_branch_disable)
> > +TASK_PFA_SET(SPEC_INDIR_BRANCH_DISABLE, spec_indir_branch_disable)
> > +TASK_PFA_CLEAR(SPEC_INDIR_BRANCH_DISABLE, spec_indir_branch_disable)
> > +
> > +TASK_PFA_TEST(SPEC_INDIR_BRANCH_FORCE_DISABLE, spec_indir_branch_force_disable)
> > +TASK_PFA_SET(SPEC_INDIR_BRANCH_FORCE_DISABLE, spec_indir_branch_force_disable)
> > +
> >  static inline void
> >  current_restore_flags(unsigned long orig_flags, unsigned long flags)
> >  {
> 
> s/INDIR_BRANCH/IB/ would be consistent here with the SSB case.

Good point.

Thanks,

	tglx

