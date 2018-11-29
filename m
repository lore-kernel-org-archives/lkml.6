Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B61C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4557521473
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gifOcTOM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4557521473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387507AbeK3BcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:32:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:60524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731758AbeK3BcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:32:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5E75213A2;
        Thu, 29 Nov 2018 14:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501611;
        bh=EjyD5ItF790zzMwiw08SUObFOQxOi6FFODmYdi/mlPg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gifOcTOMXu6a2JMZpaDC04McvFBjZ2G1BmRoV4iBvLT6MhS0PizT9uO9lT3udhV/c
         mdZDBpa33F/i1XE2n096Se5annM2YJ0S9pw/XeEw3LAn/nrsLGrjqBC16r0NroxwkU
         amUsKVEm2N8vDxj2YubgHssu5ILIjjVf/vw2XrsU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Junzhi Zhao <junzhi.zhao@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        CK Hu <ck.hu@mediatek.com>, David Airlie <airlied@linux.ie>,
        Johan Hovold <johan@kernel.org>, Rob Herring <robh@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 068/100] drm/mediatek: fix OF sibling-node lookup
Date:   Thu, 29 Nov 2018 15:12:38 +0100
Message-Id: <20181129140104.781890622@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140058.768942700@linuxfoundation.org>
References: <20181129140058.768942700@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit ceff2f4dcd44abf35864d9a99f85ac619e89a01d ]

Use the new of_get_compatible_child() helper to lookup the sibling
instead of using of_find_compatible_node(), which searches the entire
tree from a given start node and thus can return an unrelated (i.e.
non-sibling) node.

This also addresses a potential use-after-free (e.g. after probe
deferral) as the tree-wide helper drops a reference to its first
argument (i.e. the parent device node).

While at it, also fix the related cec-node reference leak.

Fixes: 8f83f26891e1 ("drm/mediatek: Add HDMI support")
Cc: stable <stable@vger.kernel.org>     # 4.8
Cc: Junzhi Zhao <junzhi.zhao@mediatek.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: CK Hu <ck.hu@mediatek.com>
Cc: David Airlie <airlied@linux.ie>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_hdmi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index 690c67507cbc..aba27ea9cea5 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -1446,8 +1446,7 @@ static int mtk_hdmi_dt_parse_pdata(struct mtk_hdmi *hdmi,
 	}
 
 	/* The CEC module handles HDMI hotplug detection */
-	cec_np = of_find_compatible_node(np->parent, NULL,
-					 "mediatek,mt8173-cec");
+	cec_np = of_get_compatible_child(np->parent, "mediatek,mt8173-cec");
 	if (!cec_np) {
 		dev_err(dev, "Failed to find CEC node\n");
 		return -EINVAL;
@@ -1457,8 +1456,10 @@ static int mtk_hdmi_dt_parse_pdata(struct mtk_hdmi *hdmi,
 	if (!cec_pdev) {
 		dev_err(hdmi->dev, "Waiting for CEC device %pOF\n",
 			cec_np);
+		of_node_put(cec_np);
 		return -EPROBE_DEFER;
 	}
+	of_node_put(cec_np);
 	hdmi->cec_dev = &cec_pdev->dev;
 
 	/*
-- 
2.17.1



