Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6899CC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 388002084D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:33:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 388002084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbeJZQJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 12:09:28 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37359 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbeJZQJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 12:09:28 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9Q7XNk5137129
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 26 Oct 2018 00:33:23 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9Q7XNA9137126;
        Fri, 26 Oct 2018 00:33:23 -0700
Date:   Fri, 26 Oct 2018 00:33:23 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-dkxsb8cwg87rmkrzrbns1o4z@git.kernel.org>
Cc:     tglx@linutronix.de, acme@redhat.com, jolsa@kernel.org,
        wangnan0@huawei.com, adrian.hunter@intel.com, namhyung@kernel.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org, dsahern@gmail.com,
        hpa@zytor.com
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org,
          namhyung@kernel.org, adrian.hunter@intel.com, hpa@zytor.com,
          dsahern@gmail.com, tglx@linutronix.de, wangnan0@huawei.com,
          jolsa@kernel.org, acme@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf trace: Drop thread refcount in
 trace__event_handler()
Git-Commit-ID: a937c6658b8e77e1f65cde2be9970811752121bb
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

Commit-ID:  a937c6658b8e77e1f65cde2be9970811752121bb
Gitweb:     https://git.kernel.org/tip/a937c6658b8e77e1f65cde2be9970811752121bb
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Sat, 20 Oct 2018 09:27:52 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 22 Oct 2018 12:37:52 -0300

perf trace: Drop thread refcount in trace__event_handler()

We must pair:

   thread = machine__findnew_thread();

with thread__put(thread). Fix it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: c4191e55b874 ("perf trace: Show comm and tid for tracepoint events")
Link: https://lkml.kernel.org/n/tip-dkxsb8cwg87rmkrzrbns1o4z@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 77b8748ad5ed..589e0412652a 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2152,8 +2152,8 @@ newline:
 		trace__fprintf_callchain(trace, sample);
 	else if (callchain_ret < 0)
 		pr_err("Problem processing %s callchain, skipping...\n", perf_evsel__name(evsel));
-	thread__put(thread);
 out:
+	thread__put(thread);
 	return 0;
 }
 
