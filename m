Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC57C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D21092098B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:01:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D21092098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbeHWL3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:29:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44346 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727852AbeHWL3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:29:31 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2DC7DC9D;
        Thu, 23 Aug 2018 08:01:07 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 64/79] net: qca_spi: Fix log level if probe fails
Date:   Thu, 23 Aug 2018 09:53:40 +0200
Message-Id: <20180823074923.333037556@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074918.641878835@linuxfoundation.org>
References: <20180823074918.641878835@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Wahren <stefan.wahren@i2se.com>

[ Upstream commit 50973993260a6934f0a00da53d9b746cfbea89ab ]

In cases the probing fails the log level of the messages should
be an error.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qualcomm/qca_spi.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -868,22 +868,22 @@ qca_spi_probe(struct spi_device *spi)
 
 	if ((qcaspi_clkspeed < QCASPI_CLK_SPEED_MIN) ||
 	    (qcaspi_clkspeed > QCASPI_CLK_SPEED_MAX)) {
-		dev_info(&spi->dev, "Invalid clkspeed: %d\n",
-			 qcaspi_clkspeed);
+		dev_err(&spi->dev, "Invalid clkspeed: %d\n",
+			qcaspi_clkspeed);
 		return -EINVAL;
 	}
 
 	if ((qcaspi_burst_len < QCASPI_BURST_LEN_MIN) ||
 	    (qcaspi_burst_len > QCASPI_BURST_LEN_MAX)) {
-		dev_info(&spi->dev, "Invalid burst len: %d\n",
-			 qcaspi_burst_len);
+		dev_err(&spi->dev, "Invalid burst len: %d\n",
+			qcaspi_burst_len);
 		return -EINVAL;
 	}
 
 	if ((qcaspi_pluggable < QCASPI_PLUGGABLE_MIN) ||
 	    (qcaspi_pluggable > QCASPI_PLUGGABLE_MAX)) {
-		dev_info(&spi->dev, "Invalid pluggable: %d\n",
-			 qcaspi_pluggable);
+		dev_err(&spi->dev, "Invalid pluggable: %d\n",
+			qcaspi_pluggable);
 		return -EINVAL;
 	}
 
@@ -944,8 +944,8 @@ qca_spi_probe(struct spi_device *spi)
 	}
 
 	if (register_netdev(qcaspi_devs)) {
-		dev_info(&spi->dev, "Unable to register net device %s\n",
-			 qcaspi_devs->name);
+		dev_err(&spi->dev, "Unable to register net device %s\n",
+			qcaspi_devs->name);
 		free_netdev(qcaspi_devs);
 		return -EFAULT;
 	}


