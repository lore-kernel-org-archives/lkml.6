Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2590C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9593420840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdxUyQbk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9593420840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbeKIXwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 18:52:20 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:45326 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbeKIXwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 18:52:19 -0500
Received: by mail-yb1-f194.google.com with SMTP id 131-v6so1059851ybe.12;
        Fri, 09 Nov 2018 06:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SQ1qrcLiIRYqOVmsCK0PkJAXJvvPlMp6EdxfoWbisj0=;
        b=RdxUyQbkpkC6SAQUQSvaz17J9cY1KfdUEWq03ulBktroBdHbQCT3Xl0zl6sD6FD/Vs
         9ZQ2IED5qBB3EwGQa4kanWL17vCm1idiTEWQTt273lnTxwT6S7HGXFI0l1TJOA7CZJjb
         tRvjgLD8da+8wAGmvzsL1n10A2JqKJjoPpMUqUHjnPqN3jiLCyNIeG/vhEbJPjtWQlm8
         edJa3ttPeND/8V7iyuW2m5Kf8RJJmpsj16pmauC/GZ4GgV836++azscamvxn8a8h1yga
         vaB8h6pbXL/Jf67+lVzEJCIA2yirmsKff+wpKNgePNJ+zAIvrVSa5zf4inrlpB9RzxR5
         b1vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SQ1qrcLiIRYqOVmsCK0PkJAXJvvPlMp6EdxfoWbisj0=;
        b=VLPCTZ25r7aRjQ+tcOyxojr327ABW2yjptb2iPM1pX1tWCUMLHfnnAotQbcdXSq3Ub
         +s+pUkI6H0OdYXPRqyUHdsESuAZi2EdBRdS+xMLNxwz9deZO+NdWjH14v3IwkFROWkPS
         46yL9F6BrGvO/CrFx4SqauUcOw3eP/2FYmBY8wsFDuPO1iyV7YSi2Gxh6CLj5jmLxNwT
         HMFX8//9xQKkbm62n41gMZfqjjqu1ZpDt63QZUnwmivb/Z1hISvPHQjIKAIwdiQUFY3d
         my9nM7gyah+CgGtcqukzp9Ef5A6bLqtn1FH6ElFnmWjZAZ/VqUoa69pel92osudytfEI
         Uwrg==
X-Gm-Message-State: AGRZ1gLmIXbMPykmzNntlGIIpo2/G99Qo42UD23KYwY0dnjX336uoxKD
        4/96zEQ5ofedAFIi0UgT9yyQ1s03+bA=
X-Google-Smtp-Source: AJdET5f5qCC9oQa2WkHIrYuP38sbT2YTTrYLFjU4qmfPyEXSslJMdN8FUzcKETUQigVvtYWhz0adRQ==
X-Received: by 2002:a25:48c7:: with SMTP id v190-v6mr8705826yba.7.1541772692936;
        Fri, 09 Nov 2018 06:11:32 -0800 (PST)
Received: from stbsrv-and-3.and.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id c6-v6sm7301965ywh.34.2018.11.09.06.11.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 06:11:32 -0800 (PST)
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
Subject: [PATCH V4 3/5] usb: xhci: xhci-plat: Add support for Broadcom STB SoC's
Date:   Fri,  9 Nov 2018 09:01:58 -0500
Message-Id: <1541772120-40394-4-git-send-email-alcooperx@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
In-Reply-To: <1541772120-40394-1-git-send-email-alcooperx@gmail.com>
References: <1541772120-40394-1-git-send-email-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Broadcom STB SoC's to the xhci platform driver

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/usb/host/xhci-brcm.c | 16 ++++++++++++++++
 drivers/usb/host/xhci-brcm.h | 16 ++++++++++++++++
 drivers/usb/host/xhci-plat.c |  8 ++++++++
 3 files changed, 40 insertions(+)
 create mode 100644 drivers/usb/host/xhci-brcm.c
 create mode 100644 drivers/usb/host/xhci-brcm.h

diff --git a/drivers/usb/host/xhci-brcm.c b/drivers/usb/host/xhci-brcm.c
new file mode 100644
index 000000000000..bf8c0bfd1780
--- /dev/null
+++ b/drivers/usb/host/xhci-brcm.c
@@ -0,0 +1,16 @@
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

