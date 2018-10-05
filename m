Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E3BC65BBE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C79F420875
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:41:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C79F420875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbeJFDl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 23:41:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58636 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728451AbeJFDl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 23:41:27 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1B5FE30001F0;
        Fri,  5 Oct 2018 20:41:05 +0000 (UTC)
Received: from localhost (ovpn-117-52.phx2.redhat.com [10.3.117.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9AFCB6249C;
        Fri,  5 Oct 2018 20:41:03 +0000 (UTC)
From:   Eduardo Habkost <ehabkost@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] perf: More portable way to make CFLAGS work with clang
Date:   Fri,  5 Oct 2018 17:40:58 -0300
Message-Id: <20181005204058.7966-3-ehabkost@redhat.com>
In-Reply-To: <20181005204058.7966-1-ehabkost@redhat.com>
References: <20181005204058.7966-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 05 Oct 2018 20:41:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing code that tries to make CFLAGS compatible with clang
doesn't work with Python 3.

Instead of trying to touch _sysconfigdata.build_time_vars
directly, change the dictionary returned by
disutils.sysconfig.get_config_vars().  This works on both Python
2 and Python 3.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tools/perf/util/setup.py | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index 261a55e7e1b2..63f758c655d5 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -9,12 +9,14 @@ def clang_has_option(option):
 
 cc = getenv("CC")
 if cc == "clang":
-    from _sysconfigdata import build_time_vars
-    build_time_vars["CFLAGS"] = sub("-specs=[^ ]+", "", build_time_vars["CFLAGS"])
-    if not clang_has_option("-mcet"):
-        build_time_vars["CFLAGS"] = sub("-mcet", "", build_time_vars["CFLAGS"])
-    if not clang_has_option("-fcf-protection"):
-        build_time_vars["CFLAGS"] = sub("-fcf-protection", "", build_time_vars["CFLAGS"])
+    from distutils.sysconfig import get_config_vars
+    vars = get_config_vars()
+    for var in ('CFLAGS', 'OPT'):
+        vars[var] = sub("-specs=[^ ]+", "", vars[var])
+        if not clang_has_option("-mcet"):
+            vars[var] = sub("-mcet", "", vars[var])
+        if not clang_has_option("-fcf-protection"):
+            vars[var] = sub("-fcf-protection", "", vars[var])
 
 from distutils.core import setup, Extension
 
-- 
2.18.0.rc1.1.g3f1ff2140

