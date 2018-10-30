Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E815C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC2A420827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KgcO75qV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC2A420827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbeJ3W0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:26:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:55090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727845AbeJ3W0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:26:35 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF932205F4;
        Tue, 30 Oct 2018 13:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540906386;
        bh=xvVkWtfQGNWNNc9Gkf34fIJvPAteRuObM3yIKSTkjZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KgcO75qVtU85BaB8m71IGe665D8OIajW65LqrxYm6YjqFhXPpleWcUiQy1wGJSZSJ
         shcjEMp6gCs9yzotxjrubCIz4Ksa0qkmRqe+hfPUUl+6QdmBrjc5HeIBN9GEiW1qpK
         4M2P+L8+pzfGlbzOGFDoltxfAtizF22llX8VCv/M=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 3/5] net: qla3xxx: Remove overflowing shift statement
Date:   Tue, 30 Oct 2018 09:32:32 -0400
Message-Id: <20181030133234.218251-3-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181030133234.218251-1-sashal@kernel.org>
References: <20181030133234.218251-1-sashal@kernel.org>
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
index c2f09af5c25b..a51506b6901c 100644
--- a/drivers/net/ethernet/qlogic/qla3xxx.c
+++ b/drivers/net/ethernet/qlogic/qla3xxx.c
@@ -382,8 +382,6 @@ static void fm93c56a_select(struct ql3_adapter *qdev)
 
 	qdev->eeprom_cmd_data = AUBURN_EEPROM_CS_1;
 	ql_write_nvram_reg(qdev, spir, ISP_NVRAM_MASK | qdev->eeprom_cmd_data);
-	ql_write_nvram_reg(qdev, spir,
-			   ((ISP_NVRAM_MASK << 16) | qdev->eeprom_cmd_data));
 }
 
 /*
-- 
2.17.1

