Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79D5C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD0D120855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bxt7r7e1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD0D120855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbeLJIxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 03:53:25 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41710 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbeLJIxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 03:53:24 -0500
Received: by mail-wr1-f68.google.com with SMTP id x10so9538678wrs.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 00:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=39wBlDXGyPZlvdOM4v0qZ1Ghil7xJLHLF05MaMBQC4c=;
        b=bxt7r7e1AGI4295LFa3jazbFqPFJ32MDDhQyDn4+GuLOA0SEIMz9uk5rORpI2g3oZN
         qDMO3WpYTVfLKNe8SNjhp0YhRcwg2b6cjABzskwJK1WY2p+BK0xRMR3B0NehJEMpd2LE
         HL5EBnL+r1UUHKvB2FEbsUt2ojc/XuzWq95W4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=39wBlDXGyPZlvdOM4v0qZ1Ghil7xJLHLF05MaMBQC4c=;
        b=X9+eTCgBe049Soovy1WhuDz2QgmL3RS/sXPqSJxuzI6FG8RZdfoVoUppfxZH0ocoAx
         wJwuCWPmrJbijsa1Mz3tndIbaUn85/H42Zmiu/NScZyRzz6rXXDEOkX/4PDBhnkZqF9P
         1dmip+IaRl6PZnZw+3TK+E0hLQfuPx89MYiE6Z24k5GIu0myP8hIGv9i1z67pDbPcW6m
         m+NsycQVuVvDYyYvsfwCFMMYJj5pFNYvl2aD5o9PoG7erbFc7l8R29TjOtUbsFP/XIAW
         3t0D/AE0W1hrTpJb5lzC3ZK0IFiHwvcVmKthEgrQuKo4z6rIz5eU7+/H3bfGS2fcPItM
         UXqA==
X-Gm-Message-State: AA+aEWaZlDf39rbP7WOk/nRJJlkn2lN2v81flFEAvC+CE7+flvcZjscV
        Am5b6e2VqqJv1zCDss8BJ2mq0w==
X-Google-Smtp-Source: AFSGD/UCxOAAimwOtRz+m3ihM9FavjpRssg34v7WWRaeSby5HSzfleS40mAdMNyu1M2pfger1AN2sw==
X-Received: by 2002:adf:be0f:: with SMTP id n15mr9403212wrh.267.1544432002659;
        Mon, 10 Dec 2018 00:53:22 -0800 (PST)
Received: from localhost.localdomain ([209.250.228.18])
        by smtp.gmail.com with ESMTPSA id m4sm9097351wml.2.2018.12.10.00.53.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Dec 2018 00:53:21 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Coresight ML <coresight@lists.linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>, Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>
Subject: [PATCH v2 1/6] perf cs-etm: Correct packets swapping in cs_etm__flush()
Date:   Mon, 10 Dec 2018 16:52:56 +0800
Message-Id: <1544431981-24144-2-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544431981-24144-1-git-send-email-leo.yan@linaro.org>
References: <1544431981-24144-1-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The structure cs_etm_queue uses 'prev_packet' to point to previous
packet, this can be used to combine with new coming packet to generate
samples.

In function cs_etm__flush() it swaps packets only when the flag
'etm->synth_opts.last_branch' is true, this means that it will not
swap packets if without option '--itrace=il' to generate last branch
entries; thus for this case the 'prev_packet' doesn't point to the
correct previous packet and the stale packet still will be used to
generate sequential sample.  Thus if dump trace with 'perf script'
command we can see the incorrect flow with the stale packet's address
info.

This patch corrects packets swapping in cs_etm__flush(); except using
the flag 'etm->synth_opts.last_branch' it also checks the another flag
'etm->sample_branches', if any flag is true then it swaps packets so
can save correct content to 'prev_packet'.  Finally this can fix the
wrong program flow dumping issue.

The patch has a minor refactoring to use 'etm->synth_opts.last_branch'
instead of 'etmq->etm->synth_opts.last_branch' for condition checking,
this is consistent with that is done in cs_etm__sample().

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Robert Walker <robert.walker@arm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 23159c33..789707b 100644
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
2.7.4

