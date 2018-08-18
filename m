Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C742DC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C59A218A8
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:58:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C59A218A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbeHRPFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 11:05:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49943 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbeHRPFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 11:05:55 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7IBwJ0O1291690
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Aug 2018 04:58:19 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7IBwJAN1291687;
        Sat, 18 Aug 2018 04:58:19 -0700
Date:   Sat, 18 Aug 2018 04:58:19 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-7asds7yn6gzg6ns1lw17ukul@git.kernel.org>
Cc:     namhyung@kernel.org, mingo@kernel.org, dsahern@gmail.com,
        tglx@linutronix.de, jolsa@kernel.org, adrian.hunter@intel.com,
        hpa@zytor.com, acme@redhat.com, linux-kernel@vger.kernel.org,
        wangnan0@huawei.com
Reply-To: namhyung@kernel.org, mingo@kernel.org, dsahern@gmail.com,
          tglx@linutronix.de, jolsa@kernel.org, adrian.hunter@intel.com,
          hpa@zytor.com, acme@redhat.com, linux-kernel@vger.kernel.org,
          wangnan0@huawei.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf python: Remove -mcet and -fcf-protection
 when building with clang
Git-Commit-ID: 5508672d7f4949f15c316ffd947228f130498534
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  5508672d7f4949f15c316ffd947228f130498534
Gitweb:     https://git.kernel.org/tip/5508672d7f4949f15c316ffd947228f130498534
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 14 Aug 2018 18:00:40 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 14 Aug 2018 18:50:20 -0300

perf python: Remove -mcet and -fcf-protection when building with clang

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
 
