Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC18C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A6372083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:04:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A6372083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387426AbeHATvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:51:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50226 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405820AbeHATIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:08:37 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5E3AA110C;
        Wed,  1 Aug 2018 17:04:45 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 218/336] soc/tegra: pmc: Dont allocate struct tegra_powergate on stack
Date:   Wed,  1 Aug 2018 18:49:13 +0200
Message-Id: <20180801165037.419514940@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Viresh Kumar <viresh.kumar@linaro.org>

[ Upstream commit 495ac33a3b82f85ed4fbdd9b826c1d2fbc8e9b68 ]

With a later commit an instance of the struct device will be added to
struct genpd and with that the size of the struct tegra_powergate will
be over 1024 bytes. That generates following warning:

drivers/soc/tegra/pmc.c:579:1: warning: the frame size of 1200 bytes is larger than 1024 bytes [-Wframe-larger-than=]

Avoid such warnings by allocating the structure dynamically.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/soc/tegra/pmc.c |   20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -559,22 +559,28 @@ EXPORT_SYMBOL(tegra_powergate_remove_cla
 int tegra_powergate_sequence_power_up(unsigned int id, struct clk *clk,
 				      struct reset_control *rst)
 {
-	struct tegra_powergate pg;
+	struct tegra_powergate *pg;
 	int err;
 
 	if (!tegra_powergate_is_available(id))
 		return -EINVAL;
 
-	pg.id = id;
-	pg.clks = &clk;
-	pg.num_clks = 1;
-	pg.reset = rst;
-	pg.pmc = pmc;
+	pg = kzalloc(sizeof(*pg), GFP_KERNEL);
+	if (!pg)
+		return -ENOMEM;
 
-	err = tegra_powergate_power_up(&pg, false);
+	pg->id = id;
+	pg->clks = &clk;
+	pg->num_clks = 1;
+	pg->reset = rst;
+	pg->pmc = pmc;
+
+	err = tegra_powergate_power_up(pg, false);
 	if (err)
 		pr_err("failed to turn on partition %d: %d\n", id, err);
 
+	kfree(pg);
+
 	return err;
 }
 EXPORT_SYMBOL(tegra_powergate_sequence_power_up);


