Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E9EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1269D218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388686AbeLTSL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:11:57 -0500
Received: from terminus.zytor.com ([198.137.202.136]:53199 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728956AbeLTSL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:11:56 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBKIBkmG3682055
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 20 Dec 2018 10:11:46 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBKIBkED3682052;
        Thu, 20 Dec 2018 10:11:46 -0800
Date:   Thu, 20 Dec 2018 10:11:46 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-vac4sn1ns1vj4y07lzj7y4b8@git.kernel.org>
Cc:     wangnan0@huawei.com, tglx@linutronix.de, acme@redhat.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, hpa@zytor.com, jolsa@kernel.org,
        namhyung@kernel.org
Reply-To: linux-kernel@vger.kernel.org, jolsa@kernel.org,
          namhyung@kernel.org, hpa@zytor.com, adrian.hunter@intel.com,
          acme@redhat.com, tglx@linutronix.de, wangnan0@huawei.com,
          mingo@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Switch to using a struct for the
 aumented_raw_syscalls syscalls map values
Git-Commit-ID: bbab50dda724309eccec92132d3f36cb262e8728
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

Commit-ID:  bbab50dda724309eccec92132d3f36cb262e8728
Gitweb:     https://git.kernel.org/tip/bbab50dda724309eccec92132d3f36cb262e8728
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 12 Dec 2018 16:54:09 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 18 Dec 2018 12:23:58 -0300

perf trace: Switch to using a struct for the aumented_raw_syscalls syscalls map values

We'll start adding more perf-syscall stuff, so lets do this prep step so
that the next ones are just about adding more fields.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-vac4sn1ns1vj4y07lzj7y4b8@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index de81918c7ad4..096380e8c213 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -908,6 +908,10 @@ struct syscall {
 	struct syscall_arg_fmt *arg_fmt;
 };
 
+struct bpf_map_syscall_entry {
+	bool	enabled;
+};
+
 /*
  * We need to have this 'calculated' boolean because in some cases we really
  * don't know what is the duration of a syscall, for instance, when we start
@@ -2583,7 +2587,9 @@ out_enomem:
 static int trace__set_ev_qualifier_bpf_filter(struct trace *trace)
 {
 	int fd = bpf_map__fd(trace->syscalls.map);
-	bool value = !trace->not_ev_qualifier;
+	struct bpf_map_syscall_entry value = {
+		.enabled = !trace->not_ev_qualifier,
+	};
 	int err = 0;
 	size_t i;
 
@@ -2601,10 +2607,13 @@ static int trace__set_ev_qualifier_bpf_filter(struct trace *trace)
 static int __trace__init_syscalls_bpf_map(struct trace *trace, bool enabled)
 {
 	int fd = bpf_map__fd(trace->syscalls.map);
+	struct bpf_map_syscall_entry value = {
+		.enabled = enabled,
+	};
 	int err = 0, key;
 
 	for (key = 0; key < trace->sctbl->syscalls.nr_entries; ++key) {
-		err = bpf_map_update_elem(fd, &key, &enabled, BPF_ANY);
+		err = bpf_map_update_elem(fd, &key, &value, BPF_ANY);
 		if (err)
 			break;
 	}
