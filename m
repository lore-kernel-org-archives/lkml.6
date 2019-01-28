Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A109C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4C3421741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548694808;
	bh=O+P3oojbtj9ao1YfFYme8jtLqBZCZgHbx324E+szaWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PlmTMu6aJYRh7IKMiZw6zLCbO46zmcTylv+078/mRRj0c8z8u0tCtnMVjrwBVtaex
	 rddCs/qzSnHZWElKe8OwTOLur5e+OCEcl8Zhiw1dilIFofMgHQvFHEZXf4TdcZWpAR
	 mraJuXvxPbW0Ns0dDqKPMSkBYLai060bFGKwT3oU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388269AbfA1RAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:00:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:46612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387865AbfA1QPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:15:49 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 065E92147A;
        Mon, 28 Jan 2019 16:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692149;
        bh=O+P3oojbtj9ao1YfFYme8jtLqBZCZgHbx324E+szaWQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VFGc80Ac5DNKwvXvQa5fzVDewKZs1dlFWGzTlfs54mP9u2r1uECjxfwIgr+i9ZGl9
         Ogxiy05t/f19wREhCCT0u5KPKA/wSX/DHDIk14/qIPZSbmLlMBK98O5VaW7oh6Ib3T
         0HwDOez8tNhY+Lbd7aEkZnwcv2vmHkQnCb1DP0KA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 089/170] OPP: Use opp_table->regulators to verify no regulator case
Date:   Mon, 28 Jan 2019 11:10:39 -0500
Message-Id: <20190128161200.55107-89-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161200.55107-1-sashal@kernel.org>
References: <20190128161200.55107-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Viresh Kumar <viresh.kumar@linaro.org>

[ Upstream commit 90e3577b5feb42bac1269e16bb3d2bdd8f6df40f ]

The value of opp_table->regulator_count is not very consistent right now
and it may end up being 0 while we do have a "opp-microvolt" property in
the OPP table. It was kept that way as we used to check if any
regulators are set with the OPP core for a device or not using value of
regulator_count.

Lets use opp_table->regulators for that purpose as the meaning of
regulator_count is going to change in the later patches.

Reported-by: Quentin Perret <quentin.perret@arm.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/power/opp/core.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index d4862775b9f6..d5e7e8cc4f22 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -192,12 +192,12 @@ unsigned long dev_pm_opp_get_max_volt_latency(struct device *dev)
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
@@ -921,6 +921,9 @@ static bool _opp_supported_by_regulators(struct dev_pm_opp *opp,
 	struct regulator *reg;
 	int i;
 
+	if (!opp_table->regulators)
+		return true;
+
 	for (i = 0; i < opp_table->regulator_count; i++) {
 		reg = opp_table->regulators[i];
 
@@ -1226,7 +1229,7 @@ static int _allocate_set_opp_data(struct opp_table *opp_table)
 	struct dev_pm_set_opp_data *data;
 	int len, count = opp_table->regulator_count;
 
-	if (WARN_ON(!count))
+	if (WARN_ON(!opp_table->regulators))
 		return -EINVAL;
 
 	/* space for set_opp_data */
-- 
2.19.1

