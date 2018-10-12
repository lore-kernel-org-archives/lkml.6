Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD565C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F6F42077C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="b5I2tJ7d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F6F42077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbeJLSnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 14:43:40 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41406 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728112AbeJLSnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 14:43:40 -0400
Received: by mail-pg1-f195.google.com with SMTP id 23-v6so5699587pgc.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 04:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6VbMN0cDbtfY/RD+G5z/cfGgvp3V9Mjd6fc+0SIk7q0=;
        b=b5I2tJ7dYL9/0L0H4NCF86b+4oh+7rhuCZQsxYhHf5eKcv5WOkx1x9x3Rv0KYV9L+Z
         RkTM33S6nvAkGdZGrkQWTBcwdootynnw1ZdClJjxguLb90w0I4z5KgY33hQYTGFHKjJk
         Rs1z+H0rOepvLaCpOOrXRNsjk4QVrrNBxqiY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6VbMN0cDbtfY/RD+G5z/cfGgvp3V9Mjd6fc+0SIk7q0=;
        b=maiCEMoMd5tt6w0FP424I3xoGGBnbuXpLLiJS9It8D98gdBtYFGgYwNhyxrgoEbtYz
         aCTv9Eh3Sx6K1+z1LtI0ROHyCe6Q3hwf2FNrgU6U1AO4mIV3aOXcf2zp58k4oYk+c3RW
         TC49jyk4yresvai6LM8DU8mA1nam5qWVyUbvX2SCMo8IVuOw+rraSmnk9hH5pRsMH2j8
         LIpTBgM7np9MSjjyRu8NCUgz7V16GJjyn9n1qWFKhlCwUnU+3yF6V3sgNfenNPjph67D
         KrJQ1j8VyWU/5gPovGhUVtaM3ZG0GbQh6VPiGCtxkDBh+p7TX7InWrs5lj6S2cNFTmCs
         f9Pg==
X-Gm-Message-State: ABuFfoj8Sq8k91TdbY8GMiVRogPW+AaxkKBFzq5Idi9SNDo8sEyzohrO
        4mT8xI+0x9B/l6Cq9gG6uJVuMA==
X-Google-Smtp-Source: ACcGV620I0k5iXb47orWTSCv3aumeuNlWlNftKPIQG+to8Z+CryOO92I/BcXVv10PPPE3+boDFi7rg==
X-Received: by 2002:a62:d046:: with SMTP id p67-v6mr5811016pfg.147.1539342704246;
        Fri, 12 Oct 2018 04:11:44 -0700 (PDT)
Received: from localhost ([122.171.67.41])
        by smtp.gmail.com with ESMTPSA id p1-v6sm3701574pfj.72.2018.10.12.04.11.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 04:11:43 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     ulf.hansson@linaro.org, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, niklas.cassel@linaro.org,
        rnayak@codeaurora.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/9] OPP: Identify and mark genpd OPP tables
Date:   Fri, 12 Oct 2018 16:41:09 +0530
Message-Id: <8130f5e3128fbd0dd34b02dbca9cde2b042d2494.1539341929.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a2c
In-Reply-To: <cover.1539341929.git.viresh.kumar@linaro.org>
References: <cover.1539341929.git.viresh.kumar@linaro.org>
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
index 5a4b47958073..5f114cd3d88c 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -92,6 +92,9 @@ void _of_init_opp_table(struct opp_table *opp_table, struct device *dev,
 	of_property_read_u32(np, "voltage-tolerance",
 			     &opp_table->voltage_tolerance_v1);
 
+	if (of_find_property(np, "#power-domain-cells", NULL))
+		opp_table->is_genpd = true;
+
 	/* Get OPP table node */
 	opp_np = _opp_of_get_opp_desc_node(np, index);
 	of_node_put(np);
@@ -326,8 +329,7 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
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
index 9c6544b4f4f9..cdb0c2b095e2 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -140,6 +140,7 @@ enum opp_table_access {
  * @regulators: Supply regulators
  * @regulator_count: Number of power supply regulators
  * @genpd_performance_state: Device's power domain support performance state.
+ * @is_genpd: Marks if the OPP table belongs to a genpd.
  * @set_opp: Platform specific set_opp callback
  * @set_opp_data: Data to be passed to set_opp callback
  * @dentry:	debugfs dentry pointer of the real device directory (not links).
@@ -178,6 +179,7 @@ struct opp_table {
 	struct regulator **regulators;
 	unsigned int regulator_count;
 	bool genpd_performance_state;
+	bool is_genpd;
 
 	int (*set_opp)(struct dev_pm_set_opp_data *data);
 	struct dev_pm_set_opp_data *set_opp_data;
-- 
2.18.0.rc1.242.g61856ae69a2c

