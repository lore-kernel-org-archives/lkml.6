Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746FAC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 18:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AE682073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 18:05:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AE682073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbeIEWgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 18:36:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35866 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727069AbeIEWgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 18:36:21 -0400
Received: from smtp.corp.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6778530842AE;
        Wed,  5 Sep 2018 18:05:04 +0000 (UTC)
Received: from sky.random (ovpn-120-15.rdu2.redhat.com [10.10.120.15])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1D3DCABC1F;
        Wed,  5 Sep 2018 18:05:00 +0000 (UTC)
Date:   Wed, 5 Sep 2018 14:04:59 -0400
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v3 1/3] ptrace: Provide ___ptrace_may_access() that can
 be applied on arbitrary tasks
Message-ID: <20180905180459.GB11625@redhat.com>
References: <nycvar.YFH.7.76.1808312242130.25787@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1809041619510.15880@cbobk.fhfr.pm>
 <alpine.LRH.2.00.1809041639340.14475@gjva.wvxbf.pm>
 <31436186-88da-324e-88a0-8fdca7bf60ac@linux.intel.com>
 <nycvar.YFH.7.76.1809041932590.15880@cbobk.fhfr.pm>
 <99FC4B6EFCEFD44486C35F4C281DC67321447094@ORSMSX107.amr.corp.intel.com>
 <nycvar.YFH.7.76.1809042046180.15880@cbobk.fhfr.pm>
 <3f24e8c8-eab8-66c2-9a8d-957e30cac809@linux.intel.com>
 <nycvar.YFH.7.76.1809050725390.15880@cbobk.fhfr.pm>
 <20180905155823.GL27886@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905155823.GL27886@tassilo.jf.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 05 Sep 2018 18:05:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 08:58:23AM -0700, Andi Kleen wrote:
> > So, after giving it a bit more thought, I still believe "I want spectre V2 
> > protection" vs. "I do not care about spectre V2 on my system 
> > (=nospectre_v2)" are the sane options we should provide; so I'll respin v4 
> > of my patchset, including the ptrace check in switch_mm() (statically 
> > patched out on !IBPB-capable systems), and we can then later see whether 
> > the LSM implementation, once it exists, should be used instead.
> 
> Please if you repost include plenty of performance numbers for multi threaded
> workloads.  It's ridiculous to even discuss this without them.

Multi threaded workloads won't be affected because they share the
memory in the first place... the check itself is lost in the noise
too. Maybe you meant to ask for multiple parallel processes
(multithreaded or not, zero difference) all with a different user id?

What is more weird for me is to attempt to discuss the STIBP part of
the patch without knowing which microcodes exactly implement STIBP in
a way that is slow. Tim already said it's a measurable performance hit,
but on some CPU it's zero performance hit. We don't even know if STIBP
is actually useful or if it's a noop on those CPUs where it won't
affect performance.

Back to the IBPB, from implementation standpoint at least on 3.10 this
code posted would lockup hard eventually and we got complains.

ptrace_has_cap(tcred->user_ns, mode) is supposed to eventually lockup
hard if called from scheduler as it does some locking, and we fixed
that already half a year ago.

Not sure how it's still unfixed in Jiri's codebase after so long, or
if it's an issue specific to 3.10 and upstream gets away without this.

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index eb7862f185ff..4a8d0dd73c93 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -285,7 +285,8 @@ int ___ptrace_may_access(struct task_struct *tracer,
 	    gid_eq(caller_gid, tcred->sgid) &&
 	    gid_eq(caller_gid, tcred->gid))
 		goto ok;
-	if (ptrace_has_cap(tcred->user_ns, mode))
+	if (!(mode & PTRACE_MODE_NOACCESS_CHK) &&
+	    ptrace_has_cap(tcred->user_ns, mode))
 		goto ok;
 	rcu_read_unlock();
 	return -EPERM;
@@ -296,7 +297,8 @@ ok:
 		dumpable = get_dumpable(task->mm);
 	rcu_read_lock();
 	if (dumpable != SUID_DUMP_USER &&
-	    !ptrace_has_cap(__task_cred(task)->user_ns, mode)) {
+	    ((mode & PTRACE_MODE_NOACCESS_CHK) ||
+	     !ptrace_has_cap(__task_cred(task)->user_ns, mode))) {
 		rcu_read_unlock();
 		return -EPERM;
 	}
