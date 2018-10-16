Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3C8C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C83321470
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sPIe80RC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C83321470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbeJPMBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:01:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:49336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727280AbeJPMBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:01:52 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9ACA421480;
        Tue, 16 Oct 2018 04:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663210;
        bh=JyHDsJZ9t55Q+gjZyplNVMWls6o8j6sanbBDF7Vg8h4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sPIe80RCUAD2NioK+wbdWHK42nX/AOPe9P29HDrDPM3JMopICoYIeMR778RoV8Z74
         ow/CwLZ4Dhz+vZBLRcpCRZkAlwThUvEs06NT8xw5+HLZeenBO0NmJ/Wm7N+B2NxrE5
         tkasOvVgk1WgN27MEnZQBRi4LoikA/gDmzcppdA4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 071/100] thunderbolt: Initialize after IOMMUs
Date:   Tue, 16 Oct 2018 00:11:52 -0400
Message-Id: <20181016041221.135528-71-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041221.135528-1-sashal@kernel.org>
References: <20181016041221.135528-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mika Westerberg <mika.westerberg@linux.intel.com>

[ Upstream commit eafa717bc145963c944bb0a64d16add683861b35 ]

If IOMMU is enabled and Thunderbolt driver is built into the kernel
image, it will be probed before IOMMUs are attached to the PCI bus.
Because of this DMA mappings the driver does will not go through IOMMU
and start failing right after IOMMUs are enabled.

For this reason move the Thunderbolt driver initialization happen at
rootfs level.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thunderbolt/nhi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index f5a33e88e676..2d042150e41c 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -1147,5 +1147,5 @@ static void __exit nhi_unload(void)
 	tb_domain_exit();
 }
 
-fs_initcall(nhi_init);
+rootfs_initcall(nhi_init);
 module_exit(nhi_unload);
-- 
2.17.1

