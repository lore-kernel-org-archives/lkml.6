Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9B3C10F10
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADAB8222C9
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392979AbfBOJgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:36:25 -0500
Received: from terminus.zytor.com ([198.137.202.136]:59261 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732342AbfBOJgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:36:24 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1F9aCGm1117629
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 15 Feb 2019 01:36:12 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1F9aCAq1117623;
        Fri, 15 Feb 2019 01:36:12 -0800
Date:   Fri, 15 Feb 2019 01:36:12 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-rjopq5y92itgokppdhe8sc6z@git.kernel.org>
Cc:     tglx@linutronix.de, jolsa@kernel.org, acme@redhat.com,
        mingo@kernel.org, hpa@zytor.com, wangnan0@huawei.com,
        adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        lclaudio@redhat.com, namhyung@kernel.org
Reply-To: linux-kernel@vger.kernel.org, wangnan0@huawei.com,
          adrian.hunter@intel.com, namhyung@kernel.org,
          lclaudio@redhat.com, tglx@linutronix.de, hpa@zytor.com,
          mingo@kernel.org, jolsa@kernel.org, acme@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Filter out gnome-terminal* parent
Git-Commit-ID: ca2da70c411c4022a479d36063f0d0a862ea636e
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

Commit-ID:  ca2da70c411c4022a479d36063f0d0a862ea636e
Gitweb:     https://git.kernel.org/tip/ca2da70c411c4022a479d36063f0d0a862ea636e
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 12 Feb 2019 13:51:49 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 14 Feb 2019 15:18:04 -0300

perf trace: Filter out gnome-terminal* parent

Just like it does with 'sshd', to reduce the feedback loop when doing
system wide tracing on on a gnome GUI.

Need to figure out how to auto-filter the calls to other UI components
tho.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-rjopq5y92itgokppdhe8sc6z@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index a9b51f59ab54..68a01e624ad3 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2771,7 +2771,8 @@ static int trace__set_filter_loop_pids(struct trace *trace)
 		if (parent == NULL)
 			break;
 
-		if (!strcmp(thread__comm_str(parent), "sshd")) {
+		if (!strcmp(thread__comm_str(parent), "sshd") ||
+		    strstarts(thread__comm_str(parent), "gnome-terminal")) {
 			pids[nr++] = parent->tid;
 			break;
 		}
