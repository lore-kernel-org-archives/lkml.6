Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC32C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FD9C20989
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691542;
	bh=mN8hK7119mhhlQEMcPoiM0hkdX0V8kwKxe9/BOuU61c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o3+gIU4N6y7np8vz+wVrZlgVqA3nZEctK6hCLU3JxPwnSn+o8xieAeLutBcCynvaT
	 Fjl/X5Xj+FLZaylSmVMgmd95O3yj5yKYrl/5C9HP+t5dmkEPKR8qRAzlU9SVeuqD30
	 d0bkk4y5pXqR3vg58Bv1S9TVHRUIfrSG22Yu/fsk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731199AbfA1QFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:05:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:52602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731873AbfA1QFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:05:35 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E10D820989;
        Mon, 28 Jan 2019 16:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691534;
        bh=mN8hK7119mhhlQEMcPoiM0hkdX0V8kwKxe9/BOuU61c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ul2TCCOs3GqjQqqnXfCnvFNiCsz986+9DXxa7Ylesp5XAyg/Ni5Y9Twv6WmdxrPIi
         KjBaQ8WwU65kSWYNbit6XZbdzyA2mx31QiT8IURTLoOJWIy2tLmUVJSHU0SX2jnmup
         UzwoizqyX3D8SYtExmXARU0YY2UA/0NzmRCCtiRg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vadim Pasternak <vadimp@mellanox.com>,
        Darren Hart <dvhart@infradead.org>,
        Sasha Levin <sashal@kernel.org>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 133/258] platform/x86: mlx-platform: Fix tachometer registers
Date:   Mon, 28 Jan 2019 10:57:19 -0500
Message-Id: <20190128155924.51521-133-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
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
index d89936c93ba0..78b4aa4410fb 100644
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

