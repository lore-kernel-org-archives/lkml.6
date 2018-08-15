Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3AFC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 15:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BF65208E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 15:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKavpyHl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BF65208E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730739AbeHOSBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 14:01:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:51086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729528AbeHOSBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 14:01:11 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E4EE208E0;
        Wed, 15 Aug 2018 15:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534345719;
        bh=9BU7cdRnpuEyfQsc+dN5zvaQQzUjH8eLvBoTcGBOA5Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fKavpyHlgnodX0dHgZPOw1oNsXWsB/mBts4ZsTFe0WA6QYnFJHwZtgGj1SagPbzrk
         i9b9a4+e8JemWh3kMWkcg8Rbm2qBBE4w0l9ZpTy8s6f+zia53uTZrSInd2HBM5Vel9
         5AMZc8Yd61sF16MAa1sn1s8n01rAIKdA0ksukh6o=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 31/35] perf python: Remove -mcet and -fcf-protection when building with clang
Date:   Wed, 15 Aug 2018 12:06:07 -0300
Message-Id: <20180815150611.32080-32-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180815150611.32080-1-acme@kernel.org>
References: <20180815150611.32080-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

These options are not present in older clang versions, so when we build
for a distro that has a gcc new enough to have these options and that
the distro python build config settings use them but clang doesn't
support, b00m.

This is the case with fedora 28 and rawhide, so check if clang has the
options and remove the missing ones from CFLAGS.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-7asds7yn6gzg6ns1lw17ukul@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/setup.py | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index 001be4f9d3b9..97efbcad076e 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -1,12 +1,20 @@
 #!/usr/bin/python
 
 from os import getenv
+from subprocess import Popen, PIPE
+from re import sub
+
+def clang_has_option(option):
+    return [o for o in Popen(['clang', option], stderr=PIPE).stderr.readlines() if "unknown argument" in o] == [ ]
 
 cc = getenv("CC")
 if cc == "clang":
     from _sysconfigdata import build_time_vars
-    from re import sub
     build_time_vars["CFLAGS"] = sub("-specs=[^ ]+", "", build_time_vars["CFLAGS"])
+    if not clang_has_option("-mcet"):
+        build_time_vars["CFLAGS"] = sub("-mcet", "", build_time_vars["CFLAGS"])
+    if not clang_has_option("-fcf-protection"):
+        build_time_vars["CFLAGS"] = sub("-fcf-protection", "", build_time_vars["CFLAGS"])
 
 from distutils.core import setup, Extension
 
-- 
2.14.4

