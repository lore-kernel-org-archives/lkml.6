Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751813AbeEVK4r (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 06:56:47 -0400
Received: from mga17.intel.com ([192.55.52.151]:56463 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751701AbeEVK4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 06:56:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,429,1520924400";
   d="scan'208";a="60711510"
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
Subject: [PATCH V3 10/17] perf buildid-cache: kcore_copy: Keep phdr data in a list
Date: Tue, 22 May 2018 13:54:38 +0300
Message-Id: <1526986485-6562-11-git-send-email-adrian.hunter@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1526986485-6562-1-git-send-email-adrian.hunter@intel.com>
References: <1526986485-6562-1-git-send-email-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, kcore_copy makes 2 program headers, one for the kernel text
(namely kernel_map) and one for the modules (namely modules_map). Now more
program headers are needed, but treating each program header as a special
case results in much more code.

Instead, in preparation to add more program headers, change to keep program
header data (phdr_data) in a list.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/symbol-elf.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 48943b834f11..b13873a6f368 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1388,6 +1388,7 @@ struct phdr_data {
 	off_t offset;
 	u64 addr;
 	u64 len;
+	struct list_head node;
 };
 
 struct kcore_copy_info {
@@ -1399,6 +1400,7 @@ struct kcore_copy_info {
 	u64 last_module_symbol;
 	struct phdr_data kernel_map;
 	struct phdr_data modules_map;
+	struct list_head phdrs;
 };
 
 static int kcore_copy__process_kallsyms(void *arg, const char *name, char type,
@@ -1510,6 +1512,11 @@ static int kcore_copy__read_maps(struct kcore_copy_info *kci, Elf *elf)
 	if (elf_read_maps(elf, true, kcore_copy__read_map, kci) < 0)
 		return -1;
 
+	if (kci->kernel_map.len)
+		list_add_tail(&kci->kernel_map.node, &kci->phdrs);
+	if (kci->modules_map.len)
+		list_add_tail(&kci->modules_map.node, &kci->phdrs);
+
 	return 0;
 }
 
@@ -1678,6 +1685,8 @@ int kcore_copy(const char *from_dir, const char *to_dir)
 	char kcore_filename[PATH_MAX];
 	char extract_filename[PATH_MAX];
 
+	INIT_LIST_HEAD(&kci.phdrs);
+
 	if (kcore_copy__copy_file(from_dir, to_dir, "kallsyms"))
 		return -1;
 
-- 
1.9.1
