Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967612AbeBNMTP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 07:19:15 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55167 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967501AbeBNMTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 07:19:13 -0500
X-Google-Smtp-Source: AH8x224T7OI3D09hn4u0YUidhf9qnweWrqCdudg2PA1qwTCQm8N3hApD4KjY5gRQMHiWjoi0oxXQlw==
From: Corentin Labbe <clabbe@baylibre.com>
To: fenghua.yu@intel.com, tony.luck@intel.com, dzickus@redhat.com,
        xiyou.wangcong@gmail.com, jarod@redhat.com, mmarek@suse.cz
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] ia64: convert unwcheck.py to python3
Date: Wed, 14 Feb 2018 12:19:06 +0000
Message-Id: <1518610746-23749-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since my system use python3 as default, arch/ia64/scripts/unwcheck.py no
longer run.

This patch convert it to the python3 syntax.
I have ran it with python2/python3 while printing values of
start/end/rlen_sum which could be impacted by this change and I see no difference.

Fixes: 94a47083522e ("scripts: change scripts to use system python instead of env")
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/ia64/scripts/unwcheck.py | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/ia64/scripts/unwcheck.py b/arch/ia64/scripts/unwcheck.py
index 89f3a1480a63..c55276e31b6b 100644
--- a/arch/ia64/scripts/unwcheck.py
+++ b/arch/ia64/scripts/unwcheck.py
@@ -16,7 +16,7 @@ import re
 import sys
 
 if len(sys.argv) != 2:
-    print "Usage: %s FILE" % sys.argv[0]
+    print("Usage: %s FILE" % sys.argv[0])
     sys.exit(2)
 
 readelf = os.getenv("READELF", "readelf")
@@ -29,7 +29,7 @@ def check_func (func, slots, rlen_sum):
         global num_errors
         num_errors += 1
         if not func: func = "[%#x-%#x]" % (start, end)
-        print "ERROR: %s: %lu slots, total region length = %lu" % (func, slots, rlen_sum)
+        print("ERROR: %s: %lu slots, total region length = %lu" % (func, slots, rlen_sum))
     return
 
 num_funcs = 0
@@ -43,23 +43,23 @@ for line in os.popen("%s -u %s" % (readelf, sys.argv[1])):
         check_func(func, slots, rlen_sum)
 
         func  = m.group(1)
-        start = long(m.group(2), 16)
-        end   = long(m.group(3), 16)
+        start = int(m.group(2), 16)
+        end   = int(m.group(3), 16)
         slots = 3 * (end - start) / 16
-        rlen_sum = 0L
+        rlen_sum = 0
         num_funcs += 1
     else:
         m = rlen_pattern.match(line)
         if m:
-            rlen_sum += long(m.group(1))
+            rlen_sum += int(m.group(1))
 check_func(func, slots, rlen_sum)
 
 if num_errors == 0:
-    print "No errors detected in %u functions." % num_funcs
+    print("No errors detected in %u functions." % num_funcs)
 else:
     if num_errors > 1:
         err="errors"
     else:
         err="error"
-    print "%u %s detected in %u functions." % (num_errors, err, num_funcs)
+    print("%u %s detected in %u functions." % (num_errors, err, num_funcs))
     sys.exit(1)
-- 
2.13.6
