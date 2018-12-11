Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D44DC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20CE22082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZwYF8clq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20CE22082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbeLKL0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 06:26:41 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39290 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbeLKL0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 06:26:40 -0500
Received: by mail-pl1-f194.google.com with SMTP id 101so6794729pld.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 03:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EZLJXHxTcd+FGSvGzSmPEZcFBlWXa9ssKRuIJpqqIhQ=;
        b=ZwYF8clqq1757VYOEH+GvmCLvcFR71xfv40qaRRvCoqdIX6LfR954dPh6u1aF5ux2I
         Bnyw/7aJgjOX283wNjb5qEGzE7J3Tk+r7buozpDVyzMy+x3MrTaFhk23OFn0EPawFRa2
         WZqC+SrgRCj7MBMwQ/CdAkeUWbxF0NCqMi820=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EZLJXHxTcd+FGSvGzSmPEZcFBlWXa9ssKRuIJpqqIhQ=;
        b=jhAz+3iZnDsirM9BYP43pl/FmE/y8MMf/yr88URRst5lUdwUf6tXs9XErxx875NQNr
         nTMcaOMJdSjiZ/6pHQULDBcssRH8+A5dr6VpzZ9taIcQK4AFTevQ06psjpO6IpqYVQ4w
         EEg88xaFqsTDgNpQX4N0Uxqqh0psWqQEwuDMdYrG8Oh904aDRB3Ushdcn2lRhn7XeepP
         zjc+qDSeDWt0sYqWJUSei3/Qgwrd0Cwfqz4y8cRbHfftaGB9BZgPUGkUisH+TR3K7P7i
         JtEdJ75JDqE5ACTGvbpT9ZILyhjzGRHkrLYiA1MiluFghp7eGg48Mow+mRcYzWc/op/A
         1D4w==
X-Gm-Message-State: AA+aEWZLM5mAItdLWjuiSSdSCtWiFa1j8JcNbHvgYyMWSutFW5ATb+lr
        X8i+4vbgXpBkz2NyPmTnvvH280lkh78=
X-Google-Smtp-Source: AFSGD/Xih+dE/SIbMCTQWd+eTydgKoriFXJO+Xe0NSTZ25lfYaMb7ozCg4ldrzlcQ2nfKxVUzIW01w==
X-Received: by 2002:a17:902:4a0c:: with SMTP id w12mr15880935pld.8.1544527599935;
        Tue, 11 Dec 2018 03:26:39 -0800 (PST)
Received: from localhost ([122.172.23.29])
        by smtp.gmail.com with ESMTPSA id v191sm31680073pgb.77.2018.12.11.03.26.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 03:26:39 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Quentin Perret <quentin.perret@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] OPP: Use opp_table->regulators to verify no regulator case
Date:   Tue, 11 Dec 2018 16:56:28 +0530
Message-Id: <90e3577b5feb42bac1269e16bb3d2bdd8f6df40f.1544527580.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e3369a
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The value of opp_table->regulator_count is not very consistent right now
and it may end up being 0 while we do have a "opp-microvolt" property in
the OPP table. It was kept that way as we used to check if any
regulators are set with the OPP core for a device or not using value of
regulator_count.

Lets use opp_table->regulators for that purpose as the meaning of
regulator_count is going to change in the later patches.

Reported-by: Quentin Perret <quentin.perret@arm.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 2c2df4e4fc14..2d3d0d1180ea 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -196,12 +196,12 @@ unsigned long dev_pm_opp_get_max_volt_latency(struct device *dev)
 	if (IS_ERR(opp_table))
 		return 0;
 
-	count = opp_table->regulator_count;
-
 	/* Regulator may not be required for the device */
-	if (!count)
+	if (!opp_table->regulators)
 		goto put_opp_table;
 
+	count = opp_table->regulator_count;
+
 	uV = kmalloc_array(count, sizeof(*uV), GFP_KERNEL);
 	if (!uV)
 		goto put_opp_table;
@@ -1049,6 +1049,9 @@ static bool _opp_supported_by_regulators(struct dev_pm_opp *opp,
 	struct regulator *reg;
 	int i;
 
+	if (!opp_table->regulators)
+		return true;
+
 	for (i = 0; i < opp_table->regulator_count; i++) {
 		reg = opp_table->regulators[i];
 
@@ -1333,7 +1336,7 @@ static int _allocate_set_opp_data(struct opp_table *opp_table)
 	struct dev_pm_set_opp_data *data;
 	int len, count = opp_table->regulator_count;
 
-	if (WARN_ON(!count))
+	if (WARN_ON(!opp_table->regulators))
 		return -EINVAL;
 
 	/* space for set_opp_data */
-- 
2.19.1.568.g152ad8e3369a

