Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC474C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A732420827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:19:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A732420827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388643AbeKGEp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 23:45:59 -0500
Received: from terminus.zytor.com ([198.137.202.136]:56909 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387804AbeKGEp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 23:45:59 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wA6JJ87h912820
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 6 Nov 2018 11:19:08 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wA6JJ8tg912816;
        Tue, 6 Nov 2018 11:19:08 -0800
Date:   Tue, 6 Nov 2018 11:19:08 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Gustavo Romero <tipbot@zytor.com>
Message-ID: <tip-mvpxxxy7wnzaj74cq75muw3f@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        hpa@zytor.com, gromero@linux.vnet.ibm.com, jolsa@kernel.org,
        acme@redhat.com
Reply-To: acme@redhat.com, gromero@linux.vnet.ibm.com, jolsa@kernel.org,
          tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: Fix undefined symbol scnprintf in
 libperf-jvmti.so
Git-Commit-ID: 6ac2226229d931153331a93d90655a3de05b9290
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

Commit-ID:  6ac2226229d931153331a93d90655a3de05b9290
Gitweb:     https://git.kernel.org/tip/6ac2226229d931153331a93d90655a3de05b9290
Author:     Gustavo Romero <gromero@linux.vnet.ibm.com>
AuthorDate: Thu, 1 Nov 2018 20:13:21 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 5 Nov 2018 16:28:00 -0300

perf tools: Fix undefined symbol scnprintf in libperf-jvmti.so

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
---
 tools/perf/jvmti/jvmti_agent.c | 49 ++++++++++++++++++++++++++++++++----------
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
