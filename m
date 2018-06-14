Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5D9F5C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CE67208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:24:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CE67208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754721AbeFNGY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 02:24:29 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33445 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752744AbeFNGY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 02:24:28 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5E6OMrn765454
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 13 Jun 2018 23:24:22 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5E6OLrQ765449;
        Wed, 13 Jun 2018 23:24:21 -0700
Date:   Wed, 13 Jun 2018 23:24:21 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-bh0ke4fh2ygpj3yowna7o1di@git.kernel.org>
Cc:     jolsa@redhat.com, linux-kernel@vger.kernel.org, jolsa@kernel.org,
        tglx@linutronix.de, acme@redhat.com, hpa@zytor.com,
        yao.jin@linux.intel.com, acme@kernel.org, mingo@kernel.org
Reply-To: acme@kernel.org, mingo@kernel.org, yao.jin@linux.intel.com,
          hpa@zytor.com, acme@redhat.com, tglx@linutronix.de,
          jolsa@kernel.org, linux-kernel@vger.kernel.org, jolsa@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf c2c: Keep struct hist_entry at the end of
 struct c2c_hist_entry
Git-Commit-ID: 4c8205273626f27b9e5a64bdc194ab483a8cce66
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

Commit-ID:  4c8205273626f27b9e5a64bdc194ab483a8cce66
Gitweb:     https://git.kernel.org/tip/4c8205273626f27b9e5a64bdc194ab483a8cce66
Author:     Jiri Olsa <jolsa@redhat.com>
AuthorDate: Fri, 8 Jun 2018 02:22:11 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 8 Jun 2018 13:35:53 -0300

perf c2c: Keep struct hist_entry at the end of struct c2c_hist_entry

Exactly as the comment just before 'struct c2c_hist_entry" says, i.e.
the last entry in struct hist_entry is a zero length array, that when
allocating space for hist_entry gets extra space if callchains are in
use, which, if hist_entry is not at the end of c2c_hist_entry, the
members after it gets corrupted when callchains get added to the rb
trees collecting them, etc.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jin Yao <yao.jin@linux.intel.com>
Fixes: 7f834c2e84bb ("perf c2c report: Display node for cacheline address")
Link: http://lkml.kernel.org/n/tip-bh0ke4fh2ygpj3yowna7o1di@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-c2c.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 307b3594525f..6a8738f7ead3 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -56,16 +56,16 @@ struct c2c_hist_entry {
 
 	struct compute_stats	 cstats;
 
+	unsigned long		 paddr;
+	unsigned long		 paddr_cnt;
+	bool			 paddr_zero;
+	char			*nodestr;
+
 	/*
 	 * must be at the end,
 	 * because of its callchain dynamic entry
 	 */
 	struct hist_entry	he;
-
-	unsigned long		 paddr;
-	unsigned long		 paddr_cnt;
-	bool			 paddr_zero;
-	char			*nodestr;
 };
 
 static char const *coalesce_default = "pid,iaddr";
