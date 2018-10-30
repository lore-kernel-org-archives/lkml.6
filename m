Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2ADEC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AD8A2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pVQaTnlq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AD8A2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbeJ3WVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:21:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:52520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbeJ3WVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:21:37 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AB5A2080A;
        Tue, 30 Oct 2018 13:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540906089;
        bh=lOOUP+yQsTqVoQfv84z0gHfc4fLIAbPH/e/UcQaDl7Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pVQaTnlqIbyKn71kyq+zdE1MWdxMZUx19HWgYSWfhtNX5ZstQRyCvdCobsWZna7PB
         EQdLVbXCIPYXQ3GCRicfiA8cPPr/7D5KFA8E52w+BsCrmrbnnqeNdpSO2Ahzgp4QT0
         T7E1H4a+MSYE5oVSzZRMWSJQUNPKSXBq4hENi/cE=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 26/33] net: qla3xxx: Remove overflowing shift statement
Date:   Tue, 30 Oct 2018 09:26:50 -0400
Message-Id: <20181030132657.217970-26-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181030132657.217970-1-sashal@kernel.org>
References: <20181030132657.217970-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit 8c3bf9b62b667456a57aefcf1689e826df146159 ]

Clang currently warns:

drivers/net/ethernet/qlogic/qla3xxx.c:384:24: warning: signed shift
result (0xF00000000) requires 37 bits to represent, but 'int' only has
32 bits [-Wshift-overflow]
                    ((ISP_NVRAM_MASK << 16) | qdev->eeprom_cmd_data));
                      ~~~~~~~~~~~~~~ ^  ~~
1 warning generated.

The warning is certainly accurate since ISP_NVRAM_MASK is defined as
(0x000F << 16) which is then shifted by 16, resulting in 64424509440,
well above UINT_MAX.

Given that this is the only location in this driver where ISP_NVRAM_MASK
is shifted again, it seems likely that ISP_NVRAM_MASK was originally
defined without a shift and during the move of the shift to the
definition, this statement wasn't properly removed (since ISP_NVRAM_MASK
is used in the statenent right above this). Only the maintainers can
confirm this since this statment has been here since the driver was
first added to the kernel.

Link: https://github.com/ClangBuiltLinux/linux/issues/127
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qla3xxx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qla3xxx.c b/drivers/net/ethernet/qlogic/qla3xxx.c
index b48f76182049..10b075bc5959 100644
--- a/drivers/net/ethernet/qlogic/qla3xxx.c
+++ b/drivers/net/ethernet/qlogic/qla3xxx.c
@@ -380,8 +380,6 @@ static void fm93c56a_select(struct ql3_adapter *qdev)
 
 	qdev->eeprom_cmd_data = AUBURN_EEPROM_CS_1;
 	ql_write_nvram_reg(qdev, spir, ISP_NVRAM_MASK | qdev->eeprom_cmd_data);
-	ql_write_nvram_reg(qdev, spir,
-			   ((ISP_NVRAM_MASK << 16) | qdev->eeprom_cmd_data));
 }
 
 /*
-- 
2.17.1

