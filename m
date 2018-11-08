Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8901FECDE4C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50F2E208A3
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAE4nWRn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50F2E208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731246AbeKIHkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:40:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:60652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727573AbeKIHkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:40:52 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C044D20892;
        Thu,  8 Nov 2018 22:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714601;
        bh=PGOHQES573MFZ76wP3N/VVt0EIPZNP5lF8K44ZVms70=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YAE4nWRn/kv3Ab+Gs9mN3TYYJYsXlnf7ggZLYu+fOiy6YT3beIYym3mOlq2Li98dY
         NetrzfPLr3gSSgM3i7sqh1bhYQIyUVspbpRPgTFjnywo27tY9dTguu7aj6zNETNAPw
         tFaS86u5vzLTDvQHuHGke+Gyf5Mc5D8yfOni0eJk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Christian=20Gr=C3=B6nke?= <c.groenke@infodas.de>,
        Alexander Duyck <alexander.h.duyck@intel.com>,
        Aaron Brown <aaron.f.brown@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 038/171] igb: Remove superfluous reset to PHY and page 0 selection
Date:   Thu,  8 Nov 2018 13:50:08 -0800
Message-Id: <20181108215130.200999812@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 2a83fba6cae89dd9c0625e68ff8ffff791c67ac0 ]

This patch reverts two previous applied patches to fix an issue
that appeared when using SGMII based SFP modules. In the current
state the driver will try to reset the PHY before obtaining the
phy_addr of the SGMII attached PHY. That leads to an error in
e1000_write_phy_reg_sgmii_82575. Causing the initialization to
fail:

    igb: Intel(R) Gigabit Ethernet Network Driver - version 5.4.0-k
    igb: Copyright (c) 2007-2014 Intel Corporation.
    igb: probe of ????:??:??.? failed with error -3

The patches being reverted are:

    commit 182785335447957409282ca745aa5bc3968facee
    Author: Aaron Sierra <asierra@xes-inc.com>
    Date:   Tue Nov 29 10:03:56 2016 -0600

        igb: reset the PHY before reading the PHY ID

    commit 440aeca4b9858248d8f16d724d9fa87a4f65fa33
    Author: Matwey V Kornilov <matwey@sai.msu.ru>
    Date:   Thu Nov 24 13:32:48 2016 +0300

         igb: Explicitly select page 0 at initialization

The first reverted patch directly causes the problem mentioned above.
In case of SGMII the phy_addr is not known at this point and will
only be obtained by 'igb_get_phy_id_82575' further down in the code.
The second removed patch selects forces selection of page 0 in the
PHY. Something that the reset tries to address as well.

As pointed out by Alexander Duzck, the patch below fixes the same
issue but in the proper location:

    commit 4e684f59d760a2c7c716bb60190783546e2d08a1
    Author: Chris J Arges <christopherarges@gmail.com>
    Date:   Wed Nov 2 09:13:42 2016 -0500

        igb: Workaround for igb i210 firmware issue

Reverts: 440aeca4b9858248d8f16d724d9fa87a4f65fa33.
Reverts: 182785335447957409282ca745aa5bc3968facee.

Signed-off-by: Christian Grönke <c.groenke@infodas.de>
Reviewed-by: Alexander Duyck <alexander.h.duyck@intel.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/igb/e1000_82575.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/e1000_82575.c b/drivers/net/ethernet/intel/igb/e1000_82575.c
index 4a50870e0fa7..a61447fd778e 100644
--- a/drivers/net/ethernet/intel/igb/e1000_82575.c
+++ b/drivers/net/ethernet/intel/igb/e1000_82575.c
@@ -245,19 +245,7 @@ static s32 igb_init_phy_params_82575(struct e1000_hw *hw)
 	hw->bus.func = (rd32(E1000_STATUS) & E1000_STATUS_FUNC_MASK) >>
 			E1000_STATUS_FUNC_SHIFT;
 
-	/* Make sure the PHY is in a good state. Several people have reported
-	 * firmware leaving the PHY's page select register set to something
-	 * other than the default of zero, which causes the PHY ID read to
-	 * access something other than the intended register.
-	 */
-	ret_val = hw->phy.ops.reset(hw);
-	if (ret_val) {
-		hw_dbg("Error resetting the PHY.\n");
-		goto out;
-	}
-
 	/* Set phy->phy_addr and phy->id. */
-	igb_write_phy_reg_82580(hw, I347AT4_PAGE_SELECT, 0);
 	ret_val = igb_get_phy_id_82575(hw);
 	if (ret_val)
 		return ret_val;
-- 
2.17.1



