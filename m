Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C96C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE0742249E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="Nsnumj1s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE0742249E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933733AbeGFRWn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:22:43 -0400
Received: from alln-iport-3.cisco.com ([173.37.142.90]:63270 "EHLO
        alln-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932895AbeGFRWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:22:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=5303; q=dns/txt; s=iport;
  t=1530897762; x=1532107362;
  h=from:to:cc:subject:date:message-id;
  bh=TlJkEb4Y2HBnpEbs3j4ucuoyrmIAKcuQB0rktCLlp9I=;
  b=Nsnumj1sqHYd7WvHR2VCAJoeibtBxSVCgW+4y+jZ0I+n+NItF+U4Rq6/
   k437SkQLcB7rAnha9qjKjCecDGOdiMnbcI9Rbew91T7xTPHhzy22jCfkW
   jQ/SclsT7UdONUoF9vxo0cKhpydZYIKbcrGmQH+7wRtr08wh4ntkr6Us6
   M=;
X-IronPort-AV: E=Sophos;i="5.51,317,1526342400"; 
   d="scan'208";a="139816817"
Received: from alln-core-11.cisco.com ([173.36.13.133])
  by alln-iport-3.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jul 2018 17:22:41 +0000
Received: from ott-ads-260.cisco.com (ott-ads-260.cisco.com [161.44.237.28])
        by alln-core-11.cisco.com (8.14.5/8.14.5) with ESMTP id w66HMfTb011641;
        Fri, 6 Jul 2018 17:22:41 GMT
Received: by ott-ads-260.cisco.com (Postfix, from userid 509275)
        id C95C6CEF; Fri,  6 Jul 2018 13:22:40 -0400 (EDT)
From:   Christian Hansen <chansen3@cisco.com>
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, Christian Hansen <chansen3@cisco.com>
Subject: [PATCH] tools: adding support for idle page tracking to tool
Date:   Fri,  6 Jul 2018 13:22:37 -0400
Message-Id: <20180706172237.21691-1-chansen3@cisco.com>
X-Mailer: git-send-email 2.10.3.dirty
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding a new flag which will use the kernels's idle
page tracking to mark pages idle.  As the tool already
prints the idle flag if set, subsequent runs will show
which pages have been accessed since last run.

Signed-off-by: Christian Hansen <chansen3@cisco.com>
---
 .../admin-guide/mm/idle_page_tracking.rst          |  5 +++
 tools/vm/page-types.c                              | 47 +++++++++++++++++++++-
 2 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/idle_page_tracking.rst b/Documentation/admin-guide/mm/idle_page_tracking.rst
index 6f7b7ca..df9394f 100644
--- a/Documentation/admin-guide/mm/idle_page_tracking.rst
+++ b/Documentation/admin-guide/mm/idle_page_tracking.rst
@@ -65,6 +65,11 @@ workload one should:
     are not reclaimable, he or she can filter them out using
     ``/proc/kpageflags``.
 
+The page-types tool in the tools/vm directory can be used to assist in this.
+If the tool is run initially with the appropriate option, it will mark all the
+queried pages as idle.  Subsequent runs of the tool can then show which pages have
+their idle flag cleared in the interim.
+
 See :ref:`Documentation/admin-guide/mm/pagemap.rst <pagemap>` for more
 information about ``/proc/pid/pagemap``, ``/proc/kpageflags``, and
 ``/proc/kpagecgroup``.
diff --git a/tools/vm/page-types.c b/tools/vm/page-types.c
index 7fe4797..6394eca 100644
--- a/tools/vm/page-types.c
+++ b/tools/vm/page-types.c
@@ -78,6 +78,8 @@
 #define PROC_KPAGECOUNT		"/proc/kpagecount"
 #define PROC_KPAGECGROUP	"/proc/kpagecgroup"
 
+#define SYS_KERNEL_MM_PAGE_IDLE "/sys/kernel/mm/page_idle/bitmap"
+
 /* [32-] kernel hacking assistances */
 #define KPF_RESERVED		32
 #define KPF_MLOCKED		33
@@ -169,6 +171,7 @@ static const char * const debugfs_known_mountpoints[] = {
 
 static int		opt_raw;	/* for kernel developers */
 static int		opt_list;	/* list pages (in ranges) */
+static int		opt_mark_idle;	/* set accessed bit */
 static int		opt_no_summary;	/* don't show summary */
 static pid_t		opt_pid;	/* process to walk */
 const char		*opt_file;	/* file or directory path */
@@ -198,6 +201,7 @@ static int		pagemap_fd;
 static int		kpageflags_fd;
 static int		kpagecount_fd = -1;
 static int		kpagecgroup_fd = -1;
+static int		page_idle_fd = -1;
 
 static int		opt_hwpoison;
 static int		opt_unpoison;
@@ -587,6 +591,30 @@ static int unpoison_page(unsigned long offset)
 	return 0;
 }
 
+static int mark_page_idle(unsigned long offset)
+{
+	static unsigned long off;
+	static uint64_t buf;
+	int len;
+
+	if ((offset / 64 == off / 64) || buf == 0) {
+		buf |= 1UL << (offset % 64);
+		off = offset;
+		return 0;
+	}
+
+	len = pwrite(page_idle_fd, &buf, 8, 8 * (off / 64));
+	if (len < 0) {
+		perror("mark page idle");
+		return len;
+	}
+
+	buf = 1UL << (offset % 64);
+	off = offset;
+
+	return 0;
+}
+
 /*
  * page frame walker
  */
@@ -635,6 +663,9 @@ static void add_page(unsigned long voffset, unsigned long offset,
 	if (opt_unpoison)
 		unpoison_page(offset);
 
+	if (opt_mark_idle)
+		mark_page_idle(offset);
+
 	if (opt_list == 1)
 		show_page_range(voffset, offset, 1, flags, cgroup, mapcnt);
 	else if (opt_list == 2)
@@ -783,6 +814,9 @@ static void walk_addr_ranges(void)
 		else
 			walk_task(opt_offset[i], opt_size[i]);
 
+	if (opt_mark_idle)
+		mark_page_idle(0);
+
 	close(kpageflags_fd);
 }
 
@@ -813,6 +847,7 @@ static void usage(void)
 "            -c|--cgroup  path|@inode   Walk pages within memory cgroup\n"
 "            -p|--pid     pid           Walk process address space\n"
 "            -f|--file    filename      Walk file address space\n"
+"            -i|--mark-idle             Mark pages idle\n"
 "            -l|--list                  Show page details in ranges\n"
 "            -L|--list-each             Show page details one by one\n"
 "            -C|--list-cgroup           Show cgroup inode for pages\n"
@@ -1221,6 +1256,7 @@ static const struct option opts[] = {
 	{ "bits"      , 1, NULL, 'b' },
 	{ "cgroup"    , 1, NULL, 'c' },
 	{ "describe"  , 1, NULL, 'd' },
+	{ "mark-idle" , 0, NULL, 'i' },
 	{ "list"      , 0, NULL, 'l' },
 	{ "list-each" , 0, NULL, 'L' },
 	{ "list-cgroup", 0, NULL, 'C' },
@@ -1240,7 +1276,7 @@ int main(int argc, char *argv[])
 	page_size = getpagesize();
 
 	while ((c = getopt_long(argc, argv,
-				"rp:f:a:b:d:c:ClLMNXxF:h",
+				"rp:f:a:b:d:c:CilLMNXxF:h",
 				opts, NULL)) != -1) {
 		switch (c) {
 		case 'r':
@@ -1267,6 +1303,9 @@ int main(int argc, char *argv[])
 		case 'd':
 			describe_flags(optarg);
 			exit(0);
+		case 'i':
+			opt_mark_idle = 1;
+			break;
 		case 'l':
 			opt_list = 1;
 			break;
@@ -1308,6 +1347,9 @@ int main(int argc, char *argv[])
 	if (opt_list && opt_list_mapcnt)
 		kpagecount_fd = checked_open(PROC_KPAGECOUNT, O_RDONLY);
 
+	if (opt_mark_idle && opt_file)
+		page_idle_fd = checked_open(SYS_KERNEL_MM_PAGE_IDLE, O_RDWR);
+
 	if (opt_list && opt_pid)
 		printf("voffset\t");
 	if (opt_list && opt_file)
@@ -1341,5 +1383,8 @@ int main(int argc, char *argv[])
 	if (opt_list_mapcnt)
 		close(kpagecount_fd);
 
+	if (page_idle_fd >= 0)
+		close(page_idle_fd);
+
 	return 0;
 }
-- 
2.10.3.dirty

