Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FFEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7369206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbfBVXG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 18:06:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:52480 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726595AbfBVXGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 18:06:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 992FFB017;
        Fri, 22 Feb 2019 23:06:50 +0000 (UTC)
From:   Tony Jones <tonyj@suse.de>
To:     linux-kernel@vger.kernel.org
Cc:     linux-perf-users@vger.kernel.org, acme@kernel.org,
        Tony Jones <tonyj@suse.de>,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Subject: [PATCH 07/15] perf script python: add Python3 support to mem-phys-addr.py
Date:   Fri, 22 Feb 2019 15:06:11 -0800
Message-Id: <20190222230619.17887-8-tonyj@suse.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222230619.17887-1-tonyj@suse.de>
References: <20190222230619.17887-1-tonyj@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support both Python2 and Python3 in the mem-phys-addr.py script

There may be differences in the ordering of output lines due to
differences in dictionary ordering etc.  However the format within lines
should be unchanged.

The use of 'from __future__' implies the minimum supported Python2 version
is now v2.6

Signed-off-by: Tony Jones <tonyj@suse.de>
Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
---
 tools/perf/scripts/python/mem-phys-addr.py | 24 +++++++++++++---------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/tools/perf/scripts/python/mem-phys-addr.py b/tools/perf/scripts/python/mem-phys-addr.py
index ebee2c5ae496..fb0bbcbfa0f0 100644
--- a/tools/perf/scripts/python/mem-phys-addr.py
+++ b/tools/perf/scripts/python/mem-phys-addr.py
@@ -4,6 +4,8 @@
 # Copyright (c) 2018, Intel Corporation.
 
 from __future__ import division
+from __future__ import print_function
+
 import os
 import sys
 import struct
@@ -31,21 +33,23 @@ def parse_iomem():
 	for i, j in enumerate(f):
 		m = re.split('-|:',j,2)
 		if m[2].strip() == 'System RAM':
-			system_ram.append(long(m[0], 16))
-			system_ram.append(long(m[1], 16))
+			system_ram.append(int(m[0], 16))
+			system_ram.append(int(m[1], 16))
 		if m[2].strip() == 'Persistent Memory':
-			pmem.append(long(m[0], 16))
-			pmem.append(long(m[1], 16))
+			pmem.append(int(m[0], 16))
+			pmem.append(int(m[1], 16))
 
 def print_memory_type():
-	print "Event: %s" % (event_name)
-	print "%-40s  %10s  %10s\n" % ("Memory type", "count", "percentage"),
-	print "%-40s  %10s  %10s\n" % ("----------------------------------------", \
+	print("Event: %s" % (event_name))
+	print("%-40s  %10s  %10s\n" % ("Memory type", "count", "percentage"), end='')
+	print("%-40s  %10s  %10s\n" % ("----------------------------------------",
 					"-----------", "-----------"),
+                                        end='');
 	total = sum(load_mem_type_cnt.values())
 	for mem_type, count in sorted(load_mem_type_cnt.most_common(), \
-					key = lambda(k, v): (v, k), reverse = True):
-		print "%-40s  %10d  %10.1f%%\n" % (mem_type, count, 100 * count / total),
+					key = lambda kv: (kv[1], kv[0]), reverse = True):
+		print("%-40s  %10d  %10.1f%%\n" % (mem_type, count, 100 * count / total),
+                        end='')
 
 def trace_begin():
 	parse_iomem()
@@ -80,7 +84,7 @@ def find_memory_type(phys_addr):
 	f.seek(0, 0)
 	for j in f:
 		m = re.split('-|:',j,2)
-		if long(m[0], 16) <= phys_addr <= long(m[1], 16):
+		if int(m[0], 16) <= phys_addr <= int(m[1], 16):
 			return m[2]
 	return "N/A"
 
-- 
2.20.1

