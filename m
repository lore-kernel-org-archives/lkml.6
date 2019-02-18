Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5ECC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DD8E21901
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550497540;
	bh=ywFdKdw4ILpZ8qYFphSJbs4Jgf/JH5YviGePnJ6XJiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EKir0iW6pOJ0q/Jk71H8lSsfu0mY8LHyetho6OxjyCUmyyidJk7gD0N0jJiluWTso
	 z5jFW4UPK17qNDdNZxsaedF1mAEfdZIGDLxhbo6IBW49FyUfZS5hNER+OP5byfK86z
	 PCyf0wb5g/zEjMxNDaSaVkyzjCIHSXawkoCpZ7ng=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731395AbfBRNpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:45:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:51818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731370AbfBRNpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:45:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF772218FC;
        Mon, 18 Feb 2019 13:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497536;
        bh=ywFdKdw4ILpZ8qYFphSJbs4Jgf/JH5YviGePnJ6XJiQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e+giJWYkKojbIqHgh2NaxUoK4+wgiyuOUbzRcJSCupQQacdgjbVDfOvnEGT6c5Ul+
         jA06TqYYSTnLTBQpcayanQ0iBbgwjVlGgatIrR5NuY+LeNU4Nsajqt4bxlqXzikhKg
         GCsaVuxKGlh1PnqwtvpXQG4kohw3agXc8+3ZVSZQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Biju Das <biju.das@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 09/92] soc: renesas: r8a774c0-sysc: Fix initialization order of 3DG-{A,B}
Date:   Mon, 18 Feb 2019 14:42:12 +0100
Message-Id: <20190218133455.517307123@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133454.668268457@linuxfoundation.org>
References: <20190218133454.668268457@linuxfoundation.org>
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



