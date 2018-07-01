Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82908C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25EA02089F
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:18:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25EA02089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030635AbeGARSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:18:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36818 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030987AbeGAQjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:39:01 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0FE1092B;
        Sun,  1 Jul 2018 16:39:00 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Finley Xiao <finley.xiao@rock-chips.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 4.17 055/220] soc: rockchip: power-domain: Fix wrong value when power up pd with writemask
Date:   Sun,  1 Jul 2018 18:21:19 +0200
Message-Id: <20180701160910.637487959@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
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

From: Finley Xiao <finley.xiao@rock-chips.com>

commit 9e59c5f66c624b43c766a9fe3b2430e0e976bf0e upstream.

Solve the pd could only ever turn off but never turn them on again,
if the pd registers have the writemask bits.

So far this affects the rk3328 only.

Fixes: 79bb17ce8edb ("soc: rockchip: power-domain: Support domain control in hiword-registers")
Cc: stable@vger.kernel.org
Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/soc/rockchip/pm_domains.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/soc/rockchip/pm_domains.c
+++ b/drivers/soc/rockchip/pm_domains.c
@@ -255,7 +255,7 @@ static void rockchip_do_pmu_set_power_do
 		return;
 	else if (pd->info->pwr_w_mask)
 		regmap_write(pmu->regmap, pmu->info->pwr_offset,
-			     on ? pd->info->pwr_mask :
+			     on ? pd->info->pwr_w_mask :
 			     (pd->info->pwr_mask | pd->info->pwr_w_mask));
 	else
 		regmap_update_bits(pmu->regmap, pmu->info->pwr_offset,


