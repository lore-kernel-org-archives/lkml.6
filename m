Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CD5ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F61720864
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:37:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F61720864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732017AbeGPIDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:03:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46782 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728460AbeGPIDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:03:52 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 522FCC03;
        Mon, 16 Jul 2018 07:37:51 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.17 11/67] mmc: renesas_sdhi_internal_dmac: Cannot clear the RX_IN_USE in abort
Date:   Mon, 16 Jul 2018 09:34:40 +0200
Message-Id: <20180716073444.849899456@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716073443.294323458@linuxfoundation.org>
References: <20180716073443.294323458@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

commit 25a98edd5795719c5187e16ea271e8de86e02809 upstream.

This patch is fixes an issue that the SDHI_INTERNAL_DMAC_RX_IN_USE
flag cannot be cleared because tmio_mmc_core sets the host->data
to NULL before the tmio_mmc_core calls tmio_mmc_abort_dma().

So, this patch clears the SDHI_INTERNAL_DMAC_RX_IN_USE in
the renesas_sdhi_internal_dmac_abort_dma() anyway. This doesn't
cause any side effects.

Fixes: 0cbc94daa554 ("mmc: renesas_sdhi_internal_dmac: limit DMA RX for old SoCs")
Cc: <stable@vger.kernel.org> # v4.17+
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -139,8 +139,7 @@ renesas_sdhi_internal_dmac_abort_dma(str
 	renesas_sdhi_internal_dmac_dm_write(host, DM_CM_RST,
 					    RST_RESERVED_BITS | val);
 
-	if (host->data && host->data->flags & MMC_DATA_READ)
-		clear_bit(SDHI_INTERNAL_DMAC_RX_IN_USE, &global_flags);
+	clear_bit(SDHI_INTERNAL_DMAC_RX_IN_USE, &global_flags);
 
 	renesas_sdhi_internal_dmac_enable_dma(host, true);
 }


