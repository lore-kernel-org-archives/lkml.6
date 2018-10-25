Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D939C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D05F2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RabTINq8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D05F2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730886AbeJYWxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:53:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:35482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730254AbeJYWxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:53:07 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A046C208A3;
        Thu, 25 Oct 2018 14:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477209;
        bh=akc4dMTs9TtQepmontKA627ZOmmO2od+TePIoHcsMXE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RabTINq8JsCfhi7Xi6fnM4N06i09CBFSv/8YgxcmTvk2OQE+xY8zbQiX5LbqAfCAR
         x6uL2h0ZH7PEPDOnExnv8SfFQB5ukpjcPSFyBu0fq+1y28MM3vMKRTHJR3l7TGUHpK
         dTR+KvFs/KirZrogrvIAYD+Cd0UAjz/JQh0FfccU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Abhilash Kesavan <a.kesavan@samsung.com>,
        Olof Johansson <olof@lixom.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 49/98] drivers: bus: check cci device tree node status
Date:   Thu, 25 Oct 2018 10:18:04 -0400
Message-Id: <20181025141853.214051-49-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abhilash Kesavan <a.kesavan@samsung.com>

[ Upstream commit 896ddd600ba4a3426aeb11710ae9c28dd7ce68ce ]

The arm-cci driver completes the probe sequence even if the cci node is
marked as disabled. Add a check in the driver to honour the cci status
in the device tree.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Acked-by: Nicolas Pitre <nico@linaro.org>
Tested-by: Sudeep Holla <sudeep.holla@arm.com>
Tested-by: Kevin Hilman <khilman@linaro.org>
Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bus/arm-cci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index 7af78df241f2..99cad3ac38f2 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -976,6 +976,9 @@ static int cci_probe(void)
 	if (!np)
 		return -ENODEV;
 
+	if (!of_device_is_available(np))
+		return -ENODEV;
+
 	cci_config = of_match_node(arm_cci_matches, np)->data;
 	if (!cci_config)
 		return -ENODEV;
-- 
2.17.1

