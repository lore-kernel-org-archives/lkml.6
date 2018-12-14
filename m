Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150BDC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6260B206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731023AbeLNUoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 15:44:25 -0500
Received: from terminus.zytor.com ([198.137.202.136]:38203 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730713AbeLNUoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 15:44:25 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBEKiDG41456874
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 14 Dec 2018 12:44:13 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBEKiCBi1456870;
        Fri, 14 Dec 2018 12:44:12 -0800
Date:   Fri, 14 Dec 2018 12:44:12 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-6h1syw2isegnhb1bjmtr9x9k@git.kernel.org>
Cc:     jolsa@kernel.org, dsahern@gmail.com, mingo@kernel.org,
        adrian.hunter@intel.com, hpa@zytor.com, wangnan0@huawei.com,
        tglx@linutronix.de, acme@redhat.com, namhyung@kernel.org,
        treeze.taeung@gmail.com, linux-kernel@vger.kernel.org
Reply-To: mingo@kernel.org, dsahern@gmail.com, jolsa@kernel.org,
          tglx@linutronix.de, wangnan0@huawei.com, hpa@zytor.com,
          adrian.hunter@intel.com, acme@redhat.com,
          linux-kernel@vger.kernel.org, treeze.taeung@gmail.com,
          namhyung@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: We need to consider "nr" if
 "__syscall_nr" is not there
Git-Commit-ID: 3e9c3a56674b5e87031c9d462ec2c6156efe442b
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

Commit-ID:  3e9c3a56674b5e87031c9d462ec2c6156efe442b
Gitweb:     https://git.kernel.org/tip/3e9c3a56674b5e87031c9d462ec2c6156efe442b
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 5 Dec 2018 13:08:11 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 6 Dec 2018 14:12:32 -0300

perf trace: We need to consider "nr" if "__syscall_nr" is not there

To cope with older kernels that don't have this patch backported:

  026842d148b9 ("tracing/syscalls: Rename "/format" tracepoint field name "nr" to "__syscall_nr:")

This makes 'perf trace' work again in RHEL7 kernels.

Cc: Taeung Song <treeze.taeung@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-6h1syw2isegnhb1bjmtr9x9k@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 2a347ed7bdf4..98aff12af9e6 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -258,7 +258,8 @@ static int perf_evsel__init_syscall_tp(struct perf_evsel *evsel)
 	struct syscall_tp *sc = evsel->priv = malloc(sizeof(struct syscall_tp));
 
 	if (evsel->priv != NULL) {
-		if (perf_evsel__init_tp_uint_field(evsel, &sc->id, "__syscall_nr"))
+		if (perf_evsel__init_tp_uint_field(evsel, &sc->id, "__syscall_nr") &&
+		    perf_evsel__init_tp_uint_field(evsel, &sc->id, "nr"))
 			goto out_delete;
 		return 0;
 	}
