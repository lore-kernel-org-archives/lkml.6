Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F43C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 750FC20883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546949541;
	bh=GbMzRensU03GT9hjWsSQCVuqqG+tPntmwIoS4ac4+Fg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0klUrJjUbNCJkahEyg2ZrtIij6F/WzrIyqgOcdZ/CMCMHtarJsgbbv++jru6G4+Ns
	 +C6iZJXvSFMjumHllyvHdu/EPeFzPaMwQub8HyWNjYViSECz9q9qY95I3PtFUHxbLC
	 RiOiKC2JbSwPceq3UxCKCvhbMYne2fwzbBb5vnI0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbfAHMMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 07:12:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:34386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728760AbfAHMMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 07:12:19 -0500
Received: from localhost.localdomain (unknown [37.223.143.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FEE320850;
        Tue,  8 Jan 2019 12:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546949538;
        bh=GbMzRensU03GT9hjWsSQCVuqqG+tPntmwIoS4ac4+Fg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oCNSQy50IPlll4Xu2ka1u4t7+FyEbf98Y+EjdA+edI5PryZwRs/NCaYEHCbs7B6Jv
         y/YfcR11K/kOXCr1PrNlay6mugj/63Y41g4gO60u6AljVTAGpA1PBkqBkyWhWsDCHu
         BeYfG2LMqUY/qPmLNtTToSnPCLS82dKus8wQunek=
From:   matthias.bgg@kernel.org
To:     mturquette@baylibre.com, sboyd@kernel.org,
        kevin-cw.chen@mediatek.com, mars.cheng@mediatek.com
Cc:     sean.wang@mediatek.com, matthias.bgg@gmail.com, jasu@njomotys.info,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 1/3] clk: mediatek: Add MUX_FLAGS macro
Date:   Tue,  8 Jan 2019 13:12:06 +0100
Message-Id: <20190108121208.2473-2-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190108121208.2473-1-matthias.bgg@kernel.org>
References: <20190108121208.2473-1-matthias.bgg@kernel.org>
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

