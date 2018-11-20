Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27748C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E45E32080C
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:31:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E45E32080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732436AbeKTK5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 05:57:24 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:40109 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728979AbeKTK5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 05:57:24 -0500
Received: from p4fea46ac.dip0.t-ipconnect.de ([79.234.70.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gOtwG-0006Wt-0X; Tue, 20 Nov 2018 01:30:48 +0100
Date:   Tue, 20 Nov 2018 01:30:47 +0100 (CET)
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
In-Reply-To: <eb6a2309-40ee-ed89-aefe-7834fd0e4139@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1811200122580.1669@nanos.tec.linutronix.de>
References: <cover.1542418936.git.tim.c.chen@linux.intel.com> <ca5dd01c12789d3f75ab1b73bfcac3bdaea93dd6.1542418937.git.tim.c.chen@linux.intel.com> <alpine.DEB.2.21.1811191423140.1537@nanos.tec.linutronix.de>
 <eb6a2309-40ee-ed89-aefe-7834fd0e4139@linux.intel.com>
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

On Mon, 19 Nov 2018, Tim Chen wrote:
> On 11/19/2018 05:32 AM, Thomas Gleixner wrote:
> > On Fri, 16 Nov 2018, Tim Chen wrote:
> >> The protection mode can be specified by the spectre_v2_app2app
> >> boot parameter with the following semantics:
> >>
> >> spectre_v2_app2app=
> >> 	off    - Turn off mitigation
> >> 	lite   - Protect processes which are marked non-dumpable
> >> 	strict - Protect all processes
> >> 	auto   - Kernel selects the mode
> > 
> > Is there any reason why we need yet another naming convention?
> > 
> > pti= 				on, off, auto
> > 
> > spectre_v2=			on, off, auto
> > 
> > spec_store_bypass_disable =	on, off, auto, prctl, seccomp
> 
> The "on" option is set by spectre_v2=on so is not specified here.

What has spectre_v2=on to do with spectre_v2_app2app=on?

Exactly nothing. You can have 'on' for both. The only side effect of
spectre_v2=on is that it also forces spectre_v2_app2app to 'on'
irrespective of what eventually was added for spectre_v2_app2app= on the
command line.

> What will you like to name the "lite" and "strict" option instead?

'prctl' and 'on' and if we add 'seccomp' then this is exactly the same as
we have for ssbd.

> > Can we please have a full documentation for all the spectre_v2 stuff
> > similar to l1tf?
> > 
> Sure.  Can we do that as a separate patch?  I'll need some time 
> and internal review for any spectre_v2 documentation that's produced.

I'm not taking that stuff without proper documentation. I complained about
that vs. L1TF and got told that no sysadmin cares, but L1TF has shown that
they care very much and appreciate proper documentation.

Nobody can oracle the protection scope out of that inconsistent command
line maze.

Thanks,

	tglx


