Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935053AbeEWUX0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 16:23:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:34468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934980AbeEWUWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 16:22:17 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Jiri Olsa <jolsa@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 15/18] perf kcore_copy: Iterate phdrs
Date: Wed, 23 May 2018 17:21:03 -0300
Message-Id: <20180523202106.17286-16-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180523202106.17286-1-acme@kernel.org>
References: <20180523202106.17286-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

In preparation to add more program headers, iterate phdrs instead of
assuming there is only one for the kernel text and one for the modules.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Link: http://lkml.kernel.org/r/1526986485-6562-15-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol-elf.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 3e76a0efd15c..91b8cfb045ec 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1701,10 +1701,11 @@ int kcore_copy(const char *from_dir, const char *to_dir)
 	struct kcore kcore;
 	struct kcore extract;
 	int idx = 0, err = -1;
-	off_t offset, sz, modules_offset = 0;
+	off_t offset, sz;
 	struct kcore_copy_info kci = { .stext = 0, };
 	char kcore_filename[PATH_MAX];
 	char extract_filename[PATH_MAX];
+	struct phdr_data *p;
 
 	INIT_LIST_HEAD(&kci.phdrs);
 
@@ -1733,14 +1734,10 @@ int kcore_copy(const char *from_dir, const char *to_dir)
 		 gelf_fsize(extract.elf, ELF_T_PHDR, kci.phnum, EV_CURRENT);
 	offset = round_up(offset, page_size);
 
-	if (kcore__add_phdr(&extract, idx++, offset, kci.kernel_map.addr,
-			    kci.kernel_map.len))
-		goto out_extract_close;
+	kcore_copy__for_each_phdr(&kci, p) {
+		off_t offs = p->rel + offset;
 
-	if (kci.modules_map.addr) {
-		modules_offset = offset + kci.kernel_map.len;
-		if (kcore__add_phdr(&extract, idx, modules_offset,
-				    kci.modules_map.addr, kci.modules_map.len))
+		if (kcore__add_phdr(&extract, idx++, offs, p->addr, p->len))
 			goto out_extract_close;
 	}
 
@@ -1748,14 +1745,12 @@ int kcore_copy(const char *from_dir, const char *to_dir)
 	if (sz < 0 || sz > offset)
 		goto out_extract_close;
 
-	if (copy_bytes(kcore.fd, kci.kernel_map.offset, extract.fd, offset,
-		       kci.kernel_map.len))
-		goto out_extract_close;
+	kcore_copy__for_each_phdr(&kci, p) {
+		off_t offs = p->rel + offset;
 
-	if (modules_offset && copy_bytes(kcore.fd, kci.modules_map.offset,
-					 extract.fd, modules_offset,
-					 kci.modules_map.len))
-		goto out_extract_close;
+		if (copy_bytes(kcore.fd, p->offset, extract.fd, offs, p->len))
+			goto out_extract_close;
+	}
 
 	if (kcore_copy__compare_file(from_dir, to_dir, "modules"))
 		goto out_extract_close;
-- 
2.14.3
