Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA92C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F35362083E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:28:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F35362083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbeIEX7s convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 19:59:48 -0400
Received: from mga07.intel.com ([134.134.136.100]:27282 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727397AbeIEX7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 19:59:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Sep 2018 12:28:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,334,1531810800"; 
   d="scan'208";a="78250213"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Sep 2018 12:27:59 -0700
Received: from orsmsx114.amr.corp.intel.com (10.22.240.10) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 5 Sep 2018 12:27:39 -0700
Received: from orsmsx107.amr.corp.intel.com ([169.254.1.245]) by
 ORSMSX114.amr.corp.intel.com ([169.254.8.8]) with mapi id 14.03.0319.002;
 Wed, 5 Sep 2018 12:27:39 -0700
From:   "Schaufler, Casey" <casey.schaufler@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>
CC:     Jiri Kosina <jikos@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>,
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
Thread-Index: AQHURHR5V11JrRcNJkuXhYQimpS2TqTg18iA//+QVJCAAIQJAIAATdIAgAB0AQCAAKEDgIAAI1+AgAAGvoCAAAMgAIAABmIA//+QKGA=
Date:   Wed, 5 Sep 2018 19:27:38 +0000
Message-ID: <99FC4B6EFCEFD44486C35F4C281DC67321447823@ORSMSX107.amr.corp.intel.com>
References: <31436186-88da-324e-88a0-8fdca7bf60ac@linux.intel.com>
 <nycvar.YFH.7.76.1809041932590.15880@cbobk.fhfr.pm>
 <99FC4B6EFCEFD44486C35F4C281DC67321447094@ORSMSX107.amr.corp.intel.com>
 <nycvar.YFH.7.76.1809042046180.15880@cbobk.fhfr.pm>
 <3f24e8c8-eab8-66c2-9a8d-957e30cac809@linux.intel.com>
 <nycvar.YFH.7.76.1809050725390.15880@cbobk.fhfr.pm>
 <20180905155823.GL27886@tassilo.jf.intel.com>
 <20180905180459.GB11625@redhat.com>
 <nycvar.YFH.7.76.1809052026470.15880@cbobk.fhfr.pm>
 <20180905184018.GC11625@redhat.com>
 <20180905190308.GD24082@hirez.programming.kicks-ass.net>
In-Reply-To: <20180905190308.GD24082@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMDUyN2ZmODEtYzhiNi00M2UyLTg5MzQtNDhmOTZjMmVhZDE2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoidGU4eko2ZFF5SE5EeEFZVlVwWElBM09uUmh6UmZXcjJzdTRyWXNPa3B3bkdYVk1makFFMjRXdWVWNWEyVytuZyJ9
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
> From: Peter Zijlstra [mailto:peterz@infradead.org]
> Sent: Wednesday, September 05, 2018 12:03 PM
> To: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Jiri Kosina <jikos@kernel.org>; Andi Kleen <ak@linux.intel.com>; Tim Chen
> <tim.c.chen@linux.intel.com>; Schaufler, Casey <casey.schaufler@intel.com>;
> Thomas Gleixner <tglx@linutronix.de>; Ingo Molnar <mingo@redhat.com>;
> Josh Poimboeuf <jpoimboe@redhat.com>; Woodhouse, David
> <dwmw@amazon.co.uk>; Oleg Nesterov <oleg@redhat.com>; linux-
> kernel@vger.kernel.org; x86@kernel.org
> Subject: Re: [PATCH v3 1/3] ptrace: Provide ___ptrace_may_access() that can
> be applied on arbitrary tasks
> 
> On Wed, Sep 05, 2018 at 02:40:18PM -0400, Andrea Arcangeli wrote:
> > [ 1838.769917]  <<EOE>>  [<ffffffff816391e5>]
> avc_compute_av+0x126/0x1b5
> 
> That does read_lock(), which is not allowed from scheduler context.
> 
> > [ 1838.777125]  [<ffffffff810b842e>] ? walk_tg_tree_from+0xbe/0x110
> > [ 1838.783828]  [<ffffffff8128b9c4>] avc_has_perm_noaudit+0xc4/0x110
> 
> In current code this can end up in avc_update_node() which uses
> spin_lock(), which is a bug from scheduler context.o
> 
> > [ 1838.790628]  [<ffffffff8128f1fb>] cred_has_capability+0x6b/0x120
> > [ 1838.797331]  [<ffffffff810db71c>] ? ktime_get+0x4c/0xd0
> > [ 1838.803160]  [<ffffffff810e167b>] ?
> clockevents_program_event+0x6b/0xf0
> > [ 1838.810532]  [<ffffffff8128f2de>] selinux_capable+0x2e/0x40
> > [ 1838.816748]  [<ffffffff81288f65>] security_capable_noaudit+0x15/0x20
> > [ 1838.823829]  [<ffffffff8108b975>] has_ns_capability_noaudit+0x15/0x20
> > [ 1838.831014]  [<ffffffff8108bc55>] ptrace_has_cap+0x35/0x40
> > [ 1838.837126]  [<ffffffff8108c717>] ___ptrace_may_access+0xa7/0x1e0
> > [ 1838.843925]  [<ffffffff8163f0ae>] __schedule+0x26e/0xa00
> > [ 1838.849855]  [<ffffffff81640949>] schedule_preempt_disabled+0x29/0x70
> > [ 1838.857041]  [<ffffffff810d9324>] cpu_startup_entry+0x184/0x290
> > [ 1838.863637]  [<ffffffff8104891a>] start_secondary+0x1da/0x250
> 
> So yes, looks like all that security LSM nonsense isn't going to work
> here.

What won't work is using the ptrace code. That is one of the reasons why
you can't just blindly use it. Look at the patch set I submitted and you'll see
that the SELinux selinux_task_safe_sidechannel() hook does not do the things
that cause the lockup.

