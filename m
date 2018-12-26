Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BD7C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C61F214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545864749;
	bh=ithz3HdDBwyGf1QfMZ1F53T7t7/y7g38e63QDCiNy2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IEPJoghbKY3Ll33MIwTGWfnEvku/uP55bb9YZCuCHb3v524DNeagDGScOjUsDl9Vr
	 OoaRPHbNOMJtUX5wJLHM9N5mfUwNTfkOekMuvO8atNPonFmh9pfYYVn/Q499hvNMHH
	 /rAMqtojcH+6oReZWZSEeRHFETsASsQaPXrsj7PQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbeLZWg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:36:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:36998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727923AbeLZWgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:36:54 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7480218FC;
        Wed, 26 Dec 2018 22:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545863813;
        bh=ithz3HdDBwyGf1QfMZ1F53T7t7/y7g38e63QDCiNy2Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z0r4s6rPmMQCegyGjFe3wUdkK9Ko6o2ztnfht1kR3aOOtvatTapG6JNASnrT+9SzB
         l69qFLYyVtTse5q2Y6b3GeeLoGDokwTNfjLN+/ALnZYsB55inTODOfVS7aSUcfVdjV
         bnnbMMshwU4DHFLRJWCA7DuVjme5urYgyXyj9ur4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ross Lagerwall <ross.lagerwall@citrix.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 34/97] ixgbe: Fix race when the VF driver does a reset
Date:   Wed, 26 Dec 2018 17:34:54 -0500
Message-Id: <20181226223557.149329-34-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223557.149329-1-sashal@kernel.org>
References: <20181226223557.149329-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ross Lagerwall <ross.lagerwall@citrix.com>

[ Upstream commit 96d1a731611f711f0cb82cea93363ae2ea8cb028 ]

When the VF driver does a reset, it (at least the Linux one) writes to
the VFCTRL register to issue a reset and then immediately sends a reset
message using the mailbox API. This is racy because when the PF driver
detects that the VFCTRL register reset pin has been asserted, it clears
the mailbox memory. Depending on ordering, the reset message sent by
the VF could be cleared by the PF driver. It then responds to the
cleared message with a NACK which causes the VF driver to malfunction.
Fix this by deferring clearing the mailbox memory until the reset
message is received.

Fixes: 939b701ad633 ("ixgbe: fix driver behaviour after issuing VFLR")
Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index eea63a99f29c..f6ffd9fb2079 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -699,7 +699,6 @@ static inline void ixgbe_vf_reset_event(struct ixgbe_adapter *adapter, u32 vf)
 	u8 num_tcs = adapter->hw_tcs;
 	u32 reg_val;
 	u32 queue;
-	u32 word;
 
 	/* remove VLAN filters beloning to this VF */
 	ixgbe_clear_vf_vlans(adapter, vf);
@@ -754,6 +753,14 @@ static inline void ixgbe_vf_reset_event(struct ixgbe_adapter *adapter, u32 vf)
 		}
 	}
 
+	IXGBE_WRITE_FLUSH(hw);
+}
+
+static void ixgbe_vf_clear_mbx(struct ixgbe_adapter *adapter, u32 vf)
+{
+	struct ixgbe_hw *hw = &adapter->hw;
+	u32 word;
+
 	/* Clear VF's mailbox memory */
 	for (word = 0; word < IXGBE_VFMAILBOX_SIZE; word++)
 		IXGBE_WRITE_REG_ARRAY(hw, IXGBE_PFMBMEM(vf), word, 0);
@@ -827,6 +834,8 @@ static int ixgbe_vf_reset_msg(struct ixgbe_adapter *adapter, u32 vf)
 	/* reset the filters for the device */
 	ixgbe_vf_reset_event(adapter, vf);
 
+	ixgbe_vf_clear_mbx(adapter, vf);
+
 	/* set vf mac address */
 	if (!is_zero_ether_addr(vf_mac))
 		ixgbe_set_vf_mac(adapter, vf, vf_mac);
-- 
2.19.1

