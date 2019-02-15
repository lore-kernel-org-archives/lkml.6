Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B75C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59D35222C9
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550191664;
	bh=pOeRP4uZkpi3aMp0MnlfEAGPtSqz5e2gzJj/+OoQsRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Jjjc9HmNxjKogty6VPb1kmvPkvuCvb3WlS+tXyfOpFLklFgTtN8U5GjTcnt9xRSZu
	 bZzFYV2tZfPZC4omAAAE0KpTQ9IUCKoEy2PW89tHTB7ryZJF5DNtu+4kVW274wU4e0
	 6DXJkKS77pwFDHOH6lBzG6Mt7xCrd2go8Y1hHmoQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730478AbfBOArl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 19:47:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:46424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389281AbfBOArh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 19:47:37 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.103.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36E24222C9;
        Fri, 15 Feb 2019 00:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550191656;
        bh=pOeRP4uZkpi3aMp0MnlfEAGPtSqz5e2gzJj/+OoQsRw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zK/XHAsa7izj1acW4Xdbe4LufcCrIPpSweD0YK9HyzDdXApiNPYLADXrXA5TQX+lG
         cY35qBPjAPhKg32/hdEYNrM964tJbLiViFca/qAJ68pSkP9DrbC5zMLavg36Zt97Bo
         1ILSiltBJKnQdTYcLjNq/G1q6jVZ/eC4w5wyK1Pc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Jiri Olsa <jolsa@redhat.com>, Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Suzuki K Poulouse <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 25/43] perf cs-etm: Fix wrong return values in error path
Date:   Thu, 14 Feb 2019 21:45:21 -0300
Message-Id: <20190215004539.23571-26-acme@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215004539.23571-1-acme@kernel.org>
References: <20190215004539.23571-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

Function cs_etm__mem_access() is supposed to return a u32 but the error
path returns negative values at a couple of places, something that really
throws off the clients using it.  Fix the situation by return '0'.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki K Poulouse <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190212171618.25355-4-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 1d9419a0cf0c..f396fee9bb95 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -324,7 +324,7 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u64 address,
 	struct	 addr_location al;
 
 	if (!etmq)
-		return -1;
+		return 0;
 
 	machine = etmq->etm->machine;
 	cpumode = cs_etm__cpu_mode(etmq, address);
@@ -332,7 +332,7 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u64 address,
 	thread = etmq->thread;
 	if (!thread) {
 		if (cpumode != PERF_RECORD_MISC_KERNEL)
-			return -EINVAL;
+			return 0;
 		thread = etmq->etm->unknown_thread;
 	}
 
-- 
2.19.1

