Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E01DC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C97D20882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548763744;
	bh=CgaBjIJ8PyJdVLWHd0+V0vZLrdJo4ZCECQETdOi/iS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ba/FhexXnnvtiwMkQEmc1f+Zkm4oNvYnuEz0q0zjB2OHuIpOjHt5IqbGvy+0Lh6ZU
	 q/O0FqsVdgC9btVuGpunY6CDOi1w/1UTX4sIg2xttq+1MnBNWCBw7+G51gYJFMTc+u
	 h8tLYs6abGmRgvZGCxiIaYfgHte4f1ULf8C/YEYY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729323AbfA2LjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:39:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:55660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729307AbfA2Li7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:38:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95D1920857;
        Tue, 29 Jan 2019 11:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548761939;
        bh=CgaBjIJ8PyJdVLWHd0+V0vZLrdJo4ZCECQETdOi/iS0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j+3o/gvi0Ug4DkWbV/ey4yYYu60yZaJAyWNGkKrYZlhmubyjuWeQC7J7/U8wmHcHB
         wvNPDe2hFPl55om+G/HTp8G2ryoEpgaaayw+vuF6Wmihn9oVVc089ouNZTSUNeNh/P
         Ub6ADRFJJSlA///CCZB38TvB9iW6OhuTcRWhht7s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Elie Roudninski <xademax@gmail.com>,
        Remi Pommarel <repk@triplefau.lt>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.20 053/117] mmc: meson-gx: Free irq in release() callback
Date:   Tue, 29 Jan 2019 12:35:04 +0100
Message-Id: <20190129113210.278399983@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113207.477505932@linuxfoundation.org>
References: <20190129113207.477505932@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Remi Pommarel <repk@triplefau.lt>

commit bb364890323cca6e43f13e86d190ebf34a7d8cea upstream.

Because the irq was requested through device managed resources API
(devm_request_threaded_irq()) it was freed after meson_mmc_remove()
completion, thus after mmc_free_host() has reclaimed meson_host memory.
As this irq is IRQF_SHARED, while using CONFIG_DEBUG_SHIRQ, its handler
get called by free_irq(). So meson_mmc_irq() was called after the
meson_host memory reclamation and was using invalid memory.

We ended up with the following scenario:
device_release_driver()
	meson_mmc_remove()
		mmc_free_host() /* Freeing host memory */
	...
	devres_release_all()
		devm_irq_release()
			__free_irq()
				meson_mmc_irq() /* Uses freed memory */

To avoid this, the irq is released in meson_mmc_remove() and in
mseon_mmc_probe() error path before mmc_free_host() gets called.

Reported-by: Elie Roudninski <xademax@gmail.com>
Signed-off-by: Remi Pommarel <repk@triplefau.lt>
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/meson-gx-mmc.c |   18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -174,6 +174,8 @@ struct meson_host {
 	struct sd_emmc_desc *descs;
 	dma_addr_t descs_dma_addr;
 
+	int irq;
+
 	bool vqmmc_enabled;
 };
 
@@ -1181,7 +1183,7 @@ static int meson_mmc_probe(struct platfo
 	struct resource *res;
 	struct meson_host *host;
 	struct mmc_host *mmc;
-	int ret, irq;
+	int ret;
 
 	mmc = mmc_alloc_host(sizeof(struct meson_host), &pdev->dev);
 	if (!mmc)
@@ -1228,8 +1230,8 @@ static int meson_mmc_probe(struct platfo
 		goto free_host;
 	}
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
+	host->irq = platform_get_irq(pdev, 0);
+	if (host->irq <= 0) {
 		dev_err(&pdev->dev, "failed to get interrupt resource.\n");
 		ret = -EINVAL;
 		goto free_host;
@@ -1283,9 +1285,8 @@ static int meson_mmc_probe(struct platfo
 	writel(IRQ_CRC_ERR | IRQ_TIMEOUTS | IRQ_END_OF_CHAIN,
 	       host->regs + SD_EMMC_IRQ_EN);
 
-	ret = devm_request_threaded_irq(&pdev->dev, irq, meson_mmc_irq,
-					meson_mmc_irq_thread, IRQF_SHARED,
-					NULL, host);
+	ret = request_threaded_irq(host->irq, meson_mmc_irq,
+			meson_mmc_irq_thread, IRQF_SHARED, NULL, host);
 	if (ret)
 		goto err_init_clk;
 
@@ -1303,7 +1304,7 @@ static int meson_mmc_probe(struct platfo
 	if (host->bounce_buf == NULL) {
 		dev_err(host->dev, "Unable to map allocate DMA bounce buffer.\n");
 		ret = -ENOMEM;
-		goto err_init_clk;
+		goto err_free_irq;
 	}
 
 	host->descs = dma_alloc_coherent(host->dev, SD_EMMC_DESC_BUF_LEN,
@@ -1322,6 +1323,8 @@ static int meson_mmc_probe(struct platfo
 err_bounce_buf:
 	dma_free_coherent(host->dev, host->bounce_buf_size,
 			  host->bounce_buf, host->bounce_dma_addr);
+err_free_irq:
+	free_irq(host->irq, host);
 err_init_clk:
 	clk_disable_unprepare(host->mmc_clk);
 err_core_clk:
@@ -1339,6 +1342,7 @@ static int meson_mmc_remove(struct platf
 
 	/* disable interrupts */
 	writel(0, host->regs + SD_EMMC_IRQ_EN);
+	free_irq(host->irq, host);
 
 	dma_free_coherent(host->dev, SD_EMMC_DESC_BUF_LEN,
 			  host->descs, host->descs_dma_addr);


