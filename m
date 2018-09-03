Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6705CC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 042AF20843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:40:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 042AF20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axis.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbeICTBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 15:01:22 -0400
Received: from bastet.se.axis.com ([195.60.68.11]:52981 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbeICTBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 15:01:22 -0400
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id E4A3E182E3;
        Mon,  3 Sep 2018 16:40:51 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id lrx-OVbL88V7; Mon,  3 Sep 2018 16:40:48 +0200 (CEST)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
        by bastet.se.axis.com (Postfix) with ESMTPS id 7F4111831E;
        Mon,  3 Sep 2018 16:40:48 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 62D421A05E;
        Mon,  3 Sep 2018 16:40:48 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5767B1A05C;
        Mon,  3 Sep 2018 16:40:48 +0200 (CEST)
Received: from seth.se.axis.com (unknown [10.0.2.172])
        by boulder02.se.axis.com (Postfix) with ESMTP;
        Mon,  3 Sep 2018 16:40:48 +0200 (CEST)
Received: from lnxartpec.se.axis.com (lnxartpec.se.axis.com [10.88.4.9])
        by seth.se.axis.com (Postfix) with ESMTP id 4B49725C2;
        Mon,  3 Sep 2018 16:40:48 +0200 (CEST)
Received: by lnxartpec.se.axis.com (Postfix, from userid 10564)
        id 47AE38096C; Mon,  3 Sep 2018 16:40:48 +0200 (CEST)
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     catalin.marinas@arm.com, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vincent Whitchurch <rabinv@axis.com>
Subject: [PATCH v3] kmemleak: add module param to print warnings to dmesg
Date:   Mon,  3 Sep 2018 16:40:46 +0200
Message-Id: <20180903144046.21023-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.11.0
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, kmemleak only prints the number of suspected leaks to dmesg
but requires the user to read a debugfs file to get the actual stack
traces of the objects' allocation points.  Add a module option to print
the full object information to dmesg too.  It can be enabled with
kmemleak.verbose=1 on the kernel command line, or "echo 1 >
/sys/module/kmemleak/parameters/verbose":

This allows easier integration of kmemleak into test systems:  We have
automated test infrastructure to test our Linux systems.  With this
option, running our tests with kmemleak is as simple as enabling
kmemleak and passing this command line option; the test infrastructure
knows how to save kernel logs, which will now include kmemleak reports.
Without this option, the test infrastructure needs to be specifically
taught to read out the kmemleak debugfs file.  Removing this need for
special handling makes kmemleak more similar to other kernel debug
options (slab debugging, debug objects, etc).

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
v3: Expand use case description.  Replace config option with module parameter.

 mm/kmemleak.c | 42 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 7 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 9a085d525bbc..c91d43738596 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -86,6 +86,7 @@
 #include <linux/seq_file.h>
 #include <linux/cpumask.h>
 #include <linux/spinlock.h>
+#include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/rcupdate.h>
 #include <linux/stacktrace.h>
@@ -181,6 +182,7 @@ struct kmemleak_object {
 /* flag set to not scan the object */
 #define OBJECT_NO_SCAN		(1 << 2)
 
+#define HEX_PREFIX		"    "
 /* number of bytes to print per line; must be 16 or 32 */
 #define HEX_ROW_SIZE		16
 /* number of bytes to print at a time (1, 2, 4, 8) */
@@ -235,6 +237,9 @@ static int kmemleak_skip_disable;
 /* If there are leaks that can be reported */
 static bool kmemleak_found_leaks;
 
+static bool kmemleak_verbose;
+module_param_named(verbose, kmemleak_verbose, bool, 0600);
+
 /*
  * Early object allocation/freeing logging. Kmemleak is initialized after the
  * kernel allocator. However, both the kernel allocator and kmemleak may
@@ -299,6 +304,25 @@ static void kmemleak_disable(void);
 	kmemleak_disable();		\
 } while (0)
 
+#define warn_or_seq_printf(seq, fmt, ...)	do {	\
+	if (seq)					\
+		seq_printf(seq, fmt, ##__VA_ARGS__);	\
+	else						\
+		pr_warn(fmt, ##__VA_ARGS__);		\
+} while (0)
+
+static void warn_or_seq_hex_dump(struct seq_file *seq, int prefix_type,
+				 int rowsize, int groupsize, const void *buf,
+				 size_t len, bool ascii)
+{
+	if (seq)
+		seq_hex_dump(seq, HEX_PREFIX, prefix_type, rowsize, groupsize,
+			     buf, len, ascii);
+	else
+		print_hex_dump(KERN_WARNING, pr_fmt(HEX_PREFIX), prefix_type,
+			       rowsize, groupsize, buf, len, ascii);
+}
+
 /*
  * Printing of the objects hex dump to the seq file. The number of lines to be
  * printed is limited to HEX_MAX_LINES to prevent seq file spamming. The
@@ -314,10 +338,10 @@ static void hex_dump_object(struct seq_file *seq,
 	/* limit the number of lines to HEX_MAX_LINES */
 	len = min_t(size_t, object->size, HEX_MAX_LINES * HEX_ROW_SIZE);
 
-	seq_printf(seq, "  hex dump (first %zu bytes):\n", len);
+	warn_or_seq_printf(seq, "  hex dump (first %zu bytes):\n", len);
 	kasan_disable_current();
-	seq_hex_dump(seq, "    ", DUMP_PREFIX_NONE, HEX_ROW_SIZE,
-		     HEX_GROUP_SIZE, ptr, len, HEX_ASCII);
+	warn_or_seq_hex_dump(seq, DUMP_PREFIX_NONE, HEX_ROW_SIZE,
+			     HEX_GROUP_SIZE, ptr, len, HEX_ASCII);
 	kasan_enable_current();
 }
 
@@ -365,17 +389,17 @@ static void print_unreferenced(struct seq_file *seq,
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
 
@@ -1598,6 +1622,10 @@ static void kmemleak_scan(void)
 		if (unreferenced_object(object) &&
 		    !(object->flags & OBJECT_REPORTED)) {
 			object->flags |= OBJECT_REPORTED;
+
+			if (kmemleak_verbose)
+				print_unreferenced(NULL, object);
+
 			new_leaks++;
 		}
 		spin_unlock_irqrestore(&object->lock, flags);
-- 
2.11.0

