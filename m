Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E895BC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B38072082E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548695922;
	bh=c7wP/oO8MsH6SEorEqRo1ZnrFMcQEaU01KcuWDELvb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rUO9C4JNHPrDSlV+DgR3mObu4Xyn7e8SA2C+M7ia327Hbrbq7xBKX5xdJJPXt4Wac
	 FF8Q3TjjihdzS7MZRUff7QjRtDBBtPAYE5lfTpRK4ZShmMilhYWoldvDW5sOWynwn7
	 pYbmEheyY3sW7vgfcPNTmRo7Kcq4Nq7Js88uIGeM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731425AbfA1RSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:18:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:51474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730204AbfA1QFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:05:11 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9C2920989;
        Mon, 28 Jan 2019 16:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691510;
        bh=c7wP/oO8MsH6SEorEqRo1ZnrFMcQEaU01KcuWDELvb0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EnxhkKydan29/HWTxPHneX/zS9cdIE+M7Lh7KpiXdF7Y0NsgPXDoSvP0xOos9maWP
         JwFMr+yWrOvZesQNhIvUI2hukHrikpcMwYkYzMypucH0CFULcG8Jm11RWQJscC80DT
         5Bx0X6UtOScoYMpdeOu3YTva41ZLofPwBSsYSjlk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 122/258] ARM: dts: Fix up the D-Link DIR-685 MTD partition info
Date:   Mon, 28 Jan 2019 10:57:08 -0500
Message-Id: <20190128155924.51521-122-sashal@kernel.org>
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

From: Linus Walleij <linus.walleij@linaro.org>

[ Upstream commit 738a05e673435afb986b53da43befd83ad87ec3b ]

The vendor firmware was analyzed to get the right idea about
this flash layout. /proc/mtd contains:

dev:    size   erasesize  name
mtd0: 01e7ff40 00020000 "rootfs"
mtd1: 01f40000 00020000 "upgrade"
mtd2: 00040000 00020000 "rgdb"
mtd3: 00020000 00020000 "nvram"
mtd4: 00040000 00020000 "RedBoot"
mtd5: 00020000 00020000 "LangPack"
mtd6: 02000000 00020000 "flash"

Here "flash" is obviously the whole device and we know "rootfs"
is a bogus hack to point to a squashfs rootfs inside of the main
"upgrade partition". We know "RedBoot" is the first 0x40000 of
the flash and the "upgrade" partition follows from 0x40000 to
0x1f8000. So we have mtd0, 1, 4 and 6 covered.

Remains:
mtd2: 00040000 00020000 "rgdb"
mtd3: 00020000 00020000 "nvram"
mtd5: 00020000 00020000 "LangPack"

Inspecting the flash at 0x1f8000 and 0x1fa000 reveals each of
these starting with "RGCFG1" so we assume 0x1f8000-1fbfff is
"rgdb" of 0x40000.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/gemini-dlink-dir-685.dts | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/gemini-dlink-dir-685.dts b/arch/arm/boot/dts/gemini-dlink-dir-685.dts
index 6f258b50eb44..502a361d1fe9 100644
--- a/arch/arm/boot/dts/gemini-dlink-dir-685.dts
+++ b/arch/arm/boot/dts/gemini-dlink-dir-685.dts
@@ -274,20 +274,16 @@
 				read-only;
 			};
 			/*
-			 * Between the boot loader and the rootfs is the kernel
-			 * in a custom Storlink format flashed from the boot
-			 * menu. The rootfs is in squashfs format.
+			 * This firmware image contains the kernel catenated
+			 * with the squashfs root filesystem. For some reason
+			 * this is called "upgrade" on the vendor system.
 			 */
-			partition@1800c0 {
-				label = "rootfs";
-				reg = <0x001800c0 0x01dbff40>;
-				read-only;
-			};
-			partition@1f40000 {
+			partition@40000 {
 				label = "upgrade";
-				reg = <0x01f40000 0x00040000>;
+				reg = <0x00040000 0x01f40000>;
 				read-only;
 			};
+			/* RGDB, Residental Gateway Database? */
 			partition@1f80000 {
 				label = "rgdb";
 				reg = <0x01f80000 0x00040000>;
-- 
2.19.1

