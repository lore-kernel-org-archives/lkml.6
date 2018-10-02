Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F20C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 433142064A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:57:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 433142064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731322AbeJBUkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:40:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34078 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729986AbeJBUOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:14:42 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B1573C47;
        Tue,  2 Oct 2018 13:31:19 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sebastian Basierski <sebastianx.basierski@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 206/228] ixgbe: fix driver behaviour after issuing VFLR
Date:   Tue,  2 Oct 2018 06:25:03 -0700
Message-Id: <20181002132511.721772927@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sebastian Basierski <sebastianx.basierski@intel.com>

[ Upstream commit 939b701ad63314f5aa90dcd3d866f73954945209 ]

Since VFLR doesn't clear VFMBMEM (VF Mailbox Memory)
and is not re-enabling queues correctly we should fix
this behavior.

Signed-off-by: Sebastian Basierski <sebastianx.basierski@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c |   26 +++++++++++++++++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h  |    1 
 2 files changed, 27 insertions(+)

--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -688,8 +688,13 @@ static int ixgbe_set_vf_macvlan(struct i
 static inline void ixgbe_vf_reset_event(struct ixgbe_adapter *adapter, u32 vf)
 {
 	struct ixgbe_hw *hw = &adapter->hw;
+	struct ixgbe_ring_feature *vmdq = &adapter->ring_feature[RING_F_VMDQ];
 	struct vf_data_storage *vfinfo = &adapter->vfinfo[vf];
+	u32 q_per_pool = __ALIGN_MASK(1, ~vmdq->mask);
 	u8 num_tcs = adapter->hw_tcs;
+	u32 reg_val;
+	u32 queue;
+	u32 word;
 
 	/* remove VLAN filters beloning to this VF */
 	ixgbe_clear_vf_vlans(adapter, vf);
@@ -726,6 +731,27 @@ static inline void ixgbe_vf_reset_event(
 
 	/* reset VF api back to unknown */
 	adapter->vfinfo[vf].vf_api = ixgbe_mbox_api_10;
+
+	/* Restart each queue for given VF */
+	for (queue = 0; queue < q_per_pool; queue++) {
+		unsigned int reg_idx = (vf * q_per_pool) + queue;
+
+		reg_val = IXGBE_READ_REG(hw, IXGBE_PVFTXDCTL(reg_idx));
+
+		/* Re-enabling only configured queues */
+		if (reg_val) {
+			reg_val |= IXGBE_TXDCTL_ENABLE;
+			IXGBE_WRITE_REG(hw, IXGBE_PVFTXDCTL(reg_idx), reg_val);
+			reg_val &= ~IXGBE_TXDCTL_ENABLE;
+			IXGBE_WRITE_REG(hw, IXGBE_PVFTXDCTL(reg_idx), reg_val);
+		}
+	}
+
+	/* Clear VF's mailbox memory */
+	for (word = 0; word < IXGBE_VFMAILBOX_SIZE; word++)
+		IXGBE_WRITE_REG_ARRAY(hw, IXGBE_PFMBMEM(vf), word, 0);
+
+	IXGBE_WRITE_FLUSH(hw);
 }
 
 static int ixgbe_set_vf_mac(struct ixgbe_adapter *adapter,
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -2518,6 +2518,7 @@ enum {
 /* Translated register #defines */
 #define IXGBE_PVFTDH(P)		(0x06010 + (0x40 * (P)))
 #define IXGBE_PVFTDT(P)		(0x06018 + (0x40 * (P)))
+#define IXGBE_PVFTXDCTL(P)	(0x06028 + (0x40 * (P)))
 #define IXGBE_PVFTDWBAL(P)	(0x06038 + (0x40 * (P)))
 #define IXGBE_PVFTDWBAH(P)	(0x0603C + (0x40 * (P)))
 


