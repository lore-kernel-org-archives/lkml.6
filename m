Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755159AbeEXFoP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 01:44:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54837 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754954AbeEXFoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 01:44:13 -0400
Date: Wed, 23 May 2018 22:43:51 -0700
From: tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-d2c959803c8843f64e419d833dc3722154c82492@git.kernel.org>
Cc: hpa@zytor.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        dave.hansen@linux.intel.com, acme@redhat.com, adrian.hunter@intel.com,
        tglx@linutronix.de, joro@8bytes.org, jolsa@redhat.com,
        mingo@kernel.org, luto@kernel.org, linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org, jolsa@redhat.com,
        luto@kernel.org, joro@8bytes.org, adrian.hunter@intel.com,
        tglx@linutronix.de, dave.hansen@linux.intel.com, acme@redhat.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        peterz@infradead.org, hpa@zytor.com
In-Reply-To: <1526986485-6562-15-git-send-email-adrian.hunter@intel.com>
References: <1526986485-6562-15-git-send-email-adrian.hunter@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf kcore_copy: Iterate phdrs
Git-Commit-ID: d2c959803c8843f64e419d833dc3722154c82492
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  d2c959803c8843f64e419d833dc3722154c82492
Gitweb:     https://git.kernel.org/tip/d2c959803c8843f64e419d833dc3722154c82492
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Tue, 22 May 2018 13:54:42 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 23 May 2018 10:26:42 -0300

perf kcore_copy: Iterate phdrs

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
