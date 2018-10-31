Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CD6C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EAC62082E
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pzA+BNRR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EAC62082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729958AbeKABoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 21:44:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:58876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729341AbeKABoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 21:44:24 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4312D20821;
        Wed, 31 Oct 2018 16:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541004337;
        bh=pHhyCxnvPJkUb5M0fPjxuXqu+lVahX4RXNSvAui8AOA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pzA+BNRRv0mdRDpD5BRPymKwfaShQysXitdTvyjcfmvWaomxTNCvTo/WLfNbltaet
         LrxWVwcyQyhrpVR0Okj4hvksnJjm9niixKTTSxbslPHPvDUAuIKyKarfiTvlLjLbz5
         pzDV0SOWL4NlU6mZ4X4a24No/4CqrDP2PsbBMjGY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Benjamin Peterson <benjamin@python.org>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 04/28] perf beauty: Introduce strarray__scnprintf_flags()
Date:   Wed, 31 Oct 2018 13:44:44 -0300
Message-Id: <20181031164508.4784-5-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181031164508.4784-1-acme@kernel.org>
References: <20181031164508.4784-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Generalizing pkey_alloc__scnprintf_access_rights(), so that we can use
it with other flags-like arguments, such as mount's mountflags argument.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Benjamin Peterson <benjamin@python.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-o3ymi3104m8moaz9865g09w9@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/beauty.h     |  1 +
 tools/perf/trace/beauty/pkey_alloc.c | 27 ++++++++++++++++-----------
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 2570152d3909..a1806c4f3ccd 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -24,6 +24,7 @@ struct strarray {
 }
 
 size_t strarray__scnprintf(struct strarray *sa, char *bf, size_t size, const char *intfmt, int val);
+size_t strarray__scnprintf_flags(struct strarray *sa, char *bf, size_t size, unsigned long flags);
 
 struct trace;
 struct thread;
diff --git a/tools/perf/trace/beauty/pkey_alloc.c b/tools/perf/trace/beauty/pkey_alloc.c
index d3e5188a9bef..1b8ed4cac815 100644
--- a/tools/perf/trace/beauty/pkey_alloc.c
+++ b/tools/perf/trace/beauty/pkey_alloc.c
@@ -9,31 +9,28 @@
 #include <linux/kernel.h>
 #include <linux/log2.h>
 
-static size_t pkey_alloc__scnprintf_access_rights(int access_rights, char *bf, size_t size)
+size_t strarray__scnprintf_flags(struct strarray *sa, char *bf, size_t size, unsigned long flags)
 {
 	int i, printed = 0;
 
-#include "trace/beauty/generated/pkey_alloc_access_rights_array.c"
-	static DEFINE_STRARRAY(pkey_alloc_access_rights);
-
-	if (access_rights == 0) {
-		const char *s = strarray__pkey_alloc_access_rights.entries[0];
+	if (flags == 0) {
+		const char *s = sa->entries[0];
 		if (s)
 			return scnprintf(bf, size, "%s", s);
 		return scnprintf(bf, size, "%d", 0);
 	}
 
-	for (i = 1; i < strarray__pkey_alloc_access_rights.nr_entries; ++i) {
-		int bit = 1 << (i - 1);
+	for (i = 1; i < sa->nr_entries; ++i) {
+		unsigned long bit = 1UL << (i - 1);
 
-		if (!(access_rights & bit))
+		if (!(flags & bit))
 			continue;
 
 		if (printed != 0)
 			printed += scnprintf(bf + printed, size - printed, "|");
 
-		if (strarray__pkey_alloc_access_rights.entries[i] != NULL)
-			printed += scnprintf(bf + printed, size - printed, "%s", strarray__pkey_alloc_access_rights.entries[i]);
+		if (sa->entries[i] != NULL)
+			printed += scnprintf(bf + printed, size - printed, "%s", sa->entries[i]);
 		else
 			printed += scnprintf(bf + printed, size - printed, "0x%#", bit);
 	}
@@ -41,6 +38,14 @@ static size_t pkey_alloc__scnprintf_access_rights(int access_rights, char *bf, s
 	return printed;
 }
 
+static size_t pkey_alloc__scnprintf_access_rights(int access_rights, char *bf, size_t size)
+{
+#include "trace/beauty/generated/pkey_alloc_access_rights_array.c"
+	static DEFINE_STRARRAY(pkey_alloc_access_rights);
+
+	return strarray__scnprintf_flags(&strarray__pkey_alloc_access_rights, bf, size, access_rights);
+}
+
 size_t syscall_arg__scnprintf_pkey_alloc_access_rights(char *bf, size_t size, struct syscall_arg *arg)
 {
 	unsigned long cmd = arg->val;
-- 
2.14.4

