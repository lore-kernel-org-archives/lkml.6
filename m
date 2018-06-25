Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BC1C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 07:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC84225578
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 07:59:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC84225578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752335AbeFYH7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 03:59:14 -0400
Received: from mout.perfora.net ([74.208.4.197]:51381 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750994AbeFYH7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 03:59:12 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LrtKS-1gJ7PS15Bu-013bNu; Mon, 25 Jun 2018 09:58:56 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     Peter Chen <Peter.Chen@nxp.com>,
        Marcel Ziswiler <marcel@ziswiler.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] usb: chipidea: tegra: Use aligned DMA on Tegra114/124
Date:   Mon, 25 Jun 2018 09:58:43 +0200
Message-Id: <20180625075843.31878-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
X-Provags-ID: V03:K1:Qt4nMLDtXx0afGkPpsgzHre3KQOrnOGqIoHyU+7HEsBP2JiiOun
 3qTZYq1Opl9MyCUnTJAFFo4B7/BaZ8gtuCKBxM7S/YlTHygB2ZFwUrk45s+XIqU9nfuylME
 LC89fv1vxImWHx4MxvbMryBUm2+20RSaTiucv08t2QxaxFm/rg+DVmak/kXen0werTI2mxm
 Obs2Tflcb3vSQCsvUuuDg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DUVUh84gFqI=:qmPL3GzTGEXU97pk0jquPt
 8unzZ+yGp3tnELMtYuINzqNHyw8dkkUIYK4388fwKwH98cRJzsgfisCbXIffAgWHU/caoKOnp
 /hH5a61xrAE+wyA8U9koqUB8FpxlzrWY92FK4y/nChh5EeS1VWShmKcPZuJt/1uVSrxqOEuE8
 41jc5BwrH5YJ68Yy10JWspeiCiZpRYZ2zio26wxey1I/x5VGaGcXKv8IgDNxIH5iYOKufCI6Y
 weWBWCeQ+w1FuL4fBD6p2sIcNlh6y23RE6ub1+8Edy4uMTvb0IG1lk7gFjGb8rkoLjKYTYOPA
 /3M7WWv9c4f6OimktM6ELXF3Vj6oTOLhbIQz1g0Khl7IlHeSvdikqOGON73lRnYyB7msv8YoW
 J5K2u/Q9h8d5lj3t97t8wq0rdEeO+4VxB7l8RDjab15cyMQssFaPrivD+WAXW9TddtxPFpO4b
 li3UY9/6rvhnbeoi4KNKjgG+Flvt8mTxyoFiL50aIQaMwETVv0AkQcehl0DJ67rLaHkaPV1tF
 tKbzbYd1TTZpOy1RNKZvY8JiKlIhlkXCuOZa6wxcKetdHxCywf8u3Wk1KyXUdpLV5lN03qFxO
 ZfXRHCvrjvmVhjb2cDu//bMEIgo3m0MmGJzFtIlmnQep0Vc9gOCdnxv+BNqgqMXgdIvkOWtwl
 B9xFNR+srM+2dnOPiXlIsiRrb06+q+4QqgaexizqEQAjQFySeY6emgEmRhzdUvkUiqZk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB Ethernet gadget now works on Tegra114 and Tegra124.

Similar to commit 061e20e9899e ("usb: chipidea: tegra: Use aligned DMA
on Tegra30").

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 drivers/usb/chipidea/ci_hdrc_tegra.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_tegra.c b/drivers/usb/chipidea/ci_hdrc_tegra.c
index 7f4d2b6af37a..772851bee99b 100644
--- a/drivers/usb/chipidea/ci_hdrc_tegra.c
+++ b/drivers/usb/chipidea/ci_hdrc_tegra.c
@@ -33,11 +33,11 @@ static const struct tegra_udc_soc_info tegra30_udc_soc_info = {
 };
 
 static const struct tegra_udc_soc_info tegra114_udc_soc_info = {
-	.flags = 0,
+	.flags = CI_HDRC_REQUIRES_ALIGNED_DMA,
 };
 
 static const struct tegra_udc_soc_info tegra124_udc_soc_info = {
-	.flags = 0,
+	.flags = CI_HDRC_REQUIRES_ALIGNED_DMA,
 };
 
 static const struct of_device_id tegra_udc_of_match[] = {
-- 
2.14.4

