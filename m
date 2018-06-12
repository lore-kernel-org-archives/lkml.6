Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3B0ACC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFA922086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="ds2NL3ZJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFA922086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933868AbeFLPc1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 11:32:27 -0400
Received: from rcdn-iport-6.cisco.com ([173.37.86.77]:52834 "EHLO
        rcdn-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932712AbeFLPc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 11:32:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=4362; q=dns/txt; s=iport;
  t=1528817546; x=1530027146;
  h=from:to:cc:subject:date:message-id;
  bh=WoA2h796hwYKLr6zVhlo4KWxn4Uf/KVuBBXvRHTcWQA=;
  b=ds2NL3ZJGj6aCIpBLjj3pgNBohUVL2DaOO5nZ2iOZ0LODAwuLqlE5wfD
   SvyZiibAqGxu1EiWnecAbTiu9gdFlHuBNU/+oe/uG5je4okjfzkoRO1A6
   Gi0Nay7WjO7Lo99UYSWy4a1T51MW6IJJT2/MQidZbstwgBmY4STKeSCF0
   w=;
X-IronPort-AV: E=Sophos;i="5.51,215,1526342400"; 
   d="scan'208";a="409336298"
Received: from rcdn-core-10.cisco.com ([173.37.93.146])
  by rcdn-iport-6.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2018 15:32:25 +0000
Received: from ott-ads-260.cisco.com (ott-ads-260.cisco.com [161.44.237.28])
        by rcdn-core-10.cisco.com (8.14.5/8.14.5) with ESMTP id w5CFWPGg025337;
        Tue, 12 Jun 2018 15:32:25 GMT
Received: by ott-ads-260.cisco.com (Postfix, from userid 509275)
        id 59360BDA; Tue, 12 Jun 2018 11:32:25 -0400 (EDT)
From:   Christian Hansen <chansen3@cisco.com>
To:     akpm@linux-foundation.org
Cc:     xe-linux-external@cisco.com, linux-kernel@vger.kernel.org,
        Christian Hansen <chansen3@cisco.com>
Subject: [PATCH] tools: adding support for idle page tracking to tool
Date:   Tue, 12 Jun 2018 11:32:23 -0400
Message-Id: <20180612153223.13174-1-chansen3@cisco.com>
X-Mailer: git-send-email 2.10.3.dirty
X-Auto-Response-Suppress: DR, OOF, AutoReply
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding a flag which will use the kernels's idle
page tracking to mark pages idle.  As the tool already
prints the idle flag if set, subsequent runs will show
which pages have been accessed since last run.

Signed-off-by: Christian Hansen <chansen3@cisco.com>
---
 tools/vm/page-types.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/tools/vm/page-types.c b/tools/vm/page-types.c
index a8783f4..1a4f70d 100644
--- a/tools/vm/page-types.c
+++ b/tools/vm/page-types.c
@@ -77,6 +77,8 @@
 #define PROC_KPAGEFLAGS		"/proc/kpageflags"
 #define PROC_KPAGECGROUP	"/proc/kpagecgroup"
 
+#define SYS_KERNEL_MM_PAGE_IDLE "/sys/kernel/mm/page_idle/bitmap"
+
 /* [32-] kernel hacking assistances */
 #define KPF_RESERVED		32
 #define KPF_MLOCKED		33
@@ -167,6 +169,7 @@ static const char * const debugfs_known_mountpoints[] = {
 
 static int		opt_raw;	/* for kernel developers */
 static int		opt_list;	/* list pages (in ranges) */
+static int		opt_mark_idle;	/* set accessed bit */
 static int		opt_no_summary;	/* don't show summary */
 static pid_t		opt_pid;	/* process to walk */
 const char		*opt_file;	/* file or directory path */
@@ -194,6 +197,7 @@ static int		page_size;
 static int		pagemap_fd;
 static int		kpageflags_fd;
 static int		kpagecgroup_fd = -1;
+static int		page_idle_fd = -1;
 
 static int		opt_hwpoison;
 static int		opt_unpoison;
@@ -566,6 +570,30 @@ static int unpoison_page(unsigned long offset)
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
@@ -613,6 +641,9 @@ static void add_page(unsigned long voffset, unsigned long offset,
 	if (opt_unpoison)
 		unpoison_page(offset);
 
+	if (opt_mark_idle)
+		mark_page_idle(offset);
+
 	if (opt_list == 1)
 		show_page_range(voffset, offset, 1, flags, cgroup);
 	else if (opt_list == 2)
@@ -755,6 +786,9 @@ static void walk_addr_ranges(void)
 		else
 			walk_task(opt_offset[i], opt_size[i]);
 
+	if (opt_mark_idle)
+		mark_page_idle(0);
+
 	close(kpageflags_fd);
 }
 
@@ -785,6 +819,7 @@ static void usage(void)
 "            -c|--cgroup  path|@inode   Walk pages within memory cgroup\n"
 "            -p|--pid     pid           Walk process address space\n"
 "            -f|--file    filename      Walk file address space\n"
+"            -i|--mark-idle             Mark pages idle\n"
 "            -l|--list                  Show page details in ranges\n"
 "            -L|--list-each             Show page details one by one\n"
 "            -C|--list-cgroup           Show cgroup inode for pages\n"
@@ -1189,6 +1224,7 @@ static const struct option opts[] = {
 	{ "bits"      , 1, NULL, 'b' },
 	{ "cgroup"    , 1, NULL, 'c' },
 	{ "describe"  , 1, NULL, 'd' },
+	{ "mark-idle" , 0, NULL, 'i' },
 	{ "list"      , 0, NULL, 'l' },
 	{ "list-each" , 0, NULL, 'L' },
 	{ "list-cgroup", 0, NULL, 'C' },
@@ -1207,7 +1243,7 @@ int main(int argc, char *argv[])
 	page_size = getpagesize();
 
 	while ((c = getopt_long(argc, argv,
-				"rp:f:a:b:d:c:ClLNXxF:h", opts, NULL)) != -1) {
+				"rp:f:a:b:d:c:CilLNXxF:h", opts, NULL)) != -1) {
 		switch (c) {
 		case 'r':
 			opt_raw = 1;
@@ -1233,6 +1269,9 @@ int main(int argc, char *argv[])
 		case 'd':
 			describe_flags(optarg);
 			exit(0);
+		case 'i':
+			opt_mark_idle = 1;
+			break;
 		case 'l':
 			opt_list = 1;
 			break;
@@ -1268,6 +1307,9 @@ int main(int argc, char *argv[])
 	if (opt_cgroup || opt_list_cgroup)
 		kpagecgroup_fd = checked_open(PROC_KPAGECGROUP, O_RDONLY);
 
+	if (opt_mark_idle && opt_file)
+		page_idle_fd = checked_open(SYS_KERNEL_MM_PAGE_IDLE, O_RDWR);
+
 	if (opt_list && opt_pid)
 		printf("voffset\t");
 	if (opt_list && opt_file)
@@ -1295,5 +1337,8 @@ int main(int argc, char *argv[])
 
 	show_summary();
 
+	if (page_idle_fd >= 0)
+		close(page_idle_fd);
+
 	return 0;
 }
-- 
2.10.3.dirty

