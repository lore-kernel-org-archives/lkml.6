Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DFCC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 106A6208F7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:40:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 106A6208F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axis.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbeHXQPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 12:15:09 -0400
Received: from bastet.se.axis.com ([195.60.68.11]:50046 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbeHXQPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 12:15:09 -0400
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id E4AAD184CD;
        Fri, 24 Aug 2018 14:40:36 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id j8J-Yr8PnoKx; Fri, 24 Aug 2018 14:40:36 +0200 (CEST)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
        by bastet.se.axis.com (Postfix) with ESMTPS id 06A76184B7;
        Fri, 24 Aug 2018 14:40:35 +0200 (CEST)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D3D8E1E06C;
        Fri, 24 Aug 2018 14:40:35 +0200 (CEST)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6B501E068;
        Fri, 24 Aug 2018 14:40:35 +0200 (CEST)
Received: from seth.se.axis.com (unknown [10.0.2.172])
        by boulder03.se.axis.com (Postfix) with ESMTP;
        Fri, 24 Aug 2018 14:40:35 +0200 (CEST)
Received: from lnxartpec.se.axis.com (lnxartpec.se.axis.com [10.88.4.9])
        by seth.se.axis.com (Postfix) with ESMTP id B94F23118;
        Fri, 24 Aug 2018 14:40:35 +0200 (CEST)
Received: by lnxartpec.se.axis.com (Postfix, from userid 10564)
        id B27198016F; Fri, 24 Aug 2018 14:40:35 +0200 (CEST)
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     catalin.marinas@arm.com, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vincent Whitchurch <rabinv@axis.com>
Subject: [PATCH] kmemleak: Add option to print warnings to dmesg
Date:   Fri, 24 Aug 2018 14:40:11 +0200
Message-Id: <20180824124011.22879-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.11.0
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, kmemleak only prints the number of suspected leaks to dmesg
but requires the user to read a debugfs file to get the actual stack
traces of the objects' allocation points.  Add an option to print the
stack trace information (except the hex dumps) to dmesg too.  This
allows easier integration of kmemleak into automated test systems since
those kind of systems presumably already save kernel logs.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 lib/Kconfig.debug |  9 +++++++++
 mm/kmemleak.c     | 21 +++++++++++++++++----
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index ab1b599202bc..9a3fc905b8bd 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -593,6 +593,15 @@ config DEBUG_KMEMLEAK_DEFAULT_OFF
 	  Say Y here to disable kmemleak by default. It can then be enabled
 	  on the command line via kmemleak=on.
 
+config DEBUG_KMEMLEAK_WARN
+	bool "Print kmemleak object warnings to log buffer"
+	depends on DEBUG_KMEMLEAK
+	help
+	  Say Y here to make kmemleak print information about unreferenced
+	  objects (including stacktraces) as warnings to the kernel log buffer.
+	  Otherwise this information is only available by reading the kmemleak
+	  debugfs file.
+
 config DEBUG_STACK_USAGE
 	bool "Stack utilization instrumentation"
 	depends on DEBUG_KERNEL && !IA64
diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 9a085d525bbc..61ba47a357fc 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -311,6 +311,9 @@ static void hex_dump_object(struct seq_file *seq,
 	const u8 *ptr = (const u8 *)object->pointer;
 	size_t len;
 
+	if (!seq)
+		return;
+
 	/* limit the number of lines to HEX_MAX_LINES */
 	len = min_t(size_t, object->size, HEX_MAX_LINES * HEX_ROW_SIZE);
 
@@ -355,6 +358,13 @@ static bool unreferenced_object(struct kmemleak_object *object)
 			       jiffies_last_scan);
 }
 
+#define warn_or_seq_printf(seq, fmt, ...)	do {	\
+	if (seq)					\
+		seq_printf(seq, fmt, ##__VA_ARGS__);	\
+	else						\
+		pr_warn(fmt, ##__VA_ARGS__);		\
+} while (0)
+
 /*
  * Printing of the unreferenced objects information to the seq file. The
  * print_unreferenced function must be called with the object->lock held.
@@ -365,17 +375,17 @@ static void print_unreferenced(struct seq_file *seq,
 	int i;
 	unsigned int msecs_age = jiffies_to_msecs(jiffies - object->jiffies);
 
-	seq_printf(seq, "unreferenced object 0x%08lx (size %zu):\n",
+	warn_or_seq_printf(seq, "unreferenced object 0x%08lx (size %zu):\n",
 		   object->pointer, object->size);
-	seq_printf(seq, "  comm \"%s\", pid %d, jiffies %lu (age %d.%03ds)\n",
+	warn_or_seq_printf(seq, "  comm \"%s\", pid %d, jiffies %lu (age %d.%03ds)\n",
 		   object->comm, object->pid, object->jiffies,
 		   msecs_age / 1000, msecs_age % 1000);
 	hex_dump_object(seq, object);
-	seq_printf(seq, "  backtrace:\n");
+	warn_or_seq_printf(seq, "  backtrace:\n");
 
 	for (i = 0; i < object->trace_len; i++) {
 		void *ptr = (void *)object->trace[i];
-		seq_printf(seq, "    [<%p>] %pS\n", ptr, ptr);
+		warn_or_seq_printf(seq, "    [<%p>] %pS\n", ptr, ptr);
 	}
 }
 
@@ -1598,6 +1608,9 @@ static void kmemleak_scan(void)
 		if (unreferenced_object(object) &&
 		    !(object->flags & OBJECT_REPORTED)) {
 			object->flags |= OBJECT_REPORTED;
+#ifdef CONFIG_DEBUG_KMEMLEAK_WARN
+			print_unreferenced(NULL, object);
+#endif
 			new_leaks++;
 		}
 		spin_unlock_irqrestore(&object->lock, flags);
-- 
2.11.0

