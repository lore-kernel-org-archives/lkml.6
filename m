Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9644EC0044C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 05:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 617272087C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 05:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zax5fOHT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 617272087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbeKKOrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 09:47:47 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38524 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727184AbeKKOrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 09:47:46 -0500
Received: by mail-wm1-f67.google.com with SMTP id f2-v6so5193509wme.3
        for <linux-kernel@vger.kernel.org>; Sat, 10 Nov 2018 21:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GlLVr9yrcWWcrnJ7efExsQPwL3OrlynWDQhaVwy2gkU=;
        b=Zax5fOHToS2p6UfHN0dl+LYAknkoVGAwHHbiN+XuzZBA9NU/Jwwl2WueViP7g5ivm6
         bmZLBHRIzMTUFLo5xhr+tWi5+WmiYf9NkPvozoqidPO6jPYWLcZpGRBf/Oht74u/7teU
         bvpPmPMEA3aqB/3xKmeQy5s4VhhyAw2Xpd9xQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GlLVr9yrcWWcrnJ7efExsQPwL3OrlynWDQhaVwy2gkU=;
        b=Ngx9hmTokYlNYEe2m63Rd5RdW6G2XAO1QOmia1Zd45zvxd33zY94IhjF5iSQnp4hB0
         qET3eBH9pyQDNI4d+eTq1uz0687eVqIIuQmhfWk66N3gMU72YpYMIPGh9DosVZzM2sMt
         5888/I3Q2/5wPIAWiUfTcdCULngIvPpaplr61Z+jUcye0ZkiPSjM9bgKdXBy4LS67/xG
         DrRGK7Nrq9y/lxfxxfnhdwyVrE9r0K3T4H1dsqU9ouXTYi4Pn2JWrlmIIP/MlFiZaNJ6
         H+OVPJnMz9mpxrnZRyeSs5jqSJIaPh+0fgxi/9/9s1INIfrBCAlB/GG3rPcjoh7eVyC8
         sYog==
X-Gm-Message-State: AGRZ1gJBePFE992jyqkN4cUplNXPE5SfSQScHmiR8Nf8swv3lcW/7rxu
        RgEO6mYscF+JWma5v+bco23QWvmLSa2hUQ==
X-Google-Smtp-Source: AJdET5eFWX8l67VgF9fdPek6j3Q3dd9M6It0EjGMCLZtHQw1rPknB3WCRPp6m/PvqH7d/Na4QrHqmQ==
X-Received: by 2002:a1c:87cb:: with SMTP id j194-v6mr3643761wmd.2.1541912417568;
        Sat, 10 Nov 2018 21:00:17 -0800 (PST)
Received: from localhost.localdomain ([209.250.228.18])
        by smtp.gmail.com with ESMTPSA id t187-v6sm4463802wmt.45.2018.11.10.21.00.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 10 Nov 2018 21:00:16 -0800 (PST)
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
Subject: [PATCH v1 2/5] perf cs-etm: Avoid stale branch samples when flush packet
Date:   Sun, 11 Nov 2018 12:59:40 +0800
Message-Id: <1541912383-19915-3-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541912383-19915-1-git-send-email-leo.yan@linaro.org>
References: <1541912383-19915-1-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the end of trace buffer handling, function cs_etm__flush() is invoked
to flush any remaining branch stack entries.  As a side effect, it also
generates branch sample, because the 'etmq->packet' doesn't contains any
new coming packet but point to one stale packet after packets swapping,
so it wrongly makes synthesize branch samples with stale packet info.

We could review below detailed flow which causes issue:

  Packet1: start_addr=0xffff000008b1fbf0 end_addr=0xffff000008b1fbfc
  Packet2: start_addr=0xffff000008b1fb5c end_addr=0xffff000008b1fb6c

  step 1: cs_etm__sample():
	sample: ip=(0xffff000008b1fbfc-4) addr=0xffff000008b1fb5c

  step 2: flush packet in cs_etm__run_decoder():
	cs_etm__run_decoder()
	  `-> err = cs_etm__flush(etmq, false);
	sample: ip=(0xffff000008b1fb6c-4) addr=0xffff000008b1fbf0

Packet1 and packet2 are two continuous packets, when packet2 is the new
coming packet, cs_etm__sample() generates branch sample for these two
packets and use [packet1::end_addr - 4 => packet2::start_addr] as branch
jump flow, thus we can see the first generated branch sample in step 1.
At the end of cs_etm__sample() it swaps packets so 'etm->prev_packet'=
packet2 and 'etm->packet'=packet1, so far it's okay for branch sample.

If packet2 is the last one packet in trace buffer, even there have no
any new coming packet, cs_etm__run_decoder() invokes cs_etm__flush() to
flush branch stack entries as expected, but it also generates branch
samples by taking 'etm->packet' as a new coming packet, thus the branch
jump flow is as [packet2::end_addr - 4 =>  packet1::start_addr]; this
is the second sample which is generated in step 2.  So actually the
second sample is a stale sample and we should not generate it.

This patch is to add new argument 'new_packet' for cs_etm__flush(), we
can pass 'true' for this argument if there have a new packet, otherwise
it will pass 'false' for the purpose of only flushing branch stack
entries and avoid to generate sample for stale packet.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index fe18d7b..f4fa877 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -955,7 +955,7 @@ static int cs_etm__sample(struct cs_etm_queue *etmq)
 	return 0;
 }
 
-static int cs_etm__flush(struct cs_etm_queue *etmq)
+static int cs_etm__flush(struct cs_etm_queue *etmq, bool new_packet)
 {
 	int err = 0;
 	struct cs_etm_auxtrace *etm = etmq->etm;
@@ -989,6 +989,20 @@ static int cs_etm__flush(struct cs_etm_queue *etmq)
 
 	}
 
+	/*
+	 * If 'new_packet' is false, this time call has no a new packet
+	 * coming and 'etmq->packet' contains the stale packet which is
+	 * set at the previous time with packets swapping.  In this case
+	 * this function is invoked only for flushing branch stack at
+	 * the end of buffer handling.
+	 *
+	 * Simply to say, branch samples should be generated when every
+	 * time receive one new packet; otherwise, directly bail out to
+	 * avoid generate branch sample with stale packet.
+	 */
+	if (!new_packet)
+		return 0;
+
 	if (etm->sample_branches &&
 	    etmq->prev_packet->sample_type == CS_ETM_RANGE) {
 		err = cs_etm__synth_branch_sample(etmq);
@@ -1075,7 +1089,7 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 					 * Discontinuity in trace, flush
 					 * previous branch stack
 					 */
-					cs_etm__flush(etmq);
+					cs_etm__flush(etmq, true);
 					break;
 				case CS_ETM_EMPTY:
 					/*
@@ -1092,7 +1106,7 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 
 		if (err == 0)
 			/* Flush any remaining branch stack entries */
-			err = cs_etm__flush(etmq);
+			err = cs_etm__flush(etmq, false);
 	}
 
 	return err;
-- 
2.7.4

