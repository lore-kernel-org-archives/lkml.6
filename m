Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934801AbeEILqI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 07:46:08 -0400
Received: from mga14.intel.com ([192.55.52.115]:26332 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934376AbeEILqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 07:46:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,381,1520924400";
   d="scan'208";a="54446053"
From: Adrian Hunter <adrian.hunter@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH RFC 16/19] perf buildid-cache: kcore_copy: Iterate phdrs
Date: Wed,  9 May 2018 14:43:45 +0300
Message-Id: <1525866228-30321-17-git-send-email-adrian.hunter@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525866228-30321-1-git-send-email-adrian.hunter@intel.com>
References: <1525866228-30321-1-git-send-email-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to add more program headers, iterate phdrs instead of
assuming there is only one for the kernel text and one for the modules.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/symbol-elf.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 9ecd83418bb5..161d12fb246c 100644
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
1.9.1
