Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C927C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE26B20844
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:10:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE26B20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbeIFRp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:45:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53959 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbeIFRp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:45:26 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86D9n9v304029
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:09:49 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86D9nEL304026;
        Thu, 6 Sep 2018 06:09:49 -0700
Date:   Thu, 6 Sep 2018 06:09:49 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-6w8ytyo5y655a1hsyfpfily6@git.kernel.org>
Cc:     acme@redhat.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, tglx@linutronix.de, dsahern@gmail.com,
        mingo@kernel.org, namhyung@kernel.org, wangnan0@huawei.com,
        jolsa@kernel.org
Reply-To: acme@redhat.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
          adrian.hunter@intel.com, mingo@kernel.org, dsahern@gmail.com,
          tglx@linutronix.de, jolsa@kernel.org, namhyung@kernel.org,
          wangnan0@huawei.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Show comm/tid for augmented_syscalls
Git-Commit-ID: c96f4edcc3560a7dc910271d30d91c54a422d46c
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

Commit-ID:  c96f4edcc3560a7dc910271d30d91c54a422d46c
Gitweb:     https://git.kernel.org/tip/c96f4edcc3560a7dc910271d30d91c54a422d46c
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 21 Aug 2018 11:47:44 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 15:52:19 -0300

perf trace: Show comm/tid for augmented_syscalls

To get us a bit more like the sys_enter + sys_exit combo:

  # perf trace -e tools/perf/examples/bpf/augmented_syscalls.c,openat cat /etc/passwd > /dev/null
     0.000 (         ): openat(dfd: CWD, filename: 0x31b6dda8, flags: CLOEXEC)
     0.009 ( 0.009 ms): cat/3619 openat(dfd: CWD, filename: 0x31b6dda8, flags: CLOEXEC) = 3
     0.051 (         ): openat(dfd: CWD, filename: 0x31d75ce0, flags: CLOEXEC)
     0.054 ( 0.010 ms): cat/3619 openat(dfd: CWD, filename: 0x31d75ce0, flags: CLOEXEC) = 3
     0.539 (         ): openat(dfd: CWD, filename: 0xca71506b)
     0.543 ( 0.115 ms): cat/3619 openat(dfd: CWD, filename: 0xca71506b) = 3
  #

After:

  # perf trace -e tools/perf/examples/bpf/augmented_syscalls.c,openat cat /etc/passwd > /dev/null
     0.000 (         ): cat/4919 openat(dfd: CWD, filename: 0xc8358da8, flags: CLOEXEC)
     0.007 ( 0.005 ms): cat/4919 openat(dfd: CWD, filename: 0xc8358da8, flags: CLOEXEC) = 3
     0.032 (         ): cat/4919 openat(dfd: CWD, filename: 0xc8560ce0, flags: CLOEXEC)
     0.033 ( 0.006 ms): cat/4919 openat(dfd: CWD, filename: 0xc8560ce0, flags: CLOEXEC) = 3
     0.301 (         ): cat/4919 openat(dfd: CWD, filename: 0x91fa306b)
     0.304 ( 0.004 ms): cat/4919 openat(dfd: CWD, filename: 0x91fa306b) = 3
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-6w8ytyo5y655a1hsyfpfily6@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 92488edd00eb..e46ac9009172 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2069,6 +2069,7 @@ static int trace__event_handler(struct trace *trace, struct perf_evsel *evsel,
 			struct thread *thread = machine__findnew_thread(trace->host, sample->pid, sample->tid);
 
 			if (thread) {
+				trace__fprintf_comm_tid(trace, thread, trace->output);
 				fprintf(trace->output, "%s(", sc->name);
 				trace__fprintf_sys_enter(trace, evsel, sample);
 				fputc(')', trace->output);
