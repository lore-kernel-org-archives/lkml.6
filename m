Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5DCC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 01:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45C26206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 01:01:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45C26206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbeIEF2X convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 01:28:23 -0400
Received: from mga04.intel.com ([192.55.52.120]:36286 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbeIEF2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 01:28:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2018 18:00:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,331,1531810800"; 
   d="scan'208";a="86060571"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by fmsmga004.fm.intel.com with ESMTP; 04 Sep 2018 18:00:44 -0700
Received: from orsmsx114.amr.corp.intel.com (10.22.240.10) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Tue, 4 Sep 2018 18:00:39 -0700
Received: from orsmsx107.amr.corp.intel.com ([169.254.1.245]) by
 ORSMSX114.amr.corp.intel.com ([169.254.8.8]) with mapi id 14.03.0319.002;
 Tue, 4 Sep 2018 18:00:38 -0700
From:   "Schaufler, Casey" <casey.schaufler@intel.com>
To:     Andrea Arcangeli <aarcange@redhat.com>
CC:     Jiri Kosina <jikos@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Schaufler, Casey" <casey.schaufler@intel.com>
Subject: RE: [PATCH v3 1/3] ptrace: Provide ___ptrace_may_access() that can
 be applied on arbitrary tasks
Thread-Topic: [PATCH v3 1/3] ptrace: Provide ___ptrace_may_access() that can
 be applied on arbitrary tasks
Thread-Index: AQHURHR5V11JrRcNJkuXhYQimpS2TqTg18iA//+QVJCAANS+AP//jPdQ
Date:   Wed, 5 Sep 2018 01:00:37 +0000
Message-ID: <99FC4B6EFCEFD44486C35F4C281DC6732144723D@ORSMSX107.amr.corp.intel.com>
References: <nycvar.YFH.7.76.1808312242130.25787@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1809041619510.15880@cbobk.fhfr.pm>
 <alpine.LRH.2.00.1809041639340.14475@gjva.wvxbf.pm>
 <31436186-88da-324e-88a0-8fdca7bf60ac@linux.intel.com>
 <nycvar.YFH.7.76.1809041932590.15880@cbobk.fhfr.pm>
 <99FC4B6EFCEFD44486C35F4C281DC67321447094@ORSMSX107.amr.corp.intel.com>
 <20180904233714.GJ4762@redhat.com>
In-Reply-To: <20180904233714.GJ4762@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZjNhNWQ0N2ItNjZhYy00MzcyLTkyYjItOTkzZTZiNTQyYjQ4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiNGNFNnVNdVp2WkJZSGFvREpGOGVUS0VGclR1NVFhREthWDlVR0N1Q0p1bFd4SjZJbHNKNm5xbFlRYm4yYTV4cCJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Andrea Arcangeli [mailto:aarcange@redhat.com]
> Sent: Tuesday, September 04, 2018 4:37 PM
> To: Schaufler, Casey <casey.schaufler@intel.com>
> Cc: Jiri Kosina <jikos@kernel.org>; Tim Chen <tim.c.chen@linux.intel.com>;
> Thomas Gleixner <tglx@linutronix.de>; Ingo Molnar <mingo@redhat.com>;
> Peter Zijlstra <peterz@infradead.org>; Josh Poimboeuf
> <jpoimboe@redhat.com>; Woodhouse, David <dwmw@amazon.co.uk>; Oleg
> Nesterov <oleg@redhat.com>; linux-kernel@vger.kernel.org; x86@kernel.org
> Subject: Re: [PATCH v3 1/3] ptrace: Provide ___ptrace_may_access() that can
> be applied on arbitrary tasks
> 
> Hello,
> 
> On Tue, Sep 04, 2018 at 06:10:47PM +0000, Schaufler, Casey wrote:
> > The real reason to use an LSM based approach is that overloading ptrace
> > checks is a Really Bad Idea. Ptrace is a user interface. Side-channel is a
> > processor interface. Even if ptrace_may_access() does exactly what you
> 
> "Side channel is a processor interface" doesn't make me optimistic,
> but I assume you're not speaking for Intel.

Sorry, I've been working in security too long for my
optimistic streak to be very wide.

> > want it to for side-channel mitigation today it would be incredibly
> > inappropriate to tie the two together for eternity. You don't want to restrict
> > the ptrace checks to only those things that are also good for side-channel,
> > and vice versa.
> 
> It seems like you want to make this more configurable,

Not especially, no. I have gotten considerable feedback that
it should be configurable, and while I may not see the value myself,
I do respect the people who've requested the configurability.

> we have all
> debugfs x86 specific tweaks to disable IBPB at runtime and we don't
> allow a runtime opt-out of IBPB alone.
> 
> If you shutdown either IBRS or retpolines at runtime with debugfs,
> then IBPB goes away too.
> 
> Giving a finegrined way to disable only IBPB we found was overkill
> because IBPB has never been measurable if done only when the prev task
> cannot ptrace the next task (which is a superset of the too weak
> upstream not dumpable check, but still not a performance issue).
> 
> Allowing IBPB runtime opt-out doesn't make much sense if you don't
> allow to disable retpolines too still at runtime. And disabling
> retpolines from LSM doesn't sounds the right place, it's an x86
> temporary quirk only relevant for current buggy CPUs.
> 
> There should be a function that decides when IBPB and flush_RSB should
> be run (flush_RSB has to be run if SMEP because with SMEP there's no
> need to run flush_RSB at every kernel entry anymore), and that
> function happens to check ptrace today, but it would check other stuff
> too if we had other interfaces besides ptrace that would allow the
> prev task to read the memory of the next task. So it's not so much
> about ptrace nor about IBPB, it's about "IBPB&flush_RSB" vs "prev task
> can read memory of next task". Then each arch can implement
> "IBPB&flush_RSB" method its own way but the check is for the common
> code and it should be in the scheduler and there's just 1 version of
> this check needed.

Right, I get that. There's more to ptrace access than "I can read the
other task". There's more to what the processor is up to than IBPB.

> 
> I don't think there should be a ton of different versions of this
> function each providing a different answer, which is what LSM would
> provide.

If they provide different answers there should be different
functions. It's a question of viewpoint. If you don't care about
the SELinux viewpoint you shouldn't have to include it in your
checks, any more than you care about x86 issues when you're
running on a MIPS processor.

> At most you can add a x86 debugfs tweak to shut off the logic but
> again it would make more sense if retpolines could be shut off at
> runtime too, doing it just for IBPB sounds backwards because it has
> such an unmeasurable overhead.
> 
> > Yes. That would be me.
> 
> Even the attempt to make an innocuous call like
> ptrace_has_cap(tcred->user_ns, mode) will eventually
> deadlock there.

Which is yet another reason there needs to be separate logic.

> I used a PTRACE_MODE_ check that the ptrace check code uses to filter
> out specific calls that may eventually enter LSM and hard lockup in
> non reproducible workloads (some false positive IBPB is ok, especially
> if it avoids a deadlock).

Yes, even security people have to worry about locking.

> Everything can be fixed in any way, but calling LSM from scheduler
> code doesn't sound the most robust thing to do in general because what
> works outside the scheduler doesn't work from within those semi atomic
> regions (it tends to work initially until it eventually
> deadlocks). The original code of such check, had all sort of deadlocks
> because of that.

What *is* the most robust way?
Yes, there are locking issues. The code in the LSM infrastructure and in
the security modules needs to be aware of that and deal with it. The SELinux
code I proposed is more complex than it could be because the audit code
requires locking that doesn't work in the switching context.

> Thanks,
> Andrea
