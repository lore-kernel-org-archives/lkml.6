Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBCBC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E3D020862
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fi9O/5uZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E3D020862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732289AbeGKHtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 03:49:49 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:39547 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbeGKHtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 03:49:49 -0400
Received: by mail-pl0-f67.google.com with SMTP id s24-v6so8809570plq.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 00:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XMQ9y3sIKTBhWg+aMmgR4c+8RQ5KqVUSz/E0xmozD0A=;
        b=fi9O/5uZlfCqJZApmRCZlROkMwiUzTJ1HpFl6g0HkcGHrOWzAgQwd+uu9Y2C7X8Fdl
         ZwQAS6BFAPmsRYEJYr5sXFmZkZQy9akfL1WEwvpIiqUULeRtv+tspKwjtXmLMN49pB3L
         uqH+BYc7dsPSFAwENwLBOxIc2z5fxaQUymIrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XMQ9y3sIKTBhWg+aMmgR4c+8RQ5KqVUSz/E0xmozD0A=;
        b=PfcWwvri3cUx9Pr6OBkTfzsV5vWmem7N91pAHLRrRK7sY+YrnnQ/xyJoAqhuyesnqg
         DTtT3N7/iqpaGllcD6YNcDHUg4aAtHsOaaFlxJ+9Bv2tVGSHyhlO0u/Z1L3Vga/YSc1c
         FokRrZXNGd+fFuxG4Y0By4lUAa9vsWKF/uGcLlEAZjbiG5asjscWbPMKRGa42tx8VRz2
         5LzEKedQcLsaVKBUhXDT6CCkR8yk+Nlld4gGRiuUL5SAmFKFkEWdigB++vjRf5Uia3T0
         y2ppbOv4lTinV2/yvvMrACT0M95fejHysTCzrQDIls6VAXS6uhv7A7hIQiOJyBWHaS6c
         rGWQ==
X-Gm-Message-State: APt69E1ANCJA09ejiCl74A6+G3t/+VWWjvoNlTlAsFeoVwU9X0VeT560
        hbICFg0Ez407Eb3ibbFbj4LU6WholDU=
X-Google-Smtp-Source: AAOMgpdXYB6DxUVhXNgVEJTzoSj3DhMtztLyM1oSE7BcRLQs5UaSc/7z/EL7kanWvzOU6uxCMHFh6Q==
X-Received: by 2002:a17:902:600d:: with SMTP id r13-v6mr27952646plj.70.1531295211467;
        Wed, 11 Jul 2018 00:46:51 -0700 (PDT)
Received: from localhost.localdomain (li1192-169.members.linode.com. [45.79.93.169])
        by smtp.gmail.com with ESMTPSA id 16-v6sm9260374pfp.6.2018.07.11.00.46.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Jul 2018 00:46:50 -0700 (PDT)
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
Subject: [PATCH v2 5/6] perf cs-etm: Generate branch sample when receiving a CS_ETM_TRACE_ON packet
Date:   Wed, 11 Jul 2018 15:45:44 +0800
Message-Id: <1531295145-596-6-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531295145-596-1-git-send-email-leo.yan@linaro.org>
References: <1531295145-596-1-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If one CS_ETM_TRACE_ON packet is inserted, we miss to generate branch
sample for the previous CS_ETM_RANGE packet.

This patch is to generate branch sample when receiving a CS_ETM_TRACE_ON
packet, so this can save complete info for the previous CS_ETM_RANGE
packet just before CS_ETM_TRACE_ON packet.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
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

