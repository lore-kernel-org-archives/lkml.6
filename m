Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEA8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FA2B20700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbfBVXGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 18:06:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:52370 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725900AbfBVXGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 18:06:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 67F53B017;
        Fri, 22 Feb 2019 23:06:39 +0000 (UTC)
From:   Tony Jones <tonyj@suse.de>
To:     linux-kernel@vger.kernel.org
Cc:     linux-perf-users@vger.kernel.org, acme@kernel.org,
        Tony Jones <tonyj@suse.de>,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Subject: [PATCH 03/15] perf script python: add Python3 support to event_analyzing_sample.py
Date:   Fri, 22 Feb 2019 15:06:07 -0800
Message-Id: <20190222230619.17887-4-tonyj@suse.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222230619.17887-1-tonyj@suse.de>
References: <20190222230619.17887-1-tonyj@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support both Python2 and Python3 in the event_analyzing_sample.py script

There may be differences in the ordering of output lines due to
differences in dictionary ordering etc.  However the format within lines
should be unchanged.

The use of 'from __future__' implies the minimum supported Python2 version
is now v2.6

Signed-off-by: Tony Jones <tonyj@suse.de>
Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
---
 .../scripts/python/event_analyzing_sample.py  | 48 ++++++++++---------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/tools/perf/scripts/python/event_analyzing_sample.py b/tools/perf/scripts/python/event_analyzing_sample.py
index 4e843b9864ec..f4c4c7963451 100644
--- a/tools/perf/scripts/python/event_analyzing_sample.py
+++ b/tools/perf/scripts/python/event_analyzing_sample.py
@@ -15,6 +15,8 @@
 # for a x86 HW PMU event: PEBS with load latency data.
 #
 
+from __future__ import print_function
+
 import os
 import sys
 import math
@@ -37,7 +39,7 @@ con = sqlite3.connect("/dev/shm/perf.db")
 con.isolation_level = None
 
 def trace_begin():
-	print "In trace_begin:\n"
+        print("In trace_begin:\n")
 
         #
         # Will create several tables at the start, pebs_ll is for PEBS data with
@@ -76,12 +78,12 @@ def process_event(param_dict):
         name       = param_dict["ev_name"]
 
         # Symbol and dso info are not always resolved
-        if (param_dict.has_key("dso")):
+        if ("dso" in param_dict):
                 dso = param_dict["dso"]
         else:
                 dso = "Unknown_dso"
 
-        if (param_dict.has_key("symbol")):
+        if ("symbol" in param_dict):
                 symbol = param_dict["symbol"]
         else:
                 symbol = "Unknown_symbol"
@@ -102,7 +104,7 @@ def insert_db(event):
                                 event.ip, event.status, event.dse, event.dla, event.lat))
 
 def trace_end():
-	print "In trace_end:\n"
+        print("In trace_end:\n")
         # We show the basic info for the 2 type of event classes
         show_general_events()
         show_pebs_ll()
@@ -123,29 +125,29 @@ def show_general_events():
         # Check the total record number in the table
         count = con.execute("select count(*) from gen_events")
         for t in count:
-                print "There is %d records in gen_events table" % t[0]
+                print("There is %d records in gen_events table" % t[0])
                 if t[0] == 0:
                         return
 
-        print "Statistics about the general events grouped by thread/symbol/dso: \n"
+        print("Statistics about the general events grouped by thread/symbol/dso: \n")
 
          # Group by thread
         commq = con.execute("select comm, count(comm) from gen_events group by comm order by -count(comm)")
-        print "\n%16s %8s %16s\n%s" % ("comm", "number", "histogram", "="*42)
+        print("\n%16s %8s %16s\n%s" % ("comm", "number", "histogram", "="*42))
         for row in commq:
-             print "%16s %8d     %s" % (row[0], row[1], num2sym(row[1]))
+             print("%16s %8d     %s" % (row[0], row[1], num2sym(row[1])))
 
         # Group by symbol
