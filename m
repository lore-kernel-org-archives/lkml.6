Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2419C43610
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 18:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 995FD20858
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 18:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="R1ccPhLH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 995FD20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390375AbeKQE4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 23:56:09 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36752 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729431AbeKQE4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 23:56:08 -0500
Received: by mail-pl1-f195.google.com with SMTP id y6-v6so3977479plt.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 10:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n6NuaXTvDWIetVmFktrRRwuNkHydvvOOmRq+K+4VF1M=;
        b=R1ccPhLHj0TC4DGM3KblDF7t12Rt2BugVfVHwvbJTHUx098oJNllJlLu4TV51/SVPN
         XLA2zI3pxrHS0DuQZu+TyZHIl9meV6Q4TyjC3ib1J4Qv22ifYEA/FyJNii0escXENlCe
         CwEVmBBXEPG8EQJKe59jjjtLkufkCxO08O1L4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n6NuaXTvDWIetVmFktrRRwuNkHydvvOOmRq+K+4VF1M=;
        b=lIWRErowW2MlxgW61BTEbSVswZZKe04Qk3ZmGs7fWOJ4wFuN4066r1G7Oi9ziqM6+x
         Bcgo58kFMvFdVXmobvAafNgFOOfS3LESNJE0khy4YwxsKk33GOz51O1RiYZ7RgbyloYU
         dmxoqv135EdOw2PXuGcX/RRkUIe0M9YRzsobURKIa6IseL+jJiljOsjC5mnLJis67T7P
         CkoypdKRTq8HyenFHlnWxP2xjnKZ8p4lKvX/M3cw35b/DPAGgxAjW9MC1B+OEnFFuov+
         Te1wqvswcNTHdEqlnZp6vFTxFPLaK0Wmor2Qc/Fnf5jsXUFUTVJ/1X6LzNTG1h6F1+Bp
         eBDA==
X-Gm-Message-State: AGRZ1gKwxdcxsfijRqIPzupmdMIa362qWE1PCl2X0g309kV3TJ5xYRm9
        WzXKaozoBeQv4kmMCJb4bEbx7g==
X-Google-Smtp-Source: AJdET5fOU0AYHccOihUyp9gEbFR6fKiQfwjqLKlZ4I3+1nzQVlZnz9Le8XnPPMk6eLWvAHsgAk2Bvg==
X-Received: by 2002:a17:902:6b01:: with SMTP id o1-v6mr12164938plk.333.1542393756105;
        Fri, 16 Nov 2018 10:42:36 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id v20-v6sm33724598pfm.114.2018.11.16.10.42.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 Nov 2018 10:42:35 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] perf tools: Add configuration for ETMv3 trace protocol
Date:   Fri, 16 Nov 2018 11:42:30 -0700
Message-Id: <1542393752-10196-2-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542393752-10196-1-git-send-email-mathieu.poirier@linaro.org>
References: <1542393752-10196-1-git-send-email-mathieu.poirier@linaro.org>
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

