Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA29C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 22:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AC2B2075B
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 22:59:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AC2B2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbeKSJVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 04:21:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:53130 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727661AbeKSJVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 04:21:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 50DCCAE0B;
        Sun, 18 Nov 2018 22:59:55 +0000 (UTC)
Date:   Sun, 18 Nov 2018 23:59:52 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Tim Chen <tim.c.chen@linux.intel.com>
cc:     Thomas Gleixner <tglx@linutronix.de>,
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
In-Reply-To: <nycvar.YFH.7.76.1811171044510.21108@cbobk.fhfr.pm>
Message-ID: <nycvar.YFH.7.76.1811182358370.21108@cbobk.fhfr.pm>
References: <cover.1542418936.git.tim.c.chen@linux.intel.com> <ca5dd01c12789d3f75ab1b73bfcac3bdaea93dd6.1542418937.git.tim.c.chen@linux.intel.com> <nycvar.YFH.7.76.1811171044510.21108@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Nov 2018, Jiri Kosina wrote:

> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 81d1d5a..9c306e3 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -4215,6 +4215,26 @@
> >  			Not specifying this option is equivalent to
> >  			spectre_v2=auto.
> >  
> > +	spectre_v2_app2app=
> > +			[X86] Control mitigation of Spectre variant 2
> > +		        application to application (indirect branch speculation)
> > +			vulnerability.
> > +
> > +			off    - Unconditionally disable mitigations
> > +			lite   - Protect tasks which have requested restricted
> > +				 indirect branch speculation via the
> > +				 PR_SET_SPECULATION_CTRL prctl(). 
> 
> Don't we also want to do the same for SECCOMP processess, analogically how 
> we do it for SSBD?

IOW, how about patch below on top of your series? Thanks.


From: Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH] x86/speculation: enforce STIBP for SECCOMP tasks in lite mode

If 'lite' mode of app2app protection from spectre_v2 is selected on
kernel command-line, we are currently applying STIBP protection to
non-dumpable tasks, and tasks that have explicitly requested such
protection via

	prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_INDIR_BRANCH, PR_SPEC_ENABLE, 0, 0);

Let's extend this to cover also SECCOMP tasks (analogically to how we
apply SSBD protection).

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 Documentation/admin-guide/kernel-parameters.txt | 9 +++++----
 arch/x86/kernel/cpu/bugs.c                      | 2 ++
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 102f9a169eec..74f547e5c8f6 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4221,10 +4221,11 @@
 			vulnerability.
 
 			off    - Unconditionally disable mitigations
-			lite   - Protect tasks which are marked non-dumpable
-				 and tasks which have requested restricted
-				 indirect branch speculation via the
-				 PR_SET_SPECULATION_CTRL prctl(). 
+			lite   - Protect tasks which are marked non-dumpable,
+				 tasks which have requested restricted indirect
+				 branch speculation via the
+				 PR_SET_SPECULATION_CTRL prctl() and seccomp
+				 tasks.
 			strict - Protect all processes
 			auto   - Kernel selects the mode
 
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index e7f9334f18c0..3ec952108e87 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -863,6 +863,8 @@ void arch_seccomp_spec_mitigate(struct task_struct *task)
 {
 	if (ssb_mode == SPEC_STORE_BYPASS_SECCOMP)
 		ssb_prctl_set(task, PR_SPEC_FORCE_DISABLE);
+	if (spectre_v2_app2app_enabled == SPECTRE_V2_APP2APP_LITE)
+		set_task_stibp(task, true);
 }
 #endif
 

-- 
Jiri Kosina
SUSE Labs

