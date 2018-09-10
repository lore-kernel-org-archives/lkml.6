Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1AFC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 20:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F15F20658
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 20:42:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F15F20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbeIKBiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 21:38:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:48676 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726043AbeIKBiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 21:38:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A00C9ADCD;
        Mon, 10 Sep 2018 20:42:23 +0000 (UTC)
Date:   Mon, 10 Sep 2018 22:42:21 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     "Schaufler, Casey" <casey.schaufler@intel.com>
cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v5 1/2] x86/speculation: apply IBPB more strictly to
 avoid cross-process data leak
In-Reply-To: <99FC4B6EFCEFD44486C35F4C281DC6732144AF24@ORSMSX107.amr.corp.intel.com>
Message-ID: <nycvar.YFH.7.76.1809102235010.15880@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1809101119280.15880@cbobk.fhfr.pm> <nycvar.YFH.7.76.1809101123020.15880@cbobk.fhfr.pm> <99FC4B6EFCEFD44486C35F4C281DC6732144ADF9@ORSMSX107.amr.corp.intel.com> <nycvar.YFH.7.76.1809102111410.15880@cbobk.fhfr.pm>
 <99FC4B6EFCEFD44486C35F4C281DC6732144AEC9@ORSMSX107.amr.corp.intel.com> <nycvar.YFH.7.76.1809102132480.15880@cbobk.fhfr.pm> <99FC4B6EFCEFD44486C35F4C281DC6732144AF24@ORSMSX107.amr.corp.intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Sep 2018, Schaufler, Casey wrote:

> It you're going to call __ptrace_access_check(), 

I guess you mean __ptrace_may_access() here.

> which already includes an LSM hook, it makes a whole lot of sense to 
> make that the path for doing any module specific checks. It seems wrong 
> to disable the LSM hook there, then turn around and introduce a new one 
> that does the check you just disabled. The patches I had proposed 
> created a new LSM hook because there was not path to an existing hook. 
> With your addition of __ptrace_access_check() that is no longer an issue 
> once any locking problems are resolved. Rather than use a new hook, the 
> existing ptrace hooks ought to work just fine, and any new checks can be 
> added in a new module that has its own ptrace_access_check hook.

Sorry for being dense, but what exactly are you proposing here then?

This patch (v4 and v5) explicitly avoids calling out to ptrace_has_cap() 
(which calls out to LSM through has_ns_capability_*() -> 
security_capable()) in PTRACE_MODE_IBPB case, exactly to avoid locking 
issues with security modules; there are known callchains that lead to 
deadlock.

With the same reasoning, security_ptrace_access_check() call is avoided, 
only there is no know particular callchain that'd lead to a lock being 
taken, but noone has done such audit (yet), as it's all hidden behind LSM 
callbacks.

So please tell me what exactly you'd like to see changed in the IBPB patch 
and why exactly, I am not seeing it yet.

Thanks,

-- 
Jiri Kosina
SUSE Labs

