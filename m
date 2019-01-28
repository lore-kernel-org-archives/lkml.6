Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327C1C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 037452175B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691195;
	bh=1uMWs1PJfJtH4xyUfZyBSupDsuVE092Sz9H+aaRFgeQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yUV6KSCgehfKtiRBp08EqGd++tpnF0MCKe2bcnqDJZ2R0dvAiZ0NQ7HjVeMHfOqDO
	 69kk7vGN+ssbQEGMMl0VZ8XC/R+Jg8RGnPJrhKrt/3+zd5T1/i9cNchrChY6Z2NgEA
	 0lvXr5tJqhWG2bo0/IVAkqGd4x1iWOb8iasN6FCk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730651AbfA1P7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:59:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:45160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730638AbfA1P7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:59:51 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B2372175B;
        Mon, 28 Jan 2019 15:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691190;
        bh=1uMWs1PJfJtH4xyUfZyBSupDsuVE092Sz9H+aaRFgeQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dSP4NiJAgH7Z7/NZIbWwHGqP09yIWgadE+RbOTGNDS9np2SwrKLfx7ydZzx9Sv8qv
         G7vgxlZkmYke2/0sYUy8hWOugyBITPA3jhwTLakVdOFu8IQ23cIzLt4fB7s0JVbBdZ
         HWkug4Qtht4dNB6/Lxh9gvLm3h1jqQqIDlYmlk0o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 009/258] gpu: ipu-v3: image-convert: Prevent race between run and unprepare
Date:   Mon, 28 Jan 2019 10:55:15 -0500
Message-Id: <20190128155924.51521-9-sashal@kernel.org>
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

From: Steve Longerbeam <slongerbeam@gmail.com>

[ Upstream commit 819bec35c8c9706185498c9222bd244e0781ad35 ]

Prevent possible race by parallel threads between ipu_image_convert_run()
and ipu_image_convert_unprepare(). This involves setting ctx->aborting
to true unconditionally so that no new job runs can be queued during
unprepare, and holding the ctx->aborting flag until the context is freed.

Note that the "normal" ipu_image_convert_abort() case (e.g. not during
context unprepare) should clear the ctx->aborting flag after aborting
any active run and clearing the context's pending queue. This is because
it should be possible to continue to use the conversion context and queue
more runs after an abort.

Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
Tested-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/ipu-v3/ipu-image-convert.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/ipu-v3/ipu-image-convert.c b/drivers/gpu/ipu-v3/ipu-image-convert.c
index f4081962784c..91653adc41cc 100644
--- a/drivers/gpu/ipu-v3/ipu-image-convert.c
+++ b/drivers/gpu/ipu-v3/ipu-image-convert.c
@@ -1524,7 +1524,7 @@ int ipu_image_convert_queue(struct ipu_image_convert_run *run)
 EXPORT_SYMBOL_GPL(ipu_image_convert_queue);
 
 /* Abort any active or pending conversions for this context */
-void ipu_image_convert_abort(struct ipu_image_convert_ctx *ctx)
+static void __ipu_image_convert_abort(struct ipu_image_convert_ctx *ctx)
 {
 	struct ipu_image_convert_chan *chan = ctx->chan;
 	struct ipu_image_convert_priv *priv = chan->priv;
@@ -1551,7 +1551,7 @@ void ipu_image_convert_abort(struct ipu_image_convert_ctx *ctx)
 
 	need_abort = (run_count || active_run);
 
-	ctx->aborting = need_abort;
+	ctx->aborting = true;
 
 	spin_unlock_irqrestore(&chan->irqlock, flags);
 
@@ -1572,7 +1572,11 @@ void ipu_image_convert_abort(struct ipu_image_convert_ctx *ctx)
 		dev_warn(priv->ipu->dev, "%s: timeout\n", __func__);
 		force_abort(ctx);
 	}
+}
 
+void ipu_image_convert_abort(struct ipu_image_convert_ctx *ctx)
+{
+	__ipu_image_convert_abort(ctx);
 	ctx->aborting = false;
 }
 EXPORT_SYMBOL_GPL(ipu_image_convert_abort);
@@ -1586,7 +1590,7 @@ void ipu_image_convert_unprepare(struct ipu_image_convert_ctx *ctx)
 	bool put_res;
 
 	/* make sure no runs are hanging around */
-	ipu_image_convert_abort(ctx);
+	__ipu_image_convert_abort(ctx);
 
 	dev_dbg(priv->ipu->dev, "%s: task %u: removing ctx %p\n", __func__,
 		chan->ic_task, ctx);
-- 
2.19.1

