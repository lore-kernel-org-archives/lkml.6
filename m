Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8A8C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A459C20878
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3Q2BtXE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A459C20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbeLEJlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:41:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:45620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728834AbeLEJlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:41:10 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF5212084C;
        Wed,  5 Dec 2018 09:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002869;
        bh=hyJLhqa2IEnucNwAcFZxSeXXLiZx3SXdVoLSc1Z+GFY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I3Q2BtXEKqvWaRJlDDrrf4ath35gpnOirqPI/w4dbr7qtmOygo8AT7f3o8w2+FB1D
         cFdSFtrRWVLS5D7shQ26BDVOTUEfc9fAOMJ/OWMTLOLF3ASJQiUQdb8QGxAc7nI/Tk
         bdtW4cV//XsqmAVgSlQVJT5H0nTCjpXm1EfAayCw=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yunjian Wang <wangyunjian@huawei.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 094/123] igb: fix uninitialized variables
Date:   Wed,  5 Dec 2018 04:35:26 -0500
Message-Id: <20181205093555.5386-94-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunjian Wang <wangyunjian@huawei.com>

[ Upstream commit e4c39f7926b4de355f7df75651d75003806aae09 ]

This patch fixes the variable 'phy_word' may be used uninitialized.

Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/igb/e1000_i210.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/igb/e1000_i210.c b/drivers/net/ethernet/intel/igb/e1000_i210.c
index c54ebedca6da..c393cb2c0f16 100644
--- a/drivers/net/ethernet/intel/igb/e1000_i210.c
+++ b/drivers/net/ethernet/intel/igb/e1000_i210.c
@@ -842,6 +842,7 @@ s32 igb_pll_workaround_i210(struct e1000_hw *hw)
 		nvm_word = E1000_INVM_DEFAULT_AL;
 	tmp_nvm = nvm_word | E1000_INVM_PLL_WO_VAL;
 	igb_write_phy_reg_82580(hw, I347AT4_PAGE_SELECT, E1000_PHY_PLL_FREQ_PAGE);
+	phy_word = E1000_PHY_PLL_UNCONF;
 	for (i = 0; i < E1000_MAX_PLL_TRIES; i++) {
 		/* check current state directly from internal PHY */
 		igb_read_phy_reg_82580(hw, E1000_PHY_PLL_FREQ_REG, &phy_word);
-- 
2.17.1

