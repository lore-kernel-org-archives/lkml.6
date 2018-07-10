Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD95C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DB5F20936
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:27:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DB5F20936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733140AbeGJS1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:27:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36706 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733117AbeGJS1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:27:33 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9D33E808255B;
        Tue, 10 Jul 2018 18:27:22 +0000 (UTC)
Received: from cervelo.rdu.redhat.com (dhcp129-44.rdu.redhat.com [10.13.129.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 73D291C5A6;
        Tue, 10 Jul 2018 18:27:22 +0000 (UTC)
From:   William Cohen <wcohen@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, William Cohen <wcohen@redhat.com>
Subject: [PATCH] Check jvmti_agent snprintf return value to avoid build failures with GCC-8.1.1
Date:   Tue, 10 Jul 2018 14:27:16 -0400
Message-Id: <20180710182716.21801-1-wcohen@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 10 Jul 2018 18:27:22 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 10 Jul 2018 18:27:22 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'wcohen@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Newer versions of GCC perform static analysis to determine whether
string truncation is possible with functions such as snprintf and
provide a warning if truncation could occur.  The make for
jvmti_agent.c uses the compiler option that treats any compiler
warnings as compiler errors.  For GCC-8.1.1 in Fedora 28 this causes
the build to fail.  The return value of the snprint is now checked to
ensure snprintf produced a NULL-terminated string.  If the string for
the path is invalid, the code does attempt to use the string.

Signed-off-by: William Cohen <wcohen@redhat.com>
---
 tools/perf/jvmti/jvmti_agent.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/jvmti/jvmti_agent.c b/tools/perf/jvmti/jvmti_agent.c
index 0c6d1002b524..30f14eafe4b3 100644
--- a/tools/perf/jvmti/jvmti_agent.c
+++ b/tools/perf/jvmti/jvmti_agent.c
@@ -227,7 +227,7 @@ void *jvmti_open(void)
 {
 	char dump_path[PATH_MAX];
 	struct jitheader header;
-	int fd;
+	int retlen, fd;
 	FILE *fp;
 
 	init_arch_timestamp();
@@ -249,7 +249,10 @@ void *jvmti_open(void)
 	/*
 	 * jitdump file name
 	 */
-	snprintf(dump_path, PATH_MAX, "%s/jit-%i.dump", jit_path, getpid());
+	retlen = snprintf(dump_path, PATH_MAX, "%s/jit-%i.dump",
+			  jit_path, getpid());
+	if (retlen <= 0 || ((int) sizeof(dump_path)) <= retlen)
+		return NULL;
 
 	fd = open(dump_path, O_CREAT|O_TRUNC|O_RDWR, 0666);
 	if (fd == -1)
-- 
2.17.1

