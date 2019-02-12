Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CD8C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CFBA21773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549987989;
	bh=kzavcezCbKBHZ9idEgPliuBsrGnUcbV3KzcyJwVlSGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OSvI8jcbBVtM4dzthTBeGgGVR6pKuty5s+7XCjDlz9J7bcXCx8w5UKiGSC0uryh4E
	 9IsFfEO6gMuGW9PKxh60HYycGzNNhmkkSzGO5wIdoVREOopuVtfUAM6HVA2oQ/0iVo
	 ycfLHMPckEML1m6wD4AZ7mv2a2GblOGL+Q2QV39Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730951AbfBLQNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:13:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:41716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728585AbfBLQNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 11:13:07 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDE7F217D9;
        Tue, 12 Feb 2019 16:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549987987;
        bh=kzavcezCbKBHZ9idEgPliuBsrGnUcbV3KzcyJwVlSGQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l5Ssxplz/C+ydomM5LG0M+w9OPxqtK/1hRGNKRYLU/NCDkzV2ohRNlIHRqQygB92J
         4K2yUmxbIlpZ3agAOVAdcyHl8YvEKmoyHsXmQ5gxCBgovlUIz6uzTsz4oRHxBg9IiO
         xqpwZDa18fSlEh8KbMtZTxzb+kfj1jbqR+DJr6JE=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Righi <righi.andrea@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH -tip v3 04/10] x86/kprobes: Prohibit probing on IRQ handlers directly
Date:   Wed, 13 Feb 2019 01:12:44 +0900
Message-Id: <154998796400.31052.8406236614820687840.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <154998785011.31052.1475728497912659748.stgit@devbox>
References: <154998785011.31052.1475728497912659748.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prohibit probing on IRQ handlers in irqentry_text because
if it interrupts user mode, at that point we haven't changed
to kernel space yet and which eventually leads a double fault.
E.g.

 # echo p apic_timer_interrupt > kprobe_events
 # echo 1 > events/kprobes/enable
 PANIC: double fault, error_code: 0x0
 CPU: 1 PID: 814 Comm: less Not tainted 4.20.0-rc3+ #30
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
 RIP: 0010:error_entry+0x12/0xf0
 [snip]
 Call Trace:
  <ENTRY_TRAMPOLINE>
  ? native_iret+0x7/0x7
  ? async_page_fault+0x8/0x30
  ? trace_hardirqs_on_thunk+0x1c/0x1c
  ? error_entry+0x7c/0xf0
  ? async_page_fault+0x8/0x30
  ? native_iret+0x7/0x7
  ? int3+0xa/0x20
  ? trace_hardirqs_on_thunk+0x1c/0x1c
  ? error_entry+0x7c/0xf0
  ? int3+0xa/0x20
  ? apic_timer_interrupt+0x1/0x20
  </ENTRY_TRAMPOLINE>
 Kernel panic - not syncing: Machine halted.
 Kernel Offset: disabled
 ---[ end Kernel panic - not syncing: Machine halted. ]---

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/x86/kernel/kprobes/core.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 4ba75afba527..a034cb808e7e 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -1028,6 +1028,13 @@ NOKPROBE_SYMBOL(kprobe_fault_handler);
 
 int __init arch_populate_kprobe_blacklist(void)
 {
+	int ret;
+
+	ret = kprobe_add_area_blacklist((unsigned long)__irqentry_text_start,
+					 (unsigned long)__irqentry_text_end);
+	if (ret)
+		return ret;
+
 	return kprobe_add_area_blacklist((unsigned long)__entry_text_start,
 					 (unsigned long)__entry_text_end);
 }

