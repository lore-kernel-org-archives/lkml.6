Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934965AbeEWUWH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 16:22:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:34260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934291AbeEWUWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 16:22:00 -0400
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
Subject: [PATCH 11/18] perf kcore_copy: Keep phdr data in a list
Date: Wed, 23 May 2018 17:20:59 -0300
Message-Id: <20180523202106.17286-12-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180523202106.17286-1-acme@kernel.org>
References: <20180523202106.17286-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Currently, kcore_copy makes 2 program headers, one for the kernel text
(namely kernel_map) and one for the modules (namely modules_map). Now
more program headers are needed, but treating each program header as a
special case results in much more code.

Instead, in preparation to add more program headers, change to keep
program header data (phdr_data) in a list.

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
Link: http://lkml.kernel.org/r/1526986485-6562-11-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.14.3
