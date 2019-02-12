Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFB4C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CD50222C1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GGgVP5XA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731779AbfBLRQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:16:27 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41250 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731754AbfBLRQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:16:25 -0500
Received: by mail-pf1-f195.google.com with SMTP id b7so1588535pfi.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 09:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d25EPOQ1/eL3uzzHkP0zLvCcnfX2yAd0t0DIGDfrgSI=;
        b=GGgVP5XANqmy0QCTFX14LkYAMfmmOgC+GSwRJVdBwgg6qA4U2J3nPYCMpJGBUMLBVO
         AZjG/MNQ8hDEjiDqMc7REehUZAAgXjHgdwvn4fXZQBpb9MdarapyjHATTQXqIs06Nsd1
         JVUaQwcXhP4Pv2xCAH2lxRHrSk8Y4Zz11CLrPNGi0OlsW+5NPA0p+g2vmRqCG6N+qZma
         YPwbgX4eLoebY3fTdh+IAgE/6DPaR4VghWMZQQGyfFuRAtxiz6+FTYVtN8V3qkjN3WXT
         yrtFDXN/BLx2dMOn7AmYBNMTUtdUTr3iaOmhWqKyLCZdyJSnWFKfNRhIvjFRC6om8a9c
         7igw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d25EPOQ1/eL3uzzHkP0zLvCcnfX2yAd0t0DIGDfrgSI=;
        b=D8W8dDGJyKlCiRegYMISW82oDiNZ5hJ4sbPWIV0YnD46VRf6V0g2U6uDI5NzJgQCuS
         5MPPVl69dxBMyM6FDeZ09fQH60vYX6t0b1YBM6dTfAC5dJ0p0rh5hrz9Tzxou9tbVLfn
         NPs2O0D7OA4Ec+qWPl24lsRT+VNdpSAOY5k1atRtD0i27gaQIgPE+rOvTJSDWE+MwbMH
         58HPp4aLyTfyCbOP8auLhAkO2jcqEsC/YIKP9KJuNvH/u6LPeyQfcpIEgKfOwd4lFjs9
         XkSKW1qLAz/oxiDVaBe/WJHkq1O6Jkbm9s5KQB9G99GW5zQAtpj4kD886ukNXuGy7wiO
         1j5A==
X-Gm-Message-State: AHQUAuZkLGa7liFdZk4Ybekgl8eQs3eauxZZs4BTbO1Ro4D624LZpsaW
        90BK2kDxEBrFHq50XlE9z9fyjQ==
X-Google-Smtp-Source: AHgI3IZJVTS6IpcnyXXlDDqH6NHHCMl2J6tP6lo1Wl2h/tBadSM4FIAOed+uLa5bWjcZ4dbtK5AMMQ==
X-Received: by 2002:aa7:808a:: with SMTP id v10mr5037856pff.8.1549991784951;
        Tue, 12 Feb 2019 09:16:24 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id z4sm8659231pgu.10.2019.02.12.09.16.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 09:16:24 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org
Cc:     suzuki.poulose@arm.com, mingo@redhat.com, peterz@infradead.org,
        jolsa@redhat.com, leo.yan@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/13] perf tools: Introducing function cs_etm_decoder__init_dparams()
Date:   Tue, 12 Feb 2019 10:16:09 -0700
Message-Id: <20190212171618.25355-5-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212171618.25355-1-mathieu.poirier@linaro.org>
References: <20190212171618.25355-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introducing function cs_etm_decoder__init_dparams() to avoid repeating
code at two different places.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../perf/util/cs-etm-decoder/cs-etm-decoder.h |  3 +-
 tools/perf/util/cs-etm.c                      | 41 +++++++++++++------
 2 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index 7e6a8850be4a..663309486784 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -105,9 +105,10 @@ enum {
 	CS_ETM_PROTO_PTM,
 };
 
-enum {
+enum cs_etm_decoder_operation {
 	CS_ETM_OPERATION_PRINT = 1,
 	CS_ETM_OPERATION_DECODE,
+	CS_ETM_OPERATION_MAX,
 };
 
 int cs_etm_decoder__process_data_block(struct cs_etm_decoder *decoder,
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index f396fee9bb95..3011c6cae531 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -136,6 +136,28 @@ static void cs_etm__packet_dump(const char *pkt_string)
 	fflush(stdout);
 }
 
+static int cs_etm__init_decoder_params(struct cs_etm_decoder_params *d_params,
+				       struct cs_etm_queue *etmq,
+				       enum cs_etm_decoder_operation mode)
+{
+	int ret = -EINVAL;
+
+	if (!(mode < CS_ETM_OPERATION_MAX))
+		goto out;
+
+	d_params->packet_printer = cs_etm__packet_dump;
+	d_params->operation = mode;
+	d_params->data = etmq;
+	d_params->formatted = true;
+	d_params->fsyncs = false;
+	d_params->hsyncs = false;
+	d_params->frame_aligned = true;
+
+	ret = 0;
+out:
+	return ret;
+}
+
 static void cs_etm__dump_event(struct cs_etm_auxtrace *etm,
 			       struct auxtrace_buffer *buffer)
 {
@@ -182,12 +204,9 @@ static void cs_etm__dump_event(struct cs_etm_auxtrace *etm,
 	}
 
 	/* Set decoder parameters to simply print the trace packets */
-	d_params.packet_printer = cs_etm__packet_dump;
-	d_params.operation = CS_ETM_OPERATION_PRINT;
-	d_params.formatted = true;
-	d_params.fsyncs = false;
-	d_params.hsyncs = false;
-	d_params.frame_aligned = true;
+	if (cs_etm__init_decoder_params(&d_params, NULL,
+					CS_ETM_OPERATION_PRINT))
+		return;
 
 	decoder = cs_etm_decoder__new(etm->num_cpu, &d_params, t_params);
 
@@ -436,13 +455,9 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
 	}
 
 	/* Set decoder parameters to simply print the trace packets */
-	d_params.packet_printer = cs_etm__packet_dump;
-	d_params.operation = CS_ETM_OPERATION_DECODE;
-	d_params.formatted = true;
-	d_params.fsyncs = false;
-	d_params.hsyncs = false;
-	d_params.frame_aligned = true;
-	d_params.data = etmq;
+	if (cs_etm__init_decoder_params(&d_params, etmq,
+					CS_ETM_OPERATION_DECODE))
+		goto out_free;
 
 	etmq->decoder = cs_etm_decoder__new(etm->num_cpu, &d_params, t_params);
 
-- 
2.17.1

