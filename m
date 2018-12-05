Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BCBC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFBFB20878
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDjAH2va"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFBFB20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbeLEJle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:41:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:46004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727908AbeLEJlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:41:31 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69D8420850;
        Wed,  5 Dec 2018 09:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002890;
        bh=+XOzV77xp2GoK9CWwidyOONpXnq2cjeGMTaNItLdp4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DDjAH2vaLrXoyvrUa6jwX3uvsQmRJI6LzODItXRWX4GeGh9IcpX8UJI/iAZI+19dx
         aM650GjekGBv+NrcuRb8WJYnkH2sYR5TKkD6AxgbNRRZsrQWEJxw6/Lg5dmhWL/1M7
         nFrkdJQS7kYlB8R85cFFkxwjjws8pIlDkIuw7BRw=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Y.C. Chen" <yc_chen@aspeedtech.com>,
        Dave Airlie <airlied@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 100/123] drm/ast: fixed reading monitor EDID not stable issue
Date:   Wed,  5 Dec 2018 04:35:32 -0500
Message-Id: <20181205093555.5386-100-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Y.C. Chen" <yc_chen@aspeedtech.com>

[ Upstream commit 300625620314194d9e6d4f6dda71f2dc9cf62d9f ]

v1: over-sample data to increase the stability with some specific monitors
v2: refine to avoid infinite loop
v3: remove un-necessary "volatile" declaration

[airlied: fix two checkpatch warnings]

Signed-off-by: Y.C. Chen <yc_chen@aspeedtech.com>
Signed-off-by: Dave Airlie <airlied@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/1542858988-1127-1-git-send-email-yc_chen@aspeedtech.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/ast/ast_mode.c | 36 ++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_mode.c
index 7c6ac3cadb6b..8bb355d5d43d 100644
--- a/drivers/gpu/drm/ast/ast_mode.c
+++ b/drivers/gpu/drm/ast/ast_mode.c
@@ -973,9 +973,21 @@ static int get_clock(void *i2c_priv)
 {
 	struct ast_i2c_chan *i2c = i2c_priv;
 	struct ast_private *ast = i2c->dev->dev_private;
-	uint32_t val;
+	uint32_t val, val2, count, pass;
+
+	count = 0;
+	pass = 0;
+	val = (ast_get_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xb7, 0x10) >> 4) & 0x01;
+	do {
+		val2 = (ast_get_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xb7, 0x10) >> 4) & 0x01;
+		if (val == val2) {
+			pass++;
+		} else {
+			pass = 0;
+			val = (ast_get_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xb7, 0x10) >> 4) & 0x01;
+		}
+	} while ((pass < 5) && (count++ < 0x10000));
 
-	val = ast_get_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xb7, 0x10) >> 4;
 	return val & 1 ? 1 : 0;
 }
 
@@ -983,9 +995,21 @@ static int get_data(void *i2c_priv)
 {
 	struct ast_i2c_chan *i2c = i2c_priv;
 	struct ast_private *ast = i2c->dev->dev_private;
-	uint32_t val;
+	uint32_t val, val2, count, pass;
+
+	count = 0;
+	pass = 0;
+	val = (ast_get_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xb7, 0x20) >> 5) & 0x01;
+	do {
+		val2 = (ast_get_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xb7, 0x20) >> 5) & 0x01;
+		if (val == val2) {
+			pass++;
+		} else {
+			pass = 0;
+			val = (ast_get_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xb7, 0x20) >> 5) & 0x01;
+		}
+	} while ((pass < 5) && (count++ < 0x10000));
 
-	val = ast_get_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xb7, 0x20) >> 5;
 	return val & 1 ? 1 : 0;
 }
 
@@ -998,7 +1022,7 @@ static void set_clock(void *i2c_priv, int clock)
 
 	for (i = 0; i < 0x10000; i++) {
 		ujcrb7 = ((clock & 0x01) ? 0 : 1);
-		ast_set_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xb7, 0xfe, ujcrb7);
+		ast_set_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xb7, 0xf4, ujcrb7);
 		jtemp = ast_get_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xb7, 0x01);
 		if (ujcrb7 == jtemp)
 			break;
@@ -1014,7 +1038,7 @@ static void set_data(void *i2c_priv, int data)
 
 	for (i = 0; i < 0x10000; i++) {
 		ujcrb7 = ((data & 0x01) ? 0 : 1) << 2;
-		ast_set_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xb7, 0xfb, ujcrb7);
+		ast_set_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xb7, 0xf1, ujcrb7);
 		jtemp = ast_get_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xb7, 0x04);
 		if (ujcrb7 == jtemp)
 			break;
-- 
2.17.1

