Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B94C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D375C223CB
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zZ/7SExB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D375C223CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732848AbeKMPyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 10:54:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:34688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732481AbeKMPsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 10:48:21 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD98B2251E;
        Tue, 13 Nov 2018 05:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542088313;
        bh=9OMiVOdxOVgl3aRdId7/e1KJzbAK3DOWzj8U1FlXQ34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zZ/7SExB4urixHu3DBIS84RPy48xBRIe4jsDSFSNIgV6q2V0X2VeiMeF8UrsDYgTu
         uXay2RYMd/w2dCJd3D53ocXPRE+n6xpPwMzscLd6TnHg8HpwpIDpnjl8d9oz2jY4Y2
         tcF38TQO1RQ42Nj00nS6GdNHzUWmEKpVgW9t0jYo=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Radoslaw Tyl <radoslawx.tyl@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 06/26] ixgbe: fix MAC anti-spoofing filter after VFLR
Date:   Tue, 13 Nov 2018 00:51:30 -0500
Message-Id: <20181113055150.78773-6-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181113055150.78773-1-sashal@kernel.org>
References: <20181113055150.78773-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Radoslaw Tyl <radoslawx.tyl@intel.com>

[ Upstream commit 6702185c1ffec3421181b5e24491e3fac920cb61 ]

This change resolves a driver bug where the driver is logging a
message that says "Spoofed packets detected". This can occur on the PF
(host) when a VF has VLAN+MACVLAN enabled and is re-started with a
different MAC address.

MAC and VLAN anti-spoofing filters are to be enabled together.

Signed-off-by: Radoslaw Tyl <radoslawx.tyl@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Acked-by: Piotr Skajewski <piotrx.skajewski@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index 112d24c6c9ce..4904a63b83ef 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -760,8 +760,10 @@ static inline void ixgbe_vf_reset_event(struct ixgbe_adapter *adapter, u32 vf)
 			ixgbe_set_vmvir(adapter, vfinfo->pf_vlan,
 					adapter->default_up, vf);
 
-		if (vfinfo->spoofchk_enabled)
+		if (vfinfo->spoofchk_enabled) {
 			hw->mac.ops.set_vlan_anti_spoofing(hw, true, vf);
+			hw->mac.ops.set_mac_anti_spoofing(hw, true, vf);
+		}
 	}
 
 	/* reset multicast table array for vf */
-- 
2.17.1

