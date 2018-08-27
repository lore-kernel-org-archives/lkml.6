Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7984FC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37829208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:38:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37829208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axis.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbeH0MYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 08:24:15 -0400
Received: from bastet.se.axis.com ([195.60.68.11]:49488 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbeH0MYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 08:24:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id 11FA7180D1;
        Mon, 27 Aug 2018 10:38:31 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id hZAeEO5OK2jC; Mon, 27 Aug 2018 10:38:29 +0200 (CEST)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
        by bastet.se.axis.com (Postfix) with ESMTPS id CAA8D180FF;
        Mon, 27 Aug 2018 10:38:29 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7573B1A064;
        Mon, 27 Aug 2018 10:38:29 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 520E91A062;
        Mon, 27 Aug 2018 10:38:29 +0200 (CEST)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
        by boulder02.se.axis.com (Postfix) with ESMTP;
        Mon, 27 Aug 2018 10:38:29 +0200 (CEST)
Received: from lnxartpec.se.axis.com (lnxartpec.se.axis.com [10.88.4.9])
        by thoth.se.axis.com (Postfix) with ESMTP id 453D41D31;
        Mon, 27 Aug 2018 10:38:29 +0200 (CEST)
Received: by lnxartpec.se.axis.com (Postfix, from userid 10564)
        id 3FFCC8016F; Mon, 27 Aug 2018 10:38:29 +0200 (CEST)
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     catalin.marinas@arm.com, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vincent Whitchurch <rabinv@axis.com>
Subject: [PATCHv2] kmemleak: Add option to print warnings to dmesg
Date:   Mon, 27 Aug 2018 10:38:21 +0200
Message-Id: <20180827083821.7706-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.11.0
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, kmemleak only prints the number of suspected leaks to dmesg
but requires the user to read a debugfs file to get the actual stack
traces of the objects' allocation points.  Add an option to print the
full object information to dmesg too.  This allows easier integration of
kmemleak into automated test systems since those kind of systems
presumably already save kernel logs.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
v2: Print hex dump too.

 lib/Kconfig.debug |  9 +++++++++
 mm/kmemleak.c     | 37 ++++++++++++++++++++++++++++++-------
 2 files changed, 39 insertions(+), 7 deletions(-)

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
index 9a085d525bbc..22662715a3dc 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -181,6 +181,7 @@ struct kmemleak_object {
 /* flag set to not scan the object */
 #define OBJECT_NO_SCAN		(1 << 2)
 
+#define HEX_PREFIX		"    "
 /* number of bytes to print per line; must be 16 or 32 */
 #define HEX_ROW_SIZE		16
 /* number of bytes to print at a time (1, 2, 4, 8) */
@@ -299,6 +300,25 @@ static void kmemleak_disable(void);
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
@@ -314,10 +334,10 @@ static void hex_dump_object(struct seq_file *seq,
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
 
@@ -365,17 +385,17 @@ static void print_unreferenced(struct seq_file *seq,
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
 
@@ -1598,6 +1618,9 @@ static void kmemleak_scan(void)
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

