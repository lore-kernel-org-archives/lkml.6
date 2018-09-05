Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9814DC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 15:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F9372086B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 15:37:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F9372086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbeIEUIh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 16:08:37 -0400
Received: from mga01.intel.com ([192.55.52.88]:52320 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbeIEUIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 16:08:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Sep 2018 08:37:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,334,1531810800"; 
   d="scan'208";a="87888470"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by orsmga001.jf.intel.com with ESMTP; 05 Sep 2018 08:37:39 -0700
Received: from orsmsx114.amr.corp.intel.com (10.22.240.10) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 5 Sep 2018 08:37:39 -0700
Received: from orsmsx107.amr.corp.intel.com ([169.254.1.245]) by
 ORSMSX114.amr.corp.intel.com ([169.254.8.8]) with mapi id 14.03.0319.002;
 Wed, 5 Sep 2018 08:37:39 -0700
From:   "Schaufler, Casey" <casey.schaufler@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Jiri Kosina <jikos@kernel.org>
CC:     Tim Chen <tim.c.chen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Schaufler, Casey" <casey.schaufler@intel.com>
Subject: RE: [PATCH v3 1/3] ptrace: Provide ___ptrace_may_access() that can
 be applied on arbitrary tasks
Thread-Topic: [PATCH v3 1/3] ptrace: Provide ___ptrace_may_access() that can
 be applied on arbitrary tasks
Thread-Index: AQHURHR5V11JrRcNJkuXhYQimpS2TqTg18iAgADxpwCAAAieMA==
Date:   Wed, 5 Sep 2018 15:37:38 +0000
Message-ID: <99FC4B6EFCEFD44486C35F4C281DC673214476DA@ORSMSX107.amr.corp.intel.com>
References: <nycvar.YFH.7.76.1808312242130.25787@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1809041619510.15880@cbobk.fhfr.pm>
 <alpine.LRH.2.00.1809041639340.14475@gjva.wvxbf.pm>
 <31436186-88da-324e-88a0-8fdca7bf60ac@linux.intel.com>
 <nycvar.YFH.7.76.1809041932590.15880@cbobk.fhfr.pm>
 <20180905080024.GP24124@hirez.programming.kicks-ass.net>
In-Reply-To: <20180905080024.GP24124@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYWUxMDI0YzMtMzgwNC00MmE4LTk2NzgtMmRiNTVkODhiOTJlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoieTExWGF6NllOMHFudllUcndmUHdTUXlFaDlRbTI1TlFOS2RUUmwraW9NR0R4MFwvRXJzSXVueWpOS0RPZUVYWngifQ==
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
> Sent: Wednesday, September 05, 2018 1:00 AM
> To: Jiri Kosina <jikos@kernel.org>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>; Thomas Gleixner
> <tglx@linutronix.de>; Ingo Molnar <mingo@redhat.com>; Josh Poimboeuf
> <jpoimboe@redhat.com>; Andrea Arcangeli <aarcange@redhat.com>;
> Woodhouse, David <dwmw@amazon.co.uk>; Oleg Nesterov
> <oleg@redhat.com>; Schaufler, Casey <casey.schaufler@intel.com>; linux-
> kernel@vger.kernel.org; x86@kernel.org
> Subject: Re: [PATCH v3 1/3] ptrace: Provide ___ptrace_may_access() that can
> be applied on arbitrary tasks
> 
> On Tue, Sep 04, 2018 at 07:35:29PM +0200, Jiri Kosina wrote:
> > On Tue, 4 Sep 2018, Tim Chen wrote:
> >
> > > > Current ptrace_may_access() implementation assumes that the 'source'
> task is
> > > > always the caller (current).
> > > >
> > > > Expose ___ptrace_may_access() that can be used to apply the check on
> arbitrary
> > > > tasks.
> > >
> > > Casey recently has proposed putting the decision making of whether to
> > > do IBPB in the security module.
> > >
> > > https://lwn.net/ml/kernel-hardening/20180815235355.14908-4-
> casey.schaufler@intel.com/
> > >
> > > That will have the advantage of giving the administrator a more flexibility
> > > of when to turn on IBPB.  The policy is very similar to what you have
> proposed here
> > > but I think the security module is a more appropriate place for the security
> policy.
> >
> > Yeah, well, honestly, I have a bit hard time buying the "generic
> > sidechannel prevention security module" idea, given how completely
> > different in nature all the mitigations have been so far. I don't see that
> > trying to abstract this somehow provides more clarity.
> >
> > So if this should be done in LSM, it'd probably have to be written by
> > someone else than me :) who actually understands how the "sidechannel
> LSM"
> > idea works.
> 
> Yeah, I'm not convinced on LSM either. Lets just do these here patches
> first and then Casey can try and convince us later.

Works for me. There are advantages to doing it either way.
The LSM approach allows you to consider implications of LSM
data, which you can't do otherwise. Once the hook is available
it becomes the obvious place to do other checks.

