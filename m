Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C588C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCA4920875
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:23:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCA4920875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388605AbeGKO2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 10:28:11 -0400
Received: from laurent.telenet-ops.be ([195.130.137.89]:43578 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387949AbeGKO2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 10:28:10 -0400
Received: from ayla.of.borg ([84.194.111.163])
        by laurent.telenet-ops.be with bizsmtp
        id 9SPZ1y02Q3XaVaC01SPZ1b; Wed, 11 Jul 2018 16:23:33 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fdG1l-0000hk-G8; Wed, 11 Jul 2018 16:23:33 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fdG1l-00018W-Dv; Wed, 11 Jul 2018 16:23:33 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] v4l: rcar_fdp1: Enable compilation on Gen2 platforms
Date:   Wed, 11 Jul 2018 16:23:32 +0200
Message-Id: <20180711142332.4324-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Commit 1d3897143815 ("[media] v4l: rcar_fdp1: add FCP dependency") fixed
a compilation breakage when the optional VIDEO_RENESAS_FCP dependency is
compiled as a module while the rcar_fdp1 driver is built in. As a side
effect it disabled compilation on Gen2 by disallowing the valid
combination ARCH_RENESAS && !VIDEO_RENESAS_FCP. Fix it by handling the
dependency the same way the vsp1 driver did in commit 199946731fa4
("[media] vsp1: clarify FCP dependency").

Fixes: 1d3897143815 ("[media] v4l: rcar_fdp1: add FCP dependency")
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/media/platform/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 210b44a457eb66f0..84cb97eccb2a52bc 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -385,7 +385,7 @@ config VIDEO_RENESAS_FDP1
 	tristate "Renesas Fine Display Processor"
 	depends on VIDEO_DEV && VIDEO_V4L2
 	depends on ARCH_RENESAS || COMPILE_TEST
-	depends on (!ARCH_RENESAS && !VIDEO_RENESAS_FCP) || VIDEO_RENESAS_FCP
+	depends on (!ARM64 && !VIDEO_RENESAS_FCP) || VIDEO_RENESAS_FCP
 	select VIDEOBUF2_DMA_CONTIG
 	select V4L2_MEM2MEM_DEV
 	---help---
-- 
2.17.1

