Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF2B2C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DEE32188F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:41:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DEE32188F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbeHROsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 10:48:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48883 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbeHROsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 10:48:21 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7IBeoFe1287717
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Aug 2018 04:40:50 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7IBeosF1287714;
        Sat, 18 Aug 2018 04:40:50 -0700
Date:   Sat, 18 Aug 2018 04:40:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-xfjyog8oveg2fjys9r1yy1es@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, jolsa@kernel.org, hpa@zytor.com,
        dsahern@gmail.com, wangnan0@huawei.com, namhyung@kernel.org,
        acme@redhat.com
Reply-To: dsahern@gmail.com, namhyung@kernel.org, wangnan0@huawei.com,
          hpa@zytor.com, acme@redhat.com, linux-kernel@vger.kernel.org,
          jolsa@kernel.org, adrian.hunter@intel.com, tglx@linutronix.de,
          mingo@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf trace: Setup the augmented syscalls
 bpf-output event fields
Git-Commit-ID: d3d1c4bdf5a793ab10c448f9cf5aa5b19ce026d3
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

Commit-ID:  d3d1c4bdf5a793ab10c448f9cf5aa5b19ce026d3
Gitweb:     https://git.kernel.org/tip/d3d1c4bdf5a793ab10c448f9cf5aa5b19ce026d3
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 7 Aug 2018 16:21:44 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 8 Aug 2018 15:55:58 -0300

perf trace: Setup the augmented syscalls bpf-output event fields

The payload that is put in place by the eBPF script attached to
syscalls:sys_enter_openat (and other syscalls with pointers, in the
future) can be consumed by the existing sys_enter beautifiers if
evsel->priv is setup with a struct syscall_tp with struct tp_fields for
the 'syscall_id' and 'args' fields expected by the beautifiers, this
patch does just that.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-xfjyog8oveg2fjys9r1yy1es@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 43a699cfcadf..06215acb1481 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -77,7 +77,8 @@ struct trace {
 		struct syscall  *table;
 		struct {
 			struct perf_evsel *sys_enter,
-					  *sys_exit;
+					  *sys_exit,
+					  *augmented;
 		}		events;
 	} syscalls;
 	struct record_opts	opts;
@@ -263,6 +264,30 @@ out_delete:
 	return -ENOENT;
 }
 
+static int perf_evsel__init_augmented_syscall_tp(struct perf_evsel *evsel)
+{
+	struct syscall_tp *sc = evsel->priv = malloc(sizeof(struct syscall_tp));
+
+	if (evsel->priv != NULL) {       /* field, sizeof_field, offsetof_field */
+		if (__tp_field__init_uint(&sc->id, sizeof(long), sizeof(long long), evsel->needs_swap))
+			goto out_delete;
+
+		return 0;
+	}
+
+	return -ENOMEM;
+out_delete:
+	zfree(&evsel->priv);
+	return -EINVAL;
+}
+
+static int perf_evsel__init_augmented_syscall_tp_args(struct perf_evsel *evsel)
+{
+	struct syscall_tp *sc = evsel->priv;
+
+	return __tp_field__init_ptr(&sc->args, sc->id.offset + sizeof(u64));
+}
+
 static int perf_evsel__init_raw_syscall_tp(struct perf_evsel *evsel, void *handler)
 {
 	evsel->priv = malloc(sizeof(struct syscall_tp));
@@ -3248,6 +3273,13 @@ int cmd_trace(int argc, const char **argv)
 		goto out;
 	}
 
+	if (evsel) {
+		if (perf_evsel__init_augmented_syscall_tp(evsel) ||
+		    perf_evsel__init_augmented_syscall_tp_args(evsel))
+			goto out;
+		trace.syscalls.events.augmented = evsel;
+	}
+
 	err = bpf__setup_stdout(trace.evlist);
 	if (err) {
 		bpf__strerror_setup_stdout(trace.evlist, err, bf, sizeof(bf));
