Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7864FC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 447FE20823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277727;
	bh=5yw88a54mzZjQJtTvDgGCGYgmSLQR2VE9JWCIyslWe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ESiv683oT3/yAbDkeFj0Iu9PBSSjMDV3WVehVWQi4dqcPYDcJxSXzbrFY7xNwYTyC
	 Ddh15rao3UT4WC9CPvz9V+D7izNq1grWin1/V6qIw0UMfKViuQJcpM3c65/bfiTJ0M
	 itGFJ1u3bxLClEQ2FfapoFBHW0GyPXFNIV3R53rs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732827AbfBDKxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:53:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:51438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732462AbfBDKxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:53:46 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85776217FA;
        Mon,  4 Feb 2019 10:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277626;
        bh=5yw88a54mzZjQJtTvDgGCGYgmSLQR2VE9JWCIyslWe8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fRnP4ZHHmurnYyWDgaUtaQWKRI964H2f7fzvS7uceYI/sUy2067E17Q+33hQh+Z6F
         IvjcJ9R98JsVeiPefUuc9nl3wg0GnMg2Im2vpiA0xlROtNroYmlNnMBLA1zoGFv3M/
         X7WcOocFjU8e0nYKUrpa2c8KCud1855AMGijlrgk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Frank Pavlic <f.pavlic@kunbus.de>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.20 55/80] mmc: bcm2835: Fix DMA channel leak on probe error
Date:   Mon,  4 Feb 2019 11:37:15 +0100
Message-Id: <20190204103627.929620553@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103620.287366543@linuxfoundation.org>
References: <20190204103620.287366543@linuxfoundation.org>
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

commit 8c9620b1cc9b69e82fa8d4081d646d0016b602e7 upstream.

The BCM2835 MMC host driver requests a DMA channel on probe but neglects
to release the channel in the probe error path.  The channel may
therefore be leaked, in particular if devm_clk_get() causes probe
deferral.  Fix it.

Fixes: 660fc733bd74 ("mmc: bcm2835: Add new driver for the sdhost controller.")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v4.12+
Cc: Frank Pavlic <f.pavlic@kunbus.de>
Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/bcm2835.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -1427,6 +1427,8 @@ static int bcm2835_probe(struct platform
 
 err:
 	dev_dbg(dev, "%s -> err %d\n", __func__, ret);
+	if (host->dma_chan_rxtx)
+		dma_release_channel(host->dma_chan_rxtx);
 	mmc_free_host(mmc);
 
 	return ret;


