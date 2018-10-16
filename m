Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAE0C070C3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B7F821471
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxNKwY4g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B7F821471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbeJPMB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:01:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:48496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728162AbeJPMB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:01:27 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D4AC208E4;
        Tue, 16 Oct 2018 04:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663184;
        bh=Sotuto2ZEBhAXD8XkyN3jjEetqdgy8y0xOHwMpyWB6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oxNKwY4gxxHIrxZcYtaUrR2zSqav2/gnen3XUUlmp8Qj+YoexRTkd3mVIhAc+H+OP
         POnNx7prSBJNlqMof4Zx4WczrbkuwuLFlD+bnByHy24fEV4NjMqpd2cvbuQ42mts1R
         mMbngjFbn9di1/xgl9s//WPROsNgpEyfJWituCmg=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sudarsana Reddy Kalluru <sudarsana.kalluru@cavium.com>,
        Sudarsana Reddy Kalluru <Sudarsana.Kalluru@cavium.com>,
        Michal Kalderon <Michal.Kalderon@cavium.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 046/100] qed: Fix shmem structure inconsistency between driver and the mfw.
Date:   Tue, 16 Oct 2018 00:11:27 -0400
Message-Id: <20181016041221.135528-46-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041221.135528-1-sashal@kernel.org>
References: <20181016041221.135528-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sudarsana Reddy Kalluru <sudarsana.kalluru@cavium.com>

[ Upstream commit 5f672090e44f4951084c5e1d6b0668a5fc422af8 ]

The structure shared between driver and the management FW (mfw) differ in
sizes. This would lead to issues when driver try to access the structure
members which are not-aligned with the mfw copy e.g., data_ptr usage in the
case of mfw_tlv request.
Align the driver structure with mfw copy, add reserved field(s) to driver
structure for the members not used by the driver.

Fixes: dd006921d67f ("qed: Add MFW interfaces for TLV request support.)
Signed-off-by: Sudarsana Reddy Kalluru <Sudarsana.Kalluru@cavium.com>
Signed-off-by: Michal Kalderon <Michal.Kalderon@cavium.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_hsi.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_hsi.h b/drivers/net/ethernet/qlogic/qed/qed_hsi.h
index bee10c1781fb..463ffa83685f 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_hsi.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_hsi.h
@@ -11987,6 +11987,7 @@ struct public_global {
 	u32 running_bundle_id;
 	s32 external_temperature;
 	u32 mdump_reason;
+	u64 reserved;
 	u32 data_ptr;
 	u32 data_size;
 };
-- 
2.17.1

