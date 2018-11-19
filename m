Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C05C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 13:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D63120851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 13:33:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D63120851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbeKSX4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 18:56:43 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:38495 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbeKSX4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 18:56:43 -0500
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gOjfU-0007Ry-UN; Mon, 19 Nov 2018 14:32:49 +0100
Date:   Mon, 19 Nov 2018 14:32:48 +0100 (CET)
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
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [Patch v5 11/16] x86/speculation: Add Spectre v2 app to app
 protection modes
In-Reply-To: <ca5dd01c12789d3f75ab1b73bfcac3bdaea93dd6.1542418937.git.tim.c.chen@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1811191423140.1537@nanos.tec.linutronix.de>
References: <cover.1542418936.git.tim.c.chen@linux.intel.com> <ca5dd01c12789d3f75ab1b73bfcac3bdaea93dd6.1542418937.git.tim.c.chen@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tim,

On Fri, 16 Nov 2018, Tim Chen wrote:

> Add new protection modes for Spectre v2 mitigations against
> Spectre v2 attacks on user processes.  There are three modes:
> 
> 	strict mode:
> 	In this mode, IBPB and STIBP are deployed full
> 	time to protect all processes.
> 
> 	lite mode:
> 	In this mode, IBPB and STIBP are only deployed on
> 	processes marked with TIF_STIBP flag.
> 
> 	none mode:
> 	In this mode, no mitigations are deployed.
>
> The protection mode can be specified by the spectre_v2_app2app
> boot parameter with the following semantics:
> 
> spectre_v2_app2app=
> 	off    - Turn off mitigation
> 	lite   - Protect processes which are marked non-dumpable
> 	strict - Protect all processes
> 	auto   - Kernel selects the mode

Is there any reason why we need yet another naming convention?

pti= 				on, off, auto

spectre_v2=			on, off, auto

spec_store_bypass_disable =	on, off, auto, prctl, seccomp


> 	Not specifying this option is equivalent to
> 	spectre_v2_app2app=auto.

For better understanding it's nowhere documented what auto does.

> +	spectre_v2_app2app=
> +			[X86] Control mitigation of Spectre variant 2
> +		        application to application (indirect branch speculation)
> +			vulnerability.
> +
> +			off    - Unconditionally disable mitigations
> +			lite   - Protect tasks which have requested restricted
> +				 indirect branch speculation via the
> +				 PR_SET_SPECULATION_CTRL prctl(). 
> +			strict - Protect all processes
> +			auto   - Kernel selects the mode
> +
> +			Not specifying this option is equivalent to
> +			spectre_v2_app2app=auto.
> +
> +			Setting spectre_v2=off will also turn off this mitigation.
> +
> +			Setting spectre_v2=on implies unconditionally enabling
> +			this mitigation.

Can we please have a full documentation for all the spectre_v2 stuff
similar to l1tf?

Thanks,

	tglx


