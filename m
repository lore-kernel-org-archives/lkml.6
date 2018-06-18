Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CBFC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 05:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 368F320874
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 05:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OyyjVDI+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 368F320874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754814AbeFRFK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 01:10:58 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:41932 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754759AbeFRFKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 01:10:53 -0400
Received: by mail-pg0-f68.google.com with SMTP id l65-v6so6961507pgl.8
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jun 2018 22:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x4bCg0+QmGBErc/o9N6g33Yfeba+eCNRT/trwWTp3QM=;
        b=OyyjVDI+JmXNJCagSbatad/T/dqDZJk1jZWxeKF4K7sl7emYbGYdrFsfcKHSmf/Qcf
         cfxExGlwfxdBWfvgvRLcR9abTdyhQJGQ4igbfZR9nCgBGJrGGRDxQ9a7CvRx/Xh8XXCS
         dKty8p8y2v4Zc8wq/tNb6kwGBmctX/2tSV7IE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x4bCg0+QmGBErc/o9N6g33Yfeba+eCNRT/trwWTp3QM=;
        b=onczX00gwdWpii0FD1jPnRczk+nolsREDsaDXvY15kxZWTsjS/9xG+XrY0koUl+G6B
         jU6FaVotVinTPuNT8Qx6ZzP9I9Z2FhmtvUVrv3R2iqZpqP359NFr21OMgzUHWEgUSF0S
         2JiCHZgebo3V/7pzGUnt4QhUIvwmX9DGNOAxCloeAr6vyMmSmrNj4fFBsLGejb897wON
         bSnsjD0u5WkZkiYHw+ornbi09/k2aLUZzoN+3s7XZf6xdBDiYGTzMqZ3KQrV7v1AIpww
         khpn/ZdHbaQkbMBYRfARNQbiAS9cP/b59cMfZXTihc8mu9jUKSPGh5Jqs7uVHsiGtoPy
         Jjfg==
X-Gm-Message-State: APt69E2Rjd3Sh1IQFLke195CY/cNfjmLuqUh+A4g7JBRvjFC/8yqtZzD
        ZVdQtd7tCasqRWfppWQ8+1E4Vw==
X-Google-Smtp-Source: ADUXVKKB6KOp1TXUmjNcTJYXJfDeo9BBXmE0MepSLFLXSqBcv7lRhuCNQxZ3tWHMfxZ/9ISUJrGeUg==
X-Received: by 2002:a65:6343:: with SMTP id p3-v6mr9803912pgv.63.1529298652894;
        Sun, 17 Jun 2018 22:10:52 -0700 (PDT)
Received: from localhost.localdomain (li1181-92.members.linode.com. [45.79.82.92])
        by smtp.gmail.com with ESMTPSA id l15-v6sm29051710pfg.88.2018.06.17.22.10.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 17 Jun 2018 22:10:52 -0700 (PDT)
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
Subject: [PATCH v1 5/6] perf cs-etm: Generate branch sample when receiving a CS_ETM_TRACE_ON packet
Date:   Mon, 18 Jun 2018 13:09:58 +0800
Message-Id: <1529298599-3876-6-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529298599-3876-1-git-send-email-leo.yan@linaro.org>
References: <1529298599-3876-1-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If one CS_ETM_TRACE_ON packet is inserted, we miss to generate branch
sample for the previous CS_ETM_RANGE packet.

This patch is to generate branch sample when receiving a CS_ETM_TRACE_ON
packet, so this can save complete info for the previous CS_ETM_RANGE
packet just before CS_ETM_TRACE_ON packet.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 976db84..d3b7942 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -935,6 +935,7 @@ static int cs_etm__sample(struct cs_etm_queue *etmq)
 static int cs_etm__flush(struct cs_etm_queue *etmq)
 {
 	int err = 0;
+	struct cs_etm_auxtrace *etm = etmq->etm;
 	struct cs_etm_packet *tmp;
 
 	if (!etmq->prev_packet)
@@ -965,6 +966,13 @@ static int cs_etm__flush(struct cs_etm_queue *etmq)
 
 	}
 
+	if (etm->sample_branches &&
+	    etmq->prev_packet->sample_type == CS_ETM_RANGE) {
+		err = cs_etm__synth_branch_sample(etmq);
+		if (err)
+			return err;
+	}
+
 swap_packet:
 	if (etmq->etm->synth_opts.last_branch) {
 		/*
-- 
2.7.4

