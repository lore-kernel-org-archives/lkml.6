Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E13C6787A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 00:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 622E221479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 00:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4hR7e4D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 622E221479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbeJIIJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 04:09:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:42370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727056AbeJIIJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 04:09:44 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CC5421476;
        Tue,  9 Oct 2018 00:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539046523;
        bh=mkYykeBR8KGsh2gdZVWW9Djc7sUxlMy7Zqm17pynDPc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R4hR7e4D7ckhhuBYgFzI03/77u46rfIGsXqGu8pfQcazqlGjdv4VWSj3FEVbpYcB5
         c/tyveBgFZJ9kCotbYBmQqYovqu0S6nFLjo5r75aOFKpzGwOlnFw4BKyL80OJSm0iT
         LKtJOMEy5FCdYgsUZ/gxjr06dJjgZVn3XLd3gwq4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Eduardo Habkost <ehabkost@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 10/12] perf python: More portable way to make CFLAGS work with clang
Date:   Mon,  8 Oct 2018 21:54:25 -0300
Message-Id: <20181009005427.6607-11-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181009005427.6607-1-acme@kernel.org>
References: <20181009005427.6607-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eduardo Habkost <ehabkost@redhat.com>

The existing code that tries to make CFLAGS compatible with clang
doesn't work with Python 3.

Instead of trying to touch _sysconfigdata.build_time_vars directly,
change the dictionary returned by disutils.sysconfig.get_config_vars().
This works on both Python 2 and Python 3.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/20181005204058.7966-3-ehabkost@redhat.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.14.4

