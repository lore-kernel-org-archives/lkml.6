Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 10518C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B91D22086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Dn3yzmNS";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IOdPoKrh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B91D22086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933025AbeFLEls (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 00:41:48 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35868 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932905AbeFLEla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 00:41:30 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2BD62607A4; Tue, 12 Jun 2018 04:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528778490;
        bh=M0b6QQWRYiOc3VejHCeclEEhrzEt2uFxjWyPFgLdGCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dn3yzmNS0zb9CzoWyslFYckjizvW9UCYXGFVqHrsTMAFitLKTYhwA+o/PaYSZqFCK
         cSvmH1sBbHg4L+ur5H6PZxHNyRBIDmzYatADwjU3rnzQhpjjFqhRkbI1Fgb+KCTaXP
         f9cDQaE9pSvsIOu5ICGoq09n4JWwSpDUOAXR2Xwk=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A6F44602BD;
        Tue, 12 Jun 2018 04:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528778489;
        bh=M0b6QQWRYiOc3VejHCeclEEhrzEt2uFxjWyPFgLdGCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IOdPoKrhlhkYRR1E8DAaqv37k6mjosYmr4XdX7Mm7pyT5TvXG437SuM29A/prNBkO
         4ZLDgKABeVqqpvdcVPdaeXRf7BuN0++tR/XApeu/9454tV8/2cGBwzG//6ZXZFi6By
         wEukGm64HkSW6g1lYp9xdM41F7GjnklCrBAI98xs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A6F44602BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     viresh.kumar@linaro.org, sboyd@kernel.org, andy.gross@linaro.org,
        ulf.hansson@linaro.org, collinsd@codeaurora.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v3 7/7] soc: qcom: rpmpd/rpmhpd: Add a max vote on all corners at init
Date:   Tue, 12 Jun 2018 10:10:52 +0530
Message-Id: <20180612044052.4402-8-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180612044052.4402-1-rnayak@codeaurora.org>
References: <20180612044052.4402-1-rnayak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we move from no clients/consumers in kernel voting on corners,
to *some* voting and some not voting, we might end up in a situation
where the clients which remove votes can adversly impact others
who still don't have a way to vote.

To avoid this situation, have a max vote on all corners at init.
This should/can be removed once we have all clients moved to
be able to vote/unvote for themselves.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/soc/qcom/rpmhpd.c | 12 +++++++++++-
 drivers/soc/qcom/rpmpd.c  |  9 +++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
index 7083ec1590ff..3c753d33aeee 100644
--- a/drivers/soc/qcom/rpmhpd.c
+++ b/drivers/soc/qcom/rpmhpd.c
@@ -329,7 +329,7 @@ static int rpmhpd_update_level_mapping(struct rpmhpd *rpmhpd)
 
 static int rpmhpd_probe(struct platform_device *pdev)
 {
-	int i, ret;
+	int i, ret, max_level;
 	size_t num;
 	struct genpd_onecell_data *data;
 	struct rpmhpd **rpmhpds;
@@ -390,6 +390,16 @@ static int rpmhpd_probe(struct platform_device *pdev)
 		pm_genpd_init(&rpmhpds[i]->pd, NULL, true);
 
 		data->domains[i] = &rpmhpds[i]->pd;
+
+		/*
+		 * Until we have all consumers voting on corners
+		 * just vote the max corner on all PDs
+		 * This should ideally be *removed* once we have
+		 * all (most) consumers being able to vote
+		 */
+		max_level = rpmhpds[i]->level_count - 1;
+		rpmhpd_set_performance(&rpmhpds[i]->pd, rpmhpds[i]->level[max_level]);
+		rpmhpd_power_on(&rpmhpds[i]->pd);
 	}
 
 	return of_genpd_add_provider_onecell(pdev->dev.of_node, data);
diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
index 53209454c1f3..6440163305e3 100644
--- a/drivers/soc/qcom/rpmpd.c
+++ b/drivers/soc/qcom/rpmpd.c
@@ -310,6 +310,15 @@ static int rpmpd_probe(struct platform_device *pdev)
 		pm_genpd_init(&rpmpds[i]->pd, NULL, true);
 
 		data->domains[i] = &rpmpds[i]->pd;
+
+		/*
+		 * Until we have all consumers voting on corners
+		 * just vote the max corner on all PDs
+		 * This should ideally be *removed* once we have
+		 * all (most) consumers being able to vote
+		 */
+		rpmpd_set_performance(&rpmpds[i]->pd, MAX_RPMPD_STATE);
+		rpmpd_power_on(&rpmpds[i]->pd);
 	}
 
 	return of_genpd_add_provider_onecell(pdev->dev.of_node, data);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

