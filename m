Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87E8C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 21:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5806420865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 21:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5806420865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbeIKCZp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 22:25:45 -0400
Received: from mga07.intel.com ([134.134.136.100]:54447 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbeIKCZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 22:25:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2018 14:29:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,357,1531810800"; 
   d="scan'208";a="89287179"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by orsmga001.jf.intel.com with ESMTP; 10 Sep 2018 14:29:45 -0700
Received: from orsmsx107.amr.corp.intel.com ([169.254.1.245]) by
 ORSMSX110.amr.corp.intel.com ([169.254.10.41]) with mapi id 14.03.0319.002;
 Mon, 10 Sep 2018 14:29:45 -0700
From:   "Schaufler, Casey" <casey.schaufler@intel.com>
To:     Jiri Kosina <jikos@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Schaufler, Casey" <casey.schaufler@intel.com>
Subject: RE: [PATCH v5 1/2] x86/speculation: apply IBPB more strictly to
 avoid cross-process data leak
Thread-Topic: [PATCH v5 1/2] x86/speculation: apply IBPB more strictly to
 avoid cross-process data leak
Thread-Index: AQHUSOgJU5Fr+3/MVEm2Zt46QQ4u6aTp1A7wgACEY4D//4ss4IAAevsA//+NH1CAAIVcgP//ka8g
Date:   Mon, 10 Sep 2018 21:29:44 +0000
Message-ID: <99FC4B6EFCEFD44486C35F4C281DC6732144AF87@ORSMSX107.amr.corp.intel.com>
References: <nycvar.YFH.7.76.1809101119280.15880@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1809101123020.15880@cbobk.fhfr.pm>
 <99FC4B6EFCEFD44486C35F4C281DC6732144ADF9@ORSMSX107.amr.corp.intel.com>
 <nycvar.YFH.7.76.1809102111410.15880@cbobk.fhfr.pm>
 <99FC4B6EFCEFD44486C35F4C281DC6732144AEC9@ORSMSX107.amr.corp.intel.com>
 <nycvar.YFH.7.76.1809102132480.15880@cbobk.fhfr.pm>
 <99FC4B6EFCEFD44486C35F4C281DC6732144AF24@ORSMSX107.amr.corp.intel.com>
 <nycvar.YFH.7.76.1809102235010.15880@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.1809102235010.15880@cbobk.fhfr.pm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYmRjOWRhNDEtYjU1NS00NDVjLTk5NDAtYjc3OGRjYjUyNjAxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiMUl2WlEzeStDa0MzRlJPbGtDOXJCcVo1XC9KMk9qT3VwbnpDaHRzRzVPQzlpdUY2bUZ5bnlWUHR0Rzh3QXdhTnAifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Jiri Kosina [mailto:jikos@kernel.org]
> Sent: Monday, September 10, 2018 1:42 PM
> To: Schaufler, Casey <casey.schaufler@intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>; Ingo Molnar <mingo@redhat.com>;
> Peter Zijlstra <peterz@infradead.org>; Josh Poimboeuf
> <jpoimboe@redhat.com>; Andrea Arcangeli <aarcange@redhat.com>;
> Woodhouse, David <dwmw@amazon.co.uk>; Andi Kleen <ak@linux.intel.com>;
> Tim Chen <tim.c.chen@linux.intel.com>; linux-kernel@vger.kernel.org;
> x86@kernel.org
> Subject: RE: [PATCH v5 1/2] x86/speculation: apply IBPB more strictly to avoid
> cross-process data leak
> 
> On Mon, 10 Sep 2018, Schaufler, Casey wrote:
> 
> > It you're going to call __ptrace_access_check(),
> 
> I guess you mean __ptrace_may_access() here.

Sorry, yes. Too much code, too little brain.

> > which already includes an LSM hook, it makes a whole lot of sense to
> > make that the path for doing any module specific checks. It seems wrong
> > to disable the LSM hook there, then turn around and introduce a new one
> > that does the check you just disabled. The patches I had proposed
> > created a new LSM hook because there was not path to an existing hook.
> > With your addition of __ptrace_access_check() that is no longer an issue
> > once any locking problems are resolved. Rather than use a new hook, the
> > existing ptrace hooks ought to work just fine, and any new checks can be
> > added in a new module that has its own ptrace_access_check hook.
> 
> Sorry for being dense, but what exactly are you proposing here then?

Sorry for not being clear.

You added a call to __ptrace_may_access(). The security modules that get
called from __ptrace_may_access() via security_ptrace_access_check()
have known and/or suspected locking issues. So far so good. ...

> This patch (v4 and v5) explicitly avoids calling out to ptrace_has_cap()
> (which calls out to LSM through has_ns_capability_*() ->
> security_capable()) in PTRACE_MODE_IBPB case, exactly to avoid locking
> issues with security modules; there are known callchains that lead to
> deadlock.

So rather than avoiding calling these, why not avoid doing the things inside
the module specific code that cause the locking issues? Move the checks you
put in the ptrace code into the security module hooks.  I can't say 100%, but from
what I've seen so far, it's locking in the audit sub-system that causes the issues,
and that is pretty easy to work around.

> With the same reasoning, security_ptrace_access_check() call is avoided,
> only there is no know particular callchain that'd lead to a lock being
> taken, but noone has done such audit (yet), as it's all hidden behind LSM
> callbacks.

I've had a pretty good look, and there's nothing magic about the LSM callbacks.

> So please tell me what exactly you'd like to see changed in the IBPB patch
> and why exactly, I am not seeing it yet.

Short of a patch to show the changes (which I wish I could do today, but really can't)
what I want to see is:

	- Put ptrace back to using the security module interfaces.
	- Identify where this causes locking issues and work with the module
	  owners (a reasonable lot, all) to provide lock safe paths for the IBPB case.

Otherwise, I have to add a new LSM hook right after your ptrace call and duplicate
a whole lot of what you've just turned off, plus creating lock safe code that duplicates
what ptrace already does. While I would rather have the side-channel checks be
separate from the ptrace checks I can't justify doing both.

I'm sorry if that isn't clearer. I am trying.

> 
> Thanks,
> 
> --
> Jiri Kosina
> SUSE Labs

