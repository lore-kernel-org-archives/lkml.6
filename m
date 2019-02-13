Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FA7C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91AC2222D6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083271;
	bh=rb6ya/vNHe2nT5EUiuf8tkoROmejJKDovK5loXXN+Tw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hSftigwXsJuA5HKFfQbIo+pbMfvSzBUIiGxF/di4VpGgHpTRYCWM9TJ1ljjtTyxd7
	 P+Nxryz+ndagDEvXEDR6EJ59cDHh3L5LUYwJ+CnjD1y76tGHVLZmd+x2peOpfRSO3c
	 7d+V0CFk7gc9gQXUzN39SnJTVRlAEuca8VexRKrM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405505AbfBMSlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:41:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:39398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393777AbfBMSlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:41:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7176A222D7;
        Wed, 13 Feb 2019 18:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083266;
        bh=rb6ya/vNHe2nT5EUiuf8tkoROmejJKDovK5loXXN+Tw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OV5nD/e5AdQKoCFYuMZuNXGHEsDUoP/VpdtpZS8il5I+AOhT53hS1J+PqkWLTvv9v
         0VmLuuJOmWZIdNC+aeKkQ0voIOVyEhGCdVfyUPHAufTxQopnGbUIiAY5vm+wc19Qlr
         xZX7an5aQWMqrMI+UMGn1xp+3ArNEO9F5/PryIHo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Hellstrom <thellstrom@vmware.com>,
        Deepak Rawat <drawat@vmware.com>
Subject: [PATCH 4.14 17/35] drm/vmwgfx: Fix setting of dma masks
Date:   Wed, 13 Feb 2019 19:38:12 +0100
Message-Id: <20190213183706.950137393@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183706.176685027@linuxfoundation.org>
References: <20190213183706.176685027@linuxfoundation.org>
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

From: Thomas Hellstrom <thellstrom@vmware.com>

commit 4cbfa1e6c09e98450aab3240e5119b0ab2c9795b upstream.

Previously we set only the dma mask and not the coherent mask. Fix that.
Also, for clarity, make sure both are initially set to 64 bits.

Cc: <stable@vger.kernel.org>
Fixes: 0d00c488f3de: ("drm/vmwgfx: Fix the driver for large dma addresses")
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Reviewed-by: Deepak Rawat <drawat@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -604,13 +604,16 @@ out_fixup:
 static int vmw_dma_masks(struct vmw_private *dev_priv)
 {
 	struct drm_device *dev = dev_priv->dev;
+	int ret = 0;
 
-	if (intel_iommu_enabled &&
+	ret = dma_set_mask_and_coherent(dev->dev, DMA_BIT_MASK(64));
+	if (dev_priv->map_mode != vmw_dma_phys &&
 	    (sizeof(unsigned long) == 4 || vmw_restrict_dma_mask)) {
 		DRM_INFO("Restricting DMA addresses to 44 bits.\n");
-		return dma_set_mask(dev->dev, DMA_BIT_MASK(44));
+		return dma_set_mask_and_coherent(dev->dev, DMA_BIT_MASK(44));
 	}
-	return 0;
+
+	return ret;
 }
 #else
 static int vmw_dma_masks(struct vmw_private *dev_priv)


