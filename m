Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8FDC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 06:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C77A327B46
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 06:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V932m0Q4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C77A327B46
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933943AbeF2GW1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 02:22:27 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:44873 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754342AbeF2GUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 02:20:02 -0400
Received: by mail-pg0-f68.google.com with SMTP id b10-v6so3534217pgq.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 23:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=S4eygS426BABBAsQSIESeCrT2oWeYHdrfhnghVokkWA=;
        b=V932m0Q4haBm2tcIysbJW8MMYcBwvDbEly/TZrjjyBjgxbCR/0s8FngAI1amd5iNcF
         kaGlaSEQfikQ1kkQNKteNjVo/goaM7pF0x2yFJVDsGWz1acsHfeAVyGmnPSjfPsBxSP9
         WgVksM6E5lXD40dnxxXwhqU4Dg76rfUALkwZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=S4eygS426BABBAsQSIESeCrT2oWeYHdrfhnghVokkWA=;
        b=SqCjNYkpK2wt7M2ooRZn39ML8WlIV/FSpWJAu9ooszkpbCVhkALzNuuiZxnsqp9d3V
         BoYJp4PyKgEZLWgvobawEoUVNidWij/1KnbXn3elsYQWubtMkGzwX78UuFNZYGApxre9
         3QOs8DFiBMQgluYiRklOnsx1gBYdSRevoB34DUAT1nszIAqgY37RKFtPiY5lnHHk2i5L
         y/0z553fj39uYCDtn+h33U93DnxxOoN+rs3HBVialklcoga2mkAm/I0ND+Jlyxg6zaQH
         3h6qWqzmAFucoNjgLDrUt2OoVlfQePPVIkYQOWkEu6q/jW/eHkEM2AS+Q1aw/L1TsDsS
         rgog==
X-Gm-Message-State: APt69E3PiKWP/99gxCitgEGpLBjNuD9y/SqwKFeyMKCXSKHqzW1BnPQ8
        HHIpbXwfBmeUXPLsQ/THCw+SKw==
X-Google-Smtp-Source: AAOMgpe9535S8Cd2JDRCzezBza+t9ku+jbYWNukszkUIIpgcO3LiWvvc26wLTGFauCT+OfKM8DRF2Q==
X-Received: by 2002:a62:1f8c:: with SMTP id l12-v6mr4414317pfj.143.1530253202061;
        Thu, 28 Jun 2018 23:20:02 -0700 (PDT)
Received: from localhost ([122.172.117.17])
        by smtp.gmail.com with ESMTPSA id f7-v6sm1976454pfj.101.2018.06.28.23.20.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 23:20:01 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/10] OPP: Identify and mark genpd OPP tables
Date:   Fri, 29 Jun 2018 11:49:32 +0530
Message-Id: <c24cb556bd674933df19bff0acc596d73e510706.1530252803.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a2c
In-Reply-To: <cover.1530252803.git.viresh.kumar@linaro.org>
References: <cover.1530252803.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to handle genpd OPP tables differently, this is already the case
at one location and will be extended going forward. Add another field to
the OPP table to check if the table belongs to a genpd or not.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/of.c  | 6 ++++--
 drivers/opp/opp.h | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 44a6b81fd228..218b8997d817 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -88,6 +88,9 @@ void _of_init_opp_table(struct opp_table *opp_table, struct device *dev)
 	of_property_read_u32(np, "voltage-tolerance",
 			     &opp_table->voltage_tolerance_v1);
 
+	if (of_find_property(np, "#power-domain-cells", NULL))
+		opp_table->is_genpd = true;
+
 	/* Get OPP table node */
 	opp_np = _opp_of_get_opp_desc_node(np, 0);
 	of_node_put(np);
@@ -314,8 +317,7 @@ static int _opp_add_static_v2(struct opp_table *opp_table, struct device *dev,
 	ret = of_property_read_u64(np, "opp-hz", &rate);
 	if (ret < 0) {
 		/* "opp-hz" is optional for devices like power domains. */
-		if (!of_find_property(dev->of_node, "#power-domain-cells",
-				      NULL)) {
+		if (!opp_table->is_genpd) {
 			dev_err(dev, "%s: opp-hz not found\n", __func__);
 			goto free_opp;
 		}
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 7c540fd063b2..3cd3b7b167b5 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -138,6 +138,7 @@ enum opp_table_access {
  * @regulators: Supply regulators
  * @regulator_count: Number of power supply regulators
  * @genpd_performance_state: Device's power domain support performance state.
+ * @is_genpd: Marks if the OPP table belongs to a genpd.
  * @set_opp: Platform specific set_opp callback
  * @set_opp_data: Data to be passed to set_opp callback
  * @dentry:	debugfs dentry pointer of the real device directory (not links).
@@ -174,6 +175,7 @@ struct opp_table {
 	struct regulator **regulators;
 	unsigned int regulator_count;
 	bool genpd_performance_state;
+	bool is_genpd;
 
 	int (*set_opp)(struct dev_pm_set_opp_data *data);
 	struct dev_pm_set_opp_data *set_opp_data;
-- 
2.18.0.rc1.242.g61856ae69a2c

