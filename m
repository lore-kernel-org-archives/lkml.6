Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FE1C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 498DF20897
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:05:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 498DF20897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbeILOI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 10:08:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:48644 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727702AbeILOI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 10:08:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5BA13AE78;
        Wed, 12 Sep 2018 09:05:22 +0000 (UTC)
Date:   Wed, 12 Sep 2018 11:05:20 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>
cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH v6 0/3] Harden spectrev2 userspace-userspace protection
In-Reply-To: <nycvar.YFH.7.76.1809101119280.15880@cbobk.fhfr.pm>
Message-ID: <nycvar.YFH.7.76.1809121055070.15880@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1809101119280.15880@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, linux kernel is basically not preventing userspace-userspace 
spectrev2 attack, because:

- IBPB is basically unused (issued only for tasks that marked themselves 
  explicitly non-dumpable, which is absolutely negligible minority of all 
  software out there), therefore cross-process branch buffer posioning 
  using spectrev2 is possible

- STIBP is completely unused, therefore cross-process branch buffer 
  poisoning using spectrev2 between processess running on two HT siblings 
  thread s is possible

This patchset changes IBPB semantics, so that it's now applied whenever 
context-switching between processess that can't use ptrace() to achieve 
the same. This admittedly comes with extra overhad on a context switch; 
systems that don't care about could disable the mitigation using 
nospectre_v2 boot option.
The IBPB implementaion is heavily based on original patches by Tim Chen.

In addition to that, we unconditionally turn STIBP on so that HT siblings 
always have separate branch buffers.

We've been carrying IBPB implementation with the same semantics in our 
(SUSE) trees since january disclosure; STIBP was more or less ignored up 
to today.

v1->v2:
        include IBPB changes
v2->v3: 
        fix IBPB 'who can trace who' semantics
        wire up STIBP flipping to SMT hotplug
v3->v4:
	dropped ___ptrace_may_access(), as it's not needed
	fixed deadlock with LSM/audit/selinux (Andrea Arcangeli)
	statically patch out the ptrace check if !IBPB

v4->v5:
	fix MSR writing logic (Thomas Gleixner, Josh Poimboeuf)

v5->v6:
	propagate X86_FEATURE_RSB_CTXSW setting to sysfs
	propagate STIBP setting to sysfs (Thomas Gleixner)
	simplify arch_smt_update() (Thomas Gleixner)

Jiri Kosina (3):
      x86/speculation: apply IBPB more strictly to avoid cross-process data leak
      x86/speculation: Enable cross-hyperthread spectre v2 STIBP mitigation
      x86/speculation: Propagate information about RSB filling mitigation to sysfs

 arch/x86/kernel/cpu/bugs.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++------
 arch/x86/mm/tlb.c          | 31 ++++++++++++++++++++-----------
 include/linux/ptrace.h     |  4 ++++
 kernel/cpu.c               | 11 ++++++++++-
 kernel/ptrace.c            | 12 ++++++++----
 5 files changed, 96 insertions(+), 22 deletions(-)

-- 
Jiri Kosina
SUSE Labs

