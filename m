Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60E3C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E71321852
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbeLROLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:11:21 -0500
Received: from terminus.zytor.com ([198.137.202.136]:54913 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbeLROLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 09:11:20 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBIEB7HG2854102
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Dec 2018 06:11:07 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBIEB7lp2854099;
        Tue, 18 Dec 2018 06:11:07 -0800
Date:   Tue, 18 Dec 2018 06:11:07 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-6h1syw2isegnhb1bjmtr9x9k@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, namhyung@kernel.org, hpa@zytor.com,
        dsahern@gmail.com, wangnan0@huawei.com, treeze.taeung@gmail.com,
        jolsa@kernel.org, mingo@kernel.org, tglx@linutronix.de,
        adrian.hunter@intel.com, acme@redhat.com
Reply-To: jolsa@kernel.org, mingo@kernel.org, adrian.hunter@intel.com,
          tglx@linutronix.de, acme@redhat.com, hpa@zytor.com,
          dsahern@gmail.com, namhyung@kernel.org,
          linux-kernel@vger.kernel.org, wangnan0@huawei.com,
          treeze.taeung@gmail.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: We need to consider "nr" if
 "__syscall_nr" is not there
Git-Commit-ID: 42da438c1bc4ad9b904401aff03678ddbf1329b0
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
Message-ID: <20181218141107.L4Xdw8XkgZrwJTlW5K1Ojc4BT8pwgj15s7m0gBRCcj4@z>

Commit-ID:  42da438c1bc4ad9b904401aff03678ddbf1329b0
Gitweb:     https://git.kernel.org/tip/42da438c1bc4ad9b904401aff03678ddbf1329b0
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 5 Dec 2018 13:08:11 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 17 Dec 2018 14:57:02 -0300

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
