Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0CFC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3320720863
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbfBHR4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:56:44 -0500
Received: from mga11.intel.com ([192.55.52.93]:40705 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727977AbfBHR4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:56:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Feb 2019 09:56:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,348,1544515200"; 
   d="scan'208";a="142716507"
Received: from otc-lr-04.jf.intel.com ([10.54.39.129])
  by fmsmga004.fm.intel.com with ESMTP; 08 Feb 2019 09:56:39 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, jolsa@redhat.com, namhyung@kernel.org,
        ak@linux.intel.com, luto@amacapital.net, vbabka@suse.cz,
        will.deacon@arm.com, kirill@shutemov.name,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V5 06/14] perf mem: Factor out a function to generate sort order
Date:   Fri,  8 Feb 2019 09:55:01 -0800
Message-Id: <1549648509-12704-6-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549648509-12704-1-git-send-email-kan.liang@linux.intel.com>
References: <1549648509-12704-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Now, "--phys-data" is the only option which impacts the sort order.
A simple "if else" is enough to handle the option. But there will be
more options added, e.g. "--data-page-size", which also impact the sort
order. The code will become too complex to be maintained.

Divide the sort order string into several small pieces.
The first piece is always the default sort string for LOAD/STORE.
Appends the specific sort string if related option is applied.

No functional change.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

No changes since V4

 tools/perf/builtin-mem.c | 41 +++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 57393e9..0647bd7 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -273,11 +273,35 @@ static int report_raw_events(struct perf_mem *mem)
 	perf_session__delete(session);
 	return ret;
 }
+static char *get_sort_order(struct perf_mem *mem)
+{
+	bool has_extra_options = mem->phys_addr ? true : false;
+	char sort[128];
+
+	/*
+	 * there is no weight (cost) associated with stores, so don't print
+	 * the column
+	 */
+	if (!(mem->operation & MEM_OPERATION_LOAD)) {
+		strcpy(sort, "--sort=mem,sym,dso,symbol_daddr,"
+			     "dso_daddr,tlb,locked");
+	} else if (has_extra_options) {
+		strcpy(sort, "--sort=local_weight,mem,sym,dso,symbol_daddr,"
+			     "dso_daddr,snoop,tlb,locked");
+	} else
+		return NULL;
+
+	if (mem->phys_addr)
+		strcat(sort, ",phys_daddr");
+
+	return strdup(sort);
+}
 
 static int report_events(int argc, const char **argv, struct perf_mem *mem)
 {
 	const char **rep_argv;
 	int ret, i = 0, j, rep_argc;
+	char *new_sort_order;
 
 	if (mem->dump_raw)
 		return report_raw_events(mem);
@@ -291,20 +315,9 @@ static int report_events(int argc, const char **argv, struct perf_mem *mem)
 	rep_argv[i++] = "--mem-mode";
 	rep_argv[i++] = "-n"; /* display number of samples */
 
-	/*
-	 * there is no weight (cost) associated with stores, so don't print
-	 * the column
-	 */
-	if (!(mem->operation & MEM_OPERATION_LOAD)) {
-		if (mem->phys_addr)
-			rep_argv[i++] = "--sort=mem,sym,dso,symbol_daddr,"
-					"dso_daddr,tlb,locked,phys_daddr";
-		else
-			rep_argv[i++] = "--sort=mem,sym,dso,symbol_daddr,"
-					"dso_daddr,tlb,locked";
-	} else if (mem->phys_addr)
-		rep_argv[i++] = "--sort=local_weight,mem,sym,dso,symbol_daddr,"
-				"dso_daddr,snoop,tlb,locked,phys_daddr";
+	new_sort_order = get_sort_order(mem);
+	if (new_sort_order)
+		rep_argv[i++] = new_sort_order;
 
 	for (j = 1; j < argc; j++, i++)
 		rep_argv[i] = argv[j];
-- 
2.7.4

