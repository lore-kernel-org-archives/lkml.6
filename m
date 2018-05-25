Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030755AbeEYWFb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 18:05:31 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:60893 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030394AbeEYWF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 18:05:27 -0400
X-IronPort-AV: E=Sophos;i="5.49,441,1520924400";
   d="scan'208";a="11927773"
From: Prasanthi Chellakumar <Prasanthi.Chellakumar@microchip.com>
To: <linux-kernel@vger.kernel.org>
CC: Prasanthi Chellakumar <prasanthi.chellakumar@microchip.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>
Subject: [PATCH] usb: host: ohci: fix sfr kernel warning in ohci-at91 driver
Date: Fri, 25 May 2018 15:04:24 -0700
Message-ID: <1527285896-12811-1-git-send-email-Prasanthi.Chellakumar@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB Host Controller driver 'ohci-at91.c' reads a Special Function
Register - OHCI Interrupt Configuration Register (AT91_SFR_OHCIICR)
for bits SUSPEND_A/B/C. These bits are defined in sama5d2 alone, so
sfr register mapping is done with compatible string "atmel,sama5d2-sfr".
This gives a kernel warning 'failed to find sfr node' with non sama5d2
cpus which is removed here, thus leaving it up to having a proper DTS.

Signed-off-by: Prasanthi Chellakumar <prasanthi.chellakumar@microchip.com>

---

The AT91_SFR_OHCIIR register is read for USB suspend and wake
up control. The OHCI driver has a sfr register mapping for sama5d2
alone. The USB suspend proceeds only when there is valid sfr regmap.
So SFR access in boards that it is absent is not required. In such
boards, USB suspend control requests is processed by usb_hub_control().
But there is a kernel warning with non sama5d2 cpus. This patch fixes
the kernel warning, changing to debug message(dev_dbg).
---
 drivers/usb/host/ohci-at91.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index af0566d..ce11c47 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -214,7 +214,7 @@ static int usb_hcd_at91_probe(const struct hc_driver *driver,
 
 	ohci_at91->sfr_regmap = at91_dt_syscon_sfr();
 	if (!ohci_at91->sfr_regmap)
-		dev_warn(dev, "failed to find sfr node\n");
+		dev_dbg(dev, "failed to find sfr node\n");
 
 	board = hcd->self.controller->platform_data;
 	ohci = hcd_to_ohci(hcd);
-- 
2.7.4
