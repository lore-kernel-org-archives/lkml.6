Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 03B7BC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5797208D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:20:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5797208D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754618AbeFNGUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 02:20:45 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40645 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752761AbeFNGUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 02:20:44 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5E6JZiL763405
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 13 Jun 2018 23:19:35 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5E6JYOp763402;
        Wed, 13 Jun 2018 23:19:34 -0700
Date:   Wed, 13 Jun 2018 23:19:34 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-e8ife8djvvvwmeze3s4yodii@git.kernel.org>
Cc:     tglx@linutronix.de, dsahern@gmail.com, yao.jin@linux.intel.com,
        acme@redhat.com, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, namhyung@kernel.org, hpa@zytor.com,
        mingo@kernel.org, wangnan0@huawei.com, jolsa@kernel.org
Reply-To: adrian.hunter@intel.com, acme@redhat.com,
          yao.jin@linux.intel.com, tglx@linutronix.de, dsahern@gmail.com,
          namhyung@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
          mingo@kernel.org, jolsa@kernel.org, wangnan0@huawei.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf hists: Make hist_entry__has_callchains()
 work with 'perf c2c'
Git-Commit-ID: e5654455795f2f89328f7b301dacb6926e57e2b8
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

Commit-ID:  e5654455795f2f89328f7b301dacb6926e57e2b8
Gitweb:     https://git.kernel.org/tip/e5654455795f2f89328f7b301dacb6926e57e2b8
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 7 Jun 2018 14:27:19 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 7 Jun 2018 14:27:19 -0300

perf hists: Make hist_entry__has_callchains() work with 'perf c2c'

Since 'perf c2c' uses 'struct hists' not allocated together with a
'struct perf_evsel' instance, we can't go from a 'struct hist_entry'
pointer to a 'struct perf_evsel' via he->hists, so, instead, check if
space was set aside for hist_entry->callchain[0] at hist_entry__new()
time.

Reported-by: Jin Yao <yao.jin@linux.intel.com>
Reported-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: fabd37b837f6 ("perf hists: Check if a hist_entry has callchains before using them")
Link: https://lkml.kernel.org/n/tip-e8ife8djvvvwmeze3s4yodii@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/sort.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index 9ab9257ed887..8bf302cafcec 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -155,7 +155,7 @@ struct hist_entry {
 
 static __pure inline bool hist_entry__has_callchains(struct hist_entry *he)
 {
-	return hists__has_callchains(he->hists);
+	return he->callchain_size != 0;
 }
 
 static inline bool hist_entry__has_pairs(struct hist_entry *he)
