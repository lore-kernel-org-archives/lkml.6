Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D871AC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8DDB21855
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549900104;
	bh=Wlq5/lUHk3x82kg44NMjg3B3gTlvq6rzZeScnuzB7rM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ReNNW4DsGjyRcAxEOQzq2pNLIy7QMOLT9OPcAWGg0ZPGalwFfUjSpJwL9kUsbksk7
	 g7KHRjqIT8lhNTL2o4Gn2Fju7DQLoL9ZrVvLDqByKsf3MAhbDWXQs3cMc89xCVze6E
	 MxXvS8BsNboj9LHJlsUGMhgrX35yxbLeEQ5c+WGE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733025AbfBKPsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:48:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:51634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732112AbfBKOkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:40:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27EAB20700;
        Mon, 11 Feb 2019 14:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896041;
        bh=Wlq5/lUHk3x82kg44NMjg3B3gTlvq6rzZeScnuzB7rM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YFe04Zelihk+5be8ovvf1RxOwpEoZ+U74S4s6khQlHcEgnp86aUpz0QV4VCLbwAa3
         tDd+sKy5B1NAcPt7mTMrykS898+DUdvZvSUpsos/r3LW42AGfnh70A5O4D8eAG7xzT
         2452+3kwQ8VPy57sVBIf3VftZT3j4kWrVJsuw3Zw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 052/313] media: mtk-vcodec: Release device nodes in mtk_vcodec_init_enc_pm()
Date:   Mon, 11 Feb 2019 15:15:32 +0100
Message-Id: <20190211141857.228531710@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 8ea0f2ba0fa3f91ea1b8d823a54b042026ada6b3 ]

of_parse_phandle() returns the device node with refcount incremented.
There are two nodes that are used temporary in mtk_vcodec_init_enc_pm(),
but their refcounts are not decremented.

The patch adds one of_node_put() and fixes returning error codes.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c
index 3e73e9db781f..7c025045ea90 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c
@@ -41,25 +41,27 @@ int mtk_vcodec_init_enc_pm(struct mtk_vcodec_dev *mtkdev)
 	node = of_parse_phandle(dev->of_node, "mediatek,larb", 0);
 	if (!node) {
 		mtk_v4l2_err("no mediatek,larb found");
-		return -1;
+		return -ENODEV;
 	}
 	pdev = of_find_device_by_node(node);
+	of_node_put(node);
 	if (!pdev) {
 		mtk_v4l2_err("no mediatek,larb device found");
-		return -1;
+		return -ENODEV;
 	}
 	pm->larbvenc = &pdev->dev;
 
 	node = of_parse_phandle(dev->of_node, "mediatek,larb", 1);
 	if (!node) {
 		mtk_v4l2_err("no mediatek,larb found");
-		return -1;
+		return -ENODEV;
 	}
 
 	pdev = of_find_device_by_node(node);
+	of_node_put(node);
 	if (!pdev) {
 		mtk_v4l2_err("no mediatek,larb device found");
-		return -1;
+		return -ENODEV;
 	}
 
 	pm->larbvenclt = &pdev->dev;
-- 
2.19.1



