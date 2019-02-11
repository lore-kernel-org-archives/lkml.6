Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261FDC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5D1B206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896360;
	bh=vX2EIyZBUO0xZrOzawozZpkBX1uOby5g7tzuFjGdlW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZAS1/CDAlX05kASZ2AXw71/LncGwCeSQX+saXkf70sNnVY/OXS7LXnoVE5LIF5SMT
	 l9jDoXOA+YlDyDcg6mojWbSkCrFGe83NAYu9EYaXSmbGFXVLe/ukAxLzuJ0qcbD3Xx
	 F31tJbGRHo/onpUolUWrOLIGQoj7vfI7lXVTB/sY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733149AbfBKOp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:45:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:59030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733136AbfBKOpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:45:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BCE9206BA;
        Mon, 11 Feb 2019 14:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896354;
        bh=vX2EIyZBUO0xZrOzawozZpkBX1uOby5g7tzuFjGdlW0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fFVxL4Wa9uIoJlmvzHV4tuP51BKbyvtF9IOaNSeAikJmwOSm54sQOEK5muERzZo3P
         U+pvIvMvxGg928sdSVJOaUFfbo/A/8Ee50JfbGuNEOh7ljOcPzOqAWl2Rdjs+gIfvB
         /LzOU3p2NWtrahIxsDr+vigipE0hjqSmhswl2eXg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Quentin Perret <quentin.perret@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 127/313] OPP: Use opp_table->regulators to verify no regulator case
Date:   Mon, 11 Feb 2019 15:16:47 +0100
Message-Id: <20190211141902.241974074@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
 drivers/opp/core.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 31ff03dbeb83..f3433bf47b10 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -191,12 +191,12 @@ unsigned long dev_pm_opp_get_max_volt_latency(struct device *dev)
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
@@ -976,6 +976,9 @@ static bool _opp_supported_by_regulators(struct dev_pm_opp *opp,
 	struct regulator *reg;
 	int i;
 
+	if (!opp_table->regulators)
+		return true;
+
 	for (i = 0; i < opp_table->regulator_count; i++) {
 		reg = opp_table->regulators[i];
 
@@ -1263,7 +1266,7 @@ static int _allocate_set_opp_data(struct opp_table *opp_table)
 	struct dev_pm_set_opp_data *data;
 	int len, count = opp_table->regulator_count;
 
-	if (WARN_ON(!count))
+	if (WARN_ON(!opp_table->regulators))
 		return -EINVAL;
 
 	/* space for set_opp_data */
-- 
2.19.1



