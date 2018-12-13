Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BB1C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 546A020879
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Jq4RgcgA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 546A020879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbeLMQ4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 11:56:46 -0500
Received: from smtprelay2.synopsys.com ([198.182.60.111]:37722 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729645AbeLMQ4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 11:56:45 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id E0EF310C17FD;
        Thu, 13 Dec 2018 08:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1544720204; bh=Aoa+yMFINIyNSLFAiNcrIQz8XLb2ZfPLflM2tFZRRY0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jq4RgcgAqsDMzhs/uOeD5hRTouT6pAKH2t8WY7+AsLyW57SCnNp3pOiqSJxKiBieq
         TX82nY6+qU3pEzoG4A4F2CA/Fk0NVkKMtExFcjufAp623yEIvnQC/FrNbbfUboUpiH
         n0NsWx6YkZRieC33hEmdE65XUlNwg//8ff7doCO8lUsU2riRWvGn+u4wwd9O5NsKbe
         QnbBzZSpW1PD4aAlY2j6xVpWiGnll75/8yf298JUoF5XLC3TczhszfdXh/TqqUOY6y
         Ihq+mbUhkLD/VFfhIEf+jgOs//ZqoKVNO00qgL+vRgSEswRUEqSrO2zMRZ0a/Zy45N
         2FEhAEAjpOe2Q==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.66])
        by mailhost.synopsys.com (Postfix) with ESMTP id 0FE49307B;
        Thu, 13 Dec 2018 08:56:40 -0800 (PST)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH v2 3/4] ARC: perf: move HW events mapping to separate function
Date:   Thu, 13 Dec 2018 19:56:20 +0300
Message-Id: <20181213165621.20817-4-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181213165621.20817-1-Eugeniy.Paltsev@synopsys.com>
References: <20181213165621.20817-1-Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move HW events mapping to separate function to make code more readable.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/kernel/perf_event.c | 48 ++++++++++++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 15 deletions(-)

diff --git a/arch/arc/kernel/perf_event.c b/arch/arc/kernel/perf_event.c
index d60aaaead421..248c7b61690a 100644
--- a/arch/arc/kernel/perf_event.c
+++ b/arch/arc/kernel/perf_event.c
@@ -530,11 +530,39 @@ static int arc_pmu_raw_alloc(struct device *dev)
 	return 0;
 }
 
+static inline bool event_in_hw_event_map(int i, char *name)
+{
+	if (!arc_pmu_ev_hw_map[i])
+		return false;
+
+	if (!strlen(arc_pmu_ev_hw_map[i]))
+		return false;
+
+	if (strcmp(arc_pmu_ev_hw_map[i], name))
+		return false;
+
+	return true;
+}
+
+static void arc_pmu_map_hw_event(int j, char *str)
+{
+	int i;
+
+	/* See if HW condition has been mapped to a perf event_id */
+	for (i = 0; i < ARRAY_SIZE(arc_pmu_ev_hw_map); i++) {
+		if (event_in_hw_event_map(i, str)) {
+			pr_debug("mapping perf event %2d to h/w event \'%8s\' (idx %d)\n",
+				 i, str, j);
+			arc_pmu->ev_hw_idx[i] = j;
+		}
+	}
+}
+
 static int arc_pmu_device_probe(struct platform_device *pdev)
 {
 	struct arc_reg_pct_build pct_bcr;
 	struct arc_reg_cc_build cc_bcr;
-	int i, j, has_interrupts;
+	int i, has_interrupts;
 	int counter_size;	/* in bits */
 
 	union cc_name {
@@ -582,23 +610,13 @@ static int arc_pmu_device_probe(struct platform_device *pdev)
 		arc_pmu->ev_hw_idx[i] = -1;
 
 	/* loop thru all available h/w condition indexes */
-	for (j = 0; j < cc_bcr.c; j++) {
-		write_aux_reg(ARC_REG_CC_INDEX, j);
+	for (i = 0; i < cc_bcr.c; i++) {
+		write_aux_reg(ARC_REG_CC_INDEX, i);
 		cc_name.indiv.word0 = read_aux_reg(ARC_REG_CC_NAME0);
 		cc_name.indiv.word1 = read_aux_reg(ARC_REG_CC_NAME1);
 
-		/* See if it has been mapped to a perf event_id */
-		for (i = 0; i < ARRAY_SIZE(arc_pmu_ev_hw_map); i++) {
-			if (arc_pmu_ev_hw_map[i] &&
-			    !strcmp(arc_pmu_ev_hw_map[i], cc_name.str) &&
-			    strlen(arc_pmu_ev_hw_map[i])) {
-				pr_debug("mapping perf event %2d to h/w event \'%8s\' (idx %d)\n",
-					 i, cc_name.str, j);
-				arc_pmu->ev_hw_idx[i] = j;
-			}
-		}
-
-		arc_pmu_add_raw_event_attr(j, cc_name.str);
+		arc_pmu_map_hw_event(i, cc_name.str);
+		arc_pmu_add_raw_event_attr(i, cc_name.str);
 	}
 
 	arc_pmu_events_attr_gr.attrs = arc_pmu->attrs;
-- 
2.14.5

