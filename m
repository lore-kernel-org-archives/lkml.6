Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEC7C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E01CF276A9
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="h3aDLxZE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E01CF276A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965237AbeF1Qox (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 12:44:53 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:53393 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753513AbeF1QoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 12:44:25 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180628164423euoutp01fdf1b348f9ede342eaa61dd8c1ff86ea~8YKuLHmJe3228932289euoutp01X;
        Thu, 28 Jun 2018 16:44:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180628164423euoutp01fdf1b348f9ede342eaa61dd8c1ff86ea~8YKuLHmJe3228932289euoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1530204263;
        bh=dH4ajTldSsGGqC9KxOLAXS6/jBym+KlqcDZ2q+tWpMs=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=h3aDLxZEVkhsKTW/++0S5zw5mbdtQTqK8k+qgdxZL0H0C9CmDiPa6qI7KZd3AQwh9
         T0+DzV4x/PSORNswjA8KXP6/AEQThBTGIwUst+dW0UuOmeU2QJW3lL5oEFqd3mlZaY
         KTEptYJzJ7a1CDE8NlAPtbTd9qkXxJsNpbnebKOg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180628164422eucas1p23137f23919c316a7ebb8d26137e9185b~8YKta9geV1088410884eucas1p2N;
        Thu, 28 Jun 2018 16:44:22 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 89.16.05700.660153B5; Thu, 28
        Jun 2018 17:44:22 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180628164420eucas1p1f3890855a95ccfa2c0306f413c6fcf91~8YKroqMlw3253632536eucas1p1Z;
        Thu, 28 Jun 2018 16:44:20 +0000 (GMT)
