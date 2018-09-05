Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4FDC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D21712077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQ24M+Al"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D21712077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbeIFChx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:37:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:52220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727518AbeIFChw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:37:52 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1CB42077C;
        Wed,  5 Sep 2018 22:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536185141;
        bh=a7oOcxPOzk3lqwGzNf6UGNgUyfS2zAJ1sZCQuCsuF60=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JQ24M+Al9KYgfRDjD8ECId4c/dXAYZjqpQ7TkR2S2R/8XoH1rBqIR63XISaVWdJQH
         /stRM1a1VCKY1Rb6MKWoHsg9HuuLqpo3kEVJTXWG52n0m+mtGviNGpEGXPC2acWcK3
         HEb58VzQssRBXu9C4z9dK1TQzxF40n1aNybyBfRk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 18/77] perf trace beauty: Reorganize 'struct sockaddr *' beautifier
Date:   Wed,  5 Sep 2018 19:03:41 -0300
Message-Id: <20180905220440.20256-19-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.14.4

