Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7911DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 404AF20645
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPNcG0xI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 404AF20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731682AbeKZWAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 17:00:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:47528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729543AbeKZWAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 17:00:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA80E20645;
        Mon, 26 Nov 2018 11:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230408;
        bh=NN8dJiP1BPqxpxojYRAmWSh/c2WI7L4E9bFOz1LK9xE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SPNcG0xI8M7Ju0/PTRbFDuokarX1ECboyzsPxzsx9aRiohvBI+Z/O6JTGmQHd9XeZ
         tmyQSh2DLvqFjzynwXkSqqcJPLOoUX9PsxmgmrxgSZWEPsXDbOdtIdTl3HlJFGToDB
         sKQY8MH2++70ABLRPOkr0wp4mUWNuu5ZrMJ0i50k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sid Hayn <sidhayn@gmail.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Felix Fietkau <nbd@nbd.name>,
        Stanislaw Gruszka <sgruszka@redhat.com>
Subject: [PATCH 4.19 118/118] mt76x0: run vco calibration for each channel configuration
Date:   Mon, 26 Nov 2018 11:51:52 +0100
Message-Id: <20181126105106.534574167@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105059.832485122@linuxfoundation.org>
References: <20181126105059.832485122@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>

commit 473f0a763d2c7cd68a6dedf51e7d81e8f58f78ac upstream.

According to vendor sdk, vco calibration has to be executed
for each channel configuration whereas mcu calibration has to be
performed during channel scanning. This patch fixes the mt76x0
monitor mode issue since in that configuration vco calibration
was never executed

Fixes: 10de7a8b4ab9 ("mt76x0: phy files")
Tested-by: Sid Hayn <sidhayn@gmail.com>
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Cc: Stanislaw Gruszka <sgruszka@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/mediatek/mt76/mt76x0/phy.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
@@ -757,10 +757,10 @@ __mt76x0_phy_set_channel(struct mt76x0_d
 	/* Vendor driver don't do it */
 	/* mt76x0_phy_set_tx_power(dev, channel, rf_bw_band); */
 
+	mt76x0_vco_cal(dev, channel);
 	if (scan)
-		mt76x0_vco_cal(dev, channel);
+		mt76x0_mcu_calibrate(dev, MCU_CAL_RXDCOC, 1);
 
-	mt76x0_mcu_calibrate(dev, MCU_CAL_RXDCOC, 1);
 	mt76x0_phy_set_chan_pwr(dev, channel);
 
 	dev->mt76.chandef = *chandef;


