Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C280EC1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75A9B20C0E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMIwKWpc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75A9B20C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388065AbeGKUuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 16:50:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:37608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbeGKUuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 16:50:54 -0400
Received: from jouet.localdomain (unknown [71.46.56.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D13CA20C0C;
        Wed, 11 Jul 2018 20:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531341888;
        bh=s7o3yWcs0XsAxJH+bgNrC8wtHB6H2nh7dlPYRjCo7uE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mMIwKWpcQSgi0dDzlFCc/P75CCEQNV9bSLUb1A8h/LzJo5yKGn3t5GMHjnLhI/cMM
         pBlbbrc/5o18uOuNTpb1pJl4nHaGPyJcSQfmtw/lvCQFUKac6vteTwKcDcJiVJ9foO
         SQJuycprHRqsQfjbt2Fks2jwfGap05SzTQrce1+g=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jeremy Cline <jeremy@jcline.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Herton Krzesinski <herton@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 02/14] perf scripts python: Add Python 3 support to Core.py
Date:   Wed, 11 Jul 2018 16:42:53 -0400
Message-Id: <20180711204305.12924-3-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180711204305.12924-1-acme@kernel.org>
References: <20180711204305.12924-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeremy Cline <jeremy@jcline.org>

Support both Python 2 and Python 3 in Core.py. This should have no
functional change.

Signed-off-by: Jeremy Cline <jeremy@jcline.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Herton Krzesinski <herton@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/0100016341a72ebe-e572899e-f445-4765-98f0-c314935727f9-000000@email.amazonses.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../python/Perf-Trace-Util/lib/Perf/Trace/Core.py  | 40 +++++++++-------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Core.py b/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Core.py
index 38dfb720fb6f..54ace2f6bc36 100644
--- a/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Core.py
+++ b/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Core.py
@@ -31,10 +31,8 @@ def flag_str(event_name, field_name, value):
     string = ""
 
     if flag_fields[event_name][field_name]:
-	print_delim = 0
-        keys = flag_fields[event_name][field_name]['values'].keys()
-        keys.sort()
-        for idx in keys:
+        print_delim = 0
+        for idx in sorted(flag_fields[event_name][field_name]['values']):
             if not value and not idx:
                 string += flag_fields[event_name][field_name]['values'][idx]
                 break
@@ -51,14 +49,12 @@ def symbol_str(event_name, field_name, value):
     string = ""
 
     if symbolic_fields[event_name][field_name]:
-        keys = symbolic_fields[event_name][field_name]['values'].keys()
-        keys.sort()
-        for idx in keys:
+        for idx in sorted(symbolic_fields[event_name][field_name]['values']):
             if not value and not idx:
-		string = symbolic_fields[event_name][field_name]['values'][idx]
+                string = symbolic_fields[event_name][field_name]['values'][idx]
                 break
-	    if (value == idx):
-		string = symbolic_fields[event_name][field_name]['values'][idx]
+            if (value == idx):
+                string = symbolic_fields[event_name][field_name]['values'][idx]
                 break
 
     return string
@@ -74,19 +70,17 @@ def trace_flag_str(value):
     string = ""
     print_delim = 0
 
-    keys = trace_flags.keys()
-
-    for idx in keys:
-	if not value and not idx:
-	    string += "NONE"
-	    break
-
-	if idx and (value & idx) == idx:
-	    if print_delim:
-		string += " | ";
-	    string += trace_flags[idx]
-	    print_delim = 1
-	    value &= ~idx
+    for idx in trace_flags:
+        if not value and not idx:
+            string += "NONE"
+            break
+
+        if idx and (value & idx) == idx:
+            if print_delim:
+                string += " | ";
+            string += trace_flags[idx]
+            print_delim = 1
+            value &= ~idx
 
     return string
 
-- 
2.14.4

