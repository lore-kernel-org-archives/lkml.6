Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9CEC43610
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 03:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E3C2145D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 03:53:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70E3C2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbeKUO0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 09:26:09 -0500
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:2110 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726773AbeKUO0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 09:26:08 -0500
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Tue, 20 Nov 2018 19:52:59 -0800
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 30782B1870;
        Tue, 20 Nov 2018 22:53:30 -0500 (EST)
From:   Nadav Amit <namit@vmware.com>
To:     Ingo Molnar <mingo@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, <linux_dti@icloud.com>,
        <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        Nadav Amit <namit@vmware.com>
Subject: [PATCH v6 00/10] x86/alternative: text_poke() fixes
Date:   Tue, 20 Nov 2018 12:35:35 -0800
Message-ID: <20181120203545.34928-1-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-002.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set addresses some issues that might affect the security and
the correctness of code patching.

The main issue that the patches deal with is the fact that the fixmap
PTEs that are used for patching are available for access from other
cores and might be exploited. They are not even flushed from the TLB in
remote cores, so the risk is even higher. This set addresses this issue
by introducing a temporary mm that is only used during patching.

To do so, we need to avoid using text_poke() before the poking-mm is
initialized and instead use text_poke_early().

During v3 of this set, Andy & Thomas suggested that early patching of
modules can be improved by simply writing to the memory. This actually
raises a security concern: there should not be any W+X mappings at any
given moment, and modules loading breaks this protection for no good
reason. So this patch also addresses this issue, while (presumably)
improving patching speed by making module memory initially RW(+NX) and
before execution changing it into RO(+X).

In addition the patch addresses various issues that are related to code
patching, and do some cleanup.

v5->v6:
- Panic if anything goes wrong when poking [peterZ]

v4->v5:
- Fix Xen breakage [Damian Tometzki]
- BUG_ON() when poking_mm initialization fails [peterZ]
- Better comments on "x86/mm: temporary mm struct"
- Cleaner removal of the custom poker

v3->v4:
- Setting modules as RO when loading [andy, tglx]
- Adding text_poke_kgdb() to keep the text_mutex assertion [tglx]
- Simpler logic to decide when to use early-poking [peterZ]
- More cleanup

v2->v3:
- Remove the fallback path in text_poke() [peterZ]
- poking_init() was broken due to the local variable poking_addr
- Preallocate tables for the temporary-mm to avoid sleep-in-atomic
- Prevent KASAN from yelling at text_poke()

v1->v2:
- Partial revert of 9222f606506c added to 1/6 [masami]
- Added Masami's reviewed-by tag

RFC->v1:
- Added handling of error in get_locked_pte()
- Remove lockdep assertion, clarify text_mutex use instead [masami]
- Comment fix [peterz]
- Removed remainders of text_poke return value [masami]
- Use __weak for poking_init instead of macros [masami]
- Simplify error handling in poking_init [masami]

andy Lutomirski (1):
  x86/mm: temporary mm struct

Nadav Amit (9):
  Fix "x86/alternatives: Lockdep-enforce text_mutex in text_poke*()"
  x86/jump_label: Use text_poke_early() during early init
  fork: provide a function for copying init_mm
  x86/alternative: initializing temporary mm for patching
  x86/alternative: use temporary mm for text poking
  x86/kgdb: avoid redundant comparison of patched code
  x86: avoid W^X being broken during modules loading
  x86/jump-label: remove support for custom poker
  x86/alternative: remove the return value of text_poke_*()

 arch/x86/include/asm/fixmap.h        |   2 -
 arch/x86/include/asm/mmu_context.h   |  32 +++++
 arch/x86/include/asm/pgtable.h       |   3 +
 arch/x86/include/asm/text-patching.h |   7 +-
 arch/x86/kernel/alternative.c        | 197 ++++++++++++++++++++-------
 arch/x86/kernel/jump_label.c         |  19 ++-
 arch/x86/kernel/kgdb.c               |  25 +---
 arch/x86/kernel/module.c             |   2 +-
 arch/x86/mm/init_64.c                |  35 +++++
 arch/x86/xen/mmu_pv.c                |   2 -
 include/linux/filter.h               |   6 +
 include/linux/sched/task.h           |   1 +
 init/main.c                          |   3 +
 kernel/fork.c                        |  24 +++-
 kernel/module.c                      |  10 ++
 15 files changed, 279 insertions(+), 89 deletions(-)

-- 
2.17.1

