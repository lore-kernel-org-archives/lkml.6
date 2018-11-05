Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05817C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF7E92081C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/GVD1Go"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF7E92081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388132AbeKFGyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 01:54:49 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46763 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387598AbeKFGys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 01:54:48 -0500
Received: by mail-pl1-f196.google.com with SMTP id c13-v6so5065668plz.13;
        Mon, 05 Nov 2018 13:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oXPFAGO9CBh1PNvDRHgtigu8kPEG9MMwio1UV3mOaN8=;
        b=F/GVD1GoFRY+47VtWmBY5PMNbpPc81MoeiMfFCs9D6dHB7eFaXV3vb+GAYcdFySkFQ
         59Y20NgCTcpfr14ImyHUSwO/K33KONj9VvhI9GCwQYz0DGFDpbaaKSQ3HEeKEd5I3eN1
         UoYjb8twlt0w2fRkm6r7FdMAe8GPmrYnNRoOkvxwtEp2x2mULCV07brx1lnEV9aXnXqz
         qocVERjpXnRkLnj09jLgBb4+tde98inSZ8shWjwbwvRk76lUkh8U4eHyln+H/InEawZB
         B5cTRo2DdLWlF6VoG9GizLLrEXuM+drFfszrGmHHszkHLI+7OV5FFgQFWKY0aNuH9iNb
         pJog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oXPFAGO9CBh1PNvDRHgtigu8kPEG9MMwio1UV3mOaN8=;
        b=FUxaJFYeM6vPoPup/jay32eywvZLe9+UB7Anp18oCc/ymt9d8F4d8aDJZQH7BR3mEB
         Arqo4jerPn6jV8ErKuykq2ilIAeXsc6JnM/cZB4xDFOv2MSJgX44mbxifvubGQ593Yy0
         kSlVlY9g0L4G3V7TLCdDH8yilj8DE54jUj7IAOYRH51hbqz03b7765AdHviAHON9+uB5
         2/F+v5IGe4QoORbc7hrgGPAKm+AbFJD6bYhk5bC6xdzsLCUZI7Pw3wLEjLzY+hEH9WpH
         LJNSSozX7ct43bmbGtHMIUy6p/Y6Wv73+kKUFaYJ9yyr/yWBL3yAlC197hrxAk7OWVEK
         0jQQ==
X-Gm-Message-State: AGRZ1gKMdLLzMqQEs0h6p7nn04wkEtb+cuZCnGD059RLqPQdvyJ9fNKZ
        0BeHwk9siZ2ZHqDRpOIml9cpCBbKybw=
X-Google-Smtp-Source: AJdET5dCpLjXo1H39p6UpTy/x4b3rXTKd6o2rcWIDMjKtMvMJZxPUrwl1CYuysig397M9pCWExE5/w==
X-Received: by 2002:a17:902:7c0b:: with SMTP id x11-v6mr23371532pll.60.1541453586279;
        Mon, 05 Nov 2018 13:33:06 -0800 (PST)
Received: from stbsrv-and-3.and.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id m129-v6sm14328440pfm.78.2018.11.05.13.33.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 13:33:05 -0800 (PST)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Alban Bedel <albeu@free.fr>, Alex Elder <elder@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Avi Fishman <avifishman70@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Hans de Goede <hdegoede@redhat.com>,
        James Hogan <jhogan@kernel.org>,
        Jianguo Sun <sunjianguo1@huawei.com>,
        Johan Hovold <johan@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-usb@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH V3 3/6] usb: xhci: xhci-plat: Add support for Broadcom STB SoC's
Date:   Mon,  5 Nov 2018 16:31:30 -0500
Message-Id: <1541453493-34981-4-git-send-email-alcooperx@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
In-Reply-To: <1541453493-34981-1-git-send-email-alcooperx@gmail.com>
References: <1541453493-34981-1-git-send-email-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Broadcom STB SoC's to the xhci platform driver

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/usb/host/xhci-brcm.c | 17 +++++++++++++++++
 drivers/usb/host/xhci-brcm.h | 16 ++++++++++++++++
 drivers/usb/host/xhci-plat.c |  8 ++++++++
 3 files changed, 41 insertions(+)
 create mode 100644 drivers/usb/host/xhci-brcm.c
 create mode 100644 drivers/usb/host/xhci-brcm.h

diff --git a/drivers/usb/host/xhci-brcm.c b/drivers/usb/host/xhci-brcm.c
new file mode 100644
index 000000000000..a7220126f6af
--- /dev/null
+++ b/drivers/usb/host/xhci-brcm.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2018, Broadcom */
+
+#include <linux/usb.h>
+#include <linux/usb/hcd.h>
+
+#include "xhci.h"
+
+int xhci_plat_brcm_init_quirk(struct usb_hcd *hcd)
+{
+	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
+
+	xhci->quirks |= XHCI_RESET_ON_RESUME;
+	hcd->suspend_without_phy_exit = 1;
+	return 0;
+}
+
diff --git a/drivers/usb/host/xhci-brcm.h b/drivers/usb/host/xhci-brcm.h
new file mode 100644
index 000000000000..e64800fae4d5
--- /dev/null
+++ b/drivers/usb/host/xhci-brcm.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2018, Broadcom */
+
+#ifndef _XHCI_BRCM_H
+#define _XHCI_BRCM_H
+
+#if IS_ENABLED(CONFIG_USB_XHCI_BRCM)
+int xhci_plat_brcm_init_quirk(struct usb_hcd *hcd);
+#else
+static inline int xhci_plat_brcm_init_quirk(struct usb_hcd *hcd)
+{
+	return 0;
+}
+#endif
+#endif /* _XHCI_BRCM_H */
+
diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 32b5574ad5c5..5372d4040be6 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -24,6 +24,7 @@
 #include "xhci-plat.h"
 #include "xhci-mvebu.h"
 #include "xhci-rcar.h"
+#include "xhci-brcm.h"
 
 static struct hc_driver __read_mostly xhci_plat_hc_driver;
 
@@ -112,6 +113,10 @@ static int xhci_plat_start(struct usb_hcd *hcd)
 	.resume_quirk = xhci_rcar_resume_quirk,
 };
 
+static const struct xhci_plat_priv xhci_plat_brcm = {
+	.init_quirk = xhci_plat_brcm_init_quirk
+};
+
 static const struct of_device_id usb_xhci_of_match[] = {
 	{
 		.compatible = "generic-xhci",
@@ -144,6 +149,9 @@ static int xhci_plat_start(struct usb_hcd *hcd)
 	}, {
 		.compatible = "renesas,rcar-gen3-xhci",
 		.data = &xhci_plat_renesas_rcar_gen3,
+	}, {
+		.compatible = "brcm,bcm7445-xhci",
+		.data = &xhci_plat_brcm,
 	},
 	{},
 };
-- 
1.9.0.138.g2de3478

