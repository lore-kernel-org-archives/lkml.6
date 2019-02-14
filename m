Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0513DC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBCEB222DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550161946;
	bh=GbMzRensU03GT9hjWsSQCVuqqG+tPntmwIoS4ac4+Fg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=UeaT5qb7z5K5Lz0cZyyvkSIcFDaLJspYBimZa2HoJSbZsai+jDTg/36MNdeVqnfVT
	 3w6jMflesJeVRkuAfvHilbseQHUxXDiB4Bau6w0KEYz/qHCGao+uXmw/fIcNuGEEXr
	 4GmiNmxLi/zzXR8mhRImsrdT8C3zbFUE6Gh4Oupk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439669AbfBNQcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:32:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:36326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728867AbfBNQcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:32:24 -0500
Received: from ziggy.de (unknown [37.223.146.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18F5F222DA;
        Thu, 14 Feb 2019 16:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550161944;
        bh=GbMzRensU03GT9hjWsSQCVuqqG+tPntmwIoS4ac4+Fg=;
        h=From:To:Cc:Subject:Date:From;
        b=T8bZfAGXAiMXSF3lC2oWdTr9u+o2hGATuJby8133xEJI8cPF6Gw4Dmd3pJRfYtDwv
         NZFtu/Bck1UYCQvphugUn81DUnpe9ZKOgD0klfqEyi5+1kQah2NrZ+ctGG815FVDLh
         JRPCBBgM6m0/Hdu7R+uAdXAdkFXmiY60b0iKQREM=
From:   matthias.bgg@kernel.org
To:     mturquette@baylibre.com, sboyd@kernel.org,
        kevin-cw.chen@mediatek.com, mars.cheng@mediatek.com
Cc:     sean.wang@mediatek.com, matthias.bgg@gmail.com, jasu@njomotys.info,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v4 1/3] clk: mediatek: Add MUX_FLAGS macro
Date:   Thu, 14 Feb 2019 17:32:18 +0100
Message-Id: <20190214163218.26148-1-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jasper Mattsson <jasu@njomotys.info>

This is required to mark outputs of certain MUXes as CLK_IS_CRITICAL.

Signed-off-by: Jasper Mattsson <jasu@njomotys.info>
Acked-by: Mars Cheng <mars.cheng@mediatek.com>
Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 drivers/clk/mediatek/clk-mtk.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index f83c2bbb677e..daab6ee94788 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -111,7 +111,11 @@ struct mtk_composite {
 	MUX_GATE_FLAGS(_id, _name, _parents, _reg, _shift, _width,	\
 		_gate, CLK_SET_RATE_PARENT)
 
-#define MUX(_id, _name, _parents, _reg, _shift, _width) {		\
+#define MUX(_id, _name, _parents, _reg, _shift, _width)			\
+	MUX_FLAGS(_id, _name, _parents, _reg,				\
+		  _shift, _width, CLK_SET_RATE_PARENT)
+
+#define MUX_FLAGS(_id, _name, _parents, _reg, _shift, _width, _flags) {	\
 		.id = _id,						\
 		.name = _name,						\
 		.mux_reg = _reg,					\
@@ -121,7 +125,7 @@ struct mtk_composite {
 		.divider_shift = -1,					\
 		.parent_names = _parents,				\
 		.num_parents = ARRAY_SIZE(_parents),			\
-		.flags = CLK_SET_RATE_PARENT,				\
+		.flags = _flags,				\
 	}
 
 #define DIV_GATE(_id, _name, _parent, _gate_reg, _gate_shift, _div_reg,	\
-- 
2.20.1

