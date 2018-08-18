Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E84C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDBA42188F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:38:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDBA42188F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbeHROqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 10:46:10 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48635 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbeHROqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 10:46:10 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7IBcdO61287360
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Aug 2018 04:38:39 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7IBccEa1287357;
        Sat, 18 Aug 2018 04:38:38 -0700
Date:   Sat, 18 Aug 2018 04:38:38 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-nwnveo428qn0b48axj50vkc7@git.kernel.org>
Cc:     adrian.hunter@intel.com, dsahern@gmail.com, mingo@kernel.org,
        acme@redhat.com, namhyung@kernel.org, linux-kernel@vger.kernel.org,
        wangnan0@huawei.com, jolsa@kernel.org, hpa@zytor.com,
        tglx@linutronix.de
Reply-To: adrian.hunter@intel.com, dsahern@gmail.com, mingo@kernel.org,
          acme@redhat.com, namhyung@kernel.org,
          linux-kernel@vger.kernel.org, jolsa@kernel.org,
          wangnan0@huawei.com, hpa@zytor.com, tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf bpf: Add bpf__setup_output_event()
 strerror() counterpart
Git-Commit-ID: aa31be3a4874d91fb40d872f1865805ab411035c
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

Commit-ID:  aa31be3a4874d91fb40d872f1865805ab411035c
Gitweb:     https://git.kernel.org/tip/aa31be3a4874d91fb40d872f1865805ab411035c
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 6 Aug 2018 11:35:37 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 8 Aug 2018 15:55:56 -0300

perf bpf: Add bpf__setup_output_event() strerror() counterpart

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
