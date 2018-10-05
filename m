Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 411AAC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1220D208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:19:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1220D208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730453AbeJEXSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:18:30 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45163 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728967AbeJEXS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:18:29 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w95GIugu3206241
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 5 Oct 2018 09:18:56 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w95GItk93206238;
        Fri, 5 Oct 2018 09:18:55 -0700
Date:   Fri, 5 Oct 2018 09:18:55 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-25e11700b54c7b6b5ebfc4361981dae12299557b@git.kernel.org>
Cc:     jolsa@redhat.com, acme@redhat.com, mingo@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, hpa@zytor.com
Reply-To: tglx@linutronix.de, mingo@kernel.org, jolsa@redhat.com,
          acme@redhat.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
          adrian.hunter@intel.com
In-Reply-To: <20180911114504.28516-2-adrian.hunter@intel.com>
References: <20180911114504.28516-2-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf script python: Fix export-to-postgresql.py
 occasional failure
Git-Commit-ID: 25e11700b54c7b6b5ebfc4361981dae12299557b
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

Commit-ID:  25e11700b54c7b6b5ebfc4361981dae12299557b
Gitweb:     https://git.kernel.org/tip/25e11700b54c7b6b5ebfc4361981dae12299557b
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Tue, 11 Sep 2018 14:45:03 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 25 Sep 2018 11:33:06 -0300

perf script python: Fix export-to-postgresql.py occasional failure

Occasional export failures were found to be caused by truncating 64-bit
pointers to 32-bits. Fix by explicitly setting types for all ctype
arguments and results.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/20180911114504.28516-2-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
