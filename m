Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AFAC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71C882081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WXuf8ZHg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71C882081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbeLDUjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 15:39:11 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45301 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbeLDUjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 15:39:08 -0500
Received: by mail-pg1-f195.google.com with SMTP id y4so7880773pgc.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 12:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n6NuaXTvDWIetVmFktrRRwuNkHydvvOOmRq+K+4VF1M=;
        b=WXuf8ZHgfXM8hFipNJqrnlBcTvAYQRbWJD2GjJ5MIM7fMqDI0QYHkKoH+/DcNC709E
         vhp/zGQPEQ3P1t9f/7s1dShvlZRqVS3pjoRceA3RG1w3NzympRlAmlFXd9MNmOnvnWwY
         yIAPJVMeSwKwxkv+GxVs22kvCaTfnuZ4kGtZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n6NuaXTvDWIetVmFktrRRwuNkHydvvOOmRq+K+4VF1M=;
        b=KWDeaHGMU6WenhP0TbdFbLN6C/SyMSIaVOeCfoJzevx4sEFq4379wgqUNSiFI5Ca8L
         HwqUGoVpfhhwSMhjgSh1pyUG4Tld4zvP95REsHIY6edw1p86Pn9DGdlioSg0hsXu0SQ2
         UFdyTTb6TMe1A1JnSF47ulQStjKgBQjwqmoc4A04WEcxIeq5QLVQcIfgV7gtALSC9hdQ
         pbk7jElA1xZPZgcxg34p8rk5iSi71WhHxhVq70M8IDVtksNfUaz1laiHVQqKIdwe9mz8
         aL/r2PcbCv7hJ3vSi0bxM0nR5O5tpowM+NqEqAc/cvuR2qOiTfVBQsI6bQ6O37ClespG
         MreQ==
X-Gm-Message-State: AA+aEWZC9Goq9AFlnHuhMszZ0wp/uMQAyX3JbR+b5CFBHVLEqKMsnl0R
        UciklBONGOlgyrrS8YOoMD/zFg==
X-Google-Smtp-Source: AFSGD/XFPys51mL/FCvJyVYk1cmoDEkNiPZ+EhuGcwY1q70CTrvY3tjbExa/gGEjq32eV0QqEcdtog==
X-Received: by 2002:a62:8949:: with SMTP id v70mr20951469pfd.85.1543955947701;
        Tue, 04 Dec 2018 12:39:07 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id r76sm29783274pfb.69.2018.12.04.12.39.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Dec 2018 12:39:07 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 1/3] perf tools: Add configuration for ETMv3 trace protocol
Date:   Tue,  4 Dec 2018 13:39:02 -0700
Message-Id: <1543955944-10042-2-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543955944-10042-1-git-send-email-mathieu.poirier@linaro.org>
References: <1543955944-10042-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch deals with the proper initialisation of configuration parameters
for the ETMv3 trace protocol in order to properly handle packets generated
by tracers following this specification.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |  8 ++++
 tools/perf/util/cs-etm.c                        | 54 ++++++++++++++++++-------
 2 files changed, 48 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index 612b5755f742..c0c67c919093 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -43,6 +43,13 @@ struct cs_etm_queue;
 typedef u32 (*cs_etm_mem_cb_type)(struct cs_etm_queue *, u64,
 				  size_t, u8 *);
 
