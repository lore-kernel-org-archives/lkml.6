Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AD2C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B39A12147D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:19:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B39A12147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730235AbeJEXTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:19:01 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36331 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729594AbeJEXTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:19:00 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w95GJUhL3206334
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 5 Oct 2018 09:19:30 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w95GJUtE3206331;
        Fri, 5 Oct 2018 09:19:30 -0700
Date:   Fri, 5 Oct 2018 09:19:30 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-d005efe18db0b4a123dd92ea8e77e27aee8f99fd@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, jolsa@redhat.com, tglx@linutronix.de,
        mingo@kernel.org, hpa@zytor.com, acme@redhat.com,
        adrian.hunter@intel.com
Reply-To: hpa@zytor.com, acme@redhat.com, adrian.hunter@intel.com,
          mingo@kernel.org, tglx@linutronix.de, jolsa@redhat.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <20180911114504.28516-3-adrian.hunter@intel.com>
References: <20180911114504.28516-3-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf script python: Fix export-to-sqlite.py
 sample columns
Git-Commit-ID: d005efe18db0b4a123dd92ea8e77e27aee8f99fd
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

Commit-ID:  d005efe18db0b4a123dd92ea8e77e27aee8f99fd
Gitweb:     https://git.kernel.org/tip/d005efe18db0b4a123dd92ea8e77e27aee8f99fd
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Tue, 11 Sep 2018 14:45:04 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 25 Sep 2018 11:37:05 -0300

perf script python: Fix export-to-sqlite.py sample columns

With the "branches" export option, not all sample columns are exported.
However the unwanted columns are not at the end of the tuple, as assumed
by the code. Fix by taking the first 15 and last 3 values, instead of
the first 18.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/20180911114504.28516-3-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/export-to-sqlite.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/export-to-sqlite.py b/tools/perf/scripts/python/export-to-sqlite.py
index f827bf77e9d2..e4bb82c8aba9 100644
--- a/tools/perf/scripts/python/export-to-sqlite.py
+++ b/tools/perf/scripts/python/export-to-sqlite.py
@@ -440,7 +440,11 @@ def branch_type_table(*x):
 
 def sample_table(*x):
 	if branches:
-		bind_exec(sample_query, 18, x)
+		for xx in x[0:15]:
+			sample_query.addBindValue(str(xx))
+		for xx in x[19:22]:
+			sample_query.addBindValue(str(xx))
+		do_query_(sample_query)
 	else:
 		bind_exec(sample_query, 22, x)
 
