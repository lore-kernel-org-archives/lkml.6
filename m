Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D8FC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E409206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:39:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E409206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbeLEPjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:39:51 -0500
Received: from baptiste.telenet-ops.be ([195.130.132.51]:32798 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727804AbeLEPju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 10:39:50 -0500
Received: from ramsan ([84.194.111.163])
        by baptiste.telenet-ops.be with bizsmtp
        id 8Ffo1z0083XaVaC01FfoR6; Wed, 05 Dec 2018 16:39:49 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gUZHA-0001yQ-5j; Wed, 05 Dec 2018 16:39:48 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gUZHA-0003as-4Z; Wed, 05 Dec 2018 16:39:48 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/4] soc: renesas: r8a77990-sysc: Fix initialization order of 3DG-{A,B}
Date:   Wed,  5 Dec 2018 16:39:42 +0100
Message-Id: <20181205153945.13767-2-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205153945.13767-1-geert+renesas@glider.be>
References: <20181205153945.13767-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The workaround for the wrong hierarchy of the 3DG-{A,B} power
domains on R-Car E3 ES1.0 corrected the parent domains.
However, the 3DG-{A,B} power domains were still initialized and powered
in the wrong order, causing 3DG operation to fail.

Fix this by changing the order in the table at runtime, when running on
an affected SoC.

Fixes: 086b399965a7ee7e ("soc: renesas: r8a77990-sysc: Add workaround for 3DG-{A,B}")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/soc/renesas/r8a77990-sysc.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/drivers/soc/renesas/r8a77990-sysc.c b/drivers/soc/renesas/r8a77990-sysc.c
index 15579ebc5ed2059d..664b244eb1dd9d95 100644
--- a/drivers/soc/renesas/r8a77990-sysc.c
+++ b/drivers/soc/renesas/r8a77990-sysc.c
@@ -28,19 +28,6 @@ static struct rcar_sysc_area r8a77990_areas[] __initdata = {
 	{ "3dg-b",	0x100, 1, R8A77990_PD_3DG_B,	R8A77990_PD_3DG_A },
 };
 
-static void __init rcar_sysc_fix_parent(struct rcar_sysc_area *areas,
-					unsigned int num_areas, u8 id,
-					int new_parent)
-{
-	unsigned int i;
-
-	for (i = 0; i < num_areas; i++)
-		if (areas[i].isr_bit == id) {
-			areas[i].parent = new_parent;
-			return;
-		}
-}
-
 /* Fixups for R-Car E3 ES1.0 revision */
 static const struct soc_device_attribute r8a77990[] __initconst = {
 	{ .soc_id = "r8a77990", .revision = "ES1.0" },
@@ -50,12 +37,10 @@ static const struct soc_device_attribute r8a77990[] __initconst = {
 static int __init r8a77990_sysc_init(void)
 {
 	if (soc_device_match(r8a77990)) {
-		rcar_sysc_fix_parent(r8a77990_areas,
-				     ARRAY_SIZE(r8a77990_areas),
-				     R8A77990_PD_3DG_A, R8A77990_PD_3DG_B);
-		rcar_sysc_fix_parent(r8a77990_areas,
-				     ARRAY_SIZE(r8a77990_areas),
-				     R8A77990_PD_3DG_B, R8A77990_PD_ALWAYS_ON);
+		/* Fix incorrect 3DG hierarchy */
+		swap(r8a77990_areas[7], r8a77990_areas[8]);
+		r8a77990_areas[7].parent = R8A77990_PD_ALWAYS_ON;
+		r8a77990_areas[8].parent = R8A77990_PD_3DG_B;
 	}
 
 	return 0;
-- 
2.17.1

