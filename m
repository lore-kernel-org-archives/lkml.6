Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D92C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A15320827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:15:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A15320827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388654AbeKGEmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 23:42:00 -0500
Received: from terminus.zytor.com ([198.137.202.136]:54485 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730386AbeKGEl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 23:41:59 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wA6JFBFD911570
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 6 Nov 2018 11:15:12 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wA6JFBUk911565;
        Tue, 6 Nov 2018 11:15:11 -0800
Date:   Tue, 6 Nov 2018 11:15:11 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-5ed4419d47f8ba6bbccd8e3203276b3c39a792b7@git.kernel.org>
Cc:     mingo@kernel.org, adrian.hunter@intel.com, hpa@zytor.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, acme@redhat.com, jolsa@redhat.com
Reply-To: mingo@kernel.org, adrian.hunter@intel.com, tglx@linutronix.de,
          hpa@zytor.com, linux-kernel@vger.kernel.org, acme@redhat.com,
          ak@linux.intel.com, jolsa@redhat.com
In-Reply-To: <20181104151238.15947-2-adrian.hunter@intel.com>
References: <20181104151238.15947-2-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf scripts python: exported-sql-viewer.py: Fall
 back to /usr/local/lib/libxed.so
Git-Commit-ID: 5ed4419d47f8ba6bbccd8e3203276b3c39a792b7
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

Commit-ID:  5ed4419d47f8ba6bbccd8e3203276b3c39a792b7
Gitweb:     https://git.kernel.org/tip/5ed4419d47f8ba6bbccd8e3203276b3c39a792b7
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Sun, 4 Nov 2018 17:12:35 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 5 Nov 2018 14:51:31 -0300

perf scripts python: exported-sql-viewer.py: Fall back to /usr/local/lib/libxed.so

Fall back to /usr/local/lib/libxed.so to cater for distributions that do
not have /usr/local/lib in the library path by default.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20181104151238.15947-2-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/exported-sql-viewer.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 24cb0bd56afa..20cc8e7879b9 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -1929,7 +1929,12 @@ class XEDInstruction():
 class LibXED():
 
 	def __init__(self):
-		self.libxed = CDLL("libxed.so")
+		try:
+			self.libxed = CDLL("libxed.so")
+		except:
+			self.libxed = None
+		if not self.libxed:
+			self.libxed = CDLL("/usr/local/lib/libxed.so")
 
 		self.xed_tables_init = self.libxed.xed_tables_init
 		self.xed_tables_init.restype = None
