Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C658C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FC642252A
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVGwPoIb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FC642252A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388488AbeKOI3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:29:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:36812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbeKOI3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:29:47 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2442B2252A;
        Wed, 14 Nov 2018 22:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234282;
        bh=bvD5LbzOWtMYoYxJe90SSzXT6YTa+HyA9li0sVe/sBw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FVGwPoIbsn5XdNZI43OLTLeD0h8yGGva10cFPOAEeDh4aHNbB+sIduIx2fxKAzjmR
         Itbc81U029Su2oL+PhTMXw+lfeK5rt7KLpeXi8l0q1ISUCsnfLGXp6StdpkVJbwbfC
         9pRPSH2EKahDtuWTVS6+aQdCNhEXXt12fErXBLAA=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Gustavo Romero <gromero@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 41/59] perf tools: Fix undefined symbol scnprintf in libperf-jvmti.so
Date:   Wed, 14 Nov 2018 17:23:13 -0500
Message-Id: <20181114222335.99339-41-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222335.99339-1-sashal@kernel.org>
References: <20181114222335.99339-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gustavo Romero <gromero@linux.vnet.ibm.com>

[ Upstream commit 6ac2226229d931153331a93d90655a3de05b9290 ]

Currently jvmti agent can not be used because function scnprintf is not
present in the agent libperf-jvmti.so. As a result the JVM when using
such agent to record JITed code profiling information will fail on
looking up scnprintf:

  java: symbol lookup error: lib/libperf-jvmti.so: undefined symbol: scnprintf

This commit fixes that by reverting to the use of snprintf, that can be
looked up, instead of scnprintf, adding a proper check for the returned
value in order to print a better error message when the jitdump file
pathname is too long. Checking the returned value also helps to comply
with some recent gcc versions, like gcc8, which will fail due to
truncated writing checks related to the -Werror=format-truncation= flag.

Signed-off-by: Gustavo Romero <gromero@linux.vnet.ibm.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
LPU-Reference: 1541117601-18937-2-git-send-email-gromero@linux.vnet.ibm.com
Link: https://lkml.kernel.org/n/tip-mvpxxxy7wnzaj74cq75muw3f@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/jvmti/jvmti_agent.c | 49 ++++++++++++++++++++++++++--------
 1 file changed, 38 insertions(+), 11 deletions(-)

diff --git a/tools/perf/jvmti/jvmti_agent.c b/tools/perf/jvmti/jvmti_agent.c
index ac1bcdc17dae..f7eb63cbbc65 100644
--- a/tools/perf/jvmti/jvmti_agent.c
+++ b/tools/perf/jvmti/jvmti_agent.c
@@ -125,7 +125,7 @@ perf_get_timestamp(void)
 }
 
 static int
-debug_cache_init(void)
+create_jit_cache_dir(void)
 {
 	char str[32];
 	char *base, *p;
@@ -144,8 +144,13 @@ debug_cache_init(void)
 
 	strftime(str, sizeof(str), JIT_LANG"-jit-%Y%m%d", &tm);
 
-	snprintf(jit_path, PATH_MAX - 1, "%s/.debug/", base);
-
+	ret = snprintf(jit_path, PATH_MAX, "%s/.debug/", base);
+	if (ret >= PATH_MAX) {
+		warnx("jvmti: cannot generate jit cache dir because %s/.debug/"
+			" is too long, please check the cwd, JITDUMPDIR, and"
+			" HOME variables", base);
+		return -1;
+	}
 	ret = mkdir(jit_path, 0755);
 	if (ret == -1) {
 		if (errno != EEXIST) {
@@ -154,20 +159,32 @@ debug_cache_init(void)
 		}
 	}
 
-	snprintf(jit_path, PATH_MAX - 1, "%s/.debug/jit", base);
+	ret = snprintf(jit_path, PATH_MAX, "%s/.debug/jit", base);
+	if (ret >= PATH_MAX) {
+		warnx("jvmti: cannot generate jit cache dir because"
+			" %s/.debug/jit is too long, please check the cwd,"
+			" JITDUMPDIR, and HOME variables", base);
+		return -1;
+	}
 	ret = mkdir(jit_path, 0755);
 	if (ret == -1) {
 		if (errno != EEXIST) {
-			warn("cannot create jit cache dir %s", jit_path);
+			warn("jvmti: cannot create jit cache dir %s", jit_path);
 			return -1;
 		}
 	}
 
-	snprintf(jit_path, PATH_MAX - 1, "%s/.debug/jit/%s.XXXXXXXX", base, str);
-
+	ret = snprintf(jit_path, PATH_MAX, "%s/.debug/jit/%s.XXXXXXXX", base, str);
+	if (ret >= PATH_MAX) {
+		warnx("jvmti: cannot generate jit cache dir because"
+			" %s/.debug/jit/%s.XXXXXXXX is too long, please check"
+			" the cwd, JITDUMPDIR, and HOME variables",
+			base, str);
+		return -1;
+	}
 	p = mkdtemp(jit_path);
 	if (p != jit_path) {
-		warn("cannot create jit cache dir %s", jit_path);
+		warn("jvmti: cannot create jit cache dir %s", jit_path);
 		return -1;
 	}
 
@@ -228,7 +245,7 @@ void *jvmti_open(void)
 {
 	char dump_path[PATH_MAX];
 	struct jitheader header;
-	int fd;
+	int fd, ret;
 	FILE *fp;
 
 	init_arch_timestamp();
@@ -245,12 +262,22 @@ void *jvmti_open(void)
 
 	memset(&header, 0, sizeof(header));
 
-	debug_cache_init();
+	/*
+	 * jitdump file dir
+	 */
+	if (create_jit_cache_dir() < 0)
+		return NULL;
 
 	/*
 	 * jitdump file name
 	 */
-	scnprintf(dump_path, PATH_MAX, "%s/jit-%i.dump", jit_path, getpid());
+	ret = snprintf(dump_path, PATH_MAX, "%s/jit-%i.dump", jit_path, getpid());
+	if (ret >= PATH_MAX) {
+		warnx("jvmti: cannot generate jitdump file full path because"
+			" %s/jit-%i.dump is too long, please check the cwd,"
+			" JITDUMPDIR, and HOME variables", jit_path, getpid());
+		return NULL;
+	}
 
 	fd = open(dump_path, O_CREAT|O_TRUNC|O_RDWR, 0666);
 	if (fd == -1)
-- 
2.17.1

