Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCC2C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 718A220879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbfAVLgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 06:36:01 -0500
Received: from terminus.zytor.com ([198.137.202.136]:34929 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbfAVLgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 06:36:01 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0MBZrTp2929670
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 22 Jan 2019 03:35:54 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0MBZrws2929667;
        Tue, 22 Jan 2019 03:35:53 -0800
Date:   Tue, 22 Jan 2019 03:35:53 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-5q50q9w458yawgxf9ez54jbp@git.kernel.org>
Cc:     ehabkost@redhat.com, thiago.macieira@intel.com, jolsa@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, acme@redhat.com,
        adrian.hunter@intel.com, namhyung@kernel.org, mingo@kernel.org,
        tglx@linutronix.de
Reply-To: namhyung@kernel.org, adrian.hunter@intel.com, mingo@kernel.org,
          tglx@linutronix.de, ehabkost@redhat.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com, jolsa@kernel.org,
          thiago.macieira@intel.com, acme@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf python: Remove -fstack-clash-protection when
 building with some clang versions
Git-Commit-ID: 94ec1eb711db69be1414b56b3160b816e86a5c5b
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20190122113553.dquq9_Oje21AuRQWNnBx4kP8t5cBAr6U-39vGxdoU1Y@z>

Commit-ID:  94ec1eb711db69be1414b56b3160b816e86a5c5b
Gitweb:     https://git.kernel.org/tip/94ec1eb711db69be1414b56b3160b816e86a5c5b
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 18 Jan 2019 11:34:15 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 18 Jan 2019 11:38:09 -0300

perf python: Remove -fstack-clash-protection when building with some clang versions

These options are not present in some (all?) clang versions, so when we
build for a distro that has a gcc new enough to have these options and
that the distro python build config settings use them but clang doesn't
support, b00m.

This is the case with fedora rawhide (now gearing towards f30), so check
if clang has the  and remove the missing ones from CFLAGS.

Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Thiago Macieira <thiago.macieira@intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-5q50q9w458yawgxf9ez54jbp@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/setup.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index 63f758c655d5..64d1f36dee99 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -17,6 +17,8 @@ if cc == "clang":
             vars[var] = sub("-mcet", "", vars[var])
         if not clang_has_option("-fcf-protection"):
             vars[var] = sub("-fcf-protection", "", vars[var])
+        if not clang_has_option("-fstack-clash-protection"):
+            vars[var] = sub("-fstack-clash-protection", "", vars[var])
 
 from distutils.core import setup, Extension
 
