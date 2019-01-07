Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D3EC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E94262173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546864835;
	bh=zQAJWfXaPGsVpIl+fV+ly1hL9xjXCt2znZcTU1ipwNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PUCCBlXuEH1OL0LYRnNxFs68bKfzehsGDmDP+Bk86rHzPwN6/kk3zpqC4Rq8CCluu
	 RsPZdPyIuxT5FyMZXX5S7n3ewenGfiJKLtXjrQU98PoVzN6vinSSOjFzfPVFKxwOFn
	 cJMUyRy6fzhclv8joOrYFHHly9tt1H++ZsP9Lrdg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbfAGMke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:40:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:55504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727477AbfAGMkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:40:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53EA72089F;
        Mon,  7 Jan 2019 12:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546864831;
        bh=zQAJWfXaPGsVpIl+fV+ly1hL9xjXCt2znZcTU1ipwNA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QzP6kSVIxvO+6XfQRHYS/CEVkZvkqxtNuczDwDKJxC8thQ0hmYEgmnIBRAGFKO3NP
         NFxYtUxSrTexZeiL/3fOJKsb9/cdJi7guHly+ljf2YQqpYJT/xv5tRoASE9KRGA/gp
         pH+0yamw23rfsRZtFRU1N4O/HO6tSKd25d+sciJg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Mathias Duckeck <m.duckeck@kunbus.de>,
        Frank Pavlic <f.pavlic@kunbus.de>,
        Martin Sperl <kernel@martin.sperl.org>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.20 081/145] spi: bcm2835: Fix book-keeping of DMA termination
Date:   Mon,  7 Jan 2019 13:31:58 +0100
Message-Id: <20190107104447.824068213@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
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

From: Lukas Wunner <lukas@wunner.de>

commit dbc944115eed48af110646992893dc43321368d8 upstream.

If submission of a DMA TX transfer succeeds but submission of the
corresponding RX transfer does not, the BCM2835 SPI driver terminates
the TX transfer but neglects to reset the dma_pending flag to false.

Thus, if the next transfer uses interrupt mode (because it is shorter
than BCM2835_SPI_DMA_MIN_LENGTH) and runs into a timeout,
dmaengine_terminate_all() will be called both for TX (once more) and
for RX (which was never started in the first place).  Fix it.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Fixes: 3ecd37edaa2a ("spi: bcm2835: enable dma modes for transfers meeting certain conditions")
Cc: stable@vger.kernel.org # v4.2+
Cc: Mathias Duckeck <m.duckeck@kunbus.de>
Cc: Frank Pavlic <f.pavlic@kunbus.de>
Cc: Martin Sperl <kernel@martin.sperl.org>
Cc: Noralf Trønnes <noralf@tronnes.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/spi/spi-bcm2835.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -341,6 +341,7 @@ static int bcm2835_spi_transfer_one_dma(
 	if (ret) {
 		/* need to reset on errors */
 		dmaengine_terminate_all(master->dma_tx);
+		bs->dma_pending = false;
 		bcm2835_spi_reset_hw(master);
 		return ret;
 	}


