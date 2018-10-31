Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09BDECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 22:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F74B2080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 22:05:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F74B2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbeKAHFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 03:05:32 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46331 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbeKAHFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 03:05:32 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9VM5PK42560547
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 31 Oct 2018 15:05:25 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9VM5Pwf2560544;
        Wed, 31 Oct 2018 15:05:25 -0700
Date:   Wed, 31 Oct 2018 15:05:25 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for David S. Miller" <tipbot@zytor.com>
Message-ID: <tip-2wt3ayp6j2y2f2xowixa8y6y@git.kernel.org>
Cc:     davem@davemloft.net, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, acme@redhat.com,
        souvik1997@gmail.com, adrian.hunter@intel.com, jolsa@kernel.org,
        mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com,
        dsahern@gmail.com, wangnan0@huawei.com
Reply-To: adrian.hunter@intel.com, acme@redhat.com, souvik1997@gmail.com,
          jolsa@kernel.org, linux-kernel@vger.kernel.org,
          namhyung@kernel.org, davem@davemloft.net, wangnan0@huawei.com,
          dsahern@gmail.com, hpa@zytor.com, tglx@linutronix.de,
          mingo@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf callchain: Honour the ordering of
 PERF_CONTEXT_{USER,KERNEL,etc}
Git-Commit-ID: e9024d519d892b38176cafd46f68a7cdddd77412
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

Commit-ID:  e9024d519d892b38176cafd46f68a7cdddd77412
Gitweb:     https://git.kernel.org/tip/e9024d519d892b38176cafd46f68a7cdddd77412
Author:     David S. Miller <davem@davemloft.net>
AuthorDate: Tue, 30 Oct 2018 12:12:26 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 31 Oct 2018 09:57:51 -0300

perf callchain: Honour the ordering of PERF_CONTEXT_{USER,KERNEL,etc}

When processing using 'perf report -g caller', which is the default, we
ended up reverting the callchain entries received from the kernel, but
simply reverting throws away the information that tells that from a
point onwards the addresses are for userspace, kernel, guest kernel,
guest user, hypervisor.

The idea is that if we are walking backwards, for each cluster of
non-cpumode entries we have to first scan backwards for the next one and
use that for the cluster.

This seems silly and more expensive than it needs to be but it is enough
for a initial fix.

The code here is really complicated because it is intimately intertwined
with the lbr and branch handling, as well as this callchain order,
further fixes will be needed to properly take into account the cpumode
in those cases.

Another problem with ORDER_CALLER is that the NULL "0" IP that is at the
end of most callchains shows up at the top of the histogram because
every callchain contains it and with ORDER_CALLER it is the first entry.

Signed-off-by: David S. Miller <davem@davemloft.net>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Souvik Banerjee <souvik1997@gmail.com>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: stable@vger.kernel.org # 4.19
Link: https://lkml.kernel.org/n/tip-2wt3ayp6j2y2f2xowixa8y6y@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 111ae858cbcb..8ee8ab39d8ac 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2140,6 +2140,27 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 	return 0;
 }
 
+static int find_prev_cpumode(struct ip_callchain *chain, struct thread *thread,
+			     struct callchain_cursor *cursor,
+			     struct symbol **parent,
+			     struct addr_location *root_al,
+			     u8 *cpumode, int ent)
+{
+	int err = 0;
+
+	while (--ent >= 0) {
+		u64 ip = chain->ips[ent];
+
+		if (ip >= PERF_CONTEXT_MAX) {
+			err = add_callchain_ip(thread, cursor, parent,
+					       root_al, cpumode, ip,
+					       false, NULL, NULL, 0);
+			break;
+		}
+	}
+	return err;
+}
+
 static int thread__resolve_callchain_sample(struct thread *thread,
 					    struct callchain_cursor *cursor,
 					    struct perf_evsel *evsel,
@@ -2246,6 +2267,12 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 	}
 
 check_calls:
+	if (callchain_param.order != ORDER_CALLEE) {
+		err = find_prev_cpumode(chain, thread, cursor, parent, root_al,
+					&cpumode, chain->nr - first_call);
+		if (err)
+			return (err < 0) ? err : 0;
+	}
 	for (i = first_call, nr_entries = 0;
 	     i < chain_nr && nr_entries < max_stack; i++) {
 		u64 ip;
@@ -2260,9 +2287,15 @@ check_calls:
 			continue;
 #endif
 		ip = chain->ips[j];
-
 		if (ip < PERF_CONTEXT_MAX)
                        ++nr_entries;
+		else if (callchain_param.order != ORDER_CALLEE) {
+			err = find_prev_cpumode(chain, thread, cursor, parent,
+						root_al, &cpumode, j);
+			if (err)
+				return (err < 0) ? err : 0;
+			continue;
+		}
 
 		err = add_callchain_ip(thread, cursor, parent,
 				       root_al, &cpumode, ip,
