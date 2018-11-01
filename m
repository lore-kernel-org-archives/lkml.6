Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C010C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6063220820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="HqyTqGDt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6063220820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbeKATBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 15:01:38 -0400
Received: from mail.efficios.com ([167.114.142.138]:40964 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbeKATBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 15:01:38 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 4CEC0227621;
        Thu,  1 Nov 2018 05:59:20 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id 4ct89aS4CTVC; Thu,  1 Nov 2018 05:59:19 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id DAA1722761D;
        Thu,  1 Nov 2018 05:59:19 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com DAA1722761D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1541066359;
        bh=EDjICEesuI/igHNyww2t9LNHJKdlTNndQCBWSzzaIN0=;
        h=From:To:Date:Message-Id;
        b=HqyTqGDtTJ/3bmuGnQgh0wn/5BD3jS0qTk9oL4vWLNVCHdz0753SpaFLpsVAS5rMk
         eaSPGrDmpLLJXcryFl85fJX//0842PBLUmH8h5lz+YVwiQYUBrQw4YCq55lA58K7dF
         v3MCD49uyY9eOx1pjvgoZllpInhjQuFQ0h6MUPcCOgO/d9NHI6o85hvmiNzVoRXHn4
         4w0UNelwxaKf24EcXM5IAcs102r3XCfQ6hcdT2qTbxxo1bxCF8tcvmdaMXI0hDeo84
         xtg+VISu+CHwwEuicOln9wRf2N1utpie5B1js3OvtpO17766K/k61PbsJS9NjDVtBZ
         D3ayb/S8ivAHQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id KqS1mj3gQc8R; Thu,  1 Nov 2018 05:59:19 -0400 (EDT)
Received: from thinkos.etherlink (sessfw99-sesbfw99-92.ericsson.net [192.176.1.92])
        by mail.efficios.com (Postfix) with ESMTPSA id C1B25227607;
        Thu,  1 Nov 2018 05:59:12 -0400 (EDT)
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
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Matthew Wilcox <mawilcox@microsoft.com>
Subject: [RFC PATCH for 4.21 03/16] mm: Replace BUG_ON() by WARN_ON() in vm_unmap_ram()
Date:   Thu,  1 Nov 2018 10:58:31 +0100
Message-Id: <20181101095844.24462-4-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181101095844.24462-1-mathieu.desnoyers@efficios.com>
References: <20181101095844.24462-1-mathieu.desnoyers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is encouraged to warn and return rather than use BUG_ON() when
the condition can be recovered from in ways that are more graceful than
halting the whole system.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
CC: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
CC: Matthew Wilcox <mawilcox@microsoft.com>
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
---
 mm/vmalloc.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index a728fc492557..a236bac872f0 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1123,10 +1123,11 @@ void vm_unmap_ram(const void *mem, unsigned int count)
 	struct vmap_area *va;
 
 	might_sleep();
-	BUG_ON(!addr);
-	BUG_ON(addr < VMALLOC_START);
-	BUG_ON(addr > VMALLOC_END);
-	BUG_ON(!PAGE_ALIGNED(addr));
+	if (WARN_ON(!addr) ||
+	    WARN_ON(addr < VMALLOC_START) ||
+	    WARN_ON(addr > VMALLOC_END) ||
+	    WARN_ON(!PAGE_ALIGNED(addr)))
+		return;
 
 	if (likely(count <= VMAP_MAX_ALLOC)) {
 		debug_check_no_locks_freed(mem, size);
@@ -1135,7 +1136,8 @@ void vm_unmap_ram(const void *mem, unsigned int count)
 	}
 
 	va = find_vmap_area(addr);
-	BUG_ON(!va);
+	if (WARN_ON(!va))
+		return;
 	debug_check_no_locks_freed((void *)va->va_start,
 				    (va->va_end - va->va_start));
 	free_unmap_vmap_area(va);
-- 
2.11.0

