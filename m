Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E67C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 637DA2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:32:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 637DA2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730431AbeKTF57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 00:57:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36242 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728402AbeKTF56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 00:57:58 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B4DBB5F739;
        Mon, 19 Nov 2018 19:32:54 +0000 (UTC)
Received: from sky.random (ovpn-120-160.rdu2.redhat.com [10.10.120.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3774860922;
        Mon, 19 Nov 2018 19:32:54 +0000 (UTC)
Date:   Mon, 19 Nov 2018 14:32:53 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
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
Message-ID: <20181119193253.GE29258@redhat.com>
References: <cover.1542418936.git.tim.c.chen@linux.intel.com>
 <ca5dd01c12789d3f75ab1b73bfcac3bdaea93dd6.1542418937.git.tim.c.chen@linux.intel.com>
 <nycvar.YFH.7.76.1811171044510.21108@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1811182358370.21108@cbobk.fhfr.pm>
 <alpine.DEB.2.21.1811191433100.1537@nanos.tec.linutronix.de>
 <nycvar.YFH.7.76.1811191438290.21108@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1811191438290.21108@cbobk.fhfr.pm>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 19 Nov 2018 19:32:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

On Mon, Nov 19, 2018 at 02:49:36PM +0100, Jiri Kosina wrote:
> On Mon, 19 Nov 2018, Thomas Gleixner wrote:
> 
> > > On Sat, 17 Nov 2018, Jiri Kosina wrote:
> > 
> > > Subject: [PATCH] x86/speculation: enforce STIBP for SECCOMP tasks in lite mode
> > > 
> > > If 'lite' mode of app2app protection from spectre_v2 is selected on
> > > kernel command-line, we are currently applying STIBP protection to
> > > non-dumpable tasks, and tasks that have explicitly requested such
> > > protection via
> > > 
> > > 	prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_INDIR_BRANCH, PR_SPEC_ENABLE, 0, 0);
> > > 
> > > Let's extend this to cover also SECCOMP tasks (analogically to how we
> > > apply SSBD protection).
> > 
> > Right. And SSBD does not fiddle with dumpable.
> > 
> > Willy had concerns about the (ab)use of dumpable so I'm holding off on that
> > bit for now.
> 
> Yeah. IBPB implementation used to check the dumpability of tasks during 
> rescheduling, but that went away later.
> 
> I still think that ideally that 'app2app' setting would toggle how IBPB is 
> being used as well, something along the lines:
> 
> lite:
> 	- STIBP for the ones marked via prctl() and SECCOMP with the TIF_ 
> 	  flag

Note: STIBP is not SSBD: STIBP enabled inside the SECCOMP jail only
makes the code inside SECCOMP immune from attack from processes
outside the SECCOMP jail.

The specs don't say if by making it immune from BTB mistraining, it
also could prevent to mistrain the BTB in order to attack what's
outside the SECCOMP jail. Probably it won't and I doubt we can rely on
it even if some implementation could do that.

Generally speaking the untrusted code that would try to use spectrev2
to attack the other processes is more likely to run inside SECCOMP
jail than outside, so if SECCOMP should be used as a best effort
heuristic to decide when to enable STIBP, it would make more sense to
enable STIBP outside SECCOMP, and not inside. I.e. the exact opposite
of what you're proposing above.

Code running under SECCOMP is not necessarily less performance
critical so if we don't protect what's outside, I doubt we should
protect what's inside.

In short I doubt we can make an association between SECCOMP and STIBP
here and we should leave SECCOMP alone this time.

The prctl is a nice to have feature, but it is more for specialized
apps like gpg that aren't performance critical anyway.

The system wide default is more a decision the admin should do without
having to add prctl wrappers to all apps or change config
files. Clearly the prctl won't hurt especially if it can be overridden
(and forced off) with the global tweak like with the ssbd options. The
only thing I don't understand is why one has to reboot to change the
global defaults for ssbd and now STIBP (unless you're already planning
to make the global tweak runtime tunable) despite there's no runtime
benefit by forcing these decision at boot time only. Would be nice to
add runtime tweak options for at least STIBP and SSBD that aren't
confined to the prctl.

Thanks,
Andrea
