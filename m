Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE31CC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79A1B21EC2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pSSQFlOl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79A1B21EC2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733144AbeHIR0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:26:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:38818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730634AbeHIR0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:26:46 -0400
Received: from jouet.infradead.org (179-240-153-38.3g.claro.net.br [179.240.153.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FCDE214FF;
        Thu,  9 Aug 2018 15:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533826888;
        bh=S6DDdvEAqSq2l2P4q2iqaUnrfpf5247BKjYniTcSYGk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pSSQFlOlcfN1lcm6i51OJZsyuOXqW2CRsC+Cb+Ttl0pZIg4N7Jv9wHvjDKl1ronc+
         6Ystzn2OdFn8utzw+4QvmbPrVxxiJTuFbWigLkSRLd/Wz2d8raHegH68D2/L9DGxbN
         BGvLydH2zQPTFnj+YevIZ76lKjXxouWGTkXKHWSc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 36/44] perf bpf: Generalize bpf__setup_stdout()
Date:   Thu,  9 Aug 2018 11:58:14 -0300
Message-Id: <20180809145822.21391-37-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180809145822.21391-1-acme@kernel.org>
References: <20180809145822.21391-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We will use it to set up other bpf-output events, for instance to
generate augmented syscall entry tracepoints with pointer contents.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-4r7kw0nsyi4vyz6xm1tzx6a3@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf-loader.c | 26 +++++++++++++++++---------
 tools/perf/util/bpf-loader.h |  7 +++++++
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index e864a7e0ff12..95a27bb6f1a1 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -1535,10 +1535,7 @@ int bpf__apply_obj_config(void)
 			(strcmp(name, 			\
 				bpf_map__name(pos)) == 0))
 
-#define bpf__for_each_stdout_map(pos, obj, objtmp) \
-	 bpf__for_each_map_named(pos, obj, objtmp, "__bpf_stdout__")
-
-int bpf__setup_stdout(struct perf_evlist *evlist)
+int bpf__setup_output_event(struct perf_evlist *evlist, const char *name)
 {
 	struct bpf_map_priv *tmpl_priv = NULL;
 	struct bpf_object *obj, *tmp;
@@ -1547,7 +1544,7 @@ int bpf__setup_stdout(struct perf_evlist *evlist)
 	int err;
 	bool need_init = false;
 
-	bpf__for_each_stdout_map(map, obj, tmp) {
+	bpf__for_each_map_named(map, obj, tmp, name) {
 		struct bpf_map_priv *priv = bpf_map__priv(map);
 
 		if (IS_ERR(priv))
@@ -1567,17 +1564,23 @@ int bpf__setup_stdout(struct perf_evlist *evlist)
 		return 0;
 
 	if (!tmpl_priv) {
-		err = parse_events(evlist, "bpf-output/no-inherit=1,name=__bpf_stdout__/",
-				   NULL);
+		char *event_definition = NULL;
+
+		if (asprintf(&event_definition, "bpf-output/no-inherit=1,name=%s/", name) < 0)
+			return -ENOMEM;
+
+		err = parse_events(evlist, event_definition, NULL);
+		free(event_definition);
+
 		if (err) {
-			pr_debug("ERROR: failed to create bpf-output event\n");
+			pr_debug("ERROR: failed to create the \"%s\" bpf-output event\n", name);
 			return -err;
 		}
 
 		evsel = perf_evlist__last(evlist);
 	}
 
-	bpf__for_each_stdout_map(map, obj, tmp) {
+	bpf__for_each_map_named(map, obj, tmp, name) {
 		struct bpf_map_priv *priv = bpf_map__priv(map);
 
 		if (IS_ERR(priv))
@@ -1609,6 +1612,11 @@ int bpf__setup_stdout(struct perf_evlist *evlist)
 	return 0;
 }
 
+int bpf__setup_stdout(struct perf_evlist *evlist)
+{
+	return bpf__setup_output_event(evlist, "__bpf_stdout__");
+}
+
 #define ERRNO_OFFSET(e)		((e) - __BPF_LOADER_ERRNO__START)
 #define ERRCODE_OFFSET(c)	ERRNO_OFFSET(BPF_LOADER_ERRNO__##c)
 #define NR_ERRNO	(__BPF_LOADER_ERRNO__END - __BPF_LOADER_ERRNO__START)
diff --git a/tools/perf/util/bpf-loader.h b/tools/perf/util/bpf-loader.h
index 5d3aefd6fae7..6be0eec043c6 100644
--- a/tools/perf/util/bpf-loader.h
+++ b/tools/perf/util/bpf-loader.h
@@ -82,6 +82,7 @@ int bpf__apply_obj_config(void);
 int bpf__strerror_apply_obj_config(int err, char *buf, size_t size);
 
 int bpf__setup_stdout(struct perf_evlist *evlist);
+int bpf__setup_output_event(struct perf_evlist *evlist, const char *name);
 int bpf__strerror_setup_stdout(struct perf_evlist *evlist, int err,
 			       char *buf, size_t size);
 
@@ -138,6 +139,12 @@ bpf__setup_stdout(struct perf_evlist *evlist __maybe_unused)
 	return 0;
 }
 
+static inline int
+bpf__setup_output_event(struct perf_evlist *evlist __maybe_unused, const char *name __maybe_unused)
+{
+	return 0;
+}
+
 static inline int
 __bpf_strerror(char *buf, size_t size)
 {
-- 
2.14.4

