Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF67AC43610
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6EB62250E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/O/wE4C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6EB62250E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388093AbeKOIqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:46:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:34408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728976AbeKOI1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:27:25 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0568122526;
        Wed, 14 Nov 2018 22:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234142;
        bh=P+gfuLXFHyjDPBjTl8w0VSsdNfgPjJWGLwEKaoRwlhU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I/O/wE4CvIbZGW2kXi9VHYdmsjQ0PYqaNN6gT2+xxxubikNTBD3NvH3BJmnFrP5qW
         j7RFWBl0D/PlZQOKCUU1j3HUuLtlRZfHnU43s3dJDQPK1dUPMfEaDa3cjGJyrA0DRz
         HDggRvDwnmtoy5yAcBWQ+OKxvgeAc/rmckUL3D90=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Chinh T Cao <chinh.t.cao@intel.com>,
        Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 57/73] ice: Change req_speeds to be u16
Date:   Wed, 14 Nov 2018 17:21:51 -0500
Message-Id: <20181114222207.98701-57-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222207.98701-1-sashal@kernel.org>
References: <20181114222207.98701-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chinh T Cao <chinh.t.cao@intel.com>

[ Upstream commit ffe498237b36ee42624e139b21efa05da4ff1f48 ]

Since the req_speeds field in struct ice_link_status is a u8,
req_speeds & ICE_AQ_LINK_SPEED_40GB always returns 0. This was caught
by a coverity scan.

Fix this by changing req_speeds to be u16.

Reported-by: Bruce Allan <bruce.w.allan@intel.com>
Signed-off-by: Chinh T Cao <chinh.t.cao@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_type.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index 97c366e0ca59..ba11b5898833 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -83,12 +83,12 @@ struct ice_link_status {
 	u64 phy_type_low;
 	u16 max_frame_size;
 	u16 link_speed;
+	u16 req_speeds;
 	u8 lse_ena;	/* Link Status Event notification */
 	u8 link_info;
 	u8 an_info;
 	u8 ext_info;
 	u8 pacing;
-	u8 req_speeds;
 	/* Refer to #define from module_type[ICE_MODULE_TYPE_TOTAL_BYTE] of
 	 * ice_aqc_get_phy_caps structure
 	 */
-- 
2.17.1

