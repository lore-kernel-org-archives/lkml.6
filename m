Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25193ECDE3B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4CE821470
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXOGnMai"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4CE821470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbeJRG14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 02:27:56 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36632 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbeJRG14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 02:27:56 -0400
Received: by mail-pf1-f194.google.com with SMTP id l81-v6so13876864pfg.3;
        Wed, 17 Oct 2018 15:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OXrp7lSff47EDC16vYjjmN9IQaBCCpSe1i8CheNnDHA=;
        b=ZXOGnMaiEVr3u9TjvER7T/h/2Ixw331J64J207lfHMq2OZigKYoQFpGhorHdwRIqyY
         hN9PDwnyR6KynOFlZNgu3FUqEm6p4g9AekyRuxgcVwVi0IREDOo+jb+UF2LHnR+aB0Mr
         6CpkiZ7X9WNEBcc2zJ5ZUsKI+mp8A6Wx8HLdeb6AR8qEwjlZr35WMvRCuKfkAsy0WfMH
         FQMvyE0wQWiiKWMEADInBz0NPHMdRysZfS1BZYksDu3OaeH3uwfbA2ypdEYU2+7JvrO8
         iIT7wug0d6ywd0YAU0hqXIwZBA3P4PlClb4H2vxDM1JTxXRxhM1F40Wm9s8ulEWfdRrx
         LV6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OXrp7lSff47EDC16vYjjmN9IQaBCCpSe1i8CheNnDHA=;
        b=brjD4OkG6nRTKfvUlKR88CePWj82n0mRZa46qgoHldid7bJO7YT5TohonqHHcSfyzH
         U9BH8BMT863LwLO/69Bc+pt7tabGRSZJmlR0q+Ru71lmKR2p13IZQdkspZyMQEEM35Py
         7IkjcAUvWd0KnQ/laIbrVwlJLSmbuPqkWnWDcyAtkjPyhS8GW1q0D3j+SrIIqplwMdp4
         tLewaQpkhu5cmcDFI+Ep97mGfF0ELuqFQdC780TUSer/YS9Rtz5OrT688UaONllqOOsR
         9UblmNcQ+ncHPuW2qVdU664hwHLjRaExP30eE+EV91Gs4YekXVhfePZMYKXaoqKwY/Ue
         BBoQ==
X-Gm-Message-State: ABuFfogaDvZ3r+Kio5bgWgTVYLULtxBscTK4wpZ5shuePgbMltHTzZoZ
        OBGDQjeGiT7eEVoqi9y74mq+zfIIzgM=
X-Google-Smtp-Source: ACcGV63Z6qaGV0vXxZ6Y6XM2gDOLqh1jEr+vSnBGbvbuft8YVc6IL009JMlva2380xsw9wbwVMvc3g==
X-Received: by 2002:a63:4107:: with SMTP id o7-v6mr26421727pga.256.1539815409175;
        Wed, 17 Oct 2018 15:30:09 -0700 (PDT)
Received: from stbsrv-and-3.and.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id p3-v6sm352597pgl.2.2018.10.17.15.30.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 15:30:08 -0700 (PDT)
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
Subject: [PATCH V2 3/6] usb: xhci: xhci-plat: Add support for Broadcom STB SoC's
Date:   Wed, 17 Oct 2018 18:29:06 -0400
Message-Id: <1539815349-24126-4-git-send-email-alcooperx@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
In-Reply-To: <1539815349-24126-1-git-send-email-alcooperx@gmail.com>
References: <1539815349-24126-1-git-send-email-alcooperx@gmail.com>
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
index 000000000000..a39d1b807a4c
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
+static inline int xhci_brcm_init_quirk(struct usb_hcd *hcd)
+{
+	return 0;
+}
+#endif
+#endif /* _XHCI_BRCM_H */
+
diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 94e939249b2b..1de22928e862 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -23,6 +23,7 @@
 #include "xhci-plat.h"
 #include "xhci-mvebu.h"
 #include "xhci-rcar.h"
+#include "xhci-brcm.h"
 
 static struct hc_driver __read_mostly xhci_plat_hc_driver;
 
@@ -111,6 +112,10 @@ static int xhci_plat_start(struct usb_hcd *hcd)
 	.resume_quirk = xhci_rcar_resume_quirk,
 };
 
+static const struct xhci_plat_priv xhci_plat_brcm = {
+	.init_quirk = xhci_plat_brcm_init_quirk
+};
+
 static const struct of_device_id usb_xhci_of_match[] = {
 	{
 		.compatible = "generic-xhci",
@@ -143,6 +148,9 @@ static int xhci_plat_start(struct usb_hcd *hcd)
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

