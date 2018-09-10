Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E8BC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 20:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97A8F20855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 20:27:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97A8F20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbeIKBXO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 21:23:14 -0400
Received: from mga14.intel.com ([192.55.52.115]:34292 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbeIKBXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 21:23:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2018 13:27:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,356,1531810800"; 
   d="scan'208";a="73147679"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by orsmga006.jf.intel.com with ESMTP; 10 Sep 2018 13:27:25 -0700
Received: from orsmsx111.amr.corp.intel.com (10.22.240.12) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 10 Sep 2018 13:27:25 -0700
Received: from orsmsx107.amr.corp.intel.com ([169.254.1.245]) by
 ORSMSX111.amr.corp.intel.com ([169.254.12.139]) with mapi id 14.03.0319.002;
 Mon, 10 Sep 2018 13:27:25 -0700
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
Thread-Index: AQHUSOgJU5Fr+3/MVEm2Zt46QQ4u6aTp1A7wgACEY4D//4ss4IAAevsA//+NH1A=
Date:   Mon, 10 Sep 2018 20:27:24 +0000
Message-ID: <99FC4B6EFCEFD44486C35F4C281DC6732144AF24@ORSMSX107.amr.corp.intel.com>
References: <nycvar.YFH.7.76.1809101119280.15880@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1809101123020.15880@cbobk.fhfr.pm>
 <99FC4B6EFCEFD44486C35F4C281DC6732144ADF9@ORSMSX107.amr.corp.intel.com>
 <nycvar.YFH.7.76.1809102111410.15880@cbobk.fhfr.pm>
 <99FC4B6EFCEFD44486C35F4C281DC6732144AEC9@ORSMSX107.amr.corp.intel.com>
 <nycvar.YFH.7.76.1809102132480.15880@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.1809102132480.15880@cbobk.fhfr.pm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYmMxYjRmNTMtNjE0NS00ZDU3LWFjYjAtMjNiMDk4ZGUxYzU0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoicVwvVERFTTZIVWpIWnM3c1wvbEt1XC8zXC96Wm16XC9CM1puck5MbW1pMlloT2RFTlBiTEltZmJZZWRHaU5IOXN0NUtLIn0=
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
> Sent: Monday, September 10, 2018 12:36 PM
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
> > Yes, It would require that this patch be tested against all the existing
> > security modules that provide a ptrace_access_check hook. It's not like
> > the security module writers don't have a bunch of locking issues to deal
> > with.
> 
> Yeah, that was indeed my concern.
> 
> So can we agree on doing this in the 2nd envisioned step, when this is
> going to be replaced by LSM as discussed [1] previously?

It you're going to call __ptrace_access_check(), which already includes
an LSM hook, it makes a whole lot of sense to make that the path for doing
any module specific checks. It seems wrong to disable the LSM hook there,
then turn around and introduce a new one that does the check you just
disabled. The patches I had proposed created a new LSM hook because there
was not path to an existing hook. With your addition of __ptrace_access_check()
that is no longer an issue once any locking problems are resolved. Rather than
use a new hook, the existing ptrace hooks ought to work just fine, and any new
checks can be added in a new module that has its own ptrace_access_check hook.

> [1]
> http://lkml.kernel.org/r/99FC4B6EFCEFD44486C35F4C281DC67321447094@OR
> SMSX107.amr.corp.intel.com
> 
> Thanks,
> 
> --
> Jiri Kosina
> SUSE Labs

