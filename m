Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F07C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDC3520817
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RnmDy3yu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDC3520817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389779AbeKLIVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:21:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:49154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389723AbeKLIVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:21:35 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A50CF2154B;
        Sun, 11 Nov 2018 22:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975498;
        bh=iBMBrBeK+ucY5fsx3KD8udwEdbRdCoqRppMt4mcDQes=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RnmDy3yuG3eX2M6RIGMUe7/9kYRrxpuQitVsi5pf7EzffbN/ra/MT2pft2evWh3TX
         bI6OHmJrmKUO0xxamLOoPIUBlzvg1TUa06kPbH/pPVFeuhXojxRVDyHvTgZ9tshjHa
         f2f9rWgszF4vgaltN0LNaQFtdWWLcQnKW1wcb4V4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Junzhi Zhao <junzhi.zhao@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        CK Hu <ck.hu@mediatek.com>, David Airlie <airlied@linux.ie>,
        Johan Hovold <johan@kernel.org>, Rob Herring <robh@kernel.org>
Subject: [PATCH 4.18 303/350] drm/mediatek: fix OF sibling-node lookup
Date:   Sun, 11 Nov 2018 14:22:47 -0800
Message-Id: <20181111221720.754785871@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit ceff2f4dcd44abf35864d9a99f85ac619e89a01d upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/mediatek/mtk_hdmi.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -1446,8 +1446,7 @@ static int mtk_hdmi_dt_parse_pdata(struc
 	}
 
 	/* The CEC module handles HDMI hotplug detection */
-	cec_np = of_find_compatible_node(np->parent, NULL,
-					 "mediatek,mt8173-cec");
+	cec_np = of_get_compatible_child(np->parent, "mediatek,mt8173-cec");
 	if (!cec_np) {
 		dev_err(dev, "Failed to find CEC node\n");
 		return -EINVAL;
@@ -1457,8 +1456,10 @@ static int mtk_hdmi_dt_parse_pdata(struc
 	if (!cec_pdev) {
 		dev_err(hdmi->dev, "Waiting for CEC device %pOF\n",
 			cec_np);
+		of_node_put(cec_np);
 		return -EPROBE_DEFER;
 	}
+	of_node_put(cec_np);
 	hdmi->cec_dev = &cec_pdev->dev;
 
 	/*


