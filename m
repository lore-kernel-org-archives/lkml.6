Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755087AbeEXFmW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 01:42:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60081 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754937AbeEXFmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 01:42:19 -0400
Date: Wed, 23 May 2018 22:41:54 -0700
From: tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-f6838209484d5cfb368ca5c61d150cc4054eef59@git.kernel.org>
Cc: dave.hansen@linux.intel.com, jolsa@redhat.com,
        alexander.shishkin@linux.intel.com, hpa@zytor.com, luto@kernel.org,
        joro@8bytes.org, mingo@kernel.org, tglx@linutronix.de,
        ak@linux.intel.com, peterz@infradead.org, acme@redhat.com,
        adrian.hunter@intel.com, linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, luto@kernel.org, joro@8bytes.org,
        dave.hansen@linux.intel.com, jolsa@redhat.com,
        alexander.shishkin@linux.intel.com, peterz@infradead.org,
        acme@redhat.com, linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        mingo@kernel.org, tglx@linutronix.de, ak@linux.intel.com
In-Reply-To: <1526986485-6562-11-git-send-email-adrian.hunter@intel.com>
References: <1526986485-6562-11-git-send-email-adrian.hunter@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf kcore_copy: Keep phdr data in a list
Git-Commit-ID: f6838209484d5cfb368ca5c61d150cc4054eef59
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

Commit-ID:  f6838209484d5cfb368ca5c61d150cc4054eef59
Gitweb:     https://git.kernel.org/tip/f6838209484d5cfb368ca5c61d150cc4054eef59
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Tue, 22 May 2018 13:54:38 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 23 May 2018 10:26:40 -0300

perf kcore_copy: Keep phdr data in a list

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
 
