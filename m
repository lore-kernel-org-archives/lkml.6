Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2744C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0A1021B26
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549899149;
	bh=GRA4+zXjpsl7dlV8a4Z0jckTJYc+58L2WiqayCpIpRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KxgfLGOxvCY9H5llbeGzGgk5lL9kJPMFqU6C6pk96PA/3AqIU7Bx8LWBoiisu7Rss
	 vSGRQjQJDfG4HnRIHa3uk0KG7Sp32gVwxJljPxb07thjFhHXF0Dxz4/iFj17FgpG9b
	 iFiRekA62GFVzRrn0NZNjBZmNWKCpKKuM0i208eo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389243AbfBKPc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:32:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:41604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388365AbfBKOyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:54:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10A682229E;
        Mon, 11 Feb 2019 14:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896886;
        bh=GRA4+zXjpsl7dlV8a4Z0jckTJYc+58L2WiqayCpIpRY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kXhd+2ffmZRKAWzRZl0q6yCTYHLSdtdw37gCWdH1GZSaSJlGEdCgGN4KTVEaEt15Q
         stRy2paf7ESLpv5iUi0igChq5M9PLQpCWHMBiY2eSXSQ9AOUSgda95W7Dr9AJxdBMH
         wRUWP7NZxgteqxWh7gtXSsGIg5qUUMtUn3reykJ4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 006/205] gpu: ipu-v3: image-convert: Prevent race between run and unprepare
Date:   Mon, 11 Feb 2019 15:16:44 +0100
Message-Id: <20190211141827.576791817@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
References: <20190211141827.214852402@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 524a717ab28e..a5e33d58e02f 100644
--- a/drivers/gpu/ipu-v3/ipu-image-convert.c
+++ b/drivers/gpu/ipu-v3/ipu-image-convert.c
@@ -1518,7 +1518,7 @@ unlock:
 EXPORT_SYMBOL_GPL(ipu_image_convert_queue);
 
 /* Abort any active or pending conversions for this context */
-void ipu_image_convert_abort(struct ipu_image_convert_ctx *ctx)
+static void __ipu_image_convert_abort(struct ipu_image_convert_ctx *ctx)
 {
 	struct ipu_image_convert_chan *chan = ctx->chan;
 	struct ipu_image_convert_priv *priv = chan->priv;
@@ -1545,7 +1545,7 @@ void ipu_image_convert_abort(struct ipu_image_convert_ctx *ctx)
 
 	need_abort = (run_count || active_run);
 
-	ctx->aborting = need_abort;
+	ctx->aborting = true;
 
 	spin_unlock_irqrestore(&chan->irqlock, flags);
 
@@ -1566,7 +1566,11 @@ void ipu_image_convert_abort(struct ipu_image_convert_ctx *ctx)
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
@@ -1580,7 +1584,7 @@ void ipu_image_convert_unprepare(struct ipu_image_convert_ctx *ctx)
 	bool put_res;
 
 	/* make sure no runs are hanging around */
-	ipu_image_convert_abort(ctx);
+	__ipu_image_convert_abort(ctx);
 
 	dev_dbg(priv->ipu->dev, "%s: task %u: removing ctx %p\n", __func__,
 		chan->ic_task, ctx);
-- 
2.19.1



