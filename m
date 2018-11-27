Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9054AC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 19:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DCD321104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 19:44:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DCD321104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbeK1Gnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 01:43:43 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46930 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725752AbeK1Gnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 01:43:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12B8336B4;
        Tue, 27 Nov 2018 11:44:45 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D6BAB3F575;
        Tue, 27 Nov 2018 11:44:44 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id B72101AE0A0D; Tue, 27 Nov 2018 19:45:02 +0000 (GMT)
From:   Will Deacon <will.deacon@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, ard.biesheuvel@linaro.org,
        catalin.marinas@arm.com, rml@tech9.net, tglx@linutronix.de,
        peterz@infradead.org, schwidefsky@de.ibm.com,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 0/2] arm64: Only call into preempt_schedule() if need_resched()
Date:   Tue, 27 Nov 2018 19:45:00 +0000
Message-Id: <1543347902-21170-1-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This pair of patches improves our preempt_enable() implementation slightly
on arm64 by making the resulting call to preempt_schedule() conditional
on need_resched(), which is tracked in bit 32 of the preempt count. The
logic is inverted so that we can detect the preempt count going to zero
and need_resched being set with a single CBZ instruction.

Consequently, our preempt_enable() code (including prologue/epilogue)
goes from:

  40:   a9bf7bfd        stp     x29, x30, [sp, #-16]!
  44:   910003fd        mov     x29, sp
  48:   d5384101        mrs     x1, sp_el0
  4c:   b9401020        ldr     w0, [x1, #16]
  50:   51000400        sub     w0, w0, #0x1
  54:   b9001020        str     w0, [x1, #16]
  58:   350000a0        cbnz    w0, 6c
  5c:   f9400020        ldr     x0, [x1]
  60:   721f001f        tst     w0, #0x2
  64:   54000040        b.eq    6c // b.none
  68:   94000000        bl      0 <preempt_schedule>
  6c:   a8c17bfd        ldp     x29, x30, [sp], #16
  70:   d65f03c0        ret

to:

  40:   a9bf7bfd        stp     x29, x30, [sp, #-16]!
  44:   910003fd        mov     x29, sp
  48:   d5384101        mrs     x1, sp_el0
  4c:   f9400820        ldr     x0, [x1, #16]
  50:   d1000400        sub     x0, x0, #0x1
  54:   b9001020        str     w0, [x1, #16]
  58:   b4000060        cbz     x0, 64 <will+0x24>
  5c:   a8c17bfd        ldp     x29, x30, [sp], #16
  60:   d65f03c0        ret
  64:   94000000        bl      0 <preempt_schedule>
  68:   a8c17bfd        ldp     x29, x30, [sp], #16
  6c:   d65f03c0        ret

Will

--->8

Will Deacon (2):
  preempt: Move PREEMPT_NEED_RESCHED definition into arch code
  arm64: preempt: Provide our own implementation of asm/preempt.h

 arch/arm64/include/asm/Kbuild        |  1 -
 arch/arm64/include/asm/preempt.h     | 78 ++++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/thread_info.h | 13 +++++-
 arch/s390/include/asm/preempt.h      |  2 +
 arch/x86/include/asm/preempt.h       |  3 ++
 include/linux/preempt.h              |  3 --
 6 files changed, 95 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm64/include/asm/preempt.h

-- 
2.1.4

