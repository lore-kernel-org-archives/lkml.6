Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAE3C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 13:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F17A20831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 13:49:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F17A20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbeKTANV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 19:13:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:50128 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727310AbeKTANV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 19:13:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C3C91AF04;
        Mon, 19 Nov 2018 13:49:38 +0000 (UTC)
Date:   Mon, 19 Nov 2018 14:49:36 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
cc:     Tim Chen <tim.c.chen@linux.intel.com>,
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
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: Re: [Patch v5 11/16] x86/speculation: Add Spectre v2 app to app
 protection modes
In-Reply-To: <alpine.DEB.2.21.1811191433100.1537@nanos.tec.linutronix.de>
Message-ID: <nycvar.YFH.7.76.1811191438290.21108@cbobk.fhfr.pm>
References: <cover.1542418936.git.tim.c.chen@linux.intel.com> <ca5dd01c12789d3f75ab1b73bfcac3bdaea93dd6.1542418937.git.tim.c.chen@linux.intel.com> <nycvar.YFH.7.76.1811171044510.21108@cbobk.fhfr.pm> <nycvar.YFH.7.76.1811182358370.21108@cbobk.fhfr.pm>
 <alpine.DEB.2.21.1811191433100.1537@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Nov 2018, Thomas Gleixner wrote:

> > On Sat, 17 Nov 2018, Jiri Kosina wrote:
> 
> > Subject: [PATCH] x86/speculation: enforce STIBP for SECCOMP tasks in lite mode
> > 
> > If 'lite' mode of app2app protection from spectre_v2 is selected on
> > kernel command-line, we are currently applying STIBP protection to
> > non-dumpable tasks, and tasks that have explicitly requested such
> > protection via
> > 
> > 	prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_INDIR_BRANCH, PR_SPEC_ENABLE, 0, 0);
> > 
> > Let's extend this to cover also SECCOMP tasks (analogically to how we
> > apply SSBD protection).
> 
> Right. And SSBD does not fiddle with dumpable.
> 
> Willy had concerns about the (ab)use of dumpable so I'm holding off on that
> bit for now.

Yeah. IBPB implementation used to check the dumpability of tasks during 
rescheduling, but that went away later.

I still think that ideally that 'app2app' setting would toggle how IBPB is 
being used as well, something along the lines:

lite:
	- STIBP for the ones marked via prctl() and SECCOMP with the TIF_ 
	  flag
	- ibpb_needed() returning true for the same

strict:
	- STIBP: as currently implemented
	- ibpb_needed() returning always true

off:
	- neither STIBP nor IBPB applied ever

That's give us also some % of performance lost via IBPB back.

Makes sense?

Thanks,

-- 
Jiri Kosina
SUSE Labs

