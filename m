Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6166AC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 05:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A6BB20854
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 05:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kX3Ru026"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A6BB20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbeKKOrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 09:47:43 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36476 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727184AbeKKOrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 09:47:43 -0500
Received: by mail-wm1-f67.google.com with SMTP id v70-v6so4777763wmd.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Nov 2018 21:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZbLjNsAHRTQqCj6a1vHW0MpbOVGBpYLMhVIToqZ+NHM=;
        b=kX3Ru026f/ESYt6B1mTZGk6Ey5ia7fEi5PJ8IB30wxK77FSFx+/TfmzhW8Rt1b9Mws
         oOALFaXam6s1cb/uM7MDCMsKmVuZD/KEnnc/V2aTzpS+VR8Sng/OTGhv8T2Hcedq4IC5
         /gqUm0MrB1tnHKUHCkfhRdA9rVW2rc1/3D1h0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZbLjNsAHRTQqCj6a1vHW0MpbOVGBpYLMhVIToqZ+NHM=;
        b=nKVLLSOz1CWdNmJp5vXSngP3otcpnop2L8gxUNAGtKOsthsQBFUmhFLKrmpftqRUY2
         FjHOAd4h6luqUeV9oUa20hC1tqaaBAs9uvk/eqC3YK4MjfAcU/hN1jaLc2v2uBZz5dE3
         wPPBEctpNa7qPmOujPxXAAyuit0BfGCudOLr3a1n4kABbA5lHIECHnNmWZXDuH/gggu8
         vnit9x1G/M4el/w2MCXlrXMrk2RGxfD9WbKy7iZd9WD8uU5Z8GCvSTKB01QgDEt+3gLS
         djyAinaGTomr3VAGeNoOgepI5F4SAstx9Ap/4Bvh8Gh7ruQYTWjdCJyJVt/mVybqRG+D
         xsaA==
X-Gm-Message-State: AGRZ1gLlXH++AxEu3E3rvnUDfTIuOWsZ0ddLdcRgnTj4inmDVrGcNhpE
        q4QiwjUI4dQLXcrwDRjR+zuMbw==
X-Google-Smtp-Source: AJdET5ejhEC3H59ksDNIqZ7pDurxMCKolOx6CkcWZbpe6L85ZBFDPezUvVq4lnuT8PPxig93aUzm6A==
X-Received: by 2002:a1c:1a53:: with SMTP id a80-v6mr3928909wma.120.1541912413637;
        Sat, 10 Nov 2018 21:00:13 -0800 (PST)
Received: from localhost.localdomain ([209.250.228.18])
        by smtp.gmail.com with ESMTPSA id t187-v6sm4463802wmt.45.2018.11.10.21.00.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 10 Nov 2018 21:00:12 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Al Grant <Al.Grant@arm.com>,
        Coresight ML <coresight@lists.linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 1/5] perf cs-etm: Correct packets swapping in cs_etm__flush()
Date:   Sun, 11 Nov 2018 12:59:39 +0800
Message-Id: <1541912383-19915-2-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541912383-19915-1-git-send-email-leo.yan@linaro.org>
References: <1541912383-19915-1-git-send-email-leo.yan@linaro.org>
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

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 48ad217..fe18d7b 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -997,7 +997,7 @@ static int cs_etm__flush(struct cs_etm_queue *etmq)
 	}
 
 swap_packet:
-	if (etmq->etm->synth_opts.last_branch) {
+	if (etm->sample_branches || etmq->etm->synth_opts.last_branch) {
 		/*
 		 * Swap PACKET with PREV_PACKET: PACKET becomes PREV_PACKET for
 		 * the next incoming packet.
-- 
2.7.4

