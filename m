Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A60FC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF5732188F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:38:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF5732188F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbeHROpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 10:45:36 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45835 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbeHROpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 10:45:36 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7IBc5bQ1287319
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Aug 2018 04:38:05 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7IBc5EG1287316;
        Sat, 18 Aug 2018 04:38:05 -0700
Date:   Sat, 18 Aug 2018 04:38:05 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-4r7kw0nsyi4vyz6xm1tzx6a3@git.kernel.org>
Cc:     namhyung@kernel.org, dsahern@gmail.com, tglx@linutronix.de,
        mingo@kernel.org, acme@redhat.com, hpa@zytor.com,
        wangnan0@huawei.com, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, jolsa@kernel.org
Reply-To: namhyung@kernel.org, dsahern@gmail.com, tglx@linutronix.de,
          mingo@kernel.org, wangnan0@huawei.com,
          linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
          jolsa@kernel.org, acme@redhat.com, hpa@zytor.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf bpf: Generalize bpf__setup_stdout()
Git-Commit-ID: 92bbe8d834d293c4db7a70fd53884ec1c95d61dc
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

Commit-ID:  92bbe8d834d293c4db7a70fd53884ec1c95d61dc
Gitweb:     https://git.kernel.org/tip/92bbe8d834d293c4db7a70fd53884ec1c95d61dc
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 6 Aug 2018 09:53:35 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 8 Aug 2018 15:55:56 -0300

perf bpf: Generalize bpf__setup_stdout()

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
