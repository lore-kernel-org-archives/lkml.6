Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACAA0C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88CC2218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbfAaSX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 13:23:56 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49358 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726455AbfAaSXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 13:23:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16EAEA78;
        Thu, 31 Jan 2019 10:23:55 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8DA963F59C;
        Thu, 31 Jan 2019 10:23:52 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Julien Grall <julien.grall@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [RFC PATCH 0/3] arm/arm64: entry: Remove need_resched() loop
Date:   Thu, 31 Jan 2019 18:23:36 +0000
Message-Id: <20190131182339.9835-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A while back (before [1]), i386 had this in the tail of its irq
handling code:

  need_resched:
	  movl TI_flags(%ebp), %ecx       # need_resched set ?
	  testb $_TIF_NEED_RESCHED, %cl
	  jz restore_all
	  testl $IF_MASK,EFLAGS(%esp)     # interrupts off (exception path) ?
	  jz restore_all
	  sti
	  call preempt_schedule
	  cli
	  movl $0,TI_preempt_count(%ebp)
	  jmp need_resched

preempt_schedule() already had an inner need_resched() loop introduced by

  commit 4d0b85ea4610 ("[PATCH] kernel preemption bits (2/2)")

and the outer loop was needed since, as the above commit explains, it
was possible to return from preempt_schedule(), get an interrupt and
have need_resched() true.

This was eventually changed when preempt_schedule_irq() was introduced
by [1]:

  commit b268264c6299 ("[PATCH] sched: fix preemption race (Core/i386)")

which moved the enabling & disabling of interrupts inside the then
new preempt_schedule_irq(). From then on, the arch-code loop was no
longer necessary, providing preempt_schedule_irq() was used. This was
talked over on LKML in [2].

It's worth noting that it seems most archs calling
preempt_schedule_irq() have that outer loop, and for most of them it
really looks like they could get rid of it as well.

FWIW the suspects are

$ grep -r -I "preempt_schedule_irq" arch/ | cut -d/ -f2 | sort | uniq

  arc
  arm
  arm64
  c6x
  csky
  h8300
  ia64
  m68k
  microblaze
  mips
  nds32
  nios2
  parisc
  powerpc
  s390
  sh
  sparc
  x86
  xtensa


- Patches 1-2 remove the loop for arm & arm64
- Patch 3 adds a bit of documentation to point out the loop isn't needed
  to try and spread the word.

[2]: https://lore.kernel.org/lkml/cc989920-a13b-d53b-db83-1584a7f53edc@arm.com/

Valentin Schneider (3):
  arm64: entry: Remove unneeded need_resched() loop
  ARM: entry: Remove unneeded need_resched() loop
  sched/Documentation: Point out use of preempt_schedule_irq()

 Documentation/scheduler/sched-arch.txt | 10 ++++++++++
 arch/arm/kernel/entry-armv.S           | 12 +-----------
 arch/arm64/kernel/entry.S              | 11 +----------
 3 files changed, 12 insertions(+), 21 deletions(-)

--
2.20.1

