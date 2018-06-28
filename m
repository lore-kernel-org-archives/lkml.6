Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02AB3C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFBD727670
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="pJwO8rQW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFBD727670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753351AbeF1QYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 12:24:20 -0400
Received: from mail.efficios.com ([167.114.142.138]:34558 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752981AbeF1QYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 12:24:15 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 3745422E770;
        Thu, 28 Jun 2018 12:24:14 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id LvB0bLZQdvx2; Thu, 28 Jun 2018 12:24:13 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 9DD3322E76D;
        Thu, 28 Jun 2018 12:24:13 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 9DD3322E76D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1530203053;
        bh=kJ3g3D83FnWKmKKsBpugLKb7HsAwEC6B5XuK99Rl3j0=;
        h=From:To:Date:Message-Id;
        b=pJwO8rQW1Wmp6nw5GBXVte24Tq87EQ4wWlmf135gkrrvbyIQJ/WRzF7xMPPf3mfoU
         2XR+BAgl0wkLtSE+PO2/q+cnKRTljUqIQXEj8mG4zZrfrCZlsbeLsEvUry9WGzU73S
         sjsh5U7INtINUq1xIsxlYYmkOOxBTv2245wT/D+yFiVX8kuLGdWvVkp0sA7ZjMendU
         6fi057WB4mdvIG3G2zdaI6sH0+fEYAoQOX9yA2kcvMbQpuKOFvGtPILys1gOj8M4o+
         VKvoWUN14c3khbx+ssJ57K8PWag2PlJR0+50xXLBpX+usCs2aJPHWiliLyjUdf6aHR
         l+65LtRKDSCjg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id R6D_-40g4R5N; Thu, 28 Jun 2018 12:24:13 -0400 (EDT)
Received: from thinkos.internal.efficios.com (192-222-157-41.qc.cable.ebox.net [192.222.157.41])
        by mail.efficios.com (Postfix) with ESMTPSA id 4643622E75B;
        Thu, 28 Jun 2018 12:24:13 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH for 4.18 2/2] rseq: check that rseq->rseq_cs padding is zero
Date:   Thu, 28 Jun 2018 12:23:59 -0400
Message-Id: <20180628162359.9054-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180628162359.9054-1-mathieu.desnoyers@efficios.com>
References: <20180628162359.9054-1-mathieu.desnoyers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 32-bit kernels, the rseq->rseq_cs_padding field is never read by the
kernel. However, 64-bit kernels dealing with 32-bit compat tasks read the
full 64-bit in its entirety, and terminates the offending process with
a segmentation fault if the upper 32 bits are set due to failure of
copy_from_user().

Ensure that both 32-bit and 64-bit kernels dealing with 32-bit tasks end
up terminating offending tasks with a segmentation fault if the upper
32-bit padding bits (rseq->rseq_cs_padding) are set by adding an explicit
check that padding is zero on 32-bit kernels.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Paul Turner <pjt@google.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Andy Lutomirski <luto@amacapital.net>
CC: Andi Kleen <andi@firstfloor.org>
CC: Dave Watson <davejwatson@fb.com>
CC: Chris Lameter <cl@linux.com>
CC: Ingo Molnar <mingo@redhat.com>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: Ben Maurer <bmaurer@fb.com>
CC: Steven Rostedt <rostedt@goodmis.org>
CC: Josh Triplett <josh@joshtriplett.org>
CC: Linus Torvalds <torvalds@linux-foundation.org>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Russell King <linux@arm.linux.org.uk>
CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Will Deacon <will.deacon@arm.com>
CC: Michael Kerrisk <mtk.manpages@gmail.com>
CC: Boqun Feng <boqun.feng@gmail.com>
CC: linux-api@vger.kernel.org
---
 kernel/rseq.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/kernel/rseq.c b/kernel/rseq.c
index 4ba582046fcd..b038f35a60d6 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -112,6 +112,29 @@ static int rseq_reset_rseq_cpu_id(struct task_struct *t)
 	return 0;
 }
 
+#ifndef __LP64__
+/*
+ * Ensure that padding is zero.
+ */
+static int check_rseq_cs_padding(struct task_struct *t)
+{
+	unsigned long pad;
+	int ret;
+
+	ret = __get_user(pad, &t->rseq->rseq_cs_padding);
+	if (ret)
+		return ret;
+	if (pad)
+		return -EFAULT;
+	return 0;
+}
+#else
+static int check_rseq_cs_padding(struct task_struct *t)
+{
+	return 0;
+}
+#endif
+
 static int rseq_get_rseq_cs(struct task_struct *t, struct rseq_cs *rseq_cs)
 {
 	struct rseq_cs __user *urseq_cs;
@@ -123,6 +146,8 @@ static int rseq_get_rseq_cs(struct task_struct *t, struct rseq_cs *rseq_cs)
 	ret = __get_user(ptr, &t->rseq->rseq_cs);
 	if (ret)
 		return ret;
+	if (check_rseq_cs_padding(t))
+		return -EFAULT;
 	if (!ptr) {
 		memset(rseq_cs, 0, sizeof(*rseq_cs));
 		return 0;
-- 
2.11.0

