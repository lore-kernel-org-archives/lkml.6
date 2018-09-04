Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B049EC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 18:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68F332073D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 18:10:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68F332073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbeIDWhD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 18:37:03 -0400
Received: from mga18.intel.com ([134.134.136.126]:41057 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbeIDWhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 18:37:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2018 11:10:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,330,1531810800"; 
   d="scan'208";a="77929420"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Sep 2018 11:10:48 -0700
Received: from orsmsx151.amr.corp.intel.com (10.22.226.38) by
 ORSMSX103.amr.corp.intel.com (10.22.225.130) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Tue, 4 Sep 2018 11:10:48 -0700
Received: from orsmsx107.amr.corp.intel.com ([169.254.1.245]) by
 ORSMSX151.amr.corp.intel.com ([169.254.7.211]) with mapi id 14.03.0319.002;
 Tue, 4 Sep 2018 11:10:48 -0700
From:   "Schaufler, Casey" <casey.schaufler@intel.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
Thread-Index: AQHURHR5V11JrRcNJkuXhYQimpS2TqTg18iA//+QVJA=
Date:   Tue, 4 Sep 2018 18:10:47 +0000
Message-ID: <99FC4B6EFCEFD44486C35F4C281DC67321447094@ORSMSX107.amr.corp.intel.com>
References: <nycvar.YFH.7.76.1808312242130.25787@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1809041619510.15880@cbobk.fhfr.pm>
 <alpine.LRH.2.00.1809041639340.14475@gjva.wvxbf.pm>
 <31436186-88da-324e-88a0-8fdca7bf60ac@linux.intel.com>
 <nycvar.YFH.7.76.1809041932590.15880@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.1809041932590.15880@cbobk.fhfr.pm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZWZhNDQ2YzAtYzZhOC00NDA4LThhYjMtYWJmNDcwYjBmNDI3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiY3BHV3V3akVrVzQ4YXh6XC9haSt2MWlWM2MxdVAwSmZsWXhpMG1VMkNiMW91MHVIY2JVUUZxRkt5RytXVTVHMTAifQ==
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
> From: Jiri Kosina [mailto:jikos@kernel.org]
> Sent: Tuesday, September 04, 2018 10:35 AM
> To: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>; Ingo Molnar <mingo@redhat.com>;
> Peter Zijlstra <peterz@infradead.org>; Josh Poimboeuf
> <jpoimboe@redhat.com>; Andrea Arcangeli <aarcange@redhat.com>;
> Woodhouse, David <dwmw@amazon.co.uk>; Oleg Nesterov
> <oleg@redhat.com>; Schaufler, Casey <casey.schaufler@intel.com>; linux-
> kernel@vger.kernel.org; x86@kernel.org
> Subject: Re: [PATCH v3 1/3] ptrace: Provide ___ptrace_may_access() that can
> be applied on arbitrary tasks
> 
> On Tue, 4 Sep 2018, Tim Chen wrote:
> 
> > > Current ptrace_may_access() implementation assumes that the 'source'
> task is
> > > always the caller (current).
> > >
> > > Expose ___ptrace_may_access() that can be used to apply the check on
> arbitrary
> > > tasks.
> >
> > Casey recently has proposed putting the decision making of whether to
> > do IBPB in the security module.
> >
> > https://lwn.net/ml/kernel-hardening/20180815235355.14908-4-
> casey.schaufler@intel.com/
> >
> > That will have the advantage of giving the administrator a more flexibility
> > of when to turn on IBPB.  The policy is very similar to what you have proposed
> here
> > but I think the security module is a more appropriate place for the security
> policy.
> 
> Yeah, well, honestly, I have a bit hard time buying the "generic
> sidechannel prevention security module" idea, given how completely
> different in nature all the mitigations have been so far. I don't see that
> trying to abstract this somehow provides more clarity.

The real reason to use an LSM based approach is that overloading ptrace
checks is a Really Bad Idea. Ptrace is a user interface. Side-channel is a
processor interface. Even if ptrace_may_access() does exactly what you
want it to for side-channel mitigation today it would be incredibly
inappropriate to tie the two together for eternity. You don't want to restrict
the ptrace checks to only those things that are also good for side-channel,
and vice versa. 


> So if this should be done in LSM, it'd probably have to be written by
> someone else than me :) who actually understands how the "sidechannel LSM"
> idea works.

Yes. That would be me. 

> 
> Thanks,
> 
> --
> Jiri Kosina
> SUSE Labs

