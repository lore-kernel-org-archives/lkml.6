Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47172C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12464218A4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545171018;
	bh=oJsLDDuduz9xGHs2Ls/rINUNmYn2AP0b3+QGgt3wRwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B2yPYlIYkSx5Nm4QoJMSr63MyrZZ0/hJ2Aw6edcrm61iHVS4p7emyMz2AwNjruDv2
	 YIUVMAEVkZds+5W8SoSG6EEKEI/YYNqu/04sZnsNSTrYpjGs/wLunBMlYZaz5f6Emo
	 YLCY4ZpBYNQ8vt690Nv81MtjqcjKHBAvcmkukjeA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbeLRWKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:10:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:38668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726962AbeLRWKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:10:14 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.101.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A3A9217D9;
        Tue, 18 Dec 2018 22:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545171013;
        bh=oJsLDDuduz9xGHs2Ls/rINUNmYn2AP0b3+QGgt3wRwk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SeLcXSWd73lcmYLXiiM21fCBsVqiGEJgK4UlROfbqzhnH+skIAkPOOqdGmGVfHSf/
         ex46YxuQv4o5WwoXzbmUaS5pH+J75BRm5tWKQFdq5PiDS5OYO+qLO31/keThS0m5zj
         DS3NqZXOe+LbLC/sfKoL4jcqhIc9k4mSyNhT9wDA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mike Leach <mike.leach@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Robert Walker <robert.walker@arm.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 26/63] perf cs-etm: Correct packets swapping in cs_etm__flush()
Date:   Tue, 18 Dec 2018 19:06:56 -0300
Message-Id: <20181218220733.15839-27-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

The structure cs_etm_queue uses 'prev_packet' to point to previous
packet, this can be used to combine with new coming packet to generate
samples.

In function cs_etm__flush() it swaps packets only when the flag
'etm->synth_opts.last_branch' is true, this means that it will not swap
packets if without option '--itrace=il' to generate last branch entries;
thus for this case the 'prev_packet' doesn't point to the correct
previous packet and the stale packet still will be used to generate
sequential sample.  Thus if dump trace with 'perf script' command we can
see the incorrect flow with the stale packet's address info.

This patch corrects packets swapping in cs_etm__flush(); except using
the flag 'etm->synth_opts.last_branch' it also checks the another flag
'etm->sample_branches', if any flag is true then it swaps packets so can
save correct content to 'prev_packet'.  Finally this can fix the wrong
program flow dumping issue.

The patch has a minor refactoring to use 'etm->synth_opts.last_branch'
instead of 'etmq->etm->synth_opts.last_branch' for condition checking,
this is consistent with that is done in cs_etm__sample().

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Robert Walker <robert.walker@arm.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/1544513908-16805-2-git-send-email-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 23159c33db2a..789707bc4e9e 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1042,7 +1042,7 @@ static int cs_etm__flush(struct cs_etm_queue *etmq)
 	}
 
 swap_packet:
-	if (etmq->etm->synth_opts.last_branch) {
+	if (etm->sample_branches || etm->synth_opts.last_branch) {
 		/*
 		 * Swap PACKET with PREV_PACKET: PACKET becomes PREV_PACKET for
 		 * the next incoming packet.
-- 
2.19.2

