Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98344C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6385220675
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083436;
	bh=AL242eJgWlK6cL3uHneDh47Wq+AjvEbOMfpb7J9+0kI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IFuhROxYN94NuZRuqVZKw9MYyaHd26DK5KaM1HQ7p6ASdAig6+Ypjp1ctx1OW5Th7
	 6PgtDmOKB0PPzqlnui3vcH/mw6g1dfWN806TATDDiEjpKev7vVUya7l/tMYtTOzE3F
	 y9n4miEg50F9cUGYw0rCToN+SLaYYw0nCjZVg5gY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406019AbfBMSnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:43:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:42466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406007AbfBMSnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:43:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7193222D6;
        Wed, 13 Feb 2019 18:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083432;
        bh=AL242eJgWlK6cL3uHneDh47Wq+AjvEbOMfpb7J9+0kI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VohoZDAq9ysVV1GqEUMbcVkDmLDdmoMVPOESLImJ5JKyYsh8cSyj6YC5YiJApLJ6A
         LMK6IBRb0X3wegVDSKjPtCwhz802FRN7pgdgc6XOGdEEE3KRNp5d6CbFnCYEE/FGQA
         5WA+5lCySuFnI9ExQrlxkU/BUGJQP0XYnrCllH8A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Hellstrom <thellstrom@vmware.com>,
        Deepak Rawat <drawat@vmware.com>
Subject: [PATCH 4.19 34/44] drm/vmwgfx: Fix setting of dma masks
Date:   Wed, 13 Feb 2019 19:38:35 +0100
Message-Id: <20190213183654.666124599@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183651.648060257@linuxfoundation.org>
References: <20190213183651.648060257@linuxfoundation.org>
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
@@ -627,13 +627,16 @@ out_fixup:
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


