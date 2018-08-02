Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28166C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCB9C2145D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:10:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCB9C2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731501AbeHBKAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 06:00:04 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40409 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbeHBKAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 06:00:04 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7289sfN3430903
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 2 Aug 2018 01:09:54 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7289sjX3430900;
        Thu, 2 Aug 2018 01:09:54 -0700
Date:   Thu, 2 Aug 2018 01:09:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-7djfak94eb3b9ltr79cpn3ti@git.kernel.org>
Cc:     wangnan0@huawei.com, hpa@zytor.com, tglx@linutronix.de,
        dsahern@gmail.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, mingo@kernel.org, namhyung@kernel.org,
        acme@redhat.com
Reply-To: tglx@linutronix.de, dsahern@gmail.com, hpa@zytor.com,
          wangnan0@huawei.com, acme@redhat.com, namhyung@kernel.org,
          adrian.hunter@intel.com, jolsa@kernel.org,
          linux-kernel@vger.kernel.org, mingo@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace beauty: Do not print NULL strarray
 entries
Git-Commit-ID: bc972ada4f85450ebf20c4981ee84a1a4b060161
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

Commit-ID:  bc972ada4f85450ebf20c4981ee84a1a4b060161
Gitweb:     https://git.kernel.org/tip/bc972ada4f85450ebf20c4981ee84a1a4b060161
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 26 Jul 2018 15:30:33 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 31 Jul 2018 10:52:46 -0300

perf trace beauty: Do not print NULL strarray entries

We may have string tables where not all slots have values, in those
cases its better to print the numeric value, for instance:

In the table below we would show "protocol: (null)" for

      socket_ipproto[3]

Where it would be better to show "protocol: 3".

      $ tools/perf/trace/beauty/socket_ipproto.sh
      static const char *socket_ipproto[] = {
            [0] = "IP",
            [103] = "PIM",
            [108] = "COMP",
            [12] = "PUP",
            [132] = "SCTP",
            [136] = "UDPLITE",
            [137] = "MPLS",
            [17] = "UDP",
            [1] = "ICMP",
            [22] = "IDP",
            [255] = "RAW",
            [29] = "TP",
            [2] = "IGMP",
            [33] = "DCCP",
            [41] = "IPV6",
            [46] = "RSVP",
            [47] = "GRE",
            [4] = "IPIP",
            [50] = "ESP",
            [51] = "AH",
            [6] = "TCP",
            [8] = "EGP",
            [92] = "MTP",
            [94] = "BEETPH",
            [98] = "ENCAP",
      };
      $

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-7djfak94eb3b9ltr79cpn3ti@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 6a748eca2edb..632ef5f8f060 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -291,7 +291,7 @@ size_t strarray__scnprintf(struct strarray *sa, char *bf, size_t size, const cha
 {
 	int idx = val - sa->offset;
 
-	if (idx < 0 || idx >= sa->nr_entries)
+	if (idx < 0 || idx >= sa->nr_entries || sa->entries[idx] == NULL)
 		return scnprintf(bf, size, intfmt, val);
 
 	return scnprintf(bf, size, "%s", sa->entries[idx]);
