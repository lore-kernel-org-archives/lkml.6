Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752542AbeETDtE (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 23:49:04 -0400
Received: from alln-iport-7.cisco.com ([173.37.142.94]:13671 "EHLO
        alln-iport-7.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752459AbeETDtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 23:49:01 -0400
X-IronPort-AV: E=Sophos;i="5.49,421,1520899200";
   d="scan'208";a="116550154"
Date: Sat, 19 May 2018 20:39:40 -0700
From: Stefan M Schaeckeler <sschaeck@cisco.com>
To: David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: sschaeck@cisco.com
Subject: [PATCH] mtd: mtdoops: optionally dump boottime
Message-ID: <20180520033940.GA35444@sjc-ads-587.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Optionally dump boottime on the mtd device in the form of

<0>[   0.000000] Boot time mm/dd/yyyy hh:mm:ss

Time-stamps of oops messages are in seconds since boottime. Recording also
the boottime helps correlating oopses with other events having occured at
the same time. This correlation will be otherwise lost after (multiple)
reboots.

Signed-off-by: Stefan M Schaeckeler <sschaeck@cisco.com>
---
 drivers/mtd/mtdoops.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/mtdoops.c b/drivers/mtd/mtdoops.c
index 9f25111..11f93aa 100644
--- a/drivers/mtd/mtdoops.c
+++ b/drivers/mtd/mtdoops.c
@@ -54,6 +54,11 @@ module_param(dump_oops, int, 0600);
 MODULE_PARM_DESC(dump_oops,
 		"set to 1 to dump oopses, 0 to only dump panics (default 1)");
 
+static bool dump_boottime = false;
+module_param(dump_boottime, bool, 0400);
+MODULE_PARM_DESC(dump_boottime,
+		"set to 1 to dump boottime, 0 to disable (default 0)");
+
 static struct mtdoops_context {
 	struct kmsg_dumper dump;
 
@@ -69,6 +74,10 @@ static struct mtdoops_context {
 	void *oops_buf;
 } oops_cxt;
 
+/* fake kernel message syslog level and monotonic timestamp */
+#define boottime_prefix "<0>[   0.000000] Boot time "
+static char boottime[100] = {0};
+
 static void mark_page_used(struct mtdoops_context *cxt, int page)
 {
 	set_bit(page, cxt->oops_page_used);
@@ -285,13 +294,17 @@ static void mtdoops_do_dump(struct kmsg_dumper *dumper,
 {
 	struct mtdoops_context *cxt = container_of(dumper,
 			struct mtdoops_context, dump);
+	u8 boot_len = strlen(boottime); /* 0 if dump_boottime is not set */
 
 	/* Only dump oopses if dump_oops is set */
 	if (reason == KMSG_DUMP_OOPS && !dump_oops)
 		return;
 
-	kmsg_dump_get_buffer(dumper, true, cxt->oops_buf + MTDOOPS_HEADER_SIZE,
-			     record_size - MTDOOPS_HEADER_SIZE, NULL);
+	strncpy(cxt->oops_buf + MTDOOPS_HEADER_SIZE, boottime, boot_len);
+
+	kmsg_dump_get_buffer(dumper, true, cxt->oops_buf + MTDOOPS_HEADER_SIZE +
+			     boot_len, record_size - (MTDOOPS_HEADER_SIZE +
+			     boot_len), NULL);
 
 	/* Panics must be written immediately */
 	if (reason != KMSG_DUMP_OOPS)
@@ -350,7 +363,13 @@ static void mtdoops_notify_add(struct mtd_info *mtd)
 	cxt->mtd = mtd;
 	cxt->oops_pages = (int)mtd->size / record_size;
 	find_next_position(cxt);
-	printk(KERN_INFO "mtdoops: Attached to MTD device %d\n", mtd->index);
+	if (dump_boottime) {
+	    printk(KERN_INFO "mtdoops: Attached to MTD device %d "
+		   "dumping boottime\n", mtd->index);
+	} else {
+	    printk(KERN_INFO "mtdoops: Attached to MTD device %d "
+		   "not dumping boottime\n", mtd->index);
+	}
 }
 
 static void mtdoops_notify_remove(struct mtd_info *mtd)
@@ -379,6 +398,19 @@ static int __init mtdoops_init(void)
 	struct mtdoops_context *cxt = &oops_cxt;
 	int mtd_index;
 	char *endp;
+	struct timespec64 bt;
+	struct tm tm_val;
+
+	if (dump_boottime) {
+	    /* Precompute boot time ahead of an oops */
+	    getboottime64(&bt);
+	    time_to_tm(bt.tv_sec, 0, &tm_val);
+
+	    snprintf(boottime, sizeof(boottime),
+		     boottime_prefix "%02d/%02d/%4d %02d:%02d:%02d\n",
+		     tm_val.tm_mon + 1, tm_val.tm_mday, tm_val.tm_year + 1900,
+		     tm_val.tm_hour, tm_val.tm_min, tm_val.tm_sec);
+	}
 
 	if (strlen(mtddev) == 0) {
 		printk(KERN_ERR "mtdoops: mtd device (mtddev=name/number) must be supplied\n");
-- 
2.10.3.dirty
