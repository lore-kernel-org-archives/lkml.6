Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7689BC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ABB120869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:17:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ABB120869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730735AbeKGEnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 23:43:42 -0500
Received: from terminus.zytor.com ([198.137.202.136]:36635 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730386AbeKGEnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 23:43:42 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wA6JGrdE911992
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 6 Nov 2018 11:16:53 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wA6JGrC0911988;
        Tue, 6 Nov 2018 11:16:53 -0800
Date:   Tue, 6 Nov 2018 11:16:53 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-35fa1cee21e34f43db928d022610707d5a234faf@git.kernel.org>
Cc:     acme@redhat.com, hpa@zytor.com, jolsa@redhat.com, mingo@kernel.org,
        ak@linux.intel.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, adrian.hunter@intel.com
Reply-To: ak@linux.intel.com, jolsa@redhat.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          adrian.hunter@intel.com, acme@redhat.com, hpa@zytor.com
In-Reply-To: <20181104151238.15947-5-adrian.hunter@intel.com>
References: <20181104151238.15947-5-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf scripts python: exported-sql-viewer.py: Fix
 table find when table re-ordered
Git-Commit-ID: 35fa1cee21e34f43db928d022610707d5a234faf
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  35fa1cee21e34f43db928d022610707d5a234faf
Gitweb:     https://git.kernel.org/tip/35fa1cee21e34f43db928d022610707d5a234faf
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Sun, 4 Nov 2018 17:12:38 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 5 Nov 2018 14:53:00 -0300

perf scripts python: exported-sql-viewer.py: Fix table find when table re-ordered

Table rows can be re-ordered by selecting a column to sort by. After
re-ordering, the "find" operation was highlighting the wrong row, fix
it.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20181104151238.15947-5-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
