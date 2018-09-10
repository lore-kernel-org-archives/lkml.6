Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76080C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 19:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2617920866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 19:29:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2617920866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbeIKAZT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 20:25:19 -0400
Received: from mga09.intel.com ([134.134.136.24]:15242 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726603AbeIKAZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 20:25:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2018 12:29:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,356,1531810800"; 
   d="scan'208";a="71864654"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by orsmga007.jf.intel.com with ESMTP; 10 Sep 2018 12:26:06 -0700
Received: from orsmsx111.amr.corp.intel.com (10.22.240.12) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 10 Sep 2018 12:26:06 -0700
Received: from orsmsx107.amr.corp.intel.com ([169.254.1.245]) by
 ORSMSX111.amr.corp.intel.com ([169.254.12.139]) with mapi id 14.03.0319.002;
 Mon, 10 Sep 2018 12:26:06 -0700
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
Thread-Index: AQHUSOgJU5Fr+3/MVEm2Zt46QQ4u6aTp1A7wgACEY4D//4ss4A==
Date:   Mon, 10 Sep 2018 19:26:05 +0000
Message-ID: <99FC4B6EFCEFD44486C35F4C281DC6732144AEC9@ORSMSX107.amr.corp.intel.com>
References: <nycvar.YFH.7.76.1809101119280.15880@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1809101123020.15880@cbobk.fhfr.pm>
 <99FC4B6EFCEFD44486C35F4C281DC6732144ADF9@ORSMSX107.amr.corp.intel.com>
 <nycvar.YFH.7.76.1809102111410.15880@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.1809102111410.15880@cbobk.fhfr.pm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMjdiNGNiYTEtMDFhZS00ZWZmLTg0OGEtODk2NmE4OGYxOWRhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiU0VEckJFK0NGZ21sSEFLOExVbXhISFM1Uk9qYjBFMkhiejVHcTY4aFwvZjVYYjBON3RWV3F4ZlBSXC9kRTQyRWw2In0=
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
> Sent: Monday, September 10, 2018 12:14 PM
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
> > Why are you dropping the LSM check here, when in v4 you fixed the
> > SELinux audit locking issue? We can avoid introducing an LSM hook
> > and all the baggage around it if you can do the
> security_ptrace_access_check()
> > here.
> 
> So what guarantees that none of the hooks that
> security_ptrace_access_check() is invoking will not be taking locks (from
> scheduler context in this case)?

The locking issue in the security modules is the same regardless of
whether the call of security_ptrace_access_check() comes from the
__ptrace_access_check() you're adding here or from a new security
hook (I have proposed security_task_safe_sidechannel) that gets added
in the same place later on. Adding a new hook results in duplication,
because there now has to be code that does exactly the same thing as
__ptrace_access_check() but without the new NOACCESS_CHECK mode.

Yes, It would require that this patch be tested against all the existing
security modules that provide a ptrace_access_check hook. It's not like
the security module writers don't have a bunch of locking issues to deal with. 

> Thanks,
> 
> --
> Jiri Kosina
> SUSE Labs

