Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8367C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC2D120844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:29:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC2D120844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407612AbeHATQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:16:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52412 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407606AbeHATQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:16:17 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D8491D4A;
        Wed,  1 Aug 2018 17:29:33 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sean Lanigan <sean@lano.id.au>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 098/144] brcmfmac: Add support for bcm43364 wireless chipset
Date:   Wed,  1 Aug 2018 18:52:05 +0200
Message-Id: <20180801164956.529846552@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801164949.023217860@linuxfoundation.org>
References: <20180801164949.023217860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Lanigan <sean@lano.id.au>

[ Upstream commit 9c4a121e82634aa000a702c98cd6f05b27d6e186 ]

Add support for the BCM43364 chipset via an SDIO interface, as used in
e.g. the Murata 1FX module.

The BCM43364 uses the same firmware as the BCM43430 (which is already
included), the only difference is the omission of Bluetooth.

However, the SDIO_ID for the BCM43364 is 02D0:A9A4, giving it a MODALIAS
of sdio:c00v02D0dA9A4, which doesn't get recognised and hence doesn't
load the brcmfmac module. Adding the 'A9A4' ID in the appropriate place
triggers the brcmfmac driver to load, and then correctly use the
firmware file 'brcmfmac43430-sdio.bin'.

Signed-off-by: Sean Lanigan <sean@lano.id.au>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c |    1 +
 include/linux/mmc/sdio_ids.h                              |    1 +
 2 files changed, 2 insertions(+)

--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -1099,6 +1099,7 @@ static const struct sdio_device_id brcmf
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43340),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43341),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43362),
+ 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43364),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4335_4339),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4339),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43430),
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -34,6 +34,7 @@
 #define SDIO_DEVICE_ID_BROADCOM_4335_4339	0x4335
 #define SDIO_DEVICE_ID_BROADCOM_4339		0x4339
 #define SDIO_DEVICE_ID_BROADCOM_43362		0xa962
+#define SDIO_DEVICE_ID_BROADCOM_43364		0xa9a4
 #define SDIO_DEVICE_ID_BROADCOM_43430		0xa9a6
 #define SDIO_DEVICE_ID_BROADCOM_4345		0x4345
 #define SDIO_DEVICE_ID_BROADCOM_4354		0x4354


