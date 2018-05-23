Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935024AbeEWUWf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 16:22:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:34644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934849AbeEWUWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 16:22:31 -0400
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
Subject: [PATCH 18/18] perf kcore_copy: Amend the offset of sections that remap kernel text
Date: Wed, 23 May 2018 17:21:06 -0300
Message-Id: <20180523202106.17286-19-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180523202106.17286-1-acme@kernel.org>
References: <20180523202106.17286-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

x86 PTI entry trampolines all map to the same physical page. If that is
reflected in the program headers of /proc/kcore, then do the same for the
copy of kcore.

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
Link: http://lkml.kernel.org/r/1526986485-6562-18-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.14.3
