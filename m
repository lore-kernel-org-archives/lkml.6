Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A86EC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDD7E21B18
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895237;
	bh=cTtMXJXNrnhPjGw89PpXkrSod06WF4AgN8ME0tltaZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Lvb9u2/rMs3l8bI0fmVrB8jxnIGWUvG01J1SE/sPtfNquBpOdNxY+PBmuTZICQ14R
	 gPGLUznw6fpKY+Ro7BU1Ecoj93VvI4cymQaTAaVeO1xsU4rX8VE3V4wR+ofTkB278z
	 z09lyzSWkJg6w0sHoWC+DHTJxuzZLkTbyUtpcIUQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbfBKO1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:27:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:32958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729679AbfBKO1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:27:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E4482075C;
        Mon, 11 Feb 2019 14:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895232;
        bh=cTtMXJXNrnhPjGw89PpXkrSod06WF4AgN8ME0tltaZw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MizXMKvJLTlBgd2QE8tn9EknBI2+SBL0E9nvcUJVYQlHdal39pseHo5PLXHq/VnOU
         sVHcxLKCRysLgO+JwRIOqZRqnP8WB1I0WvhA517JKngwWjJlE+3+hpNw5nW90fPgD7
         lcJrq5OOBUXCC+Fz0i04ov1sognJdQYA4mUBjz28=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 137/352] ARM: dts: Fix up the D-Link DIR-685 MTD partition info
Date:   Mon, 11 Feb 2019 15:16:04 +0100
Message-Id: <20190211141855.233524233@linuxfoundation.org>
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



