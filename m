Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD524C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 859AD2145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:34:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 859AD2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbeLAEoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:44:14 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33162 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbeLAEoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 23:44:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D20F6EBD;
        Fri, 30 Nov 2018 09:34:13 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A191E3F5A0;
        Fri, 30 Nov 2018 09:34:13 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 774221AE0FA2; Fri, 30 Nov 2018 17:34:32 +0000 (GMT)
From:   Will Deacon <will.deacon@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, ard.biesheuvel@linaro.org,
        catalin.marinas@arm.com, rml@tech9.net, tglx@linutronix.de,
        peterz@infradead.org, schwidefsky@de.ibm.com,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH v2 0/2] arm64: Only call into preempt_schedule() if need_resched()
Date:   Fri, 30 Nov 2018 17:34:29 +0000
Message-Id: <1543599271-14339-1-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is version two of the patches I originally posted here:

  http://lkml.kernel.org/r/1543347902-21170-1-git-send-email-will.deacon@arm.com

The only change since v1 is that  __preempt_count_dec_and_test() now
reloads the need_resched flag if it initially saw that it was set. This
resolves the issue spotted by Peter, where an IRQ coming in during the
decrement can cause a reschedule to be missed.

Feedback welcome.

Will

--->8

Will Deacon (2):
  preempt: Move PREEMPT_NEED_RESCHED definition into arch code
  arm64: preempt: Provide our own implementation of asm/preempt.h

 arch/arm64/include/asm/Kbuild        |  1 -
 arch/arm64/include/asm/preempt.h     | 88 ++++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/thread_info.h | 13 +++++-
 arch/s390/include/asm/preempt.h      |  2 +
 arch/x86/include/asm/preempt.h       |  3 ++
 include/linux/preempt.h              |  3 --
 6 files changed, 105 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm64/include/asm/preempt.h

-- 
2.1.4

