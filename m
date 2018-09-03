Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE06C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBFD420843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPs40S+t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBFD420843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbeICTNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 15:13:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:43630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbeICTNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 15:13:19 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B21B2086A;
        Mon,  3 Sep 2018 14:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535986368;
        bh=JDuQ6xyieVkI2yrT3WAHQOECe9kTNd69AWiPxyUIDZ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YPs40S+twRSp3ZNP321S4lMN50ue9XgVFiOCnusJd5cUunYiv9cMIo9I5fHnQmhiM
         IFMvV4DIysbqDoXDB0Zt1rYLmnES9xM79rrC5ZLS1VD3ws4oIrrv2ExG/hawn1J8UW
         VF7Q0BJSj1WqBIvOcU9kOqHn1jI3tj8gmYj3luAM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Milind Chabbi <chabbi.milind@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 05/13] perf/hw_breakpoint: Enable breakpoint in modify_user_hw_breakpoint
Date:   Mon,  3 Sep 2018 11:52:16 -0300
Message-Id: <20180903145224.12318-6-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180903145224.12318-1-acme@kernel.org>
References: <20180903145224.12318-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Currently we enable the breakpoint back only if the breakpoint
modification was successful. If it fails we can leave the breakpoint in
disabled state with attr->disabled == 0.

We can safely enable the breakpoint back for both the fail and success
paths by checking the bp->attr.disabled, which either holds the new
'requested' disabled state or the original breakpoint state.

Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Milind Chabbi <chabbi.milind@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180827091228.2878-5-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 kernel/events/hw_breakpoint.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 3e560d7609fd..d6b56180827c 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -523,13 +523,11 @@ int modify_user_hw_breakpoint(struct perf_event *bp, struct perf_event_attr *att
 		perf_event_disable(bp);
 
 	err = modify_user_hw_breakpoint_check(bp, attr, false);
-	if (err)
-		return err;
 
-	if (!attr->disabled)
+	if (!bp->attr.disabled)
 		perf_event_enable(bp);
 
-	return 0;
+	return err;
 }
 EXPORT_SYMBOL_GPL(modify_user_hw_breakpoint);
 
-- 
2.14.4

