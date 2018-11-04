Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A74ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 15:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0959F2082A
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 15:14:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0959F2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730427AbeKEA3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 19:29:54 -0500
Received: from mga14.intel.com ([192.55.52.115]:64597 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730369AbeKEA3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 19:29:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2018 07:14:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,464,1534834800"; 
   d="scan'208";a="105303536"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.130])
  by orsmga001.jf.intel.com with ESMTP; 04 Nov 2018 07:14:32 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 4/4] perf scripts python: exported-sql-viewer.py: Fix table find when table re-ordered
Date:   Sun,  4 Nov 2018 17:12:38 +0200
Message-Id: <20181104151238.15947-5-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181104151238.15947-1-adrian.hunter@intel.com>
References: <20181104151238.15947-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Table rows can be re-ordered by selecting a column to sort by. After
re-ordering, the "find" operation was highlighting the wrong row, fix it.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/scripts/python/exported-sql-viewer.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index c2fcf6c5237a..f278ce5ebab7 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -1975,7 +1975,7 @@ class TableWindow(QMdiSubWindow, ResizeColumnsToContentsBase):
 	def FindDone(self, row):
 		self.find_bar.Idle()
 		if row >= 0:
-			self.view.setCurrentIndex(self.model.index(row, 0, QModelIndex()))
+			self.view.setCurrentIndex(self.model.mapFromSource(self.data_model.index(row, 0, QModelIndex())))
 		else:
 			self.find_bar.NotFound()
 
@@ -2188,6 +2188,8 @@ For PostgreSQL databases, information_schema.tables/views/columns are included.
 Ctrl-F displays a Find bar which finds substrings by either an exact match or a regular expression match.
 Refer to Python documentation for the regular expression syntax.
 All columns are searched, but only currently fetched rows are searched.
+<p>N.B. Results are found in id order, so if the table is re-ordered, find-next and find-previous
+will go to the next/previous result in id order, instead of display order.
 """
 
 # Help window
-- 
2.17.1

