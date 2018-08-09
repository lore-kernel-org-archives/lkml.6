Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8580DC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C79121DEC
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWFekC/u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C79121DEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733164AbeHIR0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:26:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:38914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730634AbeHIR0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:26:50 -0400
Received: from jouet.infradead.org (179-240-153-38.3g.claro.net.br [179.240.153.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49F242183D;
        Thu,  9 Aug 2018 15:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533826893;
        bh=Q9RAoZ3nDFwM+cal/MS8O3GIdJy0GgG4WDNiTpJJAZ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YWFekC/uuVVwMKESnwwleUwprnrfcxeUwlyI4KwsujvdrZciIzt00ZeIKWA8jMy9W
         4r8hDGGcIKlmv3NebW03NX/hcW5wI2cMJrIsISHh3k05GnS5aK4r9AboNLclQ3LKNf
         Q9s9S+8Bcp9Obg5TcoVpCDo+ddiUU5mf1U9rjFTY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 37/44] perf bpf: Add bpf__setup_output_event() strerror() counterpart
Date:   Thu,  9 Aug 2018 11:58:15 -0300
Message-Id: <20180809145822.21391-38-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180809145822.21391-1-acme@kernel.org>
References: <20180809145822.21391-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

That is just bpf__strerror_setup_stdout() renamed to the more general
"setup_output_event" method, keep the existing stdout() as a wrapper.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-nwnveo428qn0b48axj50vkc7@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf-loader.c |  4 ++--
 tools/perf/util/bpf-loader.h | 15 +++++++++------
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index 95a27bb6f1a1..80dead642719 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -1791,8 +1791,8 @@ int bpf__strerror_apply_obj_config(int err, char *buf, size_t size)
 	return 0;
 }
 
-int bpf__strerror_setup_stdout(struct perf_evlist *evlist __maybe_unused,
-			       int err, char *buf, size_t size)
+int bpf__strerror_setup_output_event(struct perf_evlist *evlist __maybe_unused,
+				     int err, char *buf, size_t size)
 {
 	bpf__strerror_head(err, buf, size);
 	bpf__strerror_end(buf, size);
diff --git a/tools/perf/util/bpf-loader.h b/tools/perf/util/bpf-loader.h
index 6be0eec043c6..8eca75145ac2 100644
--- a/tools/perf/util/bpf-loader.h
+++ b/tools/perf/util/bpf-loader.h
@@ -83,9 +83,7 @@ int bpf__strerror_apply_obj_config(int err, char *buf, size_t size);
 
 int bpf__setup_stdout(struct perf_evlist *evlist);
 int bpf__setup_output_event(struct perf_evlist *evlist, const char *name);
-int bpf__strerror_setup_stdout(struct perf_evlist *evlist, int err,
-			       char *buf, size_t size);
-
+int bpf__strerror_setup_output_event(struct perf_evlist *evlist, int err, char *buf, size_t size);
 #else
 #include <errno.h>
 
@@ -200,11 +198,16 @@ bpf__strerror_apply_obj_config(int err __maybe_unused,
 }
 
 static inline int
-bpf__strerror_setup_stdout(struct perf_evlist *evlist __maybe_unused,
-			   int err __maybe_unused, char *buf,
-			   size_t size)
+bpf__strerror_setup_output_event(struct perf_evlist *evlist __maybe_unused,
+				 int err __maybe_unused, char *buf, size_t size)
 {
 	return __bpf_strerror(buf, size);
 }
+
 #endif
+
+static inline int bpf__strerror_setup_stdout(struct perf_evlist *evlist, int err, char *buf, size_t size)
+{
+	return bpf__strerror_setup_output_event(evlist, err, buf, size);
+}
 #endif
-- 
2.14.4

