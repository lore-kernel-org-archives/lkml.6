Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E24ECDE48
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 05:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F092520831
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 05:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TByAGHbk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F092520831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbeJYOYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 10:24:33 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45303 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbeJYOYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 10:24:33 -0400
Received: by mail-pg1-f196.google.com with SMTP id s3-v6so3469021pga.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 22:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iFMPg2Y477Eixw34Pr/S9pCpksPj3HUPJVaQkzWELow=;
        b=TByAGHbk7rgoR87DUWV9J3RXadVqjbsoOsoUaThuHgJdg0z9Og9n8AwSIbRFsJk3uJ
         bXYPvH4fcnsdMnZEdCDnqO69TaKjWDm1FQ2NqvuCJNB9MyWm9yQ1FCSxydLKQAaTrjr2
         UQ74d4lTe4d7fRB+B9bEiEKUzZ73731uaHsD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iFMPg2Y477Eixw34Pr/S9pCpksPj3HUPJVaQkzWELow=;
        b=lWGvJz1T/g7Bly6VXSuTXdnPTIGfIzsgLQr9J5EvBp24IoxhGCtg7oF/9c1dtIwgtr
         3GdxQguib8shBfFVIIxsnX0scJvDDCTRpHFUj/gC93IQVwmQ3MzqwZADdhr/lS70tAPs
         /+bGS5EW8+kIGTVtifxyEmhK1Tn/FtnRIAqV1mGj6gx8Lo3qJDdbQOLvUvmyKCwjmHN4
         SurEHvBfsq94iVMngGXI38YQZ4JsgAbBoXAkzYWxu/Pxa+ZkQ8C+Yvx+oiqf3F/nkPN/
         u7KW4ONRTO5XNfrJbatMC1qjmE3nZl5PGXQYpJ00RPtMNHoIizNVQZmChboCi3Rf21dx
         GXRA==
X-Gm-Message-State: AGRZ1gIfnuCWXnVxqu9rTSfH9sCSaCJaW/cmYFzKGiB3BM+kicYt+vxC
        XoThuBBljBYtPARIXqThbdlkUg==
X-Google-Smtp-Source: AJdET5cxHtAaoKd64fqXgA4t8daiRJkloPI8Kvxnbj+KR8oo4nloBI838LHmzQaH8B9GeZBN083rgQ==
X-Received: by 2002:a62:8301:: with SMTP id h1-v6mr206832pfe.29.1540446802327;
        Wed, 24 Oct 2018 22:53:22 -0700 (PDT)
Received: from localhost ([122.172.217.9])
        by smtp.gmail.com with ESMTPSA id u7-v6sm585161pfl.34.2018.10.24.22.53.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 22:53:21 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     ulf.hansson@linaro.org, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, niklas.cassel@linaro.org,
        rnayak@codeaurora.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 02/10] OPP: Identify and mark genpd OPP tables
Date:   Thu, 25 Oct 2018 11:22:39 +0530
Message-Id: <320abb3732333763c6d87e5e6aa81aa80dbace8d.1540446493.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e3369a
In-Reply-To: <cover.1540446493.git.viresh.kumar@linaro.org>
References: <cover.1540446493.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to handle genpd OPP tables differently, this is already the case
at one location and will be extended going forward. Add another field to
the OPP table to check if the table belongs to a genpd or not.

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
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
2.19.1.568.g152ad8e3369a

