Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D350C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48B0C208A6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUZY6jQz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48B0C208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732625AbeHAXZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 19:25:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:39012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732307AbeHAXZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 19:25:07 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69D6B208B0;
        Wed,  1 Aug 2018 21:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533159440;
        bh=evSOy/+wbUrLbjozN3rQpD+sPoZQQpNMzyAYv3LP3bg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PUZY6jQzCuZs+KPsaZ9RoZdrcX065nM0BiHtgc3dQLhFOnOAPGAZFuTAAFeENWJBa
         d+MlkaVZANkwzObl8BVidXIF79mPuiiN15oyezcNF+Nu/MQZ8QLXw3nDPcp1Hft/DT
         wcC0bhOQ0iHNnn7JmbVtOS8Btm8Al+mrvnx9LXSs=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 06/21] perf trace beauty: Do not print NULL strarray entries
Date:   Wed,  1 Aug 2018 18:36:33 -0300
Message-Id: <20180801213648.4814-7-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180801213648.4814-1-acme@kernel.org>
References: <20180801213648.4814-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.14.4

