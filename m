Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA75C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86D3720820
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277332;
	bh=04mnjdQ4d9QDEDxWikpKLuvghgWMUe+EkESFt3W4anU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=luD4T/RXoBhJSx9I53ZuPwOlyGf2DDcZhrCvbMXLn5Fb0dwBR7hP3XsXvGnvswD9A
	 s5lSZW6r9/zN88lHD4mMAG18RE2D1ZF0jkORsH3nJroGFWAqjzVwGEBCBE+reLw9AI
	 fFWV9n+NsDcNT6jlmewGDkaKO8Nvz7YiBK8nVzvs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731925AbfBDKsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:48:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:46784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731916AbfBDKst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:48:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D622E2087C;
        Mon,  4 Feb 2019 10:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277329;
        bh=04mnjdQ4d9QDEDxWikpKLuvghgWMUe+EkESFt3W4anU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aGvKMffXmwlei6I6/5i4JKqZjxzMKRNCXlb3E7+KFqbI4Dl+5BpcvWpAJIO+MLl7D
         eXcnC1ECzLkgRuMnDdaYYeLfh4bogCYb0Y+QKS3wbvHNu/xlEXbNWmr1nvoE3eBv/4
         GqvL8Gs3PzV0EbJSv5mLcFdkC2EOdTF12ZpnBx6k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Frank Pavlic <f.pavlic@kunbus.de>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.19 51/74] mmc: bcm2835: Fix DMA channel leak on probe error
Date:   Mon,  4 Feb 2019 11:37:04 +0100
Message-Id: <20190204103626.396625879@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103619.714714157@linuxfoundation.org>
References: <20190204103619.714714157@linuxfoundation.org>
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


