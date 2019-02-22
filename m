Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F093AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD7E4206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbfBVXHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 18:07:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:52556 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726595AbfBVXHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 18:07:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 16A12B60F;
        Fri, 22 Feb 2019 23:06:59 +0000 (UTC)
From:   Tony Jones <tonyj@suse.de>
To:     linux-kernel@vger.kernel.org
Cc:     linux-perf-users@vger.kernel.org, acme@kernel.org,
        Tony Jones <tonyj@suse.de>,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        Tom Zanussi <tzanussi@gmail.com>
Subject: [PATCH 10/15] perf script python: add Python3 support to sctop.py
Date:   Fri, 22 Feb 2019 15:06:14 -0800
Message-Id: <20190222230619.17887-11-tonyj@suse.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222230619.17887-1-tonyj@suse.de>
References: <20190222230619.17887-1-tonyj@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support both Python2 and Python3 in the sctop.py script

There may be differences in the ordering of output lines due to
differences in dictionary ordering etc.  However the format within lines
should be unchanged.

The use of 'from __future__' implies the minimum supported Python2 version
is now v2.6

Signed-off-by: Tony Jones <tonyj@suse.de>
Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Cc: Tom Zanussi <tzanussi@gmail.com>
---
 tools/perf/scripts/python/sctop.py | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/tools/perf/scripts/python/sctop.py b/tools/perf/scripts/python/sctop.py
index 61621b93affb..987ffae7c8ca 100644
--- a/tools/perf/scripts/python/sctop.py
+++ b/tools/perf/scripts/python/sctop.py
@@ -8,7 +8,14 @@
 # will be refreshed every [interval] seconds.  The default interval is
 # 3 seconds.
 
-import os, sys, thread, time
+from __future__ import print_function
+
+import os, sys, time
+
+try:
+        import thread
+except ImportError:
+        import _thread as thread
 
 sys.path.append(os.environ['PERF_EXEC_PATH'] + \
 	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
@@ -62,18 +69,19 @@ def print_syscall_totals(interval):
 	while 1:
 		clear_term()
 		if for_comm is not None:
-			print "\nsyscall events for %s:\n\n" % (for_comm),
+			print("\nsyscall events for %s:\n" % (for_comm))
 		else:
-			print "\nsyscall events:\n\n",
+			print("\nsyscall events:\n")
 
-		print "%-40s  %10s\n" % ("event", "count"),
-		print "%-40s  %10s\n" % ("----------------------------------------", \
-						 "----------"),
+		print("%-40s  %10s" % ("event", "count"))
+		print("%-40s  %10s" %
+                        ("----------------------------------------",
+                        "----------"))
 
-		for id, val in sorted(syscalls.iteritems(), key = lambda(k, v): (v, k), \
+		for id, val in sorted(syscalls.items(), key = lambda kv: (kv[1], kv[0]), \
 					      reverse = True):
 			try:
-				print "%-40s  %10d\n" % (syscall_name(id), val),
+				print("%-40s  %10d" % (syscall_name(id), val))
 			except TypeError:
 				pass
 		syscalls.clear()
-- 
2.20.1

