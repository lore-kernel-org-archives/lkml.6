Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968954AbeE1Oaz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 10:30:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:53496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161698AbeE1KdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:33:21 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Vinod Koul <vinod.koul@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 160/329] dmaengine: rcar-dmac: fix max_chunk_size for R-Car Gen3
Date: Mon, 28 May 2018 12:01:29 +0200
Message-Id: <20180528100255.801240076@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

[ Upstream commit d716d9b702bb759dd6fb50804f10a174bd156d71 ]

According to R-Car Gen3 Rev.0.80 manual, the DMATCR can be set to
16,777,215 as maximum. So, this patch fixes the max_chunk_size for
safety on all of SoCs. Otherwise, a system may hang if the DMATCR
is set to 0 on R-Car Gen3.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/sh/rcar-dmac.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -870,7 +870,7 @@ rcar_dmac_chan_prep_sg(struct rcar_dmac_
 
 	rcar_dmac_chan_configure_desc(chan, desc);
 
-	max_chunk_size = (RCAR_DMATCR_MASK + 1) << desc->xfer_shift;
+	max_chunk_size = RCAR_DMATCR_MASK << desc->xfer_shift;
 
 	/*
 	 * Allocate and fill the transfer chunk descriptors. We own the only
