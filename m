Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EBCFECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 516BD2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:46:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 516BD2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389624AbeGPILf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:11:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49752 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388873AbeGPILe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:11:34 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 19194C03;
        Mon, 16 Jul 2018 07:45:21 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Galbraith <efault@gmx.de>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>, rostedt@goodmis.org,
        Ingo Molnar <mingo@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        "Matt Helsley (VMware)" <matt.helsley@gmail.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Bo Gan <ganb@vmware.com>
Subject: [PATCH 4.4 21/43] x86/headers: Dont include asm/processor.h in asm/atomic.h
Date:   Mon, 16 Jul 2018 09:36:26 +0200
Message-Id: <20180716073514.159881487@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716073511.796555857@linuxfoundation.org>
References: <20180716073511.796555857@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andi Kleen <ak@linux.intel.com>

commit 153a4334c439cfb62e1d31cee0c790ba4157813d upstream

asm/atomic.h doesn't really need asm/processor.h anymore. Everything
it uses has moved to other header files. So remove that include.

processor.h is a nasty header that includes lots of
other headers and makes it prone to include loops. Removing the
include here makes asm/atomic.h a "leaf" header that can
be safely included in most other headers.

The only fallout is in the lib/atomic tester which relied on
this implicit include. Give it an explicit include.
(the include is in ifdef because the user is also in ifdef)

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: rostedt@goodmis.org
Link: http://lkml.kernel.org/r/1449018060-1742-1-git-send-email-andi@firstfloor.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
Reviewed-by: Matt Helsley (VMware) <matt.helsley@gmail.com>
Reviewed-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Bo Gan <ganb@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

 arch/x86/include/asm/atomic.h      |    1 -
 arch/x86/include/asm/atomic64_32.h |    1 -
 lib/atomic64_test.c                |    4 ++++
 3 files changed, 4 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/atomic.h
+++ b/arch/x86/include/asm/atomic.h
@@ -3,7 +3,6 @@
 
 #include <linux/compiler.h>
 #include <linux/types.h>
-#include <asm/processor.h>
 #include <asm/alternative.h>
 #include <asm/cmpxchg.h>
 #include <asm/rmwcc.h>
--- a/arch/x86/include/asm/atomic64_32.h
+++ b/arch/x86/include/asm/atomic64_32.h
@@ -3,7 +3,6 @@
 
 #include <linux/compiler.h>
 #include <linux/types.h>
-#include <asm/processor.h>
 //#include <asm/cmpxchg.h>
 
 /* An 64bit atomic type */
--- a/lib/atomic64_test.c
+++ b/lib/atomic64_test.c
@@ -16,6 +16,10 @@
 #include <linux/kernel.h>
 #include <linux/atomic.h>
 
+#ifdef CONFIG_X86
+#include <asm/processor.h>	/* for boot_cpu_has below */
+#endif
+
 #define TEST(bit, op, c_op, val)				\
 do {								\
 	atomic##bit##_set(&v, v0);				\


