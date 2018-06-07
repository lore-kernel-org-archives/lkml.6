Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id aRiEGJFAGVv2YwAAmS7hNA
	; Thu, 07 Jun 2018 14:27:27 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 47ECB607E7; Thu,  7 Jun 2018 14:27:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 950276063F;
	Thu,  7 Jun 2018 14:27:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 950276063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933494AbeFGO1Z (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:27:25 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40186 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933406AbeFGO0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:26:45 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbT-0005Zx-Kz; Thu, 07 Jun 2018 15:09:28 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbB-0003Bc-Jp; Thu, 07 Jun 2018 15:09:09 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Tony Luck" <tony.luck@intel.com>,
        "Corentin Labbe" <clabbe@baylibre.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.844521797@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 324/410] ia64: convert unwcheck.py to python3
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Corentin Labbe <clabbe@baylibre.com>

commit bd5edbe677948d0883f59d9625c444818d5284b1 upstream.

Since my system use python3 as default, arch/ia64/scripts/unwcheck.py no
longer run.

This patch convert it to the python3 syntax.
I have ran it with python2/python3 while printing values of
start/end/rlen_sum which could be impacted by this change and I see no difference.

Fixes: 94a47083522e ("scripts: change scripts to use system python instead of env")
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/ia64/scripts/unwcheck.py | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/arch/ia64/scripts/unwcheck.py
+++ b/arch/ia64/scripts/unwcheck.py
@@ -15,7 +15,7 @@ import re
 import sys
 
 if len(sys.argv) != 2:
-    print "Usage: %s FILE" % sys.argv[0]
+    print("Usage: %s FILE" % sys.argv[0])
     sys.exit(2)
 
 readelf = os.getenv("READELF", "readelf")
@@ -28,7 +28,7 @@ def check_func (func, slots, rlen_sum):
         global num_errors
         num_errors += 1
         if not func: func = "[%#x-%#x]" % (start, end)
-        print "ERROR: %s: %lu slots, total region length = %lu" % (func, slots, rlen_sum)
+        print("ERROR: %s: %lu slots, total region length = %lu" % (func, slots, rlen_sum))
     return
 
 num_funcs = 0
@@ -42,23 +42,23 @@ for line in os.popen("%s -u %s" % (reade
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
