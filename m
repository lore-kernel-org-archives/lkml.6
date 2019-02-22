Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45947C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 207EA20700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfBVXG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 18:06:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:52510 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726595AbfBVXG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 18:06:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3B928B60F;
        Fri, 22 Feb 2019 23:06:56 +0000 (UTC)
From:   Tony Jones <tonyj@suse.de>
To:     linux-kernel@vger.kernel.org
Cc:     linux-perf-users@vger.kernel.org, acme@kernel.org,
        Tony Jones <tonyj@suse.de>,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH 09/15] perf script python: add Python3 support to powerpc-hcalls.py
Date:   Fri, 22 Feb 2019 15:06:13 -0800
Message-Id: <20190222230619.17887-10-tonyj@suse.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222230619.17887-1-tonyj@suse.de>
References: <20190222230619.17887-1-tonyj@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support both Python2 and Python3 in the powerpc-hcalls.py script

There may be differences in the ordering of output lines due to
differences in dictionary ordering etc.  However the format within lines
should be unchanged.

The use of 'from __future__' implies the minimum supported Python2 version
is now v2.6

Signed-off-by: Tony Jones <tonyj@suse.de>
Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 tools/perf/scripts/python/powerpc-hcalls.py | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/tools/perf/scripts/python/powerpc-hcalls.py b/tools/perf/scripts/python/powerpc-hcalls.py
index 00e0e7476e55..8b78dc790adb 100644
--- a/tools/perf/scripts/python/powerpc-hcalls.py
+++ b/tools/perf/scripts/python/powerpc-hcalls.py
@@ -4,6 +4,8 @@
 #
 # Hypervisor call statisics
 
+from __future__ import print_function
+
 import os
 import sys
 
@@ -149,7 +151,7 @@ hcall_table = {
 }
 
 def hcall_table_lookup(opcode):
-	if (hcall_table.has_key(opcode)):
+	if (opcode in hcall_table):
 		return hcall_table[opcode]
 	else:
 		return opcode
@@ -157,8 +159,8 @@ def hcall_table_lookup(opcode):
 print_ptrn = '%-28s%10s%10s%10s%10s'
 
 def trace_end():
-	print print_ptrn % ('hcall', 'count', 'min(ns)', 'max(ns)', 'avg(ns)')
-	print '-' * 68
+	print(print_ptrn % ('hcall', 'count', 'min(ns)', 'max(ns)', 'avg(ns)'))
+	print('-' * 68)
 	for opcode in output:
 		h_name = hcall_table_lookup(opcode)
 		time = output[opcode]['time']
@@ -166,14 +168,14 @@ def trace_end():
 		min_t = output[opcode]['min']
 		max_t = output[opcode]['max']
 
-		print print_ptrn % (h_name, cnt, min_t, max_t, time/cnt)
+		print(print_ptrn % (h_name, cnt, min_t, max_t, time//cnt))
 
 def powerpc__hcall_exit(name, context, cpu, sec, nsec, pid, comm, callchain,
 			opcode, retval):
-	if (d_enter.has_key(cpu) and d_enter[cpu].has_key(opcode)):
+	if (cpu in d_enter and opcode in d_enter[cpu]):
 		diff = nsecs(sec, nsec) - d_enter[cpu][opcode]
 
-		if (output.has_key(opcode)):
+		if (opcode in output):
 			output[opcode]['time'] += diff
 			output[opcode]['cnt'] += 1
 			if (output[opcode]['min'] > diff):
@@ -190,11 +192,11 @@ def powerpc__hcall_exit(name, context, cpu, sec, nsec, pid, comm, callchain,
 
 		del d_enter[cpu][opcode]
 #	else:
-#		print "Can't find matching hcall_enter event. Ignoring sample"
+#		print("Can't find matching hcall_enter event. Ignoring sample")
 
 def powerpc__hcall_entry(event_name, context, cpu, sec, nsec, pid, comm,
 			 callchain, opcode):
-		if (d_enter.has_key(cpu)):
+		if (cpu in d_enter):
 			d_enter[cpu][opcode] = nsecs(sec, nsec)
 		else:
 			d_enter[cpu] = {opcode: nsecs(sec, nsec)}
-- 
2.20.1

