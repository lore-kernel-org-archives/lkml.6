Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752178AbeCPEJI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 00:09:08 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49464 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751820AbeCPEJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 00:09:04 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7AB7E60C4F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From: Rajendra Nayak <rnayak@codeaurora.org>
To: viresh.kumar@linaro.org, sboyd@kernel.org, andy.gross@linaro.org,
        ulf.hansson@linaro.org
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH 7/7] soc: qcom: rpmpd: Add a max vote on all corners at init
Date: Fri, 16 Mar 2018 09:38:24 +0530
Message-Id: <20180316040824.21472-8-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180316040824.21472-1-rnayak@codeaurora.org>
References: <20180316040824.21472-1-rnayak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
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
---
 drivers/soc/qcom/rpmpd.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
index 4058c5b450c6..ebdcf9398441 100644
--- a/drivers/soc/qcom/rpmpd.c
+++ b/drivers/soc/qcom/rpmpd.c
@@ -304,6 +304,15 @@ static int rpmpd_probe(struct platform_device *pdev)
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
