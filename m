Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2E7C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32B9C205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2rkKx1AQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32B9C205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733131AbeK3BbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:31:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:58922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731628AbeK3BbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:31:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7B9821104;
        Thu, 29 Nov 2018 14:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501552;
        bh=2NHCgXn3uuob5Nk4LxAMBG+IPBVMfagxotmbEHwy6zs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2rkKx1AQfnkaWYCK7gcATCFZwCcwZKFWsEdpyVJw87m9TP1e2mKUv/yeOa74EKpHB
         sQryaG1gM2OWEXl1QBBRERKQkkSpzeyxRxelkIPp+mT2mTemoBeiYbdhunFGh5+c+7
         XEVrupjsmORJf47niszHVGQFL/SpV58o6jCEZgpc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mathias Duckeck <m.duckeck@kunbus.de>,
        Akshay Bhat <akshay.bhat@timesys.com>,
        Casey Fitzpatrick <casey.fitzpatrick@timesys.com>,
        Lukas Wunner <lukas@wunner.de>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4.14 043/100] can: hi311x: Use level-triggered interrupt
Date:   Thu, 29 Nov 2018 15:12:13 +0100
Message-Id: <20181129140102.572986349@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140058.768942700@linuxfoundation.org>
References: <20181129140058.768942700@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
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

commit f164d0204b1156a7e0d8d1622c1a8d25752befec upstream.

If the hi3110 shares the SPI bus with another traffic-intensive device
and packets are received in high volume (by a separate machine sending
with "cangen -g 0 -i -x"), reception stops after a few minutes and the
counter in /proc/interrupts stops incrementing.  Bus state is "active".
Bringing the interface down and back up reconvenes the reception.  The
issue is not observed when the hi3110 is the sole device on the SPI bus.

Using a level-triggered interrupt makes the issue go away and lets the
hi3110 successfully receive 2 GByte over the course of 5 days while a
ks8851 Ethernet chip on the same SPI bus handles 6 GByte of traffic.

Unfortunately the hi3110 datasheet is mum on the trigger type.  The pin
description on page 3 only specifies the polarity (active high):
http://www.holtic.com/documents/371-hi-3110_v-rev-kpdf.do

Cc: Mathias Duckeck <m.duckeck@kunbus.de>
Cc: Akshay Bhat <akshay.bhat@timesys.com>
Cc: Casey Fitzpatrick <casey.fitzpatrick@timesys.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/devicetree/bindings/net/can/holt_hi311x.txt |    2 +-
 drivers/net/can/spi/hi311x.c                              |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/Documentation/devicetree/bindings/net/can/holt_hi311x.txt
+++ b/Documentation/devicetree/bindings/net/can/holt_hi311x.txt
@@ -18,7 +18,7 @@ Example:
 		reg = <1>;
 		clocks = <&clk32m>;
 		interrupt-parent = <&gpio4>;
-		interrupts = <13 IRQ_TYPE_EDGE_RISING>;
+		interrupts = <13 IRQ_TYPE_LEVEL_HIGH>;
 		vdd-supply = <&reg5v0>;
 		xceiver-supply = <&reg5v0>;
 	};
--- a/drivers/net/can/spi/hi311x.c
+++ b/drivers/net/can/spi/hi311x.c
@@ -760,7 +760,7 @@ static int hi3110_open(struct net_device
 {
 	struct hi3110_priv *priv = netdev_priv(net);
 	struct spi_device *spi = priv->spi;
-	unsigned long flags = IRQF_ONESHOT | IRQF_TRIGGER_RISING;
+	unsigned long flags = IRQF_ONESHOT | IRQF_TRIGGER_HIGH;
 	int ret;
 
 	ret = open_candev(net);


