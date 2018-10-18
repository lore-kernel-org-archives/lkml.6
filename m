Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24FEECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 00:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9084E2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 00:56:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9084E2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbeJRIyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 04:54:31 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:46860 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726706AbeJRIya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 04:54:30 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 17 Oct 2018 17:55:41 -0700
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 3989740827;
        Wed, 17 Oct 2018 17:56:09 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Ingo Molnar <mingo@redhat.com>
CC:     Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "H . Peter Anvin " <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, Nadav Amit <nadav.amit@gmail.com>,
        <x86@kernel.org>, Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Nadav Amit <namit@vmware.com>
Subject: [RFC PATCH 0/5] x86: dynamic indirect call promotion
Date:   Wed, 17 Oct 2018 17:54:15 -0700
Message-ID: <20181018005420.82993-1-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-001.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This RFC introduces indirect call promotion in runtime, which for the
matter of simplification (and branding) will be called here "relpolines"
(relative call + trampoline). Relpolines are mainly intended as a way
of reducing retpoline overheads due to Spectre v2.

Unlike indirect call promotion through profile guided optimization, the
proposed approach does not require a profiling stage, works well with
modules whose address is unknown and can adapt to changing workloads.

The main idea is simple: for every indirect call, we inject a piece of
code with fast- and slow-path calls. The fast path is used if the target
matches the expected (hot) target. The slow-path uses a retpoline.
During training, the slow-path is set to call a function that saves the
call source and target in a hash-table and keep count for call
frequency. The most common target is then patched into the hot path.

The patching is done on-the-fly by patching the conditional branch
(opcode and offset) that is used to compare the target to the hot
target. This allows to direct all cores to the fast-path, while patching
the slow-path and vice-versa. Patching follows 2 more rules: (1) Only
patch a single byte when the code might be executed by any core. (2)
When patching more than one byte, ensure that all cores do not run the
to-be-patched-code by preventing this code from being preempted, and
using synchronize_sched() after patching the branch that jumps over this
code.

Changing all the indirect calls to use relpolines is done using assembly
macro magic. There are alternative solutions, but this one is
relatively simple and transparent. There is also logic to retrain the
software predictor, but the policy it uses may need to be refined.

Eventually the results are not bad (2 VCPU VM, throughput reported):

		base		relpoline
		----		---------
nginx 		22898 		25178 (+10%)
redis-ycsb	24523		25486 (+4%)
dbench		2144		2103 (+2%)

When retpolines are disabled, and if retraining is off, performance
benefits are up to 2% (nginx), but are much less impressive.

There are several open issues: retraining should be done when modules
are removed; CPU hotplug is not supported, x86-32 is probably broken and
the Makefile does not rebuild when the relpoline code is changed. Having
said that, I am worried that some of the approaches I took would
challenge the new code-of-conduct, so I though of getting some feedback
before putting more effort into it.

Nadav Amit (5):
  x86: introduce preemption disable prefix
  x86: patch indirect branch promotion
  x86: interface for accessing indirect branch locations
  x86: learning and patching indirect branch targets
  x86: relpoline: disabling interface

 arch/x86/entry/entry_64.S            |  10 +
 arch/x86/include/asm/nospec-branch.h | 158 +++++
 arch/x86/include/asm/sections.h      |   2 +
 arch/x86/kernel/Makefile             |   1 +
 arch/x86/kernel/asm-offsets.c        |   6 +
 arch/x86/kernel/macros.S             |   1 +
 arch/x86/kernel/nospec-branch.c      | 899 +++++++++++++++++++++++++++
 arch/x86/kernel/vmlinux.lds.S        |   7 +
 arch/x86/lib/retpoline.S             |  75 +++
 include/linux/module.h               |   5 +
 kernel/module.c                      |   8 +
 kernel/seccomp.c                     |   2 +
 12 files changed, 1174 insertions(+)
 create mode 100644 arch/x86/kernel/nospec-branch.c

-- 
2.17.1

