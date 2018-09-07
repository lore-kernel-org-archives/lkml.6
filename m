Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E15BC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D6B2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:32:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05D6B2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbeIHCPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:15:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50100 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbeIHCPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:15:05 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 76FD4A7B;
        Fri,  7 Sep 2018 21:32:13 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <treding@nvidia.com>
Subject: [PATCH 4.14 64/89] ARM: tegra: Fix Tegra30 Cardhu PCA954x reset
Date:   Fri,  7 Sep 2018 23:09:58 +0200
Message-Id: <20180907210900.034650975@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210852.341064285@linuxfoundation.org>
References: <20180907210852.341064285@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jon Hunter <jonathanh@nvidia.com>

commit 6e1811900b6fe6f2b4665dba6bd6ed32c6b98575 upstream.

On all versions of Tegra30 Cardhu, the reset signal to the NXP PCA9546
I2C mux is connected to the Tegra GPIO BB0. Currently, this pin on the
Tegra is not configured as a GPIO but as a special-function IO (SFIO)
that is multiplexing the pin to an I2S controller. On exiting system
suspend, I2C commands sent to the PCA9546 are failing because there is
no ACK. Although it is not possible to see exactly what is happening
to the reset during suspend, by ensuring it is configured as a GPIO
and driven high, to de-assert the reset, the failures are no longer
seen.

Please note that this GPIO is also used to drive the reset signal
going to the camera connector on the board. However, given that there
is no camera support currently for Cardhu, this should not have any
impact.

Fixes: 40431d16ff11 ("ARM: tegra: enable PCA9546 on Cardhu")
Cc: stable@vger.kernel.org
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/tegra30-cardhu.dtsi |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm/boot/dts/tegra30-cardhu.dtsi
+++ b/arch/arm/boot/dts/tegra30-cardhu.dtsi
@@ -206,6 +206,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x70>;
+			reset-gpio = <&gpio TEGRA_GPIO(BB, 0) GPIO_ACTIVE_LOW>;
 		};
 	};
 


