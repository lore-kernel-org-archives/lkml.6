Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728B3ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B374206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B374206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388778AbeGPIIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:08:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47788 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730161AbeGPIIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:08:32 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 42606C03;
        Mon, 16 Jul 2018 07:42:29 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Huacai Chen <chenhc@lemote.com>, linux-mips@linux-mips.org
Subject: [PATCH 4.9 02/32] MIPS: Call dump_stack() from show_regs()
Date:   Mon, 16 Jul 2018 09:36:10 +0200
Message-Id: <20180716073504.733225999@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716073504.433996952@linuxfoundation.org>
References: <20180716073504.433996952@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@mips.com>

commit 5a267832c2ec47b2dad0fdb291a96bb5b8869315 upstream.

The generic nmi_cpu_backtrace() function calls show_regs() when a struct
pt_regs is available, and dump_stack() otherwise. If we were to make use
of the generic nmi_cpu_backtrace() with MIPS' current implementation of
show_regs() this would mean that we see only register data with no
accompanying stack information, in contrast with our current
implementation which calls dump_stack() regardless of whether register
state is available.

In preparation for making use of the generic nmi_cpu_backtrace() to
implement arch_trigger_cpumask_backtrace(), have our implementation of
show_regs() call dump_stack() and drop the explicit dump_stack() call in
arch_dump_stack() which is invoked by arch_trigger_cpumask_backtrace().

This will allow the output we produce to remain the same after a later
patch switches to using nmi_cpu_backtrace(). It may mean that we produce
extra stack output in other uses of show_regs(), but this:

  1) Seems harmless.
  2) Is good for consistency between arch_trigger_cpumask_backtrace()
     and other users of show_regs().
  3) Matches the behaviour of the ARM & PowerPC architectures.

Marked for stable back to v4.9 as a prerequisite of the following patch
"MIPS: Call dump_stack() from show_regs()".

Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/19596/
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Huacai Chen <chenhc@lemote.com>
Cc: linux-mips@linux-mips.org
Cc: stable@vger.kernel.org # v4.9+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/process.c |    4 ++--
 arch/mips/kernel/traps.c   |    1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -641,8 +641,8 @@ static void arch_dump_stack(void *info)
 
 	if (regs)
 		show_regs(regs);
-
-	dump_stack();
+	else
+		dump_stack();
 }
 
 void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -351,6 +351,7 @@ static void __show_regs(const struct pt_
 void show_regs(struct pt_regs *regs)
 {
 	__show_regs((struct pt_regs *)regs);
+	dump_stack();
 }
 
 void show_registers(struct pt_regs *regs)


