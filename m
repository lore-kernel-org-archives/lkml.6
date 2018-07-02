Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F05C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EBA124FE5
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="KumkPx89"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EBA124FE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753207AbeGBUlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 16:41:20 -0400
Received: from mail.efficios.com ([167.114.142.138]:38164 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753083AbeGBUlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 16:41:17 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 1E74122F241;
        Mon,  2 Jul 2018 16:41:17 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id uM8GQrgsdh4X; Mon,  2 Jul 2018 16:41:16 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 1FD8E22F22C;
        Mon,  2 Jul 2018 16:41:16 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 1FD8E22F22C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1530564076;
        bh=WaTcsjmDOaQurvswC9UTfR2mqQg7zagKkD7i9r1qOCU=;
        h=From:To:Date:Message-Id;
        b=KumkPx89JRT996/kvQ66tfpLY9If1WHSC74UfPnlhnNx3+CSe5W9TYkdRuaZKTjDf
         J1KFi5M7krjk1TKG1nZ/elnuvoNf6poxTOQPpgaRooPT5qfVFU++0ZtjsZr1olRxPC
         9deKJqJN3Y/vkN1/scOpP6LBjl6V9/Y0nAFvG2DuCVNFJY3fDGECrgX8iH2az9g3IC
         E6ljwn/gg5cdWd7LTBegACn1OC9nExTCsvrLVKE2XWcCCBDcGyQrABvo2LrcJ4dcOg
         06kKdjElxAcJ3TpaXjiwo77H1w/icR4CBsyNpI7WSOGBDKgZYOp0NG4oeOucS/unoi
         1SlmxGKWfDs9w==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id dGtLVmxW3_9x; Mon,  2 Jul 2018 16:41:16 -0400 (EDT)
Received: from thinkos.internal.efficios.com (192-222-157-41.qc.cable.ebox.net [192.222.157.41])
        by mail.efficios.com (Postfix) with ESMTPSA id B37F122F226;
        Mon,  2 Jul 2018 16:41:15 -0400 (EDT)
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
Subject: [RFC PATCH for 4.18 1/2] rseq: use __u64 for rseq_cs fields, validate abort_ip < TASK_SIZE
Date:   Mon,  2 Jul 2018 16:40:57 -0400
Message-Id: <20180702204058.819-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the rseq ABI so rseq_cs start_ip, post_commit_offset and abort_ip
fields are seen as 64-bit fields by both 32-bit and 64-bit kernels rather
that ignoring the 32 upper bits on 32-bit kernels. This ensures we have a
consistent behavior for a 32-bit binary executed on 32-bit kernels and in
compat mode on 64-bit kernels.

Validating the value of abort_ip field to be below TASK_SIZE ensures the
kernel don't return to an invalid address when returning to userspace
after an abort. I don't fully trust each architecture code to consistently
deal with invalid return addresses.

If validation fails, the process is killed with a segmentation fault.

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
 include/uapi/linux/rseq.h | 6 +++---
 kernel/rseq.c             | 5 +++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
index d620fa43756c..519ad6e176d1 100644
--- a/include/uapi/linux/rseq.h
+++ b/include/uapi/linux/rseq.h
@@ -52,10 +52,10 @@ struct rseq_cs {
 	__u32 version;
 	/* enum rseq_cs_flags */
 	__u32 flags;
-	LINUX_FIELD_u32_u64(start_ip);
+	__u64 start_ip;
 	/* Offset from start_ip. */
-	LINUX_FIELD_u32_u64(post_commit_offset);
-	LINUX_FIELD_u32_u64(abort_ip);
+	__u64 post_commit_offset;
+	__u64 abort_ip;
 } __attribute__((aligned(4 * sizeof(__u64))));
 
 /*
diff --git a/kernel/rseq.c b/kernel/rseq.c
index 22b6acf1ad63..2e5d88f09baf 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -128,7 +128,8 @@ static int rseq_get_rseq_cs(struct task_struct *t, struct rseq_cs *rseq_cs)
 		return 0;
 	}
 	urseq_cs = (struct rseq_cs __user *)ptr;
-	if (copy_from_user(rseq_cs, urseq_cs, sizeof(*rseq_cs)))
+	if (copy_from_user(rseq_cs, urseq_cs, sizeof(*rseq_cs)) ||
+	    rseq_cs->abort_ip >= TASK_SIZE)
 		return -EFAULT;
 	if (rseq_cs->version > 0)
 		return -EINVAL;
@@ -137,7 +138,7 @@ static int rseq_get_rseq_cs(struct task_struct *t, struct rseq_cs *rseq_cs)
 	if (rseq_cs->abort_ip - rseq_cs->start_ip < rseq_cs->post_commit_offset)
 		return -EINVAL;
 
-	usig = (u32 __user *)(rseq_cs->abort_ip - sizeof(u32));
+	usig = (u32 __user *)(unsigned long)(rseq_cs->abort_ip - sizeof(u32));
 	ret = get_user(sig, usig);
 	if (ret)
 		return ret;
-- 
2.11.0

