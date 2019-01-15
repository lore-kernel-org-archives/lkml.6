Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932E3C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 06:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6344020861
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 06:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547533502;
	bh=0xtxfZtFdIUmaXPj2hBVcHLm0ZupOdVKMg42UdHhv0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JIoB5GJ6mUacXThdbMPZAloViKhFHi4Dni8VkK6L2fxa57Lp1EFSscTRo2mX+FyUH
	 RuILlqxas5luXdHTixnEhd27SyJljdU++vF1HztndHuNewu/hFHLgJs/UhyQ0Mmg7P
	 2zlS1/SXi7E1RL4u7mZowJJ/iTbqUNgvJwCWgCG8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbfAOGZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 01:25:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:41674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727470AbfAOGZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 01:25:00 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2C5020651;
        Tue, 15 Jan 2019 06:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547533499;
        bh=0xtxfZtFdIUmaXPj2hBVcHLm0ZupOdVKMg42UdHhv0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xaxRNC5TU7mwE4kCafxai/8OXGNAt1p6TBuFLDs755hYV+NpzHfTp+UCSIkQtbUtg
         Kxm5h2EQhd2+quCvpWCzOC2csDJY17wbZqs6zRdAluJR0okey87/cbt0nS07aTOKeA
         HnxMbXMMGKxU8E1Vrj6Q64otx6HiRzFzihk67BWY=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Pratyush Anand <panand@redhat.com>,
        "David A . Long" <dave.long@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>
Subject: [PATCH v2 2/4] arm64: kprobes: Remove unneeded RODATA check
Date:   Tue, 15 Jan 2019 15:24:36 +0900
Message-Id: <154753347659.31541.11277302003578292109.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <154753341900.31541.8135985235882849464.stgit@devbox>
References: <154753341900.31541.8135985235882849464.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unneeded RODATA check from arch_prepare_kprobe().

Since check_kprobe_address_safe() already ensured that
the probe address is in kernel text, we don't need to
check whether the address in RODATA or not. That must
be always false.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/arm64/kernel/probes/kprobes.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index b2d4b7428ebc..1dae500d0a81 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -91,8 +91,6 @@ static void __kprobes arch_simulate_insn(struct kprobe *p, struct pt_regs *regs)
 int __kprobes arch_prepare_kprobe(struct kprobe *p)
 {
 	unsigned long probe_addr = (unsigned long)p->addr;
-	extern char __start_rodata[];
-	extern char __end_rodata[];
 
 	if (probe_addr & 0x3)
 		return -EINVAL;
@@ -106,10 +104,6 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 	if (search_exception_tables(probe_addr))
 		return -EINVAL;
 
-	if (probe_addr >= (unsigned long) __start_rodata &&
-	    probe_addr <= (unsigned long) __end_rodata)
-		return -EINVAL;
-
 	/* decode instruction */
 	switch (arm_kprobe_decode_insn(p->addr, &p->ainsn)) {
 	case INSN_REJECTED:	/* insn not supported */

