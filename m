Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1314C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABB9720862
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dtcGRB6h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABB9720862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbeGKHte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 03:49:34 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:39531 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbeGKHte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 03:49:34 -0400
Received: by mail-pl0-f68.google.com with SMTP id s24-v6so8809272plq.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 00:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nbQNDlVOGZy2QG4EsYIlFoYPd9+L5V/lXajEoE4/YUc=;
        b=dtcGRB6hcydihMoQVZY0RMpBmfyAotIfsyezFIcF054L0tdbd2UZCDdD0R071SnLwj
         +5atqBg/hulDdnSS5VbYCae5BrKzalC8tMAvU64cZ10rqJf7cJpj4zlVj9XgJP4CuWeZ
         OajHpvk9idG9XPyFCzfyyLo9OMzuIYtUna7p8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nbQNDlVOGZy2QG4EsYIlFoYPd9+L5V/lXajEoE4/YUc=;
        b=X8kZaT+7BNbpt0akbMHKcrYhMNz7adosEshSJRVBA8GC364moeZywP+UXS468GOg0Y
         KxP9M9NxfJkdpdA7YspUA+rprygFCZseizmkaP7za45C5YSkgwbJylP1bHl2X0Eoj+Zx
         V6qgL/Sw8eX6qJae+Tx9pDsjdsk/Fg3usyB3FjdtB2eXdUfzP+giqPJ0ePBQo+69mw11
         LLRHC8DrOMBgypyVhrqnnPx5qy2zgLt+Xpv81ckAKA5UbLefpNn4Z6LKLjtUaYsLGlBd
         tIKpeyCksP6BYRfeQpoMa8wrP5lah6r9NZgvHnU/cqmwdKPsqtEGPoUMSf+9bm4092zP
         XFBA==
X-Gm-Message-State: APt69E0EEyT63F36az5M7eYFBaQ3GkP3vF2fViDFjMzpBpKyPP/1/QF5
        9c/prrWQxhTDLi7p8vjm9IXtcA==
X-Google-Smtp-Source: AAOMgpcGdLzwEJsCeysLYOKT1UNkSqWTn+9XMKoVzP+VS4jHHo0/45zgfpA5Fwb3g1fzE4MCkYfgLw==
X-Received: by 2002:a17:902:600d:: with SMTP id r13-v6mr27952076plj.70.1531295196100;
        Wed, 11 Jul 2018 00:46:36 -0700 (PDT)
Received: from localhost.localdomain (li1192-169.members.linode.com. [45.79.93.169])
        by smtp.gmail.com with ESMTPSA id 16-v6sm9260374pfp.6.2018.07.11.00.46.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Jul 2018 00:46:35 -0700 (PDT)
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
Subject: [PATCH v2 3/6] perf cs-etm: Fix start tracing packet handling
Date:   Wed, 11 Jul 2018 15:45:42 +0800
Message-Id: <1531295145-596-4-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531295145-596-1-git-send-email-leo.yan@linaro.org>
References: <1531295145-596-1-git-send-email-leo.yan@linaro.org>
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

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
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

