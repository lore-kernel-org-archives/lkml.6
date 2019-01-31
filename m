Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4EFC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D984320B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbfAaSYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 13:24:11 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49402 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726455AbfAaSYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 13:24:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6F4A1596;
        Thu, 31 Jan 2019 10:24:07 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3DB393F59C;
        Thu, 31 Jan 2019 10:24:06 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Julien Thierry <julien.thierry@arm.com>,
        linux-doc@vger.kernel.org
Subject: [RFC PATCH 3/3] sched/Documentation: Point out use of preempt_schedule_irq()
Date:   Thu, 31 Jan 2019 18:23:39 +0000
Message-Id: <20190131182339.9835-4-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131182339.9835-1-valentin.schneider@arm.com>
References: <20190131182339.9835-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since there are a few archs out there that call preempt_schedule_irq()
within a need_resched() loop, point out that it's not needed.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Julien Thierry <julien.thierry@arm.com>
Cc: linux-doc@vger.kernel.org
---
 Documentation/scheduler/sched-arch.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/scheduler/sched-arch.txt b/Documentation/scheduler/sched-arch.txt
index a2f27bbf2cba..ae41a94da700 100644
--- a/Documentation/scheduler/sched-arch.txt
+++ b/Documentation/scheduler/sched-arch.txt
@@ -59,6 +59,16 @@ Your cpu_idle routines need to obey the following rules:
 arch/x86/kernel/process.c has examples of both polling and
 sleeping idle functions.
 
+Kernel preemption
+=================
+When returning from interrupt context, you should call either of
+preempt_schedule() or preempt_schedule_irq() if preemption is enabled
+and need_resched() is true.
+
+Note that, unlike preempt_schedule(), preempt_schedule_irq() handles the
+enabling and disabling of IRQs. Since it also loops on need_resched(),
+you don't need to have that loop in your arch code. See
+arch/arm64/kernel/entry.S for an example.
 
 Possible arch/ problems
 =======================
--
2.20.1

