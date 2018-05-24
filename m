Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755097AbeEXFms (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 01:42:48 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57029 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754890AbeEXFmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 01:42:46 -0400
Date: Wed, 23 May 2018 22:42:24 -0700
From: tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-6e97957d3d30552c415292bb08a0e5f3c459c027@git.kernel.org>
Cc: tglx@linutronix.de, luto@kernel.org, dave.hansen@linux.intel.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org, hpa@zytor.com,
        jolsa@redhat.com, acme@redhat.com, joro@8bytes.org,
        adrian.hunter@intel.com, ak@linux.intel.com, mingo@kernel.org,
        alexander.shishkin@linux.intel.com
Reply-To: joro@8bytes.org, acme@redhat.com, luto@kernel.org,
        tglx@linutronix.de, peterz@infradead.org, jolsa@redhat.com,
        hpa@zytor.com, dave.hansen@linux.intel.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
        ak@linux.intel.com
In-Reply-To: <1526986485-6562-12-git-send-email-adrian.hunter@intel.com>
References: <1526986485-6562-12-git-send-email-adrian.hunter@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf kcore_copy: Keep a count of phdrs
Git-Commit-ID: 6e97957d3d30552c415292bb08a0e5f3c459c027
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

Commit-ID:  6e97957d3d30552c415292bb08a0e5f3c459c027
Gitweb:     https://git.kernel.org/tip/6e97957d3d30552c415292bb08a0e5f3c459c027
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Tue, 22 May 2018 13:54:39 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 23 May 2018 10:26:41 -0300

perf kcore_copy: Keep a count of phdrs

In preparation to add more program headers, keep a count of phdrs.

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
Link: http://lkml.kernel.org/r/1526986485-6562-12-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol-elf.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index b13873a6f368..4e7b71e8ac0e 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1398,6 +1398,7 @@ struct kcore_copy_info {
 	u64 last_symbol;
 	u64 first_module;
 	u64 last_module_symbol;
+	size_t phnum;
 	struct phdr_data kernel_map;
 	struct phdr_data modules_map;
 	struct list_head phdrs;
@@ -1517,6 +1518,8 @@ static int kcore_copy__read_maps(struct kcore_copy_info *kci, Elf *elf)
 	if (kci->modules_map.len)
 		list_add_tail(&kci->modules_map.node, &kci->phdrs);
 
+	kci->phnum = !!kci->kernel_map.len + !!kci->modules_map.len;
+
 	return 0;
 }
 
@@ -1678,7 +1681,6 @@ int kcore_copy(const char *from_dir, const char *to_dir)
 {
 	struct kcore kcore;
 	struct kcore extract;
-	size_t count = 2;
 	int idx = 0, err = -1;
 	off_t offset = page_size, sz, modules_offset = 0;
 	struct kcore_copy_info kci = { .stext = 0, };
@@ -1705,10 +1707,7 @@ int kcore_copy(const char *from_dir, const char *to_dir)
 	if (kcore__init(&extract, extract_filename, kcore.elfclass, false))
 		goto out_kcore_close;
 
-	if (!kci.modules_map.addr)
-		count -= 1;
-
-	if (kcore__copy_hdr(&kcore, &extract, count))
+	if (kcore__copy_hdr(&kcore, &extract, kci.phnum))
 		goto out_extract_close;
 
 	if (kcore__add_phdr(&extract, idx++, offset, kci.kernel_map.addr,
