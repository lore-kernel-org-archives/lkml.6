Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F52C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B71EF20700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbfBVXGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 18:06:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:52442 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725900AbfBVXGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 18:06:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DC6C6B64D;
        Fri, 22 Feb 2019 23:06:47 +0000 (UTC)
From:   Tony Jones <tonyj@suse.de>
To:     linux-kernel@vger.kernel.org
Cc:     linux-perf-users@vger.kernel.org, acme@kernel.org,
        Tony Jones <tonyj@suse.de>,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 06/15] perf script python: add Python3 support to intel-pt-events.py
Date:   Fri, 22 Feb 2019 15:06:10 -0800
Message-Id: <20190222230619.17887-7-tonyj@suse.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222230619.17887-1-tonyj@suse.de>
References: <20190222230619.17887-1-tonyj@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support both Python2 and Python3 in the intel-pt-events.py script

There may be differences in the ordering of output lines due to
differences in dictionary ordering etc.  However the format within lines
should be unchanged.

Fix space/tab inconsistency as python3 enforces consistency.

The use of 'from __future__' implies the minimum supported Python2 version
is now v2.6

Signed-off-by: Tony Jones <tonyj@suse.de>
Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/scripts/python/intel-pt-events.py | 138 ++++++++++---------
 1 file changed, 70 insertions(+), 68 deletions(-)

diff --git a/tools/perf/scripts/python/intel-pt-events.py b/tools/perf/scripts/python/intel-pt-events.py
index b19172d673af..aef54566af61 100644
--- a/tools/perf/scripts/python/intel-pt-events.py
+++ b/tools/perf/scripts/python/intel-pt-events.py
@@ -10,79 +10,81 @@
 # FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
 # more details.
 
