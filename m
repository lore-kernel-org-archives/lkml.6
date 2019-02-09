Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910DBC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CDD020643
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549738664;
	bh=+AaSc3mP8aLvi3K6rcsiNSVM3WVxFfwC9zxuymUd+bI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LYr5Hkc3u3W5TVIdhfQichC6KMxSYpTcaDR3xQacw5bpc5aiQKi6uL1+zKFhSCA/a
	 M3RCqo+fkMrkkqLzYsviWCao8jh6kTUF2prXiEATmjksBP4zc71SJkxGaAWGAC/3PI
	 rgbOzDkBihKTrenwexXZWQG0OUl/AdLGFALrnfzY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbfBIS5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:57:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:60290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727308AbfBISrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 13:47:42 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADD6221939;
        Sat,  9 Feb 2019 18:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549738062;
        bh=+AaSc3mP8aLvi3K6rcsiNSVM3WVxFfwC9zxuymUd+bI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SxwwkvdBvqWk/njTNZre/S9BUjY6kUZbmbkLBLeIXwsz9viIKrbWU64mTCogMZfAg
         AXLurTNUyeEe91O0i2OkHitgesnXxLOhGQsk+ifQhpMcX2pmPx/DVo8LPoBBRB+AMr
         WgB1rNeX1vGrReozl6XJVyo0AjN+gTAejATZ6xLk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Biju Das <biju.das@bp.renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 06/42] soc: renesas: r8a774c0-sysc: Fix initialization order of 3DG-{A,B}
Date:   Sat,  9 Feb 2019 13:46:58 -0500
Message-Id: <20190209184734.125935-6-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190209184734.125935-1-sashal@kernel.org>
References: <20190209184734.125935-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Biju Das <biju.das@bp.renesas.com>

[ Upstream commit a64597227d0de5610407fcc95dc835745a53f5d0 ]

The workaround for the wrong hierarchy of the 3DG-{A,B} power domains on
RZ/G2E ES1.0 corrected the parent domains. However, the 3DG-{A,B} power
domains were still initialized and powered in the wrong order, causing
3DG operation to fail.

Fix this by changing the order in the table at runtime, when running on
an affected SoC.

This work is based on the work done by Geert for R-Car E3.

Fixes: f37d211c687588328 ("soc: renesas: rcar-sysc: Add r8a774c0 support")

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/renesas/r8a774c0-sysc.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/drivers/soc/renesas/r8a774c0-sysc.c b/drivers/soc/renesas/r8a774c0-sysc.c
index e1ac4c0f6640..11050e17ea81 100644
--- a/drivers/soc/renesas/r8a774c0-sysc.c
+++ b/drivers/soc/renesas/r8a774c0-sysc.c
@@ -28,19 +28,6 @@ static struct rcar_sysc_area r8a774c0_areas[] __initdata = {
 	{ "3dg-b",	0x100, 1, R8A774C0_PD_3DG_B,	R8A774C0_PD_3DG_A },
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
 /* Fixups for RZ/G2E ES1.0 revision */
 static const struct soc_device_attribute r8a774c0[] __initconst = {
 	{ .soc_id = "r8a774c0", .revision = "ES1.0" },
@@ -50,12 +37,10 @@ static const struct soc_device_attribute r8a774c0[] __initconst = {
 static int __init r8a774c0_sysc_init(void)
 {
 	if (soc_device_match(r8a774c0)) {
-		rcar_sysc_fix_parent(r8a774c0_areas,
-				     ARRAY_SIZE(r8a774c0_areas),
-				     R8A774C0_PD_3DG_A, R8A774C0_PD_3DG_B);
-		rcar_sysc_fix_parent(r8a774c0_areas,
-				     ARRAY_SIZE(r8a774c0_areas),
-				     R8A774C0_PD_3DG_B, R8A774C0_PD_ALWAYS_ON);
+		/* Fix incorrect 3DG hierarchy */
+		swap(r8a774c0_areas[6], r8a774c0_areas[7]);
+		r8a774c0_areas[6].parent = R8A774C0_PD_ALWAYS_ON;
+		r8a774c0_areas[7].parent = R8A774C0_PD_3DG_B;
 	}
 
 	return 0;
-- 
2.19.1

