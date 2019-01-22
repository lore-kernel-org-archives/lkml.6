Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D1CC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B74D72084A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ccP0SZnD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbfAVKgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 05:36:20 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39653 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbfAVKgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 05:36:20 -0500
Received: by mail-lj1-f196.google.com with SMTP id t9-v6so20130029ljh.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 02:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YSObxwMHqtkC/awE9I+bX0AU7eKOCKScYLfpaQugPuE=;
        b=ccP0SZnDW53Tty9adhgMbars1kax5HN6gnRZch4Cj6BLS9FX8AeQQRog/3F5qu0QoB
         adegLU0/UyoM/vTV2qZQ7PiR66YouofnDMmXgerVXgj3Bm1/btX6hDsk5a2ROFxX3asz
         8CY2yr5kZKJK07Y3HqVyiqNb8UZDPoY5DoPTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YSObxwMHqtkC/awE9I+bX0AU7eKOCKScYLfpaQugPuE=;
        b=JA0n8MGUHyr6WPnB5acK2t4MPQM9m/R8+pgNu16bla1f+WYlzGEyUzcWL7AVi0Qs9O
         GGQ9dYal4kF9INtrdiyC/ph7k9RhbxfpkqM36mrGUneThCrxf85e0lO5NgKOpZVIrInp
         NRhNwZVhVPuHhtt88MTW1MezuhRGIV+uM4jG7DHwTI0icVBnDlcmO9cm6wEm1qu24Te2
         ydx5rntOc2Qc5WZXcdq7Cl3T1Z8jR6Lq/bda4T62WdHemkRJ72/9bbnmHCJ6BS1m3rtk
         dvhX8Umiw6t19a2j7TFwhHuwvrof6EglfjFyvHQAgVVsXU/oZzJPokPP8TkMrzyCICsj
         cmeQ==
X-Gm-Message-State: AJcUukeTcQdJG4WiHckpanQFzi7W7/XcLEZ9jpSoZJA7NDfDa44zjp/R
        Y46knEorqXjt6FVnkMnINoOcPyxGqiNP2g==
X-Google-Smtp-Source: ALg8bN4+t0oLM4Y9wtNcFbO51/YMhWk1c7uXhKnegrDcaehrC8GBbrHhUwdGqA3f1mJMjvG8qCxXkg==
X-Received: by 2002:a2e:9dcb:: with SMTP id x11-v6mr21579413ljj.158.1548153378296;
        Tue, 22 Jan 2019 02:36:18 -0800 (PST)
Received: from localhost (c-573670d5.07-21-73746f28.bbcust.telenor.se. [213.112.54.87])
        by smtp.gmail.com with ESMTPSA id l21-v6sm2737684ljj.48.2019.01.22.02.36.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 02:36:17 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     balbi@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] usb: phy: fix link errors
Date:   Tue, 22 Jan 2019 11:36:02 +0100
Message-Id: <20190122103602.2641-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix link errors when CONFIG_FSL_USB2_OTG is enabled and USB_OTG_FSM is
set to module then the following link error occurs.

aarch64-linux-gnu-ld: drivers/usb/phy/phy-fsl-usb.o: in function `fsl_otg_ioctl':
drivers/usb/phy/phy-fsl-usb.c:1083: undefined reference to `otg_statemachine'
aarch64-linux-gnu-ld: drivers/usb/phy/phy-fsl-usb.c:1083:(.text+0x574): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `otg_statemachine'
aarch64-linux-gnu-ld: drivers/usb/phy/phy-fsl-usb.o: in function `fsl_otg_start_srp':
drivers/usb/phy/phy-fsl-usb.c:674: undefined reference to `otg_statemachine'
aarch64-linux-gnu-ld: drivers/usb/phy/phy-fsl-usb.c:674:(.text+0x61c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `otg_statemachine'
aarch64-linux-gnu-ld: drivers/usb/phy/phy-fsl-usb.o: in function `fsl_otg_set_host':
drivers/usb/phy/phy-fsl-usb.c:593: undefined reference to `otg_statemachine'
aarch64-linux-gnu-ld: drivers/usb/phy/phy-fsl-usb.c:593:(.text+0x7a4): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `otg_statemachine'
aarch64-linux-gnu-ld: drivers/usb/phy/phy-fsl-usb.o: in function `fsl_otg_start_hnp':
drivers/usb/phy/phy-fsl-usb.c:695: undefined reference to `otg_statemachine'
aarch64-linux-gnu-ld: drivers/usb/phy/phy-fsl-usb.c:695:(.text+0x858): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `otg_statemachine'
aarch64-linux-gnu-ld: drivers/usb/phy/phy-fsl-usb.o: in function `a_wait_enum':
drivers/usb/phy/phy-fsl-usb.c:274: undefined reference to `otg_statemachine'
aarch64-linux-gnu-ld: drivers/usb/phy/phy-fsl-usb.c:274:(.text+0x16f0): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `otg_statemachine'
aarch64-linux-gnu-ld: drivers/usb/phy/phy-fsl-usb.o:drivers/usb/phy/phy-fsl-usb.c:619: more undefined references to `otg_statemachine' follow
aarch64-linux-gnu-ld: drivers/usb/phy/phy-fsl-usb.o: in function `fsl_otg_set_peripheral':
drivers/usb/phy/phy-fsl-usb.c:619:(.text+0x1fa0): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `otg_statemachine'
make[1]: *** [Makefile:1020: vmlinux] Error 1
make[1]: Target 'Image' not remade because of errors.
make: *** [Makefile:152: sub-make] Error 2
make: Target 'Image' not remade because of errors.

Rework so that FSL_USB2_OTG depends on that the USB_OTG_FSM is builtin.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/phy/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
index d7312eed6088..91ea3083e7ad 100644
--- a/drivers/usb/phy/Kconfig
+++ b/drivers/usb/phy/Kconfig
@@ -21,7 +21,7 @@ config AB8500_USB
 
 config FSL_USB2_OTG
 	bool "Freescale USB OTG Transceiver Driver"
-	depends on USB_EHCI_FSL && USB_FSL_USB2 && USB_OTG_FSM && PM
+	depends on USB_EHCI_FSL && USB_FSL_USB2 && USB_OTG_FSM=y && PM
 	depends on USB_GADGET || !USB_GADGET # if USB_GADGET=m, this can't be 'y'
 	select USB_PHY
 	help
-- 
2.20.1

