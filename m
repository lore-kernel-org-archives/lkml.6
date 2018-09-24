Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7A5C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 01:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CE3F20989
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 01:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="fSftghN+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CE3F20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbeIXHbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 03:31:44 -0400
Received: from vern.gendns.com ([206.190.152.46]:40156 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726837AbeIXHbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 03:31:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WnumxkXPUODljWxWnms1EA2VOICpKj7KP0Y0t3598Zc=; b=fSftghN+bR8QI9Yw/igiZlzuFu
        2DrEeN3Fxlq/AQ+Q3iUc+5Md6PcsJm+ZG/NwDWAUeiCwqBOi2HPNlmuvBN9uQ4hygC/aU1eFfGE8J
        fOJa/I+npUkhbCyOxDwn8oA1cUJswhZpepMube+F/rOFStGVPqPcuIZs+uFDtfityMf7IrCn0pTLB
        Ge0oH5wpve6HrBDQ/QAmJi5spr+9kU1smZr+w2niyj+5n1YMC7+pZPdQX48Lmg2Ffv6i4zKfB5+wR
        eW47IVZBTR7dLjxg6BTqO7RhvUv8I1gYK6ZI0kkqsZQK5akJEFhYJ4Y8fXkhLz7KsmQaJWRRx9Y1W
        U0t8dTFA==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:59868 helo=freyr.lechnology.com)
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1g4FjB-001qJJ-7h; Sun, 23 Sep 2018 21:31:57 -0400
From:   David Lechner <david@lechnology.com>
To:     Sekhar Nori <nsekhar@ti.com>
Cc:     David Lechner <david@lechnology.com>,
        Kevin Hilman <khilman@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: da850-lego-ev3: slow down A/DC as much as possible
Date:   Sun, 23 Sep 2018 20:31:46 -0500
Message-Id: <20180924013146.18121-1-david@lechnology.com>
X-Mailer: git-send-email 2.17.1
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the electrical design of the A/DC circuits on LEGO MINDSTORMS EV3,
if we are reading analog values as fast as possible (i.e. using DMA to
service the SPI) the A/DC chip will read incorrect values - as much as
0.1V off when the SPI is running at 10MHz. (This has to do with the
capacitor charge time when channels are muxed in the A/DC.)

This patch slows down the SPI as much as possible (if CPU is at 456MHz,
SPI runs at 1/2 of that, so 228MHz and has a max prescalar of 256, so
we could get ~891kHz, but we're just rounding it to 1MHz). We also use
the max allowable value for WDELAY to slow things down even more.

These changes reduce the error of the analog values to about 5mV, which
is tolerable.

Commits a3762b13a596 ("spi: spi-davinci: Add support for SPI_CS_WORD")
and e2540da86ef8 ("iio: adc: ti-ads7950: use SPI_CS_WORD to reduce
CPU usage") introduce changes that allow DMA transfers to be used, so
this slow down is needed now.

Signed-off-by: David Lechner <david@lechnology.com>
---

FYI, this patch doesn't strictly depend on the other two mentioned. In fact, it
would better if it got merged before them, but the consequences are minimal, so
it doesn't seem worth it to me to try coordinating merges here.

Both of these patches mentioned have been picked up in the respective
subsystems.

 arch/arm/boot/dts/da850-lego-ev3.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/da850-lego-ev3.dts b/arch/arm/boot/dts/da850-lego-ev3.dts
index c4729d0e6c19..66fcadf0ba91 100644
--- a/arch/arm/boot/dts/da850-lego-ev3.dts
+++ b/arch/arm/boot/dts/da850-lego-ev3.dts
@@ -352,7 +352,8 @@
 		compatible = "ti,ads7957";
 		reg = <3>;
 		#io-channel-cells = <1>;
-		spi-max-frequency = <10000000>;
+		spi-max-frequency = <1000000>;
+		ti,spi-wdelay = <63>;
 		vref-supply = <&adc_ref>;
 	};
 };
-- 
2.17.1

