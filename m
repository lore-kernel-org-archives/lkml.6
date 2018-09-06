Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F000FC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0D6F2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:47:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0D6F2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730026AbeIFSWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:22:46 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46665 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729485AbeIFSWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:22:46 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86DkwCP311101
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:46:58 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86Dkwgm311098;
        Thu, 6 Sep 2018 06:46:58 -0700
Date:   Thu, 6 Sep 2018 06:46:58 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-iiseo3s0qbf9i3rzn8k597bv@git.kernel.org>
Cc:     dsahern@gmail.com, adrian.hunter@intel.com, acme@redhat.com,
        namhyung@kernel.org, wangnan0@huawei.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
        mingo@kernel.org, jolsa@kernel.org
Reply-To: hpa@zytor.com, namhyung@kernel.org, linux-kernel@vger.kernel.org,
          wangnan0@huawei.com, jolsa@kernel.org, tglx@linutronix.de,
          mingo@kernel.org, adrian.hunter@intel.com, acme@redhat.com,
          dsahern@gmail.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Introduce syscall__augmented_args()
 method
Git-Commit-ID: 8a041f86a83f9783ba23a423a2d5a51b48136850
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

Commit-ID:  8a041f86a83f9783ba23a423a2d5a51b48136850
Gitweb:     https://git.kernel.org/tip/8a041f86a83f9783ba23a423a2d5a51b48136850
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 3 Sep 2018 16:07:53 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 3 Sep 2018 16:07:53 -0300

perf trace: Introduce syscall__augmented_args() method

That will be used by trace__sys_enter when we start combining the
augmented syscalls:sys_enter_FOO + syscalls:sys_exit_FOO.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-iiseo3s0qbf9i3rzn8k597bv@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index c106189f4066..12356deb6046 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1677,6 +1677,17 @@ static int trace__fprintf_sample(struct trace *trace, struct perf_evsel *evsel,
 	return printed;
 }
 
+static void *syscall__augmented_args(struct syscall *sc, struct perf_sample *sample, int *augmented_args_size)
+{
+	void *augmented_args = NULL;
+
+	*augmented_args_size = sample->raw_size - sc->args_size;
+	if (*augmented_args_size > 0)
+		augmented_args = sample->raw_data + sc->args_size;
+
+	return augmented_args;
+}
+
 static int trace__sys_enter(struct trace *trace, struct perf_evsel *evsel,
 			    union perf_event *event __maybe_unused,
 			    struct perf_sample *sample)
@@ -1762,10 +1773,7 @@ static int trace__fprintf_sys_enter(struct trace *trace, struct perf_evsel *evse
 		goto out_put;
 
 	args = perf_evsel__sc_tp_ptr(evsel, args, sample);
-	augmented_args_size = sample->raw_size - sc->args_size;
-	if (augmented_args_size > 0)
-		augmented_args = sample->raw_data + sc->args_size;
-
+	augmented_args = syscall__augmented_args(sc, sample, &augmented_args_size);
 	syscall__scnprintf_args(sc, msg, sizeof(msg), args, augmented_args, augmented_args_size, trace, thread);
 	fprintf(trace->output, "%s", msg);
 	err = 0;
