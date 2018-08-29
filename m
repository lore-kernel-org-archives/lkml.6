Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2779C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E9C2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:13:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85E9C2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbeH2MJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:09:09 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:43187 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727198AbeH2MJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:09:07 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 29 Aug 2018 01:13:09 -0700
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 23B5540B4D;
        Wed, 29 Aug 2018 01:13:26 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        <linux-arch@vger.kernel.org>, Nadav Amit <namit@vmware.com>,
        Andy Lutomirski <luto@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [RFC PATCH 0/6] x86: text_poke() fixes
Date:   Wed, 29 Aug 2018 01:11:41 -0700
Message-ID: <20180829081147.184610-1-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-001.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set addresses some issues that were raised in the recent
correspondence and might affect the security and the correctness of code
patching. (Note that patching performance is not addressed by this
patch-set).

The main issue that the patches deal with is the fact that the fixmap
PTEs that are used for patching are available for access from other
cores and might be exploited. They are not even flushed from the TLB in
remote cores, so the risk is even higher. Address this issue by
introducing a temporary mm that is only used during patching.
Unfortunately, due to init ordering, fixmap is still used during
boot-time patching. Future patches can eliminate the need for it.

The second issue is the missing lockdep assertion to ensure text_mutex
is taken. It is actually not always taken, so fix the instances that
were found not to take the lock (although they should be safe even
without taking the lock).

Finally, try to be more conservative and to map a single page, instead
of two, when possible. This helps both security and performance.

In addition, there is some cleanup of the patching code to make it more
readable.

[ Andy: please provide your SOB for your patch ]

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>

Andy Lutomirski (1):
  x86/mm: temporary mm struct

Nadav Amit (5):
  x86/alternative: assert text_mutex is taken
  fork: provide a function for copying init_mm
  x86/alternatives: initializing temporary mm for patching
  x86/alternatives: use temporary mm for text poking
  x86/alternatives: remove text_poke() return value

 arch/x86/include/asm/mmu_context.h   |  20 ++++
 arch/x86/include/asm/pgtable.h       |   4 +
 arch/x86/include/asm/text-patching.h |   4 +-
 arch/x86/kernel/alternative.c        | 157 +++++++++++++++++++++++----
 arch/x86/kernel/kgdb.c               |   9 ++
 arch/x86/mm/init_64.c                |  35 ++++++
 include/asm-generic/pgtable.h        |   4 +
 include/linux/sched/task.h           |   1 +
 init/main.c                          |   1 +
 kernel/fork.c                        |  24 +++-
 10 files changed, 230 insertions(+), 29 deletions(-)

-- 
2.17.1

