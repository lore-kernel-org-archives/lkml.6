Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B11C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC9F0206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bfgxvQG2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC9F0206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbeIKWJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 18:09:06 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:50216 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbeIKWIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 18:08:55 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8BH8bU3035774;
        Tue, 11 Sep 2018 12:08:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1536685717;
        bh=PK/7NWCVTG8nsW2kpAy3E+E5fedwIgzEJ4d1himThi8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=bfgxvQG2Wj2i+j5cvlEhJSTbKyf47MBoQgJnXcgrdNXfOHJZmG1SXY+5Zne0FDMpn
         d4CfD6x9unynLU6q0xLdbASqj01blfD5cwzmwUUB0Ult9CFymdtdG05xWfYKUi5LnL
         C7arf36H4AZjol3NXHZCJxhZu8n7oYiFkHjg19uc=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8BH8bfq031485;
        Tue, 11 Sep 2018 12:08:37 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 11
 Sep 2018 12:08:37 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 11 Sep 2018 12:08:37 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8BH8aD1015313;
        Tue, 11 Sep 2018 12:08:36 -0500
Received: from localhost (a0272616local-lt.dhcp.ti.com [172.22.156.248])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w8BH8ax21205;
        Tue, 11 Sep 2018 12:08:36 -0500 (CDT)
From:   Dan Murphy <dmurphy@ti.com>
To:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lee.jones@linaro.org>, <linux-omap@vger.kernel.org>,
        <linux-leds@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v7 5/6] dt-bindings: leds: Add runtime ramp node for LM3697
Date:   Tue, 11 Sep 2018 12:08:24 -0500
Message-ID: <20180911170825.17789-6-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20180911170825.17789-1-dmurphy@ti.com>
References: <20180911170825.17789-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add runtime ramp rates for the LM3697 LED
driver.  This LED driver supports separate
runtime ramp rates for going from a higher
or lower level of brightnesses

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---

v7 - New change for the series to support feature in ti-lmu

 .../devicetree/bindings/leds/leds-lm3697.txt         | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/leds-lm3697.txt b/Documentation/devicetree/bindings/leds/leds-lm3697.txt
index 85ae075f6677..4bb2ed51025b 100644
--- a/Documentation/devicetree/bindings/leds/leds-lm3697.txt
+++ b/Documentation/devicetree/bindings/leds/leds-lm3697.txt
@@ -30,6 +30,12 @@ Required child properties:
 			1 - HVLED string is controlled by this control bank
 
 Optional child properties:
+	- runtime-ramp-up-msec: Current ramping from one brightness level to
+				the a higher brightness level.
+				Range from 2048 us - 117.44 s
+	- runtime-ramp-down-msec: Current ramping from one brightness level to
+				  the a lower brightness level.
+				  Range from 2048 us - 117.44 s
 	- label : see Documentation/devicetree/bindings/leds/common.txt
 	- linux,default-trigger :
 	   see Documentation/devicetree/bindings/leds/common.txt
@@ -51,6 +57,8 @@ led-controller@36 {
 	led@0 {
 		reg = <0>;
 		led-sources = <1 0 1>;
+		runtime-ramp-up-msec = <5000>;
+		runtime-ramp-down-msec = <1000>;
 		label = "white:first_backlight_cluster";
 		linux,default-trigger = "backlight";
 	};
@@ -58,6 +66,8 @@ led-controller@36 {
 	led@1 {
 		reg = <1>;
 		led-sources = <0 1 0>;
+		runtime-ramp-up-msec = <500>;
+		runtime-ramp-down-msec = <1000>;
 		label = "white:second_backlight_cluster";
 		linux,default-trigger = "backlight";
 	};
@@ -77,6 +87,8 @@ led-controller@36 {
 	led@0 {
 		reg = <0>;
 		led-sources = <1 1 1>;
+		runtime-ramp-up-msec = <500>;
+		runtime-ramp-down-msec = <1000>;
 		label = "white:backlight_cluster";
 		linux,default-trigger = "backlight";
 	};
-- 
2.17.0.1855.g63749b2dea

