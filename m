Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3ECC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 22:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34E9B206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 22:25:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34E9B206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbeILD1F convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 23:27:05 -0400
Received: from mga18.intel.com ([134.134.136.126]:36137 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726885AbeILD1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 23:27:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2018 15:25:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,362,1531810800"; 
   d="scan'208";a="73484028"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by orsmga006.jf.intel.com with ESMTP; 11 Sep 2018 15:25:40 -0700
Received: from orsmsx113.amr.corp.intel.com (10.22.240.9) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Tue, 11 Sep 2018 15:25:40 -0700
Received: from orsmsx107.amr.corp.intel.com ([169.254.1.245]) by
 ORSMSX113.amr.corp.intel.com ([169.254.9.72]) with mapi id 14.03.0319.002;
 Tue, 11 Sep 2018 15:25:39 -0700
From:   "Schaufler, Casey" <casey.schaufler@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Jiri Kosina <jikos@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
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
Thread-Index: AQHUSOgJU5Fr+3/MVEm2Zt46QQ4u6aTp1A7wgACEY4D//4ss4IAAevsA//+NH1CAAIVcgP//ka8gAEE8cYAADY+/8A==
Date:   Tue, 11 Sep 2018 22:25:38 +0000
Message-ID: <99FC4B6EFCEFD44486C35F4C281DC6732144B7E1@ORSMSX107.amr.corp.intel.com>
References: <nycvar.YFH.7.76.1809101119280.15880@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1809101123020.15880@cbobk.fhfr.pm>
 <99FC4B6EFCEFD44486C35F4C281DC6732144ADF9@ORSMSX107.amr.corp.intel.com>
 <nycvar.YFH.7.76.1809102111410.15880@cbobk.fhfr.pm>
 <99FC4B6EFCEFD44486C35F4C281DC6732144AEC9@ORSMSX107.amr.corp.intel.com>
 <nycvar.YFH.7.76.1809102132480.15880@cbobk.fhfr.pm>
 <99FC4B6EFCEFD44486C35F4C281DC6732144AF24@ORSMSX107.amr.corp.intel.com>
 <nycvar.YFH.7.76.1809102235010.15880@cbobk.fhfr.pm>
 <99FC4B6EFCEFD44486C35F4C281DC6732144AF87@ORSMSX107.amr.corp.intel.com>
 <alpine.DEB.2.21.1809112302580.1427@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1809112302580.1427@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOWQ4YzMxODctOGM5Yi00YTNmLTg2NzMtN2RmYzEwMzBjN2E5IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiVFBxWmZKTExBQ2RrOWg4Y2wxbWRKUVJQVnFnVElHaE9EUElaeWZxeDk0OFFuNUpsTGl0b0dMdlQrM1d3b0hvaCJ9
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
> From: Thomas Gleixner [mailto:tglx@linutronix.de]
...
> 
> Casey, can you please spare us the completely redundant copy of the mail
> header?

Sorry to be a bother.

> > Short of a patch to show the changes (which I wish I could do today, but
> > really can't) what I want to see is:
> >
> > 	- Put ptrace back to using the security module interfaces.
> > 	- Identify where this causes locking issues and work with the module
> > 	  owners (a reasonable lot, all) to provide lock safe paths for the IBPB
> case.
> >
> > Otherwise, I have to add a new LSM hook right after your ptrace call and
> > duplicate a whole lot of what you've just turned off, plus creating lock
> > safe code that duplicates what ptrace already does. While I would rather
> > have the side-channel checks be separate from the ptrace checks I can't
> > justify doing both.
> 
> I'm not yet convinced that making these decisions purely based on LSM is a
> good idea.

The current patch-under-discussion uses the ptrace access policy as the
criteria for deciding that side-channel attacks are worrisome. This patch
excludes the LSM checks that are usually called by the ptrace code. If it
retained the LSM checks the need to do anything special in an LSM would
be limited to things that the ptrace checks don't already do.

> The LSM based decision can optionally replace the built in
> default decision at runtime,

LSM modules can add restrictions, but do not replace existing decisions.

> but it cannot replace it because its simpler
> for most people to install a new kernel than fiddling with LSM.

Um, installing a new kernel is the usual way to fiddle with LSM.
It's done by configuration options, so I don't see the distinction you're making.

> We want a halfways sane default solution for this ASAP and Jiri's patch is
> straight forward providing one without preventing you from adding your
> magic LSM stuff once you have time to work on it including all (locking)
> problems it creates.

There's actually one locking issue in the SELinux ptrace hook, and that's
due to auditing. It's easy to fix. I did it in the side channel LSM that I proposed.
There's nothing magic about the "LSM stuff", especially compared to what goes
on in ptrace.

> Nice try to offload that to Jiri.

Oh, come off it. If ptrace is the right way to do this check, that's great.
What I'm saying is that rather than turning off the LSM checks in ptrace
because it will take some work to get it right for the environment it gets
called from the right thing to do is to fix the LSM code.

How about this? Take Jiri's patch as written. You get everything except checks
on the security blobs and any "magic" that my safesidechannel module did. I
will propose a follow on patch that fixes the SELinux code to eliminate the locking
issue and enables the LSM hooks in the IBPB case. I can then do a revised "magic"
safesidechannel security module that uses the ptrace hook instead of adding a
new hook explicitly for IBPB. There is some danger that in the future ptrace and
IBPB criteria will diverge sufficiently that a common hook becomes nonsensical.
As no one else seems concerned about this possibility, I won't lose any sleep over
it either.

> Thanks,
> 
> 	tglx
