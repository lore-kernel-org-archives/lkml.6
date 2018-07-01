Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8079C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7261D2558F
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:07:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7261D2558F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032098AbeGAQlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:41:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37424 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032079AbeGAQlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:41:42 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EC142AA6;
        Sun,  1 Jul 2018 16:41:41 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 4.17 077/220] ARM64: dts: meson-gx: fix ATF reserved memory region
Date:   Sun,  1 Jul 2018 18:21:41 +0200
Message-Id: <20180701160911.662594946@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
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

From: Kevin Hilman <khilman@baylibre.com>

commit 48e21ded0432ee1e2359d4143d7a6925cefee1b5 upstream.

Vendor firmware/uboot has different reserved regions depending on
firmware version, but current codebase reserves the same regions on
GXL and GXBB, so move the additional reserved memory region to common
.dtsi.

Found when putting a recent vendor u-boot on meson-gxbb-p200.

Suggested-by: Neil Armstrong <narmstrong@baylibre.com>
Cc: stable@vger.kernel.org
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi  |    6 ++++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi |    8 --------
 2 files changed, 6 insertions(+), 8 deletions(-)

--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -35,6 +35,12 @@
 			no-map;
 		};
 
+		/* Alternate 3 MiB reserved for ARM Trusted Firmware (BL31) */
+		secmon_reserved_alt: secmon@5000000 {
+			reg = <0x0 0x05000000 0x0 0x300000>;
+			no-map;
+		};
+
 		linux,cma {
 			compatible = "shared-dma-pool";
 			reusable;
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -13,14 +13,6 @@
 / {
 	compatible = "amlogic,meson-gxl";
 
-	reserved-memory {
-		/* Alternate 3 MiB reserved for ARM Trusted Firmware (BL31) */
-		secmon_reserved_alt: secmon@5000000 {
-			reg = <0x0 0x05000000 0x0 0x300000>;
-			no-map;
-		};
-	};
-
 	soc {
 		usb0: usb@c9000000 {
 			status = "disabled";


