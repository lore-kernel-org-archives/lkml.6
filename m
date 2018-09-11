Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A89C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 11:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC65F20839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 11:46:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC65F20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbeIKQpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 12:45:50 -0400
Received: from mga06.intel.com ([134.134.136.31]:6783 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbeIKQpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 12:45:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2018 04:46:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,360,1531810800"; 
   d="scan'208";a="89010234"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.98])
  by fmsmga001.fm.intel.com with ESMTP; 11 Sep 2018 04:46:49 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] perf script python: Fix export-to-postgresql.py occasional failure
Date:   Tue, 11 Sep 2018 14:45:03 +0300
Message-Id: <20180911114504.28516-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180911114504.28516-1-adrian.hunter@intel.com>
References: <20180911114504.28516-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Occasional export failures were found to be caused by truncating 64-bit
pointers to 32-bits. Fix by explicitly setting types for all ctype
arguments and results.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
---
 tools/perf/scripts/python/export-to-postgresql.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/scripts/python/export-to-postgresql.py b/tools/perf/scripts/python/export-to-postgresql.py
index efcaf6cac2eb..e46f51b17513 100644
--- a/tools/perf/scripts/python/export-to-postgresql.py
+++ b/tools/perf/scripts/python/export-to-postgresql.py
@@ -204,14 +204,23 @@ from ctypes import *
 libpq = CDLL("libpq.so.5")
 PQconnectdb = libpq.PQconnectdb
 PQconnectdb.restype = c_void_p
+PQconnectdb.argtypes = [ c_char_p ]
 PQfinish = libpq.PQfinish
+PQfinish.argtypes = [ c_void_p ]
 PQstatus = libpq.PQstatus
+PQstatus.restype = c_int
+PQstatus.argtypes = [ c_void_p ]
 PQexec = libpq.PQexec
 PQexec.restype = c_void_p
+PQexec.argtypes = [ c_void_p, c_char_p ]
 PQresultStatus = libpq.PQresultStatus
+PQresultStatus.restype = c_int
+PQresultStatus.argtypes = [ c_void_p ]
 PQputCopyData = libpq.PQputCopyData
+PQputCopyData.restype = c_int
 PQputCopyData.argtypes = [ c_void_p, c_void_p, c_int ]
 PQputCopyEnd = libpq.PQputCopyEnd
+PQputCopyEnd.restype = c_int
 PQputCopyEnd.argtypes = [ c_void_p, c_void_p ]
 
 sys.path.append(os.environ['PERF_EXEC_PATH'] + \
-- 
2.17.1