X-AuditID: cbfec7f2-1c1ff70000011644-6f-5b351066121a
Received: from eusync3.samsung.com ( [203.254.199.213]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 50.8A.04183.460153B5; Thu, 28
        Jun 2018 17:44:20 +0100 (BST)
Received: from AMDC2075.DIGITAL.local ([106.120.51.25]) by
        eusync3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PB1006SUL5Q0Y10@eusync3.samsung.com>;
        Thu, 28 Jun 2018 17:44:20 +0100 (BST)
From:   Maciej Purski <m.purski@samsung.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org, Maciej Purski <m.purski@samsung.com>
Subject: [PATCH 3/3] drm/bridge/sii8620: Fix link mode selection
Date:   Thu, 28 Jun 2018 18:44:03 +0200
Message-id: <1530204243-6370-4-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1530204243-6370-1-git-send-email-m.purski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRmVeSWpSXmKPExsWy7djPc7ppAqbRBtN28FncWneO1aL33Ekm
        i6aOt6wWG2esZ7W48vU9m0XnxCXsFpd3zWGzWPDyFovF2iN32R04PS739TJ5zO6Yyeqx/dsD
        Vo/73ceZPPq2rGL0+LxJLoAtissmJTUnsyy1SN8ugSvj94X1TAXv+Cuevb3E1MC4jLeLkZND
        QsBEYvnTp0xdjFwcQgIrGCUaJ01iAUkICXxmlPh13QmuaNM7doiiZYwSM9d0s0A4/4E6fn9m
        7mLk4GAT0JJY0x4P0iAioCzxd+IqRpAaZoGrTBInL29nAkkICzhIrL/3lRHEZhFQlehZtA0s
        zivgLLH45yZWiG1yEjfPdTKD2JwCLhJzGleADZIQWMAm8f7kVjaIIheJDYuXQTUIS7w6voUd
        wpaRuDy5mwXCrpZY+XI5C0RzA6PEl7uXmSES1hKHj18Ea2YW4JOYtG062AcSArwSHW1CECUe
        Ejt3/mCE+HI6o8TPj31sExglFzAyrGIUTy0tzk1PLTbMSy3XK07MLS7NS9dLzs/dxAiMz9P/
        jn/awfj1UtIhRgEORiUe3hNXTKKFWBPLiitzDzFKcDArifAKcZpGC/GmJFZWpRblxxeV5qQW
        H2KU5mBREueN06iLEhJITyxJzU5NLUgtgskycXBKNTCuYJqUt71kUwy37x3362Zls6avVtH4
        sryt9efyGNWI7n3Rax6YKMV1XFRq61lxJ9538WGJxlNhc8M2vRBRmzBX/M0Tyx/yEz9+3HZx
        9m+XtqkfztS0PZDO/7FU/8+ZoMm1sm+3fLhk+HZ6aqiMmF7A9swl+2b+ilN2azvdmiH9uDN3
        3z5D67nXlFiKMxINtZiLihMBeNaClcsCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGLMWRmVeSWpSXmKPExsVy+t/xq7opAqbRBktfylrcWneO1aL33Ekm
        i6aOt6wWG2esZ7W48vU9m0XnxCXsFpd3zWGzWPDyFovF2iN32R04PS739TJ5zO6Yyeqx/dsD
        Vo/73ceZPPq2rGL0+LxJLoAtissmJTUnsyy1SN8ugSvj94X1TAXv+Cuevb3E1MC4jLeLkZND
        QsBEYvmmd+xdjFwcQgJLGCV+rT/DBuE0Mknc+3yKqYuRg4NNQEtiTXs8SIOIgLLE34mrGEFq
        mAVuMkn8PbuXFSQhLOAgsf7eV0YQm0VAVaJn0TYmEJtXwFli8c9NrBDb5CRunutkBrE5BVwk
        5jSuAKsXAqo5vbeJbQIjzwJGhlWMIqmlxbnpucVGesWJucWleel6yfm5mxiBobXt2M8tOxi7
        3gUfYhTgYFTi4T1xxSRaiDWxrLgy9xCjBAezkgivEKdptBBvSmJlVWpRfnxRaU5q8SFGaQ4W
        JXHe8waVUUIC6YklqdmpqQWpRTBZJg5OqQZGJXHhH3yKNV+/zFgmWf5pz89zkXvM7n/6LXXX
        5eH83HUTfvxwTlPP/rrE/V9iT0LX1Kfz3VK3+b+3lN2yz29ieqKxvujuBnGux2X3zsTXz0ws
        4L4ie1rlyjRh6aapOp9qL2j9m2XtdO99pMnrT2ty+BpUrC5rdKT+zT52M16v6Djf67JdQVrV
        SizFGYmGWsxFxYkAlTPcpykCAAA=
X-CMS-MailID: 20180628164420eucas1p1f3890855a95ccfa2c0306f413c6fcf91
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180628164420eucas1p1f3890855a95ccfa2c0306f413c6fcf91
References: <1530204243-6370-1-git-send-email-m.purski@samsung.com>
        <CGME20180628164420eucas1p1f3890855a95ccfa2c0306f413c6fcf91@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current link mode values do not allow to enable packed pixel modes.

Select packed pixel clock mode, if needed, every time the link mode
register gets updated.

Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 drivers/gpu/drm/bridge/sil-sii8620.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/bridge/sil-sii8620.c b/drivers/gpu/drm/bridge/sil-sii8620.c
index 16fe7ea..a6e8f45 100644
--- a/drivers/gpu/drm/bridge/sil-sii8620.c
+++ b/drivers/gpu/drm/bridge/sil-sii8620.c
@@ -1165,8 +1165,14 @@ static void sii8620_start_video(struct sii8620 *ctx)
 	sii8620_set_format(ctx);
 
 	if (!sii8620_is_mhl3(ctx)) {
-		sii8620_mt_write_stat(ctx, MHL_DST_REG(LINK_MODE),
-			MHL_DST_LM_CLK_MODE_NORMAL | MHL_DST_LM_PATH_ENABLED);
+		u8 link_mode = MHL_DST_LM_PATH_ENABLED;
+
+		if (ctx->use_packed_pixel)
+			link_mode |= MHL_DST_LM_CLK_MODE_PACKED_PIXEL;
+		else
+			link_mode |= MHL_DST_LM_CLK_MODE_NORMAL;
+
+		sii8620_mt_write_stat(ctx, MHL_DST_REG(LINK_MODE), link_mode);
 		sii8620_set_auto_zone(ctx);
 	} else {
 		static const struct {
@@ -1677,14 +1683,18 @@ static void sii8620_status_dcap_ready(struct sii8620 *ctx)
 
 static void sii8620_status_changed_path(struct sii8620 *ctx)
 {
-	if (ctx->stat[MHL_DST_LINK_MODE] & MHL_DST_LM_PATH_ENABLED) {
-		sii8620_mt_write_stat(ctx, MHL_DST_REG(LINK_MODE),
-				      MHL_DST_LM_CLK_MODE_NORMAL
-				      | MHL_DST_LM_PATH_ENABLED);
-	} else {
-		sii8620_mt_write_stat(ctx, MHL_DST_REG(LINK_MODE),
-				      MHL_DST_LM_CLK_MODE_NORMAL);
-	}
+	u8 link_mode;
+
+	if (ctx->use_packed_pixel)
+		link_mode = MHL_DST_LM_CLK_MODE_PACKED_PIXEL;
+	else
+		link_mode = MHL_DST_LM_CLK_MODE_NORMAL;
+
+	if (ctx->stat[MHL_DST_LINK_MODE] & MHL_DST_LM_PATH_ENABLED)
+		link_mode |= MHL_DST_LM_PATH_ENABLED;
+
+	sii8620_mt_write_stat(ctx, MHL_DST_REG(LINK_MODE),
+			      link_mode);
 }
 
 static void sii8620_msc_mr_write_stat(struct sii8620 *ctx)
-- 
2.7.4

