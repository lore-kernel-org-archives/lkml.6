Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AECBC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE56320881
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="rKWacuvz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE56320881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbeIJWt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 18:49:26 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53886 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbeIJWt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 18:49:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=gOYpWX1evdALiXHwbvBENo5VBqlRTGajyNuuOBajfV8=; b=rKWacuvzxGJn
        tF/otTjg2UMXLrCM6La1VWuvP2mG7ydPfnr4OpWX8SrJcd+HEKDMrXG0J7ZYibGWl6AXYdRBaWF34
        vVJWGVbP9tH2aHvk5U+goERTvubdzWt2M9MKSmzXERuEf83LxtoEPm9XtAudRAmHliA6XKVWBPQmN
        aiXmM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fzQNy-00028d-RS; Mon, 10 Sep 2018 17:54:06 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 9142B11227B6; Mon, 10 Sep 2018 18:54:06 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Chuanhua Han <chuanhua.han@nxp.com>
Cc:     <stable@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
        broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, boris.brezillon@bootlin.com,
        stable@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Applied "spi: spi-mem: Adjust op len based on message/transfer size limitations" to the spi tree
In-Reply-To:  <1535618604-21706-1-git-send-email-chuanhua.han@nxp.com>
Message-Id: <20180910175406.9142B11227B6@debutante.sirena.org.uk>
Date:   Mon, 10 Sep 2018 18:54:06 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: spi-mem: Adjust op len based on message/transfer size limitations

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From e757996cafbeb6b71234a17130674bcd8f44c59e Mon Sep 17 00:00:00 2001
From: Chuanhua Han <chuanhua.han@nxp.com>
Date: Thu, 30 Aug 2018 16:43:24 +0800
Subject: [PATCH] spi: spi-mem: Adjust op len based on message/transfer size
 limitations

We need that to adjust the len of the 2nd transfer (called data in
spi-mem) if it's too long to fit in a SPI message or SPI transfer.

Fixes: c36ff266dc82 ("spi: Extend the core to ease integration of SPI memory controllers")
Cc: <stable@vger.kernel.org>
Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>
Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-mem.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index e43842c7a31a..eb72dba71d83 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -346,10 +346,25 @@ EXPORT_SYMBOL_GPL(spi_mem_get_name);
 int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 {
 	struct spi_controller *ctlr = mem->spi->controller;
+	size_t len;
+
+	len = sizeof(op->cmd.opcode) + op->addr.nbytes + op->dummy.nbytes;
 
 	if (ctlr->mem_ops && ctlr->mem_ops->adjust_op_size)
 		return ctlr->mem_ops->adjust_op_size(mem, op);
 
+	if (!ctlr->mem_ops || !ctlr->mem_ops->exec_op) {
+		if (len > spi_max_transfer_size(mem->spi))
+			return -EINVAL;
+
+		op->data.nbytes = min3((size_t)op->data.nbytes,
+				       spi_max_transfer_size(mem->spi),
+				       spi_max_message_size(mem->spi) -
+				       len);
+		if (!op->data.nbytes)
+			return -EINVAL;
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(spi_mem_adjust_op_size);
-- 
2.19.0.rc1