+struct cs_etmv3_trace_params {
+	u32 reg_ctrl;
+	u32 reg_trc_id;
+	u32 reg_ccer;
+	u32 reg_idr;
+};
+
 struct cs_etmv4_trace_params {
 	u32 reg_idr0;
 	u32 reg_idr1;
@@ -55,6 +62,7 @@ struct cs_etmv4_trace_params {
 struct cs_etm_trace_params {
 	int protocol;
 	union {
+		struct cs_etmv3_trace_params etmv3;
 		struct cs_etmv4_trace_params etmv4;
 	};
 };
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 73430b73570d..830e9136ad7c 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -122,15 +122,28 @@ static void cs_etm__dump_event(struct cs_etm_auxtrace *etm,
 	/* Use metadata to fill in trace parameters for trace decoder */
 	t_params = zalloc(sizeof(*t_params) * etm->num_cpu);
 	for (i = 0; i < etm->num_cpu; i++) {
-		t_params[i].protocol = CS_ETM_PROTO_ETMV4i;
-		t_params[i].etmv4.reg_idr0 = etm->metadata[i][CS_ETMV4_TRCIDR0];
-		t_params[i].etmv4.reg_idr1 = etm->metadata[i][CS_ETMV4_TRCIDR1];
-		t_params[i].etmv4.reg_idr2 = etm->metadata[i][CS_ETMV4_TRCIDR2];
-		t_params[i].etmv4.reg_idr8 = etm->metadata[i][CS_ETMV4_TRCIDR8];
-		t_params[i].etmv4.reg_configr =
+		if (etm->metadata[i][CS_ETM_MAGIC] == __perf_cs_etmv3_magic) {
+			t_params[i].protocol = CS_ETM_PROTO_ETMV3;
+			t_params[i].etmv3.reg_ctrl =
+					etm->metadata[i][CS_ETM_ETMCR];
+			t_params[i].etmv3.reg_trc_id =
+					etm->metadata[i][CS_ETM_ETMTRACEIDR];
+		} else if (etm->metadata[i][CS_ETM_MAGIC] ==
+						      __perf_cs_etmv4_magic) {
+			t_params[i].protocol = CS_ETM_PROTO_ETMV4i;
+			t_params[i].etmv4.reg_idr0 =
+					etm->metadata[i][CS_ETMV4_TRCIDR0];
+			t_params[i].etmv4.reg_idr1 =
+					etm->metadata[i][CS_ETMV4_TRCIDR1];
+			t_params[i].etmv4.reg_idr2 =
+					etm->metadata[i][CS_ETMV4_TRCIDR2];
+			t_params[i].etmv4.reg_idr8 =
+					etm->metadata[i][CS_ETMV4_TRCIDR8];
+			t_params[i].etmv4.reg_configr =
 					etm->metadata[i][CS_ETMV4_TRCCONFIGR];
-		t_params[i].etmv4.reg_traceidr =
+			t_params[i].etmv4.reg_traceidr =
 					etm->metadata[i][CS_ETMV4_TRCTRACEIDR];
+		}
 	}
 
 	/* Set decoder parameters to simply print the trace packets */
@@ -360,15 +373,28 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
 		goto out_free;
 
 	for (i = 0; i < etm->num_cpu; i++) {
-		t_params[i].protocol = CS_ETM_PROTO_ETMV4i;
-		t_params[i].etmv4.reg_idr0 = etm->metadata[i][CS_ETMV4_TRCIDR0];
-		t_params[i].etmv4.reg_idr1 = etm->metadata[i][CS_ETMV4_TRCIDR1];
-		t_params[i].etmv4.reg_idr2 = etm->metadata[i][CS_ETMV4_TRCIDR2];
-		t_params[i].etmv4.reg_idr8 = etm->metadata[i][CS_ETMV4_TRCIDR8];
-		t_params[i].etmv4.reg_configr =
+		if (etm->metadata[i][CS_ETM_MAGIC] == __perf_cs_etmv3_magic) {
+			t_params[i].protocol = CS_ETM_PROTO_ETMV3;
+			t_params[i].etmv3.reg_ctrl =
+					etm->metadata[i][CS_ETM_ETMCR];
+			t_params[i].etmv3.reg_trc_id =
+					etm->metadata[i][CS_ETM_ETMTRACEIDR];
+		} else if (etm->metadata[i][CS_ETM_MAGIC] ==
+							__perf_cs_etmv4_magic) {
+			t_params[i].protocol = CS_ETM_PROTO_ETMV4i;
+			t_params[i].etmv4.reg_idr0 =
+					etm->metadata[i][CS_ETMV4_TRCIDR0];
+			t_params[i].etmv4.reg_idr1 =
+					etm->metadata[i][CS_ETMV4_TRCIDR1];
+			t_params[i].etmv4.reg_idr2 =
+					etm->metadata[i][CS_ETMV4_TRCIDR2];
+			t_params[i].etmv4.reg_idr8 =
+					etm->metadata[i][CS_ETMV4_TRCIDR8];
+			t_params[i].etmv4.reg_configr =
 					etm->metadata[i][CS_ETMV4_TRCCONFIGR];
-		t_params[i].etmv4.reg_traceidr =
+			t_params[i].etmv4.reg_traceidr =
 					etm->metadata[i][CS_ETMV4_TRCTRACEIDR];
+		}
 	}
 
 	/* Set decoder parameters to simply print the trace packets */
-- 
2.7.4

