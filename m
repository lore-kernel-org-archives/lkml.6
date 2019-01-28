Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0A6C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 521452175B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690667;
	bh=4AaioCdyaHuUdYVQkroHL0h/cVKMkG8pqt1NGx1i39k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JCmi1jcZs++julWWl+7+ZeUk0k4fJOVtNF6TR1ZLtuuvxRWcUDHDlVg8VehZvuw0z
	 w52sp10oZLxGh1np9ATKXHuWQFsGeTQPPXXa1AkPM1Td+lbJCf9//9nx6pRcem8yD5
	 rAi1crYdwhOWnpJ+r7DO2ZFptUYxYQl+WW/S48X0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbfA1PvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:51:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:37652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728551AbfA1PvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:51:00 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4582F20880;
        Mon, 28 Jan 2019 15:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690659;
        bh=4AaioCdyaHuUdYVQkroHL0h/cVKMkG8pqt1NGx1i39k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rdR4yh/PJwTT0JHF2j+bWQkkK7VWY6eoUybolqxggzB0rg1TH4Hy2Bzt4ERrHMFk7
         jdRnsgS2EZvSnBnd700Hk8ClExiTwTJRACRum1RolP4Of8j5KFLUwwL1rR1mZ1tff8
         WzAp2ipOB1BU1PL67qRSiDJZBlKMo5hLuefqDttE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vadim Pasternak <vadimp@mellanox.com>,
        Darren Hart <dvhart@infradead.org>,
        Sasha Levin <sashal@kernel.org>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 157/304] platform/x86: mlx-platform: Fix tachometer registers
Date:   Mon, 28 Jan 2019 10:41:14 -0500
Message-Id: <20190128154341.47195-157-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vadim Pasternak <vadimp@mellanox.com>

[ Upstream commit edd45cba5ed7f53974475ddc9a1453c2c87b3328 ]

Shift by one the registers for tachometers (7 - 12).

This fix is relevant for the same new systems MQMB7, MSN37, MSN34,
which are about to be released to the customers.
At the moment, none of them is at customers sites. The customers will
not suffer from this change.
This fix is necessary, because register used before for tachometer 7
has been than reserved for the second PWM for newer systems, which are
not supported yet in mlx-platform driver. So registers of tachometers
7-12 have been shifted by one.

Fixes: 0378123c5800 ("platform/x86: mlx-platform: Add mlxreg-fan platform driver activation")
Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
Signed-off-by: Darren Hart (VMware) <dvhart@infradead.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/mlx-platform.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/mlx-platform.c b/drivers/platform/x86/mlx-platform.c
index c2c3a1a19879..14f88bfabd5d 100644
--- a/drivers/platform/x86/mlx-platform.c
+++ b/drivers/platform/x86/mlx-platform.c
@@ -83,12 +83,12 @@
 #define MLXPLAT_CPLD_LPC_REG_TACHO4_OFFSET	0xe7
 #define MLXPLAT_CPLD_LPC_REG_TACHO5_OFFSET	0xe8
 #define MLXPLAT_CPLD_LPC_REG_TACHO6_OFFSET	0xe9
-#define MLXPLAT_CPLD_LPC_REG_TACHO7_OFFSET	0xea
-#define MLXPLAT_CPLD_LPC_REG_TACHO8_OFFSET	0xeb
-#define MLXPLAT_CPLD_LPC_REG_TACHO9_OFFSET	0xec
-#define MLXPLAT_CPLD_LPC_REG_TACHO10_OFFSET	0xed
-#define MLXPLAT_CPLD_LPC_REG_TACHO11_OFFSET	0xee
-#define MLXPLAT_CPLD_LPC_REG_TACHO12_OFFSET	0xef
+#define MLXPLAT_CPLD_LPC_REG_TACHO7_OFFSET	0xeb
+#define MLXPLAT_CPLD_LPC_REG_TACHO8_OFFSET	0xec
+#define MLXPLAT_CPLD_LPC_REG_TACHO9_OFFSET	0xed
+#define MLXPLAT_CPLD_LPC_REG_TACHO10_OFFSET	0xee
+#define MLXPLAT_CPLD_LPC_REG_TACHO11_OFFSET	0xef
+#define MLXPLAT_CPLD_LPC_REG_TACHO12_OFFSET	0xf0
 #define MLXPLAT_CPLD_LPC_IO_RANGE		0x100
 #define MLXPLAT_CPLD_LPC_I2C_CH1_OFF		0xdb
 #define MLXPLAT_CPLD_LPC_I2C_CH2_OFF		0xda
-- 
2.19.1

