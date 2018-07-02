Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51742C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A74125AB3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="sl54Btmv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A74125AB3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753307AbeGBUlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 16:41:22 -0400
Received: from mail.efficios.com ([167.114.142.138]:38162 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753121AbeGBUlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 16:41:17 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 0F60022F23D;
        Mon,  2 Jul 2018 16:41:17 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id GO_Y7V0B7qmQ; Mon,  2 Jul 2018 16:41:16 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 7490B22F233;
        Mon,  2 Jul 2018 16:41:16 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 7490B22F233
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1530564076;
        bh=vIXublIQ6WDadAULnGnU+jj52fEIwRVb5cFCYUhJAOY=;
        h=From:To:Date:Message-Id;
        b=sl54BtmvnEtHs/FhXPPK0bbX/iQfpAAQ9rE695RANtiKmPTBYiBt3vLq5Ug+HtjKC
         D6SRhJsWWE77Uadu12gPnrpe9fsPJ4CNgDjdpYeS2jucUmSnlPiir6TGBi4ojOGQYQ
         zbvN27TxLXzofj2gpFqWLCjQjOCvgiWNpUHqmA8MfpdlNKqfAmTjSbF80BrBYAh9HA
         I8W2qdK0dRlCnGmNrxSifMUAOPDB1k2ZGytPxDxBAi3TXWLv+D2MioV8zJ/hqxOInv
         4qdL2FEvcYlKsnTRHsL2SL5HH87VSY/RrFkIdhKLpRihQ0odBnRFJCfbVtSUm0XMDB
         MLeUstHfhLMKg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id PY3tVCqtHWgO; Mon,  2 Jul 2018 16:41:16 -0400 (EDT)
Received: from thinkos.internal.efficios.com (192-222-157-41.qc.cable.ebox.net [192.222.157.41])
        by mail.efficios.com (Postfix) with ESMTPSA id 149FA22F227;
        Mon,  2 Jul 2018 16:41:16 -0400 (EDT)
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
Subject: [RFC PATCH for 4.18 2/2] rseq: validate rseq->rseq_cs padding to be zero
Date:   Mon,  2 Jul 2018 16:40:58 -0400
Message-Id: <20180702204058.819-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180702204058.819-1-mathieu.desnoyers@efficios.com>
References: <20180702204058.819-1-mathieu.desnoyers@efficios.com>
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
32-bit padding bits (rseq->rseq_cs_padding) are set by explicitly ensuring
that padding is zero on 32-bit kernels.

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
 kernel/rseq.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/kernel/rseq.c b/kernel/rseq.c
index 2e5d88f09baf..c4c48157198f 100644
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
@@ -123,6 +146,9 @@ static int rseq_get_rseq_cs(struct task_struct *t, struct rseq_cs *rseq_cs)
 	ret = __get_user(ptr, &t->rseq->rseq_cs);
 	if (ret)
 		return ret;
+	ret = check_rseq_cs_padding(t);
+	if (ret)
+		return ret;
 	if (!ptr) {
 		memset(rseq_cs, 0, sizeof(*rseq_cs));
 		return 0;
-- 
2.11.0

