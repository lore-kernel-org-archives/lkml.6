Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA37C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F412820675
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895363;
	bh=+xVMf97vz4CCKSnIT/euPzltuMYtI/GQ8pStB546Lmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JtMunCDePyx23ApXZlJCPyZWKuawEX7ivhDyMqlBMvj98rJkVM/KF4Sge6yl32AJ6
	 ubj86cCypeA9pwuX6cAQ7EGmhsPZI/EYiqJ70ldPdunT1Ds9CDzxbCy4pD7gNqR8Sq
	 zgPfPmmqX4NGM/dQJLNz3SdD3A5tDiCa/+9vDQLY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729980AbfBKO3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:29:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:35374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727441AbfBKO3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:29:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DEFD20675;
        Mon, 11 Feb 2019 14:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895357;
        bh=+xVMf97vz4CCKSnIT/euPzltuMYtI/GQ8pStB546Lmo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pQchLpm5cWz24t/w/HE+KfE1Ja4fIa3uPQg86P7utca1R5mWcK91dFoU2T/aaIUT7
         3EfD65JKLG32Tj/5cHUEW/duBQ3ULrXQxRFwntZ+2kOiquDmo3/4vIyuAODF4+NjxZ
         TFh5V5PJ1dv77FOZIZfQXR8JmnCBAYQG3iunx8kU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vadim Pasternak <vadimp@mellanox.com>,
        "Darren Hart (VMware)" <dvhart@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 147/352] platform/x86: mlx-platform: Fix tachometer registers
Date:   Mon, 11 Feb 2019 15:16:14 +0100
Message-Id: <20190211141855.965517137@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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



