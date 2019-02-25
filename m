Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE33AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98FA521874
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129756;
	bh=XWRFlyclP+EIQNJndaWZ9CyfOewG6ivy6wprh5SuLK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0gH6yd2N6pcxqpX/m7f/v8s0MljyosrXaLDMzubThj639ew69Hp56IemlKeGIAghe
	 Ebx43ILycWqal5dV/eYkus7jOxcUR9zWrawvRZ8N/f2rN0DN65jPvLQKC4xToIyrtX
	 4hogxdPjgeQCtGIyf88RJoamKX0T/TB/hAuj+ejI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730910AbfBYVWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:22:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:56704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729604AbfBYVWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:22:31 -0500
Received: from quaco.ghostprotocols.net (179-240-165-120.3g.claro.net.br [179.240.165.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8068A21852;
        Mon, 25 Feb 2019 21:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129750;
        bh=XWRFlyclP+EIQNJndaWZ9CyfOewG6ivy6wprh5SuLK0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xoxCsOMtnVQrPuc+/FSE/gL68PkLQn8ZoRw/8kZVfAqopzotVIhiVp6fN7AHKiIEH
         gxXoHpWCxYbuo8wrUFKNI+NxVD2Gh5phBTY2EZTTXaC/fc+msl57V3iEYhj7HrwSTv
         xeN9Rjt6J18qp+d50hYOASBKfQTnhd/Ox4wn4Z0g=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 27/37] perf tools: Add perf_exe() helper to find perf binary
Date:   Mon, 25 Feb 2019 18:20:25 -0300
Message-Id: <20190225212035.24781-28-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225212035.24781-1-acme@kernel.org>
References: <20190225212035.24781-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Also convert one existing user.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20190224153722.27020-9-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 12 +++---------
 tools/perf/util/util.c   | 10 ++++++++++
 tools/perf/util/util.h   |  2 ++
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index a2323d777dae..01b324c275b9 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -527,17 +527,11 @@ static int write_event_desc(struct feat_fd *ff,
 static int write_cmdline(struct feat_fd *ff,
 			 struct perf_evlist *evlist __maybe_unused)
 {
-	char buf[MAXPATHLEN];
-	u32 n;
-	int i, ret;
+	char pbuf[MAXPATHLEN], *buf;
+	int i, ret, n;
 
 	/* actual path to perf binary */
-	ret = readlink("/proc/self/exe", buf, sizeof(buf) - 1);
-	if (ret <= 0)
-		return -1;
-
-	/* readlink() does not add null termination */
-	buf[ret] = '\0';
+	buf = perf_exe(pbuf, MAXPATHLEN);
 
 	/* account for binary path */
 	n = perf_env.nr_cmdline + 1;
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 706818693086..d388f80d8703 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -568,3 +568,13 @@ const char *perf_tip(const char *dirpath)
 
 	return tip;
 }
+
+char *perf_exe(char *buf, int len)
+{
+	int n = readlink("/proc/self/exe", buf, len);
+	if (n > 0) {
+		buf[n] = 0;
+		return buf;
+	}
+	return strcpy(buf, "perf");
+}
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index 01c538027c6f..09c1b0f91f65 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -77,6 +77,8 @@ extern bool perf_singlethreaded;
 void perf_set_singlethreaded(void);
 void perf_set_multithreaded(void);
 
+char *perf_exe(char *buf, int len);
+
 #ifndef O_CLOEXEC
 #ifdef __sparc__
 #define O_CLOEXEC      0x400000
-- 
2.20.1

