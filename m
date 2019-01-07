Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5904C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D4FE2089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866862;
	bh=iLxnWlURcDZ/MKgxGi6yDEVSeaLYPvnPGBbK0PgXfXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rCkCbkpqxS3AlWco0cQ2L0rmGEdwrEIY621iBbyea3/jZtmG6BowqS6x+dXyDQjr1
	 RkJeUMpXoL0vpWoH1oDT1sMjR9GNVSJHTyKrVpAyURJB90SeIpJfPmtuK9J/aCa+Oj
	 LdOPOqKvHehya6j008tGDg+Kj/POboubZ1sPFJ2Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730916AbfAGNDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:03:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:50460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730900AbfAGNC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:02:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35AD0206BB;
        Mon,  7 Jan 2019 13:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866177;
        bh=iLxnWlURcDZ/MKgxGi6yDEVSeaLYPvnPGBbK0PgXfXA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zmueCPcmr0Kj0xh2nPZ+v4cMnEzX+wXSeyDcOM7zOYXWurBxK1aruY6NOj81NHdxI
         CFyBDX4oJBa/b9sLcGvI3vL788Y68rdTb5vonJDP5zOngzQbyJV8PcAGtR12jDQ2tr
         gOwDS1cWhIKo8wo4Az9/9PxzhhW7q3hqVMwWEMxM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Mathias Duckeck <m.duckeck@kunbus.de>,
        Frank Pavlic <f.pavlic@kunbus.de>,
        Martin Sperl <kernel@martin.sperl.org>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.14 070/101] spi: bcm2835: Fix book-keeping of DMA termination
Date:   Mon,  7 Jan 2019 13:32:58 +0100
Message-Id: <20190107105336.821784097@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107105330.372621917@linuxfoundation.org>
References: <20190107105330.372621917@linuxfoundation.org>
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


