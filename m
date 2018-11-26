Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47294C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09BC62082F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="akh0TU0w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09BC62082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbeKZTDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 14:03:40 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36750 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbeKZTDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 14:03:39 -0500
Received: by mail-pf1-f194.google.com with SMTP id b85so6199574pfc.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 00:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=msGAK4RrrMmKEQHc7IKbb8yv9gPVm8eo19cu/yD5PZM=;
        b=akh0TU0wu4X/UJ5H904fmz49+221eV8eIaHnNwzkORb4SZl70SGS6MUPII/2EWe3JA
         z5duPkIG5iGCXPWCpKYnqlYCVomAhMCv4R8CeIVy4UiixflLrKMyR1/I08UMV1zi5q12
         tx8ya/f+QT5pT06MMBRXdofC8ahTEx4pUTH08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=msGAK4RrrMmKEQHc7IKbb8yv9gPVm8eo19cu/yD5PZM=;
        b=VewPQeb09SDQM33cREAvJueIIHIELzMdDxzuxpWc9O64TLzGeqcpT0vkGMj7bWydKn
         MM8b1A9izyTrlPbQx7eFKWje+xHZQKSiD4zoGzC49dGAW/jthVx+r5bcADaQY3wvbl9e
         0ABFUeMN8MVXN4kO3c/sMokzAzO0vp9P98DVlgf1heJ3GQvb5+/YOudxRc6dGQky3duT
         Q6t4JUeyq7TvM8akaSZeXrFvDkqViZXeIkkuKv/LciUM/UYIqp/xzqr2wmhd6gjspDho
         LNDZIQvkRrWNrrie049Z84RwHjWr9tY9Yz1NC9JMQm9rK09G+pWjyJDRnfmq/4Bqvvya
         eNsQ==
X-Gm-Message-State: AGRZ1gI+YGz8/vQ0Fv1a8JnQVhBLchomMwdA2PBzllD1j7EKljVP+0B2
        QHdvIA7FkPjXYKZwuqY6gy9eVw==
X-Google-Smtp-Source: AJdET5dqTRwHJXVk22h37byaAIuO4HvLEUFdiJ4vvTn3dcG237opOlQlfFUMbLdyiti1iWPBM+YOXQ==
X-Received: by 2002:a62:6ec8:: with SMTP id j191mr26761209pfc.198.1543219819913;
        Mon, 26 Nov 2018 00:10:19 -0800 (PST)
Received: from localhost ([122.172.88.116])
        by smtp.gmail.com with ESMTPSA id x3sm52269025pgk.18.2018.11.26.00.10.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 00:10:19 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     ulf.hansson@linaro.org, Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        rnayak@codeaurora.org, niklas.cassel@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/5] OPP: Improve _find_table_of_opp_np()
Date:   Mon, 26 Nov 2018 13:40:00 +0530
Message-Id: <24e67ba3145090fb73609a6f681c4f8ff8f73594.1543219386.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e3369a
In-Reply-To: <cover.1543219386.git.viresh.kumar@linaro.org>
References: <cover.1543219386.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make _find_table_of_opp_np() more efficient by using of_get_parent() to
find the parent OPP table node.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/of.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 840f85181a37..04968b6a9708 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -114,19 +114,25 @@ static struct device_node *of_parse_required_opp(struct device_node *np,
 static struct opp_table *_find_table_of_opp_np(struct device_node *opp_np)
 {
 	struct opp_table *opp_table;
-	struct dev_pm_opp *opp;
+	struct device_node *opp_table_np;
 
 	lockdep_assert_held(&opp_table_lock);
 
+	opp_table_np = of_get_parent(opp_np);
+	if (!opp_table_np)
+		goto err;
+
+	/* It is safe to put the node now as all we need now is its address */
+	of_node_put(opp_table_np);
+
 	list_for_each_entry(opp_table, &opp_tables, node) {
-		opp = _find_opp_of_np(opp_table, opp_np);
-		if (opp) {
-			dev_pm_opp_put(opp);
+		if (opp_table_np == opp_table->np) {
 			_get_opp_table_kref(opp_table);
 			return opp_table;
 		}
 	}
 
+err:
 	return ERR_PTR(-ENODEV);
 }
 
-- 
2.19.1.568.g152ad8e3369a

