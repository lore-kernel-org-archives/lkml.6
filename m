Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4F0C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 603FD208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:09:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 603FD208C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388855AbeHWMij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:38:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56514 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728274AbeHWMij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:38:39 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EF5B6CA6;
        Thu, 23 Aug 2018 09:09:53 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 290/324] net: qca_spi: Fix log level if probe fails
Date:   Thu, 23 Aug 2018 09:55:56 +0200
Message-Id: <20180823075010.545386321@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

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
@@ -881,22 +881,22 @@ qca_spi_probe(struct spi_device *spi)
 
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
 
@@ -958,8 +958,8 @@ qca_spi_probe(struct spi_device *spi)
 	}
 
 	if (register_netdev(qcaspi_devs)) {
-		dev_info(&spi->dev, "Unable to register net device %s\n",
-			 qcaspi_devs->name);
+		dev_err(&spi->dev, "Unable to register net device %s\n",
+			qcaspi_devs->name);
 		free_netdev(qcaspi_devs);
 		return -EFAULT;
 	}


