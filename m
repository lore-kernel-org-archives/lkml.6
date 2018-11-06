Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A8FC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FB0F2086C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrjQ14Ce"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FB0F2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388230AbeKFVcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 16:32:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:33930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388204AbeKFVcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 16:32:09 -0500
Received: from jouet.infradead.org (unknown [189.40.102.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A848D2083D;
        Tue,  6 Nov 2018 12:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541506035;
        bh=beBFKsOA1/LtW5vToKwq5Lz7+SIhItcAFg3TKZ0BrhU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PrjQ14CeLrXc2SFOl+555y/o7IDiMGelr5nlBDgr4Q+RN+WlRRw7ry/aRwOPXKyhc
         71asdAdo19MlvtwuNIBzssY3s7QWlzkouPr4RCkVJJfIzJXA8mKDbY8p1rMcqA8Bnv
         lLeIoU8VZJX5S09awXmaS3n5obPc65O1YdJtBPEo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 13/18] perf scripts python: exported-sql-viewer.py: Fix table find when table re-ordered
Date:   Tue,  6 Nov 2018 09:06:07 -0300
Message-Id: <20181106120612.8262-14-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181106120612.8262-1-acme@kernel.org>
References: <20181106120612.8262-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

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
-- 
2.14.4

