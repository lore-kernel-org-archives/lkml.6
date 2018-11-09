Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED1DC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8AE420825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWY/g4gR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8AE420825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbeKIXwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 18:52:14 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:41965 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbeKIXwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 18:52:14 -0500
Received: by mail-yb1-f196.google.com with SMTP id t13-v6so1077573ybb.8;
        Fri, 09 Nov 2018 06:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=G42SJPWvg3e/7j5Qp8MnT98QJRSCpsI3xdm9poMgmvY=;
        b=KWY/g4gRfBzGH6QwwDzcH6zsOSTEb4f14J1qzwTy/opYjFaWn4XZebd1GHCLcoa9F3
         SFdFX+9GvF+BaXlTeQiUGFy6RB4pcCCjVv9YG2vSg+zXfpA5zxhaLS0zg/xitdydUxrc
         LYyul+UNsTv2K7AMMl2BK1YkVgaxmL8/T/OB3ejZK7e55n30B71pZgqYi8steJRqun1s
         2nDz4lSKm8gdLYPvZJTLdOpmHQHRfPqua+G8gs9jexVAoA/LqyX4x1tVIQ6TeIy/Qjnw
         6LF/NyqN5Y35rF6mtUoigyCXIczrFoC5RVWcO+rT1xVRXD8LppEaht0DNHp6KyQEVBVR
         mImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=G42SJPWvg3e/7j5Qp8MnT98QJRSCpsI3xdm9poMgmvY=;
        b=TKLTgjay/MyvGYZ6g5nOag/YrWCncTBEV3c7+01eylDX77+XV4nN5E4dTe1zwj7pul
         sv3qJwip5ljBomzBORCsRGqsVvGYpz3gUAlcH6jrxV3NFRj9vjkT0WPAFRl4U1UvtGKd
         lkfdoUCqzOCr0l/oCc3kQSEjYE5LAp84C/nMusxxlVZlm/YmZ4Vg5QYRk4ZLVUcIj4fa
         Dt1G/86mW87rUpgHZqisfO1oJE2EoRpa8TAKgHHDKy4T+DjYIskJTkf+f3CFOycREXJa
         JTBAwLD3wnoGO86JZ4Wh6IK+kpYP82cC2lNZCSJcksBqoW5BIY0zyta5NHLWl9NN1Li6
         EkEg==
X-Gm-Message-State: AGRZ1gIv5VquHFUJ8kwza4bi85huE/7KwKg1XfzJnoJ51l4Vpsu3e7nU
        9fddRnCDhVbFyOPxcEE6zb4O2v09rZ0=
X-Google-Smtp-Source: AJdET5eFKqLlpgRKUwDpRlAn3EB29zB0qde/b6fjyJQLnDOYDXT7AF3PEt42bRmxzMhloqn1wYEw9g==
X-Received: by 2002:a25:49c1:: with SMTP id w184-v6mr8781771yba.457.1541772687901;
        Fri, 09 Nov 2018 06:11:27 -0800 (PST)
Received: from stbsrv-and-3.and.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id c6-v6sm7301965ywh.34.2018.11.09.06.11.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 06:11:27 -0800 (PST)
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
Subject: [PATCH V4 0/5] Add XHCI, EHCI and OHCI support for Broadcom STB SoS's
Date:   Fri,  9 Nov 2018 09:01:55 -0500
Message-Id: <1541772120-40394-1-git-send-email-alcooperx@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V4 - Rename hcd phy flag "suspend_without_phy_exit" to
     "phy_supplies_usb_clock" to more closely reflect
     the actaual hardware. Add the device tree property
     "suspend-without-phy-exit" to set the flag. Remove the code
     that sets the flag in the OHCI, EHCI and XHCI drivers which
     means that the ohci_platform.c driver can be used without
     any modifications.
   
V3 - Based on feedback
   - Patch 3/6
     In xhci-brcm.h, fixed incorrect function name when
     CONFIG_USB_XHCI_BRCM is not defined. Found by kbuild test robot.
   - Patch 4/6
     In ohci-platform.c, use devm_kmemdup() instead of demv_kzalloc().
   - Patch 5/6
     In ehci-platform.c, use dma_coerce_mask_and_coherent()
     instead of dma_coerce_mask_and_coherent(). Remove unneeded
     #ifdef CONFIG_OF.

V2 - Based on feedback, the functionality for XHCI and OHCI was
     moved from Broadcom platform drivers into the standard XHCI
     and OHCI platform drivers. The EHCI functionality still uses
     a Broadcom EHCI driver because of the workarounds needed for
     bugs in the EHCI controller.

This adds support for the XHCI, EHCI and OHCI host controllers found
in Broadcom STB SoC's. These drivers depend on getting access to the
new Broadcom STB USB PHY driver through a device-tree phandle and
will fail if the driver is not available.

Al Cooper (5):
  dt-bindings: Add Broadcom STB USB support
  usb: core: Add ability to skip phy exit on suspend and init on resume
  usb: xhci: xhci-plat: Add support for Broadcom STB SoC's
  usb: ehci: Add new EHCI driver for Broadcom STB SoC's
  usb: host: Add ability to build new Broadcom STB USB drivers

 .../devicetree/bindings/usb/brcm,bcm7445-ehci.txt  |  24 ++
 Documentation/devicetree/bindings/usb/usb-hcd.txt  |   3 +
 Documentation/devicetree/bindings/usb/usb-xhci.txt |   1 +
 MAINTAINERS                                        |   9 +
 arch/arm/configs/multi_v7_defconfig                |   1 +
 arch/arm64/configs/defconfig                       |   1 +
 drivers/usb/core/hcd.c                             |   8 +-
 drivers/usb/core/phy.c                             |  28 +-
 drivers/usb/core/phy.h                             |   9 +-
 drivers/usb/host/Kconfig                           |  26 ++
 drivers/usb/host/Makefile                          |  18 +-
 drivers/usb/host/ehci-brcm.c                       | 286 +++++++++++++++++++++
 drivers/usb/host/xhci-brcm.c                       |  16 ++
 drivers/usb/host/xhci-brcm.h                       |  16 ++
 drivers/usb/host/xhci-plat.c                       |   8 +
 include/linux/usb/hcd.h                            |   6 +
 16 files changed, 439 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.txt
 create mode 100644 drivers/usb/host/ehci-brcm.c
 create mode 100644 drivers/usb/host/xhci-brcm.c
 create mode 100644 drivers/usb/host/xhci-brcm.h

-- 
1.9.0.138.g2de3478

