Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C54C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 05:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7339420874
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 05:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sy8DMrZ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7339420874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754739AbeFRFKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 01:10:51 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:40735 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754714AbeFRFKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 01:10:45 -0400
Received: by mail-pl0-f67.google.com with SMTP id t12-v6so8348976plo.7
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jun 2018 22:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RhXey0Jlqp5lMh1Tvv94h72eqzeQPgFS1KWBXkgo+88=;
        b=Sy8DMrZ+0L8KlPCHh3m6ZxpNJvameyteO5e2eariergV3cFQiXG71LmQaUWKOMpz9q
         uIqJmfpH6/DiryKCLnhSqJwAAy/jWqbwRBu5z9LgKWULVtlxBlkkMZPehdxsOQQCF74/
         WdRcJnbHLd/0+YaZPjdqh/Wtie/b+tJXiYnhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RhXey0Jlqp5lMh1Tvv94h72eqzeQPgFS1KWBXkgo+88=;
        b=RsC3zRzfsrK6H04nVWBSjD4izP3SpqeTAV7Q+wWLwnQFDnFZyDH8/3G4603zG9bjfl
         ZqJq3Rlqzw8KFOJQ8e9fehDOF0jgiFFx4n9tEsGUldNEBe7cR/LrgAoia5/pG0mFudvo
         dtQeReYvJ2UWFdT0JEvHoXnp2c9W5Ji/XsMNmULsOSTwnsNC7bkP27A5CBfDbcV84EDQ
         6Cq5X/+/lnQ+PAJzejmlrqxruVzzDoBFzNzWz8jgPwhgQevE4/zsRiebA52FLNYJ7TZy
         Ftb5+Tl0WeiAv+xws7b5yF2W7jmnVqCOZjjY9+tRDFZbT5drFsXE3Jor3bqUzrJTYkIs
         zLWQ==
X-Gm-Message-State: APt69E3SNuXDu479CicTpJHwTONA0761Oxf7nS9+Z1RGKdae1Vfqalxx
        x8XKoysDBjnRHWwwhWkiINj7pdK8TtA=
X-Google-Smtp-Source: ADUXVKLMerL6aOaaHzGlvU2J2aJjXdF1EPE91BVHYMl4okHqGtRJDWYr5iQxQBPpHjEahyZ2e71iJw==
X-Received: by 2002:a17:902:9685:: with SMTP id n5-v6mr12366608plp.15.1529298645013;
        Sun, 17 Jun 2018 22:10:45 -0700 (PDT)
Received: from localhost.localdomain (li1181-92.members.linode.com. [45.79.82.92])
        by smtp.gmail.com with ESMTPSA id l15-v6sm29051710pfg.88.2018.06.17.22.10.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 17 Jun 2018 22:10:44 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Kim Phillips <kim.phillips@arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 3/6] perf cs-etm: Fix start tracing packet handling
Date:   Mon, 18 Jun 2018 13:09:56 +0800
Message-Id: <1529298599-3876-4-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529298599-3876-1-git-send-email-leo.yan@linaro.org>
References: <1529298599-3876-1-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Usually the start tracing packet is a CS_ETM_TRACE_ON packet, this
packet is passed to cs_etm__flush();  cs_etm__flush() will check the
condition 'prev_packet->sample_type == CS_ETM_RANGE' but 'prev_packet'
is allocated by zalloc() so 'prev_packet->sample_type' is zero in
initialization and this condition is false.  So cs_etm__flush() will
directly bail out without handling the start tracing packet.

This patch is to introduce a new sample type CS_ETM_EMPTY, which is used
to indicate the packet is an empty packet.  cs_etm__flush() will swap
packets when it finds the previous packet is empty, so this can record
the start tracing packet into 'etmq->prev_packet'.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |  1 +
 tools/perf/util/cs-etm.c                        | 19 ++++++++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index 743f5f4..612b575 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -23,6 +23,7 @@ struct cs_etm_buffer {
 };
 
 enum cs_etm_sample_type {
+	CS_ETM_EMPTY = 0,
 	CS_ETM_RANGE = 1 << 0,
 	CS_ETM_TRACE_ON = 1 << 1,
 };
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 8b2c099..ae7c9c88 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -924,8 +924,14 @@ static int cs_etm__flush(struct cs_etm_queue *etmq)
 	int err = 0;
 	struct cs_etm_packet *tmp;
 
+	if (!etmq->prev_packet)
+		return 0;
+
+	/* Handle start tracing packet */
+	if (etmq->prev_packet->sample_type == CS_ETM_EMPTY)
+		goto swap_packet;
+
 	if (etmq->etm->synth_opts.last_branch &&
-	    etmq->prev_packet &&
 	    etmq->prev_packet->sample_type == CS_ETM_RANGE) {
 		/*
 		 * Generate a last branch event for the branches left in the
@@ -944,6 +950,10 @@ static int cs_etm__flush(struct cs_etm_queue *etmq)
 
 		etmq->period_instructions = 0;
 
+	}
+
+swap_packet:
+	if (etmq->etm->synth_opts.last_branch) {
 		/*
 		 * Swap PACKET with PREV_PACKET: PACKET becomes PREV_PACKET for
 		 * the next incoming packet.
@@ -1023,6 +1033,13 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 					 */
 					cs_etm__flush(etmq);
 					break;
+				case CS_ETM_EMPTY:
+					/*
+					 * Should not receive empty packet,
+					 * report error.
+					 */
+					pr_err("CS ETM Trace: empty packet\n");
+					return -EINVAL;
 				default:
 					break;
 				}
-- 
2.7.4

