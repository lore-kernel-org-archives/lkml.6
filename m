Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4ABC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35C6220838
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550500762;
	bh=fChc9no21nk/V6ZEnJcaccUe3MksOLBLKjla+cYVh2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WRU+qBdW5oNBE/tL93jeBnF+6QRyvrbr419FGJhfKd54SR4tjZ1vGw32+pmSO6OLm
	 xgiXy5BMGv3dhCngXi6VKEnbiPLIwMCTucy57sldVzdLYI1SY/gvskewuwkpXFCEIw
	 vCscJRVn4mS/q5XFJM58APNP47Tn8pZJ814KSgWw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387785AbfBROjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:39:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:33140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732934AbfBRNxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:53:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46C9D21904;
        Mon, 18 Feb 2019 13:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498003;
        bh=fChc9no21nk/V6ZEnJcaccUe3MksOLBLKjla+cYVh2k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vQbWubHbfjRpGwku4m9Ok7nhWIH/fTRVvLa8fyjqF/OgZYXqBCHY8Xg9MjGAD4wFk
         BlUr0dk64GY5Y2GzI3KGcctQ+OcklbPQ7YCqtehC3Q7oINL8wVVKhTKi/NoGv+pIjj
         JXG/QJ/fc/aYF1T6yJxmh+q7ESGRPJTh4fLMWP0I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.19 63/85] mmc: sunxi: Filter out unsupported modes declared in the device tree
Date:   Mon, 18 Feb 2019 14:43:29 +0100
Message-Id: <20190218133506.064897748@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133459.758004711@linuxfoundation.org>
References: <20190218133459.758004711@linuxfoundation.org>
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

From: Chen-Yu Tsai <wens@csie.org>

commit d6f11e7d91f2ac85f66194fe3ef8789b49901d64 upstream.

The MMC device tree bindings include properties used to signal various
signalling speed modes. Until now the sunxi driver was accepting them
without any further filtering, while the sunxi device trees were not
actually using them.

Since some of the H5 boards can not run at higher speed modes stably,
we are resorting to declaring the higher speed modes per-board.

Regardless, having boards declare modes and blindly following them,
even without proper support in the driver, is generally a bad thing.

Filter out all unsupported modes from the capabilities mask after
the device tree properties have been parsed.

Cc: <stable@vger.kernel.org>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/sunxi-mmc.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1394,6 +1394,21 @@ static int sunxi_mmc_probe(struct platfo
 	if (ret)
 		goto error_free_dma;
 
+	/*
+	 * If we don't support delay chains in the SoC, we can't use any
+	 * of the higher speed modes. Mask them out in case the device
+	 * tree specifies the properties for them, which gets added to
+	 * the caps by mmc_of_parse() above.
+	 */
+	if (!(host->cfg->clk_delays || host->use_new_timings)) {
+		mmc->caps &= ~(MMC_CAP_3_3V_DDR | MMC_CAP_1_8V_DDR |
+			       MMC_CAP_1_2V_DDR | MMC_CAP_UHS);
+		mmc->caps2 &= ~MMC_CAP2_HS200;
+	}
+
+	/* TODO: This driver doesn't support HS400 mode yet */
+	mmc->caps2 &= ~MMC_CAP2_HS400;
+
 	ret = sunxi_mmc_init_host(host);
 	if (ret)
 		goto error_free_dma;


