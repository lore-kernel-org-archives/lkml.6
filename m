Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934866AbeEWUWP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 16:22:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:34356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934291AbeEWUWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 16:22:09 -0400
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
Subject: [PATCH 13/18] perf kcore_copy: Calculate offset from phnum
Date: Wed, 23 May 2018 17:21:01 -0300
Message-Id: <20180523202106.17286-14-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180523202106.17286-1-acme@kernel.org>
References: <20180523202106.17286-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

In preparation to add more program headers, calculate offset from the
number of phdrs.

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
Link: http://lkml.kernel.org/r/1526986485-6562-13-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol-elf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 4e7b71e8ac0e..4aec12102e19 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1682,7 +1682,7 @@ int kcore_copy(const char *from_dir, const char *to_dir)
 	struct kcore kcore;
 	struct kcore extract;
 	int idx = 0, err = -1;
-	off_t offset = page_size, sz, modules_offset = 0;
+	off_t offset, sz, modules_offset = 0;
 	struct kcore_copy_info kci = { .stext = 0, };
 	char kcore_filename[PATH_MAX];
 	char extract_filename[PATH_MAX];
@@ -1710,6 +1710,10 @@ int kcore_copy(const char *from_dir, const char *to_dir)
 	if (kcore__copy_hdr(&kcore, &extract, kci.phnum))
 		goto out_extract_close;
 
+	offset = gelf_fsize(extract.elf, ELF_T_EHDR, 1, EV_CURRENT) +
+		 gelf_fsize(extract.elf, ELF_T_PHDR, kci.phnum, EV_CURRENT);
+	offset = round_up(offset, page_size);
+
 	if (kcore__add_phdr(&extract, idx++, offset, kci.kernel_map.addr,
 			    kci.kernel_map.len))
 		goto out_extract_close;
-- 
2.14.3
