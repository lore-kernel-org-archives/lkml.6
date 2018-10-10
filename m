Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F50C46464
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8398A206B2
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="pojuf1kk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8398A206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbeJKCnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 22:43:43 -0400
Received: from mail.efficios.com ([167.114.142.138]:32914 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbeJKCnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 22:43:42 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 68508183B8F;
        Wed, 10 Oct 2018 15:20:09 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id Cc-RHBPAIvn7; Wed, 10 Oct 2018 15:20:08 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id D9714183B8C;
        Wed, 10 Oct 2018 15:20:08 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com D9714183B8C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1539199208;
        bh=N3v2LzU7/zfxpIewN1Lf4Ei0VdWx18Nl2AhIPWVI0IE=;
        h=From:To:Date:Message-Id;
        b=pojuf1kk6MRO/Lc3GGHNBSlUm1oXl0KHEDFzI70c+3NmZTyRvFmBSWtRkJyDPkerP
         3RS7Kw6yS/PRMkyWpvXNRGCYiHv0glP/ms4u/yjTYdsbXHU9WL2ycoA8ac8cGbmoK/
         g8GwLiZ0cKNOJHXjH0WXQdQ7VwZvjF9LbqsO0dselL4l3lZnC8h3nY3e3wY1QjKBq0
         WvLJK2sDLpZM3tjBa+STMCbBi1lXAt3WnHunTvQvBu8xfG/8ZhaW5SjXKZ5hkSL71G
         NUbqWFAMSLHdlgTBT8595h6zRLFX/fFzo9LFTZuOV3xmZ6EwL7WsLmyZWoIWC2FDZX
         Xqz/RePjhyXeQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id ZosSI9PQcR26; Wed, 10 Oct 2018 15:20:08 -0400 (EDT)
Received: from thinkos.internal.efficios.com (192-222-157-41.qc.cable.ebox.net [192.222.157.41])
        by mail.efficios.com (Postfix) with ESMTPSA id 59062183B7F;
        Wed, 10 Oct 2018 15:20:07 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
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
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-mm@kvack.org
Subject: [RFC PATCH for 4.21 05/16] mm: Provide is_vma_noncached
Date:   Wed, 10 Oct 2018 15:19:25 -0400
Message-Id: <20181010191936.7495-6-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181010191936.7495-1-mathieu.desnoyers@efficios.com>
References: <20181010191936.7495-1-mathieu.desnoyers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide is_vma_noncached() static inline to allow generic code to
check whether the given vma consists of noncached memory.

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
CC: linux-mm@kvack.org
---
 include/linux/mm.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0416a7204be3..18acf4f339f8 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2551,6 +2551,30 @@ static inline struct page *follow_page(struct vm_area_struct *vma,
 	return follow_page_mask(vma, address, foll_flags, &unused_page_mask);
 }
 
+static inline bool pgprot_same(pgprot_t a, pgprot_t b)
+{
+	return pgprot_val(a) == pgprot_val(b);
+}
+
+#ifdef pgprot_noncached
+static inline bool is_vma_noncached(struct vm_area_struct *vma)
+{
+	pgprot_t pgprot = vma->vm_page_prot;
+
+	/* Check whether architecture implements noncached pages. */
+	if (pgprot_same(pgprot_noncached(PAGE_KERNEL), PAGE_KERNEL))
+		return false;
+	if (!pgprot_same(pgprot, pgprot_noncached(pgprot)))
+		return false;
+	return true;
+}
+#else
+static inline bool is_vma_noncached(struct vm_area_struct *vma)
+{
+	return false;
+}
+#endif
+
 #define FOLL_WRITE	0x01	/* check pte is writable */
 #define FOLL_TOUCH	0x02	/* mark page accessed */
 #define FOLL_GET	0x04	/* do get_page on page */
-- 
2.11.0

