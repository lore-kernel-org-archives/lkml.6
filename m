Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4728AC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 18:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C879823F51
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 18:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="aUMhPNT7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C879823F51
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753814AbeGESMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 14:12:13 -0400
Received: from alln-iport-8.cisco.com ([173.37.142.95]:1446 "EHLO
        alln-iport-8.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753405AbeGESML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 14:12:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=10146; q=dns/txt;
  s=iport; t=1530814331; x=1532023931;
  h=from:to:cc:subject:date:message-id;
  bh=sZzIeXh+zZpJrNEmCiHoNSQLFGNfjhoa2ffAZf8ZivE=;
  b=aUMhPNT7C9XK1CAin2OK6Pjp0KDdMAyU/EtocNNez1MymMblZZQHaAEn
   2yGYMND5/tCVIQSAi/huqqJodRdUESdVedgWqBndqrYDA4FR/2UiCYeBj
   avDkw/esSZugZxfjeZ7bPHc4W3iFc+xLrH55BXy8ugraJlk/mujlolLbQ
   w=;
X-IronPort-AV: E=Sophos;i="5.51,313,1526342400"; 
   d="scan'208";a="138640068"
Received: from alln-core-12.cisco.com ([173.36.13.134])
  by alln-iport-8.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jul 2018 18:12:11 +0000
Received: from ott-ads-260.cisco.com (ott-ads-260.cisco.com [161.44.237.28])
        by alln-core-12.cisco.com (8.14.5/8.14.5) with ESMTP id w65ICADi001409;
        Thu, 5 Jul 2018 18:12:11 GMT
Received: by ott-ads-260.cisco.com (Postfix, from userid 509275)
        id ADCA7A9B; Thu,  5 Jul 2018 14:12:09 -0400 (EDT)
From:   Christian Hansen <chansen3@cisco.com>
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, Christian Hansen <chansen3@cisco.com>
Subject: [PATCH] tools: modifying page-types to include shared map counts
Date:   Thu,  5 Jul 2018 14:12:04 -0400
Message-Id: <20180705181204.5529-1-chansen3@cisco.com>
X-Mailer: git-send-email 2.10.3.dirty
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding a new flag that will read kpagecount for each PFN
and print out the number of times the page is mapped along
with the flags in the listing view.

This information is useful in understanding and optimizing
memory usage. Identifying pages which are not shared allows
us to focus on adjusting the memory layout or access patterns
for the sole owning process.  Knowing the number of processes
that share a page tells us how many other times we must make
the same adjustments or how many processes to potentially disable.

Truncated sample output:

voffset map-cnt offset  len     flags
561a3591e       1       15fe8   1       ___U_lA____Ma_b___________________________
561a3591f       1       2b103   1       ___U_lA____Ma_b___________________________
561a36ca4       1       2cc78   1       ___U_lA____Ma_b___________________________
7f588bb4e       14      2273c   1       __RU_lA____M______________________________

Signed-off-by: Christian Hansen <chansen3@cisco.com>
---
 Documentation/admin-guide/mm/pagemap.rst |  3 ++
 tools/vm/page-types.c                    | 73 ++++++++++++++++++++++++++------
 2 files changed, 62 insertions(+), 14 deletions(-)

diff --git a/Documentation/admin-guide/mm/pagemap.rst b/Documentation/admin-guide/mm/pagemap.rst
index 577af85..3f7bade 100644
--- a/Documentation/admin-guide/mm/pagemap.rst
+++ b/Documentation/admin-guide/mm/pagemap.rst
@@ -44,6 +44,9 @@ There are four components to pagemap:
  * ``/proc/kpagecount``.  This file contains a 64-bit count of the number of
    times each page is mapped, indexed by PFN.
 
+The page-types tool in the tools/vm directory can be used to query the
+number of times a page is mapped.
+
  * ``/proc/kpageflags``.  This file contains a 64-bit set of flags for each
    page, indexed by PFN.
 
diff --git a/tools/vm/page-types.c b/tools/vm/page-types.c
index cce853d..7fe4797 100644
--- a/tools/vm/page-types.c
+++ b/tools/vm/page-types.c
@@ -75,6 +75,7 @@
 
 #define KPF_BYTES		8
 #define PROC_KPAGEFLAGS		"/proc/kpageflags"
+#define PROC_KPAGECOUNT		"/proc/kpagecount"
 #define PROC_KPAGECGROUP	"/proc/kpagecgroup"
 
 /* [32-] kernel hacking assistances */
@@ -173,6 +174,7 @@ static pid_t		opt_pid;	/* process to walk */
 const char		*opt_file;	/* file or directory path */
 static uint64_t		opt_cgroup;	/* cgroup inode */
 static int		opt_list_cgroup;/* list page cgroup */
+static int		opt_list_mapcnt;/* list page map count */
 static const char	*opt_kpageflags;/* kpageflags file to parse */
 
 #define MAX_ADDR_RANGES	1024
@@ -194,6 +196,7 @@ static int		page_size;
 
 static int		pagemap_fd;
 static int		kpageflags_fd;
+static int		kpagecount_fd = -1;
 static int		kpagecgroup_fd = -1;
 
 static int		opt_hwpoison;
@@ -298,6 +301,15 @@ static unsigned long kpagecgroup_read(uint64_t *buf,
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
@@ -370,16 +382,18 @@ static char *page_flag_longname(uint64_t flags)
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
@@ -391,12 +405,15 @@ static void show_page_range(unsigned long voffset, unsigned long offset,
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
@@ -404,11 +421,11 @@ static void show_page_range(unsigned long voffset, unsigned long offset,
 
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
@@ -416,6 +433,9 @@ static void show_page(unsigned long voffset, unsigned long offset,
 		printf("%lu\t", voffset);
 	if (opt_list_cgroup)
 		printf("@%llu\t", (unsigned long long)cgroup);
+	if (opt_list_mapcnt)
+		printf("%lu\t", mapcnt);
+
 	printf("%lx\t%s\n", offset, page_flag_name(flags));
 }
 
@@ -599,7 +619,8 @@ static size_t hash_slot(uint64_t flags)
 }
 
 static void add_page(unsigned long voffset, unsigned long offset,
-		     uint64_t flags, uint64_t cgroup, uint64_t pme)
+		     uint64_t flags, uint64_t cgroup, uint64_t mapcnt,
+		     uint64_t pme)
 {
 	flags = kpageflags_flags(flags, pme);
 
@@ -615,9 +636,9 @@ static void add_page(unsigned long voffset, unsigned long offset,
 		unpoison_page(offset);
 
 	if (opt_list == 1)
-		show_page_range(voffset, offset, 1, flags, cgroup);
+		show_page_range(voffset, offset, 1, flags, cgroup, mapcnt);
 	else if (opt_list == 2)
-		show_page(voffset, offset, flags, cgroup);
+		show_page(voffset, offset, flags, cgroup, mapcnt);
 
 	nr_pages[hash_slot(flags)]++;
 	total_pages++;
@@ -631,6 +652,7 @@ static void walk_pfn(unsigned long voffset,
 {
 	uint64_t buf[KPAGEFLAGS_BATCH];
 	uint64_t cgi[KPAGEFLAGS_BATCH];
+	uint64_t cnt[KPAGEFLAGS_BATCH];
 	unsigned long batch;
 	unsigned long pages;
 	unsigned long i;
@@ -654,8 +676,12 @@ static void walk_pfn(unsigned long voffset,
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
@@ -673,9 +699,10 @@ static void walk_swap(unsigned long voffset, uint64_t pme)
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
@@ -789,6 +816,7 @@ static void usage(void)
 "            -l|--list                  Show page details in ranges\n"
 "            -L|--list-each             Show page details one by one\n"
 "            -C|--list-cgroup           Show cgroup inode for pages\n"
+"            -M|--list-mapcnt           Show page map count\n"
 "            -N|--no-summary            Don't show summary info\n"
 "            -X|--hwpoison              hwpoison pages\n"
 "            -x|--unpoison              unpoison pages\n"
@@ -925,6 +953,7 @@ static void walk_file(const char *name, const struct stat *st)
 	uint8_t vec[PAGEMAP_BATCH];
 	uint64_t buf[PAGEMAP_BATCH], flags;
 	uint64_t cgroup = 0;
+	uint64_t mapcnt = 0;
 	unsigned long nr_pages, pfn, i;
 	off_t off, end = st->st_size;
 	int fd;
@@ -984,13 +1013,15 @@ static void walk_file(const char *name, const struct stat *st)
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
 
@@ -1193,6 +1224,7 @@ static const struct option opts[] = {
 	{ "list"      , 0, NULL, 'l' },
 	{ "list-each" , 0, NULL, 'L' },
 	{ "list-cgroup", 0, NULL, 'C' },
+	{ "list-mapcnt", 0, NULL, 'M' },
 	{ "no-summary", 0, NULL, 'N' },
 	{ "hwpoison"  , 0, NULL, 'X' },
 	{ "unpoison"  , 0, NULL, 'x' },
@@ -1208,7 +1240,8 @@ int main(int argc, char *argv[])
 	page_size = getpagesize();
 
 	while ((c = getopt_long(argc, argv,
-				"rp:f:a:b:d:c:ClLNXxF:h", opts, NULL)) != -1) {
+				"rp:f:a:b:d:c:ClLMNXxF:h",
+				opts, NULL)) != -1) {
 		switch (c) {
 		case 'r':
 			opt_raw = 1;
@@ -1240,6 +1273,9 @@ int main(int argc, char *argv[])
 		case 'L':
 			opt_list = 2;
 			break;
+		case 'M':
+			opt_list_mapcnt = 1;
+			break;
 		case 'N':
 			opt_no_summary = 1;
 			break;
@@ -1269,12 +1305,18 @@ int main(int argc, char *argv[])
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
@@ -1296,5 +1338,8 @@ int main(int argc, char *argv[])
 
 	show_summary();
 
+	if (opt_list_mapcnt)
+		close(kpagecount_fd);
+
 	return 0;
 }
-- 
2.10.3.dirty

