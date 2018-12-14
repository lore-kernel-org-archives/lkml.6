Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB16EC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3BD120892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544790680;
	bh=r+4ouX6oVBPi2Se3O7g8lwYyP7l9jmoMzHo4WFOsRMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Vw8Pmg0GZLMX2712KFs6foN0B57monFxwdUXE7/Efl4aeSw/ZEzBfJSlmTrQMlxOk
	 Xj9kI/StMKF6xmtkuFnGVk6aGAnbRD3ri01oJIgLrLRJD48dFR6HPdBxW5lxoGeWIN
	 4+9DEksvhluBi+Ef+78ZmZ8pNAb1kci8n+2zhzjE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3BD120892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731503AbeLNMJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:09:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:55492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731493AbeLNMJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:09:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BB15214C4;
        Fri, 14 Dec 2018 12:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789385;
        bh=r+4ouX6oVBPi2Se3O7g8lwYyP7l9jmoMzHo4WFOsRMA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=seW2VF9Cc6Kb7t3weANEpqFxcDVx8Z3pRe7SagKtfZhwi/zUJAqACzjWG7n/bVA7O
         EW5XXR1i1FCVSucF1zApuGNti6hphb2Mn6DeZ5zIEM2WTJBNN5qDONmLwng6TbNgBP
         WEpLpARi300c3iiv+KDY/EULsovwFCuPXVjnpOaA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yunjian Wang <wangyunjian@huawei.com>,
        Aaron Brown <aaron.f.brown@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 61/89] igb: fix uninitialized variables
Date:   Fri, 14 Dec 2018 13:00:14 +0100
Message-Id: <20181214115732.681976290@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115729.658859279@linuxfoundation.org>
References: <20181214115729.658859279@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 07d48f2e3369..6766081f5ab9 100644
--- a/drivers/net/ethernet/intel/igb/e1000_i210.c
+++ b/drivers/net/ethernet/intel/igb/e1000_i210.c
@@ -862,6 +862,7 @@ s32 igb_pll_workaround_i210(struct e1000_hw *hw)
 		nvm_word = E1000_INVM_DEFAULT_AL;
 	tmp_nvm = nvm_word | E1000_INVM_PLL_WO_VAL;
 	igb_write_phy_reg_82580(hw, I347AT4_PAGE_SELECT, E1000_PHY_PLL_FREQ_PAGE);
+	phy_word = E1000_PHY_PLL_UNCONF;
 	for (i = 0; i < E1000_MAX_PLL_TRIES; i++) {
 		/* check current state directly from internal PHY */
 		igb_read_phy_reg_82580(hw, E1000_PHY_PLL_FREQ_REG, &phy_word);
-- 
2.19.1



