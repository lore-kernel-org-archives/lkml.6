Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656EEC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3732A20851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:03:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3732A20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbeKTF2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 00:28:20 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:39530 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbeKTF2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 00:28:19 -0500
Received: from p4fea46ac.dip0.t-ipconnect.de ([79.234.70.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gOop5-0001PT-8K; Mon, 19 Nov 2018 20:03:03 +0100
Date:   Mon, 19 Nov 2018 20:03:02 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Tim Chen <tim.c.chen@linux.intel.com>
cc:     Peter Zijlstra <peterz@infradead.org>,
        Jiri Kosina <jikos@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
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
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [Patch v5 08/16] smt: Create cpu_smt_enabled static key for SMT
 specific code
In-Reply-To: <439a2d72-988c-d397-dc32-daf098af655c@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1811191959540.1669@nanos.tec.linutronix.de>
References: <cover.1542418936.git.tim.c.chen@linux.intel.com> <91b719e53640f60666b40a3516da2b80703b2f76.1542418937.git.tim.c.chen@linux.intel.com> <20181119145754.GA2131@hirez.programming.kicks-ass.net>
 <439a2d72-988c-d397-dc32-daf098af655c@linux.intel.com>
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

Tim,

On Mon, 19 Nov 2018, Tim Chen wrote:
> On 11/19/2018 06:57 AM, Peter Zijlstra wrote:
> > In particular, the SMT topology bits are set before we enable
> > interrrupts and similarly, are cleared after we disable interrupts for
> > the last time and die.
> 
> 
> Peter & Thomas,
> 
> Any objection if I export sched_smt_present after including
> Peter's patch and use it in spec_ctrl_update_msr instead.
> 
> Something like this?

>  
> +#ifdef CONFIG_SCHED_SMT
> +
> +extern struct static_key_false sched_smt_present;
> +
> +static inline bool cpu_smt_present(void)
> +{
> +	if (static_branch_unlikely(&sched_smt_present))
> +		return true;
> +	else
> +		return false;

What's wrong with

       return static_branch_unlikely(&sched_smt_present);

???

But that's just a stylistic nitpick. The real issue is that you prevent the
mitigation when CONFIG_SCHED_SMT=n.

Thanks,

	tglx
