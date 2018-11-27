Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC58C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B02720989
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:48:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B02720989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729701AbeK0TpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 14:45:22 -0500
Received: from mga11.intel.com ([192.55.52.93]:13616 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729580AbeK0TpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 14:45:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2018 00:48:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,286,1539673200"; 
   d="scan'208";a="277499301"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.130])
  by orsmga005.jf.intel.com with ESMTP; 27 Nov 2018 00:48:10 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] perf auxtrace: Alter addr_filter__entire_dso() to work if there are no symbols
Date:   Tue, 27 Nov 2018 10:46:34 +0200
Message-Id: <20181127084634.12469-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

addr_filter__entire_dso() uses the first and last symbols from a dso,
and so does not work when there are no symbols.  Alter it to filter the
whole file instead.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/auxtrace.c | 11 ++++-------
 tools/perf/util/dso.c      |  6 +++---
 tools/perf/util/dso.h      |  1 +
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 72d5ba2479bf..f69961c4a4f3 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1983,17 +1983,14 @@ static int find_dso_sym(struct dso *dso, const char *sym_name, u64 *start,
 
 static int addr_filter__entire_dso(struct addr_filter *filt, struct dso *dso)
 {
-	struct symbol *first_sym = dso__first_symbol(dso);
-	struct symbol *last_sym = dso__last_symbol(dso);
-
-	if (!first_sym || !last_sym) {
-		pr_err("Failed to determine filter for %s\nNo symbols found.\n",
+	if (dso__data_file_size(dso, NULL)) {
+		pr_err("Failed to determine filter for %s\nCannot determine file size.\n",
 		       filt->filename);
 		return -EINVAL;
 	}
 
-	filt->addr = first_sym->start;
-	filt->size = last_sym->end - first_sym->start;
+	filt->addr = 0;
+	filt->size = dso->data.file_size;
 
 	return 0;
 }
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index bbed90e5d9bb..721f3d583945 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -894,7 +894,7 @@ static ssize_t cached_read(struct dso *dso, struct machine *machine,
 	return r;
 }
 
-static int data_file_size(struct dso *dso, struct machine *machine)
+int dso__data_file_size(struct dso *dso, struct machine *machine)
 {
 	int ret = 0;
 	struct stat st;
@@ -943,7 +943,7 @@ static int data_file_size(struct dso *dso, struct machine *machine)
  */
 off_t dso__data_size(struct dso *dso, struct machine *machine)
 {
-	if (data_file_size(dso, machine))
+	if (dso__data_file_size(dso, machine))
 		return -1;
 
 	/* For now just estimate dso data size is close to file size */
@@ -953,7 +953,7 @@ off_t dso__data_size(struct dso *dso, struct machine *machine)
 static ssize_t data_read_offset(struct dso *dso, struct machine *machine,
 				u64 offset, u8 *data, ssize_t size)
 {
-	if (data_file_size(dso, machine))
+	if (dso__data_file_size(dso, machine))
 		return -1;
 
 	/* Check the offset sanity. */
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index c5380500bed4..8c8a7abe809d 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -322,6 +322,7 @@ int dso__data_get_fd(struct dso *dso, struct machine *machine);
 void dso__data_put_fd(struct dso *dso);
 void dso__data_close(struct dso *dso);
 
+int dso__data_file_size(struct dso *dso, struct machine *machine);
 off_t dso__data_size(struct dso *dso, struct machine *machine);
 ssize_t dso__data_read_offset(struct dso *dso, struct machine *machine,
 			      u64 offset, u8 *data, ssize_t size);
-- 
2.17.1

