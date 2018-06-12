Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 403ACC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E02D62086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="PQL9QHC4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E02D62086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754361AbeFLPcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 11:32:10 -0400
Received: from alln-iport-6.cisco.com ([173.37.142.93]:62234 "EHLO
        alln-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754056AbeFLPcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 11:32:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=8677; q=dns/txt; s=iport;
  t=1528817528; x=1530027128;
  h=from:to:cc:subject:date:message-id;
  bh=58i2EZ0nxfVVIswLVje0tjjVWDqn+kfmvcGLLBPefew=;
  b=PQL9QHC4A311oEKOaA+lcrgYuMW2FMooLOu6+x2xJj31p45CSHhgks6+
   g5k0LA/FVyb5QPzuM4OrEEvb3cCpJF4h4nKpUTYGPTss4xrevv6Askrg9
   cj93MWWLCNV2LBQ3N9yF/J8pWWeAKEFyfh6WdaHF4sfI5YE0kDqa9du7l
   0=;
X-IronPort-AV: E=Sophos;i="5.51,215,1526342400"; 
   d="scan'208";a="128003080"
Received: from alln-core-1.cisco.com ([173.36.13.131])
  by alln-iport-6.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2018 15:32:08 +0000
Received: from ott-ads-260.cisco.com (ott-ads-260.cisco.com [161.44.237.28])
        by alln-core-1.cisco.com (8.14.5/8.14.5) with ESMTP id w5CFW729028511;
        Tue, 12 Jun 2018 15:32:08 GMT
Received: by ott-ads-260.cisco.com (Postfix, from userid 509275)
        id 86F2DBDA; Tue, 12 Jun 2018 11:32:07 -0400 (EDT)
From:   Christian Hansen <chansen3@cisco.com>
To:     akpm@linux-foundation.org
Cc:     xe-linux-external@cisco.com, linux-kernel@vger.kernel.org,
        Christian Hansen <chansen3@cisco.com>
Subject: [PATCH] tools: modifying page-types to include shared map counts
Date:   Tue, 12 Jun 2018 11:32:05 -0400
Message-Id: <20180612153205.12879-1-chansen3@cisco.com>
X-Mailer: git-send-email 2.10.3.dirty
X-Auto-Response-Suppress: DR, OOF, AutoReply
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding a new flag that will read kpagecount for each PFN
and print out the number of time the page is mapped along
with the flags in the listing view.

Signed-off-by: Christian Hansen <chansen3@cisco.com>
---
 tools/vm/page-types.c | 73 +++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 59 insertions(+), 14 deletions(-)

diff --git a/tools/vm/page-types.c b/tools/vm/page-types.c
index a8783f4..c3e1453 100644
--- a/tools/vm/page-types.c
+++ b/tools/vm/page-types.c
@@ -75,6 +75,7 @@
 
 #define KPF_BYTES		8
 #define PROC_KPAGEFLAGS		"/proc/kpageflags"
+#define PROC_KPAGECOUNT		"/proc/kpagecount"
 #define PROC_KPAGECGROUP	"/proc/kpagecgroup"
 
 /* [32-] kernel hacking assistances */
@@ -172,6 +173,7 @@ static pid_t		opt_pid;	/* process to walk */
 const char		*opt_file;	/* file or directory path */
 static uint64_t		opt_cgroup;	/* cgroup inode */
 static int		opt_list_cgroup;/* list page cgroup */
+static int		opt_list_mapcnt;/* list page map count */
 static const char	*opt_kpageflags;/* kpageflags file to parse */
 
 #define MAX_ADDR_RANGES	1024
@@ -193,6 +195,7 @@ static int		page_size;
 
 static int		pagemap_fd;
 static int		kpageflags_fd;
+static int		kpagecount_fd = -1;
 static int		kpagecgroup_fd = -1;
 
 static int		opt_hwpoison;
@@ -297,6 +300,15 @@ static unsigned long kpagecgroup_read(uint64_t *buf,
 	return do_u64_read(kpagecgroup_fd, opt_kpageflags, buf, index, pages);
 }
 
+static unsigned long kpagecount_read(uint64_t *buf,
+				     unsigned long index,
+				     unsigned long pages)
+{
+	return kpagecount_fd < 0 ? pages:
+		do_u64_read(kpagecount_fd, PROC_KPAGECOUNT,
+			    buf, index, pages);
+}
+
 static unsigned long pagemap_read(uint64_t *buf,
 				  unsigned long index,
 				  unsigned long pages)
@@ -369,16 +381,18 @@ static char *page_flag_longname(uint64_t flags)
  */
 
 static void show_page_range(unsigned long voffset, unsigned long offset,
-			    unsigned long size, uint64_t flags, uint64_t cgroup)
+			    unsigned long size, uint64_t flags,
+			    uint64_t cgroup, uint64_t mapcnt)
 {
 	static uint64_t      flags0;
 	static uint64_t	     cgroup0;
+	static uint64_t      mapcnt0;
 	static unsigned long voff;
 	static unsigned long index;
 	static unsigned long count;
 
-	if (flags == flags0 && cgroup == cgroup0 && offset == index + count &&
-	    size && voffset == voff + count) {
+	if (flags == flags0 && cgroup == cgroup0 && mapcnt == mapcnt0 &&
+	    offset == index + count && size && voffset == voff + count) {
 		count += size;
 		return;
 	}
@@ -390,12 +404,15 @@ static void show_page_range(unsigned long voffset, unsigned long offset,
 			printf("%lu\t", voff);
 		if (opt_list_cgroup)
 			printf("@%llu\t", (unsigned long long)cgroup0);
+		if (opt_list_mapcnt)
+			printf("%lu\t", mapcnt0);
 		printf("%lx\t%lx\t%s\n",
 				index, count, page_flag_name(flags0));
 	}
 
 	flags0 = flags;
-	cgroup0= cgroup;
+	cgroup0 = cgroup;
+	mapcnt0 = mapcnt;
 	index  = offset;
 	voff   = voffset;
 	count  = size;
@@ -403,11 +420,11 @@ static void show_page_range(unsigned long voffset, unsigned long offset,
 
 static void flush_page_range(void)
 {
-	show_page_range(0, 0, 0, 0, 0);
+	show_page_range(0, 0, 0, 0, 0, 0);
 }
 
 static void show_page(unsigned long voffset, unsigned long offset,
-		      uint64_t flags, uint64_t cgroup)
+		      uint64_t flags, uint64_t cgroup, uint64_t mapcnt)
 {
 	if (opt_pid)
 		printf("%lx\t", voffset);
@@ -415,6 +432,9 @@ static void show_page(unsigned long voffset, unsigned long offset,
 		printf("%lu\t", voffset);
 	if (opt_list_cgroup)
 		printf("@%llu\t", (unsigned long long)cgroup);
+	if (opt_list_mapcnt)
+		printf("%lu\t", mapcnt);
+
 	printf("%lx\t%s\n", offset, page_flag_name(flags));
 }
 
@@ -598,7 +618,8 @@ static size_t hash_slot(uint64_t flags)
 }
 
 static void add_page(unsigned long voffset, unsigned long offset,
-		     uint64_t flags, uint64_t cgroup, uint64_t pme)
+		     uint64_t flags, uint64_t cgroup, uint64_t mapcnt,
+		     uint64_t pme)
 {
 	flags = kpageflags_flags(flags, pme);
 
@@ -614,9 +635,9 @@ static void add_page(unsigned long voffset, unsigned long offset,
 		unpoison_page(offset);
 
 	if (opt_list == 1)
-		show_page_range(voffset, offset, 1, flags, cgroup);
+		show_page_range(voffset, offset, 1, flags, cgroup, mapcnt);
 	else if (opt_list == 2)
-		show_page(voffset, offset, flags, cgroup);
+		show_page(voffset, offset, flags, cgroup, mapcnt);
 
 	nr_pages[hash_slot(flags)]++;
 	total_pages++;
@@ -630,6 +651,7 @@ static void walk_pfn(unsigned long voffset,
 {
 	uint64_t buf[KPAGEFLAGS_BATCH];
 	uint64_t cgi[KPAGEFLAGS_BATCH];
+	uint64_t cnt[KPAGEFLAGS_BATCH];
 	unsigned long batch;
 	unsigned long pages;
 	unsigned long i;
@@ -653,8 +675,12 @@ static void walk_pfn(unsigned long voffset,
 		if (kpagecgroup_read(cgi, index, pages) != pages)
 			fatal("kpagecgroup returned fewer pages than expected");
 
+		if (kpagecount_read(cnt, index, batch) != pages)
+			fatal("kpagecount returned fewer pages than expected");
+
 		for (i = 0; i < pages; i++)
-			add_page(voffset + i, index + i, buf[i], cgi[i], pme);
+			add_page(voffset + i, index + i,
+				 buf[i], cgi[i], cnt[i], pme);
 
 		index += pages;
 		count -= pages;
@@ -672,9 +698,10 @@ static void walk_swap(unsigned long voffset, uint64_t pme)
 		return;
 
 	if (opt_list == 1)
-		show_page_range(voffset, pagemap_swap_offset(pme), 1, flags, 0);
+		show_page_range(voffset, pagemap_swap_offset(pme),
+				1, flags, 0, 0);
 	else if (opt_list == 2)
-		show_page(voffset, pagemap_swap_offset(pme), flags, 0);
+		show_page(voffset, pagemap_swap_offset(pme), flags, 0, 0);
 
 	nr_pages[hash_slot(flags)]++;
 	total_pages++;
@@ -788,6 +815,7 @@ static void usage(void)
 "            -l|--list                  Show page details in ranges\n"
 "            -L|--list-each             Show page details one by one\n"
 "            -C|--list-cgroup           Show cgroup inode for pages\n"
+"            -M|--list-mapcnt           Show page map count\n"
 "            -N|--no-summary            Don't show summary info\n"
 "            -X|--hwpoison              hwpoison pages\n"
 "            -x|--unpoison              unpoison pages\n"
@@ -924,6 +952,7 @@ static void walk_file(const char *name, const struct stat *st)
 	uint8_t vec[PAGEMAP_BATCH];
 	uint64_t buf[PAGEMAP_BATCH], flags;
 	uint64_t cgroup = 0;
+	uint64_t mapcnt = 0;
 	unsigned long nr_pages, pfn, i;
 	off_t off, end = st->st_size;
 	int fd;
@@ -983,13 +1012,15 @@ static void walk_file(const char *name, const struct stat *st)
 				continue;
 			if (!kpagecgroup_read(&cgroup, pfn, 1))
 				fatal("kpagecgroup_read failed");
+			if (!kpagecount_read(&mapcnt, pfn, 1))
+				fatal("kpagecount_read failed");
 			if (first && opt_list) {
 				first = 0;
 				flush_page_range();
 				show_file(name, st);
 			}
 			add_page(off / page_size + i, pfn,
-				 flags, cgroup, buf[i]);
+				 flags, cgroup, mapcnt, buf[i]);
 		}
 	}
 
@@ -1192,6 +1223,7 @@ static const struct option opts[] = {
 	{ "list"      , 0, NULL, 'l' },
 	{ "list-each" , 0, NULL, 'L' },
 	{ "list-cgroup", 0, NULL, 'C' },
+	{ "list-mapcnt", 0, NULL, 'M' },
 	{ "no-summary", 0, NULL, 'N' },
 	{ "hwpoison"  , 0, NULL, 'X' },
 	{ "unpoison"  , 0, NULL, 'x' },
@@ -1207,7 +1239,8 @@ int main(int argc, char *argv[])
 	page_size = getpagesize();
 
 	while ((c = getopt_long(argc, argv,
-				"rp:f:a:b:d:c:ClLNXxF:h", opts, NULL)) != -1) {
+				"rp:f:a:b:d:c:ClLMNXxF:h",
+				opts, NULL)) != -1) {
 		switch (c) {
 		case 'r':
 			opt_raw = 1;
@@ -1239,6 +1272,9 @@ int main(int argc, char *argv[])
 		case 'L':
 			opt_list = 2;
 			break;
+		case 'M':
+			opt_list_mapcnt = 1;
+			break;
 		case 'N':
 			opt_no_summary = 1;
 			break;
@@ -1268,12 +1304,18 @@ int main(int argc, char *argv[])
 	if (opt_cgroup || opt_list_cgroup)
 		kpagecgroup_fd = checked_open(PROC_KPAGECGROUP, O_RDONLY);
 
+	if (opt_list && opt_list_mapcnt)
+		kpagecount_fd = checked_open(PROC_KPAGECOUNT, O_RDONLY);
+
 	if (opt_list && opt_pid)
 		printf("voffset\t");
 	if (opt_list && opt_file)
 		printf("foffset\t");
 	if (opt_list && opt_list_cgroup)
 		printf("cgroup\t");
+	if (opt_list && opt_list_mapcnt)
+		printf("map-cnt\t");
+
 	if (opt_list == 1)
 		printf("offset\tlen\tflags\n");
 	if (opt_list == 2)
@@ -1295,5 +1337,8 @@ int main(int argc, char *argv[])
 
 	show_summary();
 
+	if (opt_list_mapcnt)
+		close(kpagecount_fd);
+
 	return 0;
 }
-- 
2.10.3.dirty

