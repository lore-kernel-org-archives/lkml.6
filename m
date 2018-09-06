Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1705CC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE93D2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:16:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE93D2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbeIFRwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:52:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44471 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729162AbeIFRwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:52:21 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86DGhlC305072
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:16:43 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86DGgBB305069;
        Thu, 6 Sep 2018 06:16:42 -0700
Date:   Thu, 6 Sep 2018 06:16:42 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-v3s85ra659tc40g1s1xaqoun@git.kernel.org>
Cc:     jolsa@kernel.org, tglx@linutronix.de, dsahern@gmail.com,
        hpa@zytor.com, namhyung@kernel.org, adrian.hunter@intel.com,
        wangnan0@huawei.com, linux-kernel@vger.kernel.org, acme@redhat.com,
        mingo@kernel.org
Reply-To: acme@redhat.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
          wangnan0@huawei.com, adrian.hunter@intel.com,
          namhyung@kernel.org, tglx@linutronix.de, jolsa@kernel.org,
          hpa@zytor.com, dsahern@gmail.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace beauty: Reorganize 'struct sockaddr *'
 beautifier
Git-Commit-ID: b043cb524d2892be75c78bc348e83863829d50a0
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

Commit-ID:  b043cb524d2892be75c78bc348e83863829d50a0
Gitweb:     https://git.kernel.org/tip/b043cb524d2892be75c78bc348e83863829d50a0
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 29 Aug 2018 17:11:33 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 15:52:20 -0300

perf trace beauty: Reorganize 'struct sockaddr *' beautifier

Use an array to multiplex by sockaddr->sa_family, this way adding new
families gets a bit easier and tidy.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-v3s85ra659tc40g1s1xaqoun@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/sockaddr.c | 60 +++++++++++++++++++++++++-------------
 1 file changed, 39 insertions(+), 21 deletions(-)

diff --git a/tools/perf/trace/beauty/sockaddr.c b/tools/perf/trace/beauty/sockaddr.c
index 3944a7d54d3c..71a79f72d9d9 100644
--- a/tools/perf/trace/beauty/sockaddr.c
+++ b/tools/perf/trace/beauty/sockaddr.c
@@ -17,34 +17,52 @@ static const char *socket_families[] = {
 };
 DEFINE_STRARRAY(socket_families);
 
+static size_t af_inet__scnprintf(struct sockaddr *sa, char *bf, size_t size)
+{
+	struct sockaddr_in *sin = (struct sockaddr_in *)sa;
+	char tmp[16];
+	return scnprintf(bf, size, ", port: %d, addr: %s", ntohs(sin->sin_port),
+			 inet_ntop(sin->sin_family, &sin->sin_addr, tmp, sizeof(tmp)));
+}
+
+static size_t af_inet6__scnprintf(struct sockaddr *sa, char *bf, size_t size)
+{
+	struct sockaddr_in6 *sin6 = (struct sockaddr_in6 *)sa;
+	u32 flowinfo = ntohl(sin6->sin6_flowinfo);
+	char tmp[512];
+	size_t printed = scnprintf(bf, size, ", port: %d, addr: %s", ntohs(sin6->sin6_port),
+				   inet_ntop(sin6->sin6_family, &sin6->sin6_addr, tmp, sizeof(tmp)));
+	if (flowinfo != 0)
+		printed += scnprintf(bf + printed, size - printed, ", flowinfo: %lu", flowinfo);
+	if (sin6->sin6_scope_id != 0)
+		printed += scnprintf(bf + printed, size - printed, ", scope_id: %lu", sin6->sin6_scope_id);
+
+	return printed;
+}
+
+static size_t af_local__scnprintf(struct sockaddr *sa, char *bf, size_t size)
+{
+	struct sockaddr_un *sun = (struct sockaddr_un *)sa;
+	return scnprintf(bf, size, ", path: %s", sun->sun_path);
+}
+
+static size_t (*af_scnprintfs[])(struct sockaddr *sa, char *bf, size_t size) = {
+	[AF_LOCAL] = af_local__scnprintf,
+	[AF_INET]  = af_inet__scnprintf,
+	[AF_INET6] = af_inet6__scnprintf,
+};
+
 static size_t syscall_arg__scnprintf_augmented_sockaddr(struct syscall_arg *arg, char *bf, size_t size)
 {
-	struct sockaddr_in *sin = (struct sockaddr_in *)arg->augmented.args;
+	struct sockaddr *sa = (struct sockaddr *)arg->augmented.args;
 	char family[32];
 	size_t printed;
 
-	strarray__scnprintf(&strarray__socket_families, family, sizeof(family), "%d", sin->sin_family);
+	strarray__scnprintf(&strarray__socket_families, family, sizeof(family), "%d", sa->sa_family);
 	printed = scnprintf(bf, size, "{ .family: %s", family);
 
-	if (sin->sin_family == AF_INET) {
-		char tmp[512];
-		printed += scnprintf(bf + printed, size - printed, ", port: %d, addr: %s", ntohs(sin->sin_port),
-				     inet_ntop(sin->sin_family, &sin->sin_addr, tmp, sizeof(tmp)));
-	} else if (sin->sin_family == AF_INET6) {
-		struct sockaddr_in6 *sin6 = (struct sockaddr_in6 *)sin;
-		u32 flowinfo = ntohl(sin6->sin6_flowinfo);
-		char tmp[512];
-
-		printed += scnprintf(bf + printed, size - printed, ", port: %d, addr: %s", ntohs(sin6->sin6_port),
-				     inet_ntop(sin6->sin6_family, &sin6->sin6_addr, tmp, sizeof(tmp)));
-		if (flowinfo != 0)
-			printed += scnprintf(bf + printed, size - printed, ", flowinfo: %lu", flowinfo);
-		if (sin6->sin6_scope_id != 0)
-			printed += scnprintf(bf + printed, size - printed, ", scope_id: %lu", sin6->sin6_scope_id);
-	} else if (sin->sin_family == AF_LOCAL) {
-		struct sockaddr_un *sun = (struct sockaddr_un *)sin;
-		printed += scnprintf(bf + printed, size - printed, ", path: %s", sun->sun_path);
-	}
+	if (sa->sa_family < ARRAY_SIZE(af_scnprintfs) && af_scnprintfs[sa->sa_family])
+		printed += af_scnprintfs[sa->sa_family](sa, bf + printed, size - printed);
 
 	return printed + scnprintf(bf + printed, size - printed, " }");
 }
