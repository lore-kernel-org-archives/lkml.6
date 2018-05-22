Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752365AbeEVK5N (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 06:57:13 -0400
Received: from mga17.intel.com ([192.55.52.151]:56463 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751354AbeEVK5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 06:57:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,429,1520924400";
   d="scan'208";a="60711646"
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
Subject: [PATCH V3 17/17] perf buildid-cache: kcore_copy: Amend the offset of sections that remap kernel text
Date: Tue, 22 May 2018 13:54:45 +0300
Message-Id: <1526986485-6562-18-git-send-email-adrian.hunter@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1526986485-6562-1-git-send-email-adrian.hunter@intel.com>
References: <1526986485-6562-1-git-send-email-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86 PTI entry trampolines all map to the same physical page. If that is
reflected in the program headers of /proc/kcore, then do the same for the
copy of kcore.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/symbol-elf.c | 53 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 584966913aeb..29770ea61768 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1390,6 +1390,7 @@ struct phdr_data {
 	u64 addr;
 	u64 len;
 	struct list_head node;
+	struct phdr_data *remaps;
 };
 
 struct sym_data {
@@ -1597,16 +1598,62 @@ static int kcore_copy__read_maps(struct kcore_copy_info *kci, Elf *elf)
 	return 0;
 }
 
+static void kcore_copy__find_remaps(struct kcore_copy_info *kci)
+{
+	struct phdr_data *p, *k = NULL;
+	u64 kend;
+
+	if (!kci->stext)
+		return;
+
+	/* Find phdr that corresponds to the kernel map (contains stext) */
+	kcore_copy__for_each_phdr(kci, p) {
+		u64 pend = p->addr + p->len - 1;
+
+		if (p->addr <= kci->stext && pend >= kci->stext) {
+			k = p;
+			break;
+		}
+	}
+
+	if (!k)
+		return;
+
+	kend = k->offset + k->len;
+
+	/* Find phdrs that remap the kernel */
+	kcore_copy__for_each_phdr(kci, p) {
+		u64 pend = p->offset + p->len;
+
+		if (p == k)
+			continue;
+
+		if (p->offset >= k->offset && pend <= kend)
+			p->remaps = k;
+	}
+}
+
 static void kcore_copy__layout(struct kcore_copy_info *kci)
 {
 	struct phdr_data *p;
 	off_t rel = 0;
 
+	kcore_copy__find_remaps(kci);
+
 	kcore_copy__for_each_phdr(kci, p) {
-		p->rel = rel;
-		rel += p->len;
+		if (!p->remaps) {
+			p->rel = rel;
+			rel += p->len;
+		}
 		kci->phnum += 1;
 	}
+
+	kcore_copy__for_each_phdr(kci, p) {
+		struct phdr_data *k = p->remaps;
+
+		if (k)
+			p->rel = p->offset - k->offset + k->rel;
+	}
 }
 
 static int kcore_copy__calc_maps(struct kcore_copy_info *kci, const char *dir,
@@ -1821,6 +1868,8 @@ int kcore_copy(const char *from_dir, const char *to_dir)
 	kcore_copy__for_each_phdr(&kci, p) {
 		off_t offs = p->rel + offset;
 
+		if (p->remaps)
+			continue;
 		if (copy_bytes(kcore.fd, p->offset, extract.fd, offs, p->len))
 			goto out_extract_close;
 	}
-- 
1.9.1