+from __future__ import print_function
+
 import os
 import sys
 import struct
 
 sys.path.append(os.environ['PERF_EXEC_PATH'] + \
-	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
+        '/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
 
 # These perf imports are not used at present
 #from perf_trace_context import *
 #from Core import *
 
 def trace_begin():
-	print "Intel PT Power Events and PTWRITE"
+        print("Intel PT Power Events and PTWRITE")
 
 def trace_end():
-	print "End"
+        print("End")
 
 def trace_unhandled(event_name, context, event_fields_dict):
-		print ' '.join(['%s=%s'%(k,str(v))for k,v in sorted(event_fields_dict.items())])
+        print(' '.join(['%s=%s'%(k,str(v))for k,v in sorted(event_fields_dict.items())]))
 
 def print_ptwrite(raw_buf):
-	data = struct.unpack_from("<IQ", raw_buf)
-	flags = data[0]
-	payload = data[1]
-	exact_ip = flags & 1
-	print "IP: %u payload: %#x" % (exact_ip, payload),
+        data = struct.unpack_from("<IQ", raw_buf)
+        flags = data[0]
+        payload = data[1]
+        exact_ip = flags & 1
+        print("IP: %u payload: %#x" % (exact_ip, payload), end='')
 
 def print_cbr(raw_buf):
-	data = struct.unpack_from("<BBBBII", raw_buf)
-	cbr = data[0]
-	f = (data[4] + 500) / 1000
-	p = ((cbr * 1000 / data[2]) + 5) / 10
-	print "%3u  freq: %4u MHz  (%3u%%)" % (cbr, f, p),
+        data = struct.unpack_from("<BBBBII", raw_buf)
+        cbr = data[0]
+        f = (data[4] + 500) / 1000
+        p = ((cbr * 1000 / data[2]) + 5) / 10
+        print("%3u  freq: %4u MHz  (%3u%%)" % (cbr, f, p), end='')
 
 def print_mwait(raw_buf):
-	data = struct.unpack_from("<IQ", raw_buf)
-	payload = data[1]
-	hints = payload & 0xff
-	extensions = (payload >> 32) & 0x3
-	print "hints: %#x extensions: %#x" % (hints, extensions),
+        data = struct.unpack_from("<IQ", raw_buf)
+        payload = data[1]
+        hints = payload & 0xff
+        extensions = (payload >> 32) & 0x3
+        print("hints: %#x extensions: %#x" % (hints, extensions), end='')
 
 def print_pwre(raw_buf):
-	data = struct.unpack_from("<IQ", raw_buf)
-	payload = data[1]
-	hw = (payload >> 7) & 1
-	cstate = (payload >> 12) & 0xf
-	subcstate = (payload >> 8) & 0xf
-	print "hw: %u cstate: %u sub-cstate: %u" % (hw, cstate, subcstate),
+        data = struct.unpack_from("<IQ", raw_buf)
+        payload = data[1]
+        hw = (payload >> 7) & 1
+        cstate = (payload >> 12) & 0xf
+        subcstate = (payload >> 8) & 0xf
+        print("hw: %u cstate: %u sub-cstate: %u" % (hw, cstate, subcstate), end='')
 
 def print_exstop(raw_buf):
-	data = struct.unpack_from("<I", raw_buf)
-	flags = data[0]
-	exact_ip = flags & 1
-	print "IP: %u" % (exact_ip),
+        data = struct.unpack_from("<I", raw_buf)
+        flags = data[0]
+        exact_ip = flags & 1
+        print("IP: %u" % (exact_ip), end='')
 
 def print_pwrx(raw_buf):
-	data = struct.unpack_from("<IQ", raw_buf)
-	payload = data[1]
-	deepest_cstate = payload & 0xf
-	last_cstate = (payload >> 4) & 0xf
-	wake_reason = (payload >> 8) & 0xf
-	print "deepest cstate: %u last cstate: %u wake reason: %#x" % (deepest_cstate, last_cstate, wake_reason),
+        data = struct.unpack_from("<IQ", raw_buf)
+        payload = data[1]
+        deepest_cstate = payload & 0xf
+        last_cstate = (payload >> 4) & 0xf
+        wake_reason = (payload >> 8) & 0xf
+        print("deepest cstate: %u last cstate: %u wake reason: %#x" % (deepest_cstate, last_cstate, wake_reason), end='')
 
 def print_common_start(comm, sample, name):
-	ts = sample["time"]
-	cpu = sample["cpu"]
-	pid = sample["pid"]
-	tid = sample["tid"]
-	print "%16s %5u/%-5u [%03u] %9u.%09u %7s:" % (comm, pid, tid, cpu, ts / 1000000000, ts %1000000000, name),
+        ts = sample["time"]
+        cpu = sample["cpu"]
+        pid = sample["pid"]
+        tid = sample["tid"]
+        print("%16s %5u/%-5u [%03u] %9u.%09u %7s:" % (comm, pid, tid, cpu, ts / 1000000000, ts %1000000000, name), end='')
 
 def print_common_ip(sample, symbol, dso):
-	ip = sample["ip"]
-	print "%16x %s (%s)" % (ip, symbol, dso)
+        ip = sample["ip"]
+        print("%16x %s (%s)" % (ip, symbol, dso))
 
 def process_event(param_dict):
         event_attr = param_dict["attr"]
@@ -92,37 +94,37 @@ def process_event(param_dict):
         name       = param_dict["ev_name"]
 
         # Symbol and dso info are not always resolved
-        if (param_dict.has_key("dso")):
+        if "dso" in param_dict:
                 dso = param_dict["dso"]
         else:
                 dso = "[unknown]"
 
-        if (param_dict.has_key("symbol")):
+        if "symbol" in param_dict:
                 symbol = param_dict["symbol"]
         else:
                 symbol = "[unknown]"
 
-	if name == "ptwrite":
-		print_common_start(comm, sample, name)
-		print_ptwrite(raw_buf)
-		print_common_ip(sample, symbol, dso)
-	elif name == "cbr":
-		print_common_start(comm, sample, name)
-		print_cbr(raw_buf)
-		print_common_ip(sample, symbol, dso)
-	elif name == "mwait":
-		print_common_start(comm, sample, name)
-		print_mwait(raw_buf)
-		print_common_ip(sample, symbol, dso)
-	elif name == "pwre":
-		print_common_start(comm, sample, name)
-		print_pwre(raw_buf)
-		print_common_ip(sample, symbol, dso)
-	elif name == "exstop":
-		print_common_start(comm, sample, name)
-		print_exstop(raw_buf)
-		print_common_ip(sample, symbol, dso)
-	elif name == "pwrx":
-		print_common_start(comm, sample, name)
-		print_pwrx(raw_buf)
-		print_common_ip(sample, symbol, dso)
+        if name == "ptwrite":
+                print_common_start(comm, sample, name)
+                print_ptwrite(raw_buf)
+                print_common_ip(sample, symbol, dso)
+        elif name == "cbr":
+                print_common_start(comm, sample, name)
+                print_cbr(raw_buf)
+                print_common_ip(sample, symbol, dso)
+        elif name == "mwait":
+                print_common_start(comm, sample, name)
+                print_mwait(raw_buf)
+                print_common_ip(sample, symbol, dso)
+        elif name == "pwre":
+                print_common_start(comm, sample, name)
+                print_pwre(raw_buf)
+                print_common_ip(sample, symbol, dso)
+        elif name == "exstop":
+                print_common_start(comm, sample, name)
+                print_exstop(raw_buf)
+                print_common_ip(sample, symbol, dso)
+        elif name == "pwrx":
+                print_common_start(comm, sample, name)
+                print_pwrx(raw_buf)
+                print_common_ip(sample, symbol, dso)
-- 
2.20.1

