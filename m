Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF823C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89DBE2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IgzZwIgR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89DBE2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbeLKHkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 02:40:37 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:45990 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbeLKHkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 02:40:36 -0500
Received: by mail-wr1-f54.google.com with SMTP id b14so12949213wru.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 23:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mLWiAqN9O2/h7R2V1jDZK7ROs4Kq3pLvcay7+sOXvAk=;
        b=IgzZwIgRJYXQqYm4CKMxjNs8DOwkpBTMmA2RqZsUDz0n5lKYvy1PIY7p2OxGnpbfzD
         5c57q1h8fV0zuqoGByB+LWOJgV8lwQQZs/jYNIfNlBrOmLDEY9P5/HGzoxwJke1xB7qs
         BlEmYhpZwAlinsi76PLA+86t/oAWID8wS9Ckg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mLWiAqN9O2/h7R2V1jDZK7ROs4Kq3pLvcay7+sOXvAk=;
        b=Bq873YSBJXJQ5MDfPxI3/VpzY1TMb2NrOaRhNty1rZQu4IsJC7Vt6TDS1KTDkjB16n
         iYfpa3nKtDypu66XnlYaRd/UKm2CssT6+yj+iJSc5TCGVONRkGbZsrZ4cIUojuebCFQY
         NkUYny/GhJmvD53Cbp651721pQ/XGL50SkRMiMf777ApJa1AprfGEf2xUZ3dx1mNKils
         7SmrAPD+U8Q7ESdAS0zWElFintGdQaOSBivBwX0c2ln7iLm6KtaK5d2Cyj+QKnlUCNWN
         q3TZok0V77kjRaCMA3DGA0jNpKYwXihGh/qt9uLImyIp2psT3ryYtAQax+BPLVfqdjxr
         4B6w==
X-Gm-Message-State: AA+aEWYc/ttjY7ggcs7t82OLnqsmWUJiRb2XrNToTZti6EP0XmpKKYYA
        if/QdMxSmkB8B9h0B0B+x5kmAA==
X-Google-Smtp-Source: AFSGD/UlMzW0Tv2s9wPCu4ZjNP+tCIH7yfFpeepTHHfXnnT/DPwXYJoSg8LDDo299fvUOfbp+GIskQ==
X-Received: by 2002:adf:e149:: with SMTP id f9mr13540430wri.42.1544514033386;
        Mon, 10 Dec 2018 23:40:33 -0800 (PST)
Received: from localhost.localdomain ([209.250.228.18])
        by smtp.gmail.com with ESMTPSA id k7sm14186961wrl.51.2018.12.10.23.40.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Dec 2018 23:40:32 -0800 (PST)
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
Subject: [PATCH v3 2/8] perf cs-etm: Avoid stale branch samples when flush packet
Date:   Tue, 11 Dec 2018 15:38:22 +0800
Message-Id: <1544513908-16805-3-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544513908-16805-1-git-send-email-leo.yan@linaro.org>
References: <1544513908-16805-1-git-send-email-leo.yan@linaro.org>
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

This patch introduces a new function cs_etm__end_block(), at the end of
trace block this function is invoked to only flush branch stack entries
and thus can avoid to generate branch sample for stale packet.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Robert Walker <robert.walker@arm.com>
---
 tools/perf/util/cs-etm.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 789707b..ffc4fe5 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1055,6 +1055,39 @@ static int cs_etm__flush(struct cs_etm_queue *etmq)
 	return err;
 }
 
+static int cs_etm__end_block(struct cs_etm_queue *etmq)
+{
+	int err;
+
+	/*
+	 * It has no new packet coming and 'etmq->packet' contains the stale
+	 * packet which was set at the previous time with packets swapping;
+	 * so skip to generate branch sample to avoid stale packet.
+	 *
+	 * For this case only flush branch stack and generate a last branch
+	 * event for the branches left in the circular buffer at the end of
+	 * the trace.
+	 */
+	if (etmq->etm->synth_opts.last_branch &&
+	    etmq->prev_packet->sample_type == CS_ETM_RANGE) {
+		/*
+		 * Use the address of the end of the last reported execution
+		 * range.
+		 */
+		u64 addr = cs_etm__last_executed_instr(etmq->prev_packet);
+
+		err = cs_etm__synth_instruction_sample(
+			etmq, addr,
+			etmq->period_instructions);
+		if (err)
+			return err;
+
+		etmq->period_instructions = 0;
+	}
+
+	return 0;
+}
+
 static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 {
 	struct cs_etm_auxtrace *etm = etmq->etm;
@@ -1137,7 +1170,7 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 
 		if (err == 0)
 			/* Flush any remaining branch stack entries */
-			err = cs_etm__flush(etmq);
+			err = cs_etm__end_block(etmq);
 	}
 
 	return err;
-- 
2.7.4