-        print "\n%32s %8s %16s\n%s" % ("symbol", "number", "histogram", "="*58)
+        print("\n%32s %8s %16s\n%s" % ("symbol", "number", "histogram", "="*58))
         symbolq = con.execute("select symbol, count(symbol) from gen_events group by symbol order by -count(symbol)")
         for row in symbolq:
-             print "%32s %8d     %s" % (row[0], row[1], num2sym(row[1]))
+             print("%32s %8d     %s" % (row[0], row[1], num2sym(row[1])))
 
         # Group by dso
-        print "\n%40s %8s %16s\n%s" % ("dso", "number", "histogram", "="*74)
+        print("\n%40s %8s %16s\n%s" % ("dso", "number", "histogram", "="*74))
         dsoq = con.execute("select dso, count(dso) from gen_events group by dso order by -count(dso)")
         for row in dsoq:
-             print "%40s %8d     %s" % (row[0], row[1], num2sym(row[1]))
+             print("%40s %8d     %s" % (row[0], row[1], num2sym(row[1])))
 
 #
 # This function just shows the basic info, and we could do more with the
@@ -156,35 +158,35 @@ def show_pebs_ll():
 
         count = con.execute("select count(*) from pebs_ll")
         for t in count:
-                print "There is %d records in pebs_ll table" % t[0]
+                print("There is %d records in pebs_ll table" % t[0])
                 if t[0] == 0:
                         return
 
-        print "Statistics about the PEBS Load Latency events grouped by thread/symbol/dse/latency: \n"
+        print("Statistics about the PEBS Load Latency events grouped by thread/symbol/dse/latency: \n")
 
         # Group by thread
         commq = con.execute("select comm, count(comm) from pebs_ll group by comm order by -count(comm)")
-        print "\n%16s %8s %16s\n%s" % ("comm", "number", "histogram", "="*42)
+        print("\n%16s %8s %16s\n%s" % ("comm", "number", "histogram", "="*42))
         for row in commq:
-             print "%16s %8d     %s" % (row[0], row[1], num2sym(row[1]))
+             print("%16s %8d     %s" % (row[0], row[1], num2sym(row[1])))
 
         # Group by symbol
-        print "\n%32s %8s %16s\n%s" % ("symbol", "number", "histogram", "="*58)
+        print("\n%32s %8s %16s\n%s" % ("symbol", "number", "histogram", "="*58))
         symbolq = con.execute("select symbol, count(symbol) from pebs_ll group by symbol order by -count(symbol)")
         for row in symbolq:
-             print "%32s %8d     %s" % (row[0], row[1], num2sym(row[1]))
+             print("%32s %8d     %s" % (row[0], row[1], num2sym(row[1])))
 
         # Group by dse
         dseq = con.execute("select dse, count(dse) from pebs_ll group by dse order by -count(dse)")
-        print "\n%32s %8s %16s\n%s" % ("dse", "number", "histogram", "="*58)
+        print("\n%32s %8s %16s\n%s" % ("dse", "number", "histogram", "="*58))
         for row in dseq:
-             print "%32s %8d     %s" % (row[0], row[1], num2sym(row[1]))
+             print("%32s %8d     %s" % (row[0], row[1], num2sym(row[1])))
 
         # Group by latency
         latq = con.execute("select lat, count(lat) from pebs_ll group by lat order by lat")
-        print "\n%32s %8s %16s\n%s" % ("latency", "number", "histogram", "="*58)
+        print("\n%32s %8s %16s\n%s" % ("latency", "number", "histogram", "="*58))
         for row in latq:
-             print "%32s %8d     %s" % (row[0], row[1], num2sym(row[1]))
+             print("%32s %8d     %s" % (row[0], row[1], num2sym(row[1])))
 
 def trace_unhandled(event_name, context, event_fields_dict):
-		print ' '.join(['%s=%s'%(k,str(v))for k,v in sorted(event_fields_dict.items())])
+        print(' '.join(['%s=%s'%(k,str(v))for k,v in sorted(event_fields_dict.items())]))
-- 
2.20.1

