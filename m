Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DADC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 18:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81B6B21473
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 18:46:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81B6B21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbeJFBqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 21:46:55 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:38865 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728958AbeJFBqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 21:46:55 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g8V7R-0006sW-9A; Fri, 05 Oct 2018 20:46:33 +0200
Date:   Fri, 5 Oct 2018 20:46:29 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Tim Chen <tim.c.chen@linux.intel.com>
cc:     Jiri Kosina <jikos@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [Patch v2 4/4] x86/speculation: Add prctl to control indirect
 branch speculation per process
In-Reply-To: <5a558b4e-e241-2ab8-3653-b25dc014b78d@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1810052046110.5454@nanos.tec.linutronix.de>
References: <cover.1537920575.git.tim.c.chen@linux.intel.com> <ae3fb86f74de2001ddab477579afd813bca9baa9.1537920575.git.tim.c.chen@linux.intel.com> <alpine.DEB.2.21.1810021949450.1435@nanos.tec.linutronix.de>
 <5a558b4e-e241-2ab8-3653-b25dc014b78d@linux.intel.com>
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

On Fri, 5 Oct 2018, Tim Chen wrote:

> On 10/02/2018 10:58 AM, Thomas Gleixner wrote:
> > On Tue, 25 Sep 2018, Tim Chen wrote:
> >>  
> >> +void arch_set_dumpable(struct task_struct *tsk, struct mm_struct *mm, int value)
> >> +{
> >> +	if (!static_branch_unlikely(&spectre_v2_app_lite))
> >> +		return;
> >> +	if (!static_cpu_has(X86_FEATURE_STIBP))
> >> +		return;
> >> +
> >> +	if ((unsigned) value != SUID_DUMP_USER) {
> > 
> > First of all we use unsigned int and not unsigned, Aside of that why is the
> > argument not unsigned int right away?
> 
> 
> The original set_dumpable passes suid_dumpable, which was
> exposed via /proc/sys/fs/suid_dumpable and defined as int.
> It will make sense to define suid_dumpable as an unsigned int instead.
> 
> Would you like me to redefine suid_dumpable as unsigned int
> in sysctl.c in the patch revision as a separate clean up patch?

Yes, that makes sense.

Thanks,

	tglx
