Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE48C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 21:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E2FD21470
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 21:49:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E2FD21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731850AbeHNAdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 20:33:39 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:53316 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731690AbeHNAdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 20:33:39 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue006 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MCk22-1fh3Ey1FGE-009Mj7; Mon, 13 Aug 2018 23:49:26 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Felipe Balbi <balbi@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: hide usb_of_get_companion_dev for CONFIG_USB=n
Date:   Mon, 13 Aug 2018 23:48:46 +0200
Message-Id: <20180813214924.3567840-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:+C/AY/FsJPTL/edJ8vjd+U5L1h5y/lkPFRi66nBg2KO9OM5fO0w
 5aOg8QyirCrauT6HZaXu93C/92Wtsx0OwxCt6b3eePzit7CWh1hRgpIJ9a0m00p+Ryb7pvb
 cc58QsoomZ0vlhFWBDpIq67aGjvf5XbAR8BbeR0F2tfusHZPrtG+XTzQ5oSFI03HlHDTpMZ
 or+54bV9OeLh77PufL0iA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0JJ1W3OBiY0=:2XToV9Ex8w6bA5UFVZBgLd
 BFF6BMRVyhGsv51b9e1UQ3NGBNGCTBrjuk5SuZ20vBkAT4W3EZ/A4nrXpkn148yhu0y6gqgsM
 7LwXnq9iIf1uoYEe8SUU90k8hhxlk9RDIxtAMZhTL/d2dAGJcuygwaSaN7cgrh4yNBsRU+yC1
 rlwIiJv9IZvzWosNJrLj1AGX3C1AXDkLPVapZO6FnCzOkje6OF2x/lDoT/XwoxTYj9jFUDg/r
 timyN2wREiATYtj0s28rjwozDO19MwBu8YlYwNFMoUc/HBfMy/AEyqUiT42zjgOvaqsBXfi1O
 99iKcSV3rzAlqMOaaGnyJ4yeuNxFVtWifldMb1/qlvd8YfTMPRZGEWwCesabLlP1592wPSsKa
 KxJMOZXf2Hnwn4PvvQcDdQFH13+cvnCTtlt9yCax1lfJDSGWH+gACRsrIn+a8GM2yNQ8EbFv7
 hgJYwgZSE5FTTJ7OHCQC7poZaFlmqtYW/7ehbiDNIb+XI9ymQpG02vREZyEo7s3g/R4+QK10w
 2ALCtowj+tk6IDXY+hAPVs+9Plfr+3IJRVhKVM1e+jSOiIgTU3X1BsiI9KAAoKmJUeeGJmUEO
 +xTvzysovC0s2eSVLRl6VT9LOGwV9Ue+xENrfnO2HweHGDY2zFDZwIwJJtEuTt2vsWEGQVuZz
 m87dnDazi/BTVnb/1/oxhuYWmq8oZ5CjxDOLoBe2SDTyZdExT8z5sOqAxN8J1hZZvftY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The renesas UDC implementation now calls usb_of_get_companion_dev(),
which is only defined when CONFIG_USB is enabled:

drivers/usb/gadget/udc/renesas_usb3.o: In function `renesas_usb3_probe':
renesas_usb3.c:(.text+0xa34): undefined reference to `usb_of_get_companion_dev'

To avoid the build error, we need two changes:

- usb_of_get_companion_dev must be stubbed out when CONFIG_USB is
  disabled, so it the udc driver can be built for a gadget-only
  mode kernel
- With CONFIG_USB=m, we must not attempt to have USB_RENESAS_USB3
  built-in, so we need a soft dependency on USB.

Fixes: 39facfa01c9f ("usb: gadget: udc: renesas_usb3: Add register of usb role switch")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/gadget/udc/Kconfig | 1 +
 include/linux/usb/of.h         | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/Kconfig b/drivers/usb/gadget/udc/Kconfig
index 0a16cbd4e528..663a8bd67a7b 100644
--- a/drivers/usb/gadget/udc/Kconfig
+++ b/drivers/usb/gadget/udc/Kconfig
@@ -193,6 +193,7 @@ config USB_RENESAS_USB3
 	tristate 'Renesas USB3.0 Peripheral controller'
 	depends on ARCH_RENESAS || COMPILE_TEST
 	depends on EXTCON
+	depends on USB || !USB
 	select USB_ROLE_SWITCH
 	help
 	   Renesas USB3.0 Peripheral controller is a USB peripheral controller
diff --git a/include/linux/usb/of.h b/include/linux/usb/of.h
index dba55ccb9b53..733339218466 100644
--- a/include/linux/usb/of.h
+++ b/include/linux/usb/of.h
@@ -23,7 +23,6 @@ struct device_node *usb_of_get_device_node(struct usb_device *hub, int port1);
 bool usb_of_has_combined_node(struct usb_device *udev);
 struct device_node *usb_of_get_interface_node(struct usb_device *udev,
 		u8 config, u8 ifnum);
-struct device *usb_of_get_companion_dev(struct device *dev);
 #else
 static inline enum usb_dr_mode
 of_usb_get_dr_mode_by_phy(struct device_node *np, int arg0)
@@ -53,6 +52,11 @@ usb_of_get_interface_node(struct usb_device *udev, u8 config, u8 ifnum)
 {
 	return NULL;
 }
+#endif
+
+#if IS_ENABLED(CONFIG_OF) && IS_ENABLED(CONFIG_USB)
+struct device *usb_of_get_companion_dev(struct device *dev);
+#else
 static inline struct device *usb_of_get_companion_dev(struct device *dev)
 {
 	return NULL;
-- 
2.18.0

