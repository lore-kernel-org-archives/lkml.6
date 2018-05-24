Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755123AbeEXFnR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 01:43:17 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40409 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755106AbeEXFnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 01:43:15 -0400
Date: Wed, 23 May 2018 22:42:53 -0700
From: tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-c9dd1d894958b81a329ec01e7dd03b92eca52789@git.kernel.org>
Cc: peterz@infradead.org, ak@linux.intel.com, tglx@linutronix.de,
        acme@redhat.com, luto@kernel.org, dave.hansen@linux.intel.com,
        adrian.hunter@intel.com, mingo@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, jolsa@redhat.com,
        alexander.shishkin@linux.intel.com, joro@8bytes.org
Reply-To: alexander.shishkin@linux.intel.com, hpa@zytor.com, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, joro@8bytes.org, adrian.hunter@intel.com,
        mingo@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        ak@linux.intel.com, acme@redhat.com, dave.hansen@linux.intel.com,
        luto@kernel.org
In-Reply-To: <1526986485-6562-13-git-send-email-adrian.hunter@intel.com>
References: <1526986485-6562-13-git-send-email-adrian.hunter@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf kcore_copy: Calculate offset from phnum
Git-Commit-ID: c9dd1d894958b81a329ec01e7dd03b92eca52789
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

Commit-ID:  c9dd1d894958b81a329ec01e7dd03b92eca52789
Gitweb:     https://git.kernel.org/tip/c9dd1d894958b81a329ec01e7dd03b92eca52789
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Tue, 22 May 2018 13:54:40 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 23 May 2018 10:26:41 -0300

perf kcore_copy: Calculate offset from phnum

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
