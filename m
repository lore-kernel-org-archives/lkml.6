Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14224C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D02D3214DE
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789598;
	bh=wyNANDblERKyJXLqBuBHaKH/FzMh7hyUq3ng232NBV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P+qG3/INV/VWBC8mMwuLGAQkxT9Co8UG1eCxFz3EEz5cLtQLOVLBQSv4c2/NvuI3J
	 oetu+L9OUkUNcNnWfCYHa0VS8NenDbOoo2UXxUxnVNy/yxgGwUWoBWXndkmG/p2mWH
	 e+qXypbMup+40qYFRZ3ULfUOBtYn6ZeY8J53HMnU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D02D3214DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732100AbeLNMNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:13:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:60732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732086AbeLNMNN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:13:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 585BB214E0;
        Fri, 14 Dec 2018 12:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789592;
        bh=wyNANDblERKyJXLqBuBHaKH/FzMh7hyUq3ng232NBV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zK//gybuzDR31Lr7tLY79iyHGPPqRdxr8o8jvmyppc1HLcos2HOGmUjDmRXJqiVqu
         jmY5c17gqBlbv0QUM/ua1DgHOWX6qcGxoc8vETy0WSsB/1Bvned5568WjQE38LI5Fu
         8NesUe/u0/I8YRrEhHSlIzMyzwc5DwgQaaDIkdn8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Y.C. Chen" <yc_chen@aspeedtech.com>,
        Dave Airlie <airlied@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 41/51] drm/ast: fixed reading monitor EDID not stable issue
Date:   Fri, 14 Dec 2018 13:00:43 +0100
Message-Id: <20181214115716.842801826@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115713.244259772@linuxfoundation.org>
References: <20181214115713.244259772@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 57205016b04a..201874b96dd6 100644
--- a/drivers/gpu/drm/ast/ast_mode.c
+++ b/drivers/gpu/drm/ast/ast_mode.c
@@ -954,9 +954,21 @@ static int get_clock(void *i2c_priv)
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
 
@@ -964,9 +976,21 @@ static int get_data(void *i2c_priv)
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
 
@@ -979,7 +1003,7 @@ static void set_clock(void *i2c_priv, int clock)
 
 	for (i = 0; i < 0x10000; i++) {
 		ujcrb7 = ((clock & 0x01) ? 0 : 1);
-		ast_set_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xb7, 0xfe, ujcrb7);
+		ast_set_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xb7, 0xf4, ujcrb7);
 		jtemp = ast_get_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xb7, 0x01);
 		if (ujcrb7 == jtemp)
 			break;
@@ -995,7 +1019,7 @@ static void set_data(void *i2c_priv, int data)
 
 	for (i = 0; i < 0x10000; i++) {
 		ujcrb7 = ((data & 0x01) ? 0 : 1) << 2;
-		ast_set_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xb7, 0xfb, ujcrb7);
+		ast_set_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xb7, 0xf1, ujcrb7);
 		jtemp = ast_get_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xb7, 0x04);
 		if (ujcrb7 == jtemp)
 			break;
-- 
2.19.1



