Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755188AbeEXFo6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 01:44:58 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39253 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755069AbeEXFop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 01:44:45 -0400
Date: Wed, 23 May 2018 22:43:23 -0700
From: tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-15acef6c3727cfe0bc9d1f6b273cca46689e8cd8@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, luto@kernel.org, joro@8bytes.org,
        ak@linux.intel.com, peterz@infradead.org, mingo@kernel.org,
        jolsa@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
        alexander.shishkin@linux.intel.com, acme@redhat.com,
        tglx@linutronix.de, adrian.hunter@intel.com
Reply-To: adrian.hunter@intel.com, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, acme@redhat.com, hpa@zytor.com,
        dave.hansen@linux.intel.com, jolsa@redhat.com, peterz@infradead.org,
        mingo@kernel.org, ak@linux.intel.com, linux-kernel@vger.kernel.org,
        joro@8bytes.org, luto@kernel.org
In-Reply-To: <1526986485-6562-14-git-send-email-adrian.hunter@intel.com>
References: <1526986485-6562-14-git-send-email-adrian.hunter@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf kcore_copy: Layout sections
Git-Commit-ID: 15acef6c3727cfe0bc9d1f6b273cca46689e8cd8
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

Commit-ID:  15acef6c3727cfe0bc9d1f6b273cca46689e8cd8
Gitweb:     https://git.kernel.org/tip/15acef6c3727cfe0bc9d1f6b273cca46689e8cd8
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Tue, 22 May 2018 13:54:41 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 23 May 2018 10:26:42 -0300

perf kcore_copy: Layout sections

In preparation to add more program headers, layout the relative offset
of each section.

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
Link: http://lkml.kernel.org/r/1526986485-6562-14-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol-elf.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 4aec12102e19..3e76a0efd15c 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1386,6 +1386,7 @@ static off_t kcore__write(struct kcore *kcore)
 
 struct phdr_data {
 	off_t offset;
+	off_t rel;
 	u64 addr;
 	u64 len;
 	struct list_head node;
@@ -1404,6 +1405,9 @@ struct kcore_copy_info {
 	struct list_head phdrs;
 };
 
+#define kcore_copy__for_each_phdr(k, p) \
+	list_for_each_entry((p), &(k)->phdrs, node)
+
 static int kcore_copy__process_kallsyms(void *arg, const char *name, char type,
 					u64 start)
 {
@@ -1518,11 +1522,21 @@ static int kcore_copy__read_maps(struct kcore_copy_info *kci, Elf *elf)
 	if (kci->modules_map.len)
 		list_add_tail(&kci->modules_map.node, &kci->phdrs);
 
-	kci->phnum = !!kci->kernel_map.len + !!kci->modules_map.len;
-
 	return 0;
 }
 
+static void kcore_copy__layout(struct kcore_copy_info *kci)
+{
+	struct phdr_data *p;
+	off_t rel = 0;
+
+	kcore_copy__for_each_phdr(kci, p) {
+		p->rel = rel;
+		rel += p->len;
+		kci->phnum += 1;
+	}
+}
+
 static int kcore_copy__calc_maps(struct kcore_copy_info *kci, const char *dir,
 				 Elf *elf)
 {
@@ -1558,7 +1572,12 @@ static int kcore_copy__calc_maps(struct kcore_copy_info *kci, const char *dir,
 	if (kci->first_module && !kci->last_module_symbol)
 		return -1;
 
-	return kcore_copy__read_maps(kci, elf);
+	if (kcore_copy__read_maps(kci, elf))
+		return -1;
+
+	kcore_copy__layout(kci);
+
+	return 0;
 }
 
 static int kcore_copy__copy_file(const char *from_dir, const char *to_dir,
