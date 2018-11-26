Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4148DC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0645821104
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGk5CfgG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0645821104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730267AbeKZVzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:55:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:38184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726543AbeKZVzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:55:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF6FF2089F;
        Mon, 26 Nov 2018 11:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230106;
        bh=Uuk1LsUmOSf2CWtJmy7G2HPARMN0ibVOk62ReGKR0M4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HGk5CfgGPxHq4JE8bosciAAzvlXHiy9+j/7YE8fSpcaUrOSepaj7oEmd1pHyVnr0P
         3gmK5FKbKkIoaiGvT0CHNS0e24QNFcMvZlHHdFzpx+FXFeAOTnaVwTYnFyeqMiok+F
         jJzCIinCmZfSG+26lbJ89E332GWv8hSdstMCOE0M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Radoslaw Tyl <radoslawx.tyl@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Piotr Skajewski <piotrx.skajewski@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 011/118] ixgbe: fix MAC anti-spoofing filter after VFLR
Date:   Mon, 26 Nov 2018 11:50:05 +0100
Message-Id: <20181126105100.289303383@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105059.832485122@linuxfoundation.org>
References: <20181126105059.832485122@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 3c6f01c41b78..eea63a99f29c 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -721,8 +721,10 @@ static inline void ixgbe_vf_reset_event(struct ixgbe_adapter *adapter, u32 vf)
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



