Return-Path: <okaya@codeaurora.org>
X-Google-Smtp-Source: AIpwx49UaSZyVbQ4SxSTtK97kfbwvKui5boRcjh1dF8NCbiPwgNVpq4f53wY1/61Gq3oUkeWx2AU
ARC-Seal: i=1; a=rsa-sha256; t=1524167797; cv=none;
        d=google.com; s=arc-20160816;
        b=qquX2LKnDJyc8ls8gQOu0k5bPfKrJgN44RXS3lmaO4JvKMM24WImpEoEr6aiaMvf9C
         StB0COIhZZgt22xKqRSF5Uk8I3Cr/xM4LETgQVVIpOJeI/S+Hm9wu0A59kCS7HlnZMCH
         mFdUfDcEY5lUmBThQGy1rB20n4/ybf8amEA031KV5KWLKnigr9Av8+qKj38IW5RzMRIG
         Um4vkCJv47dlBzuqWNiGMneXhdee6ayntpW0zHnf3Xryxo7PxFU2QFrV+IflPS5K7F0i
         guMHc7gGKU50dQyqxtFR/3p6RRt4lUd1qdoNVL970VhF3clcAUHx8uBAXXDmKODwfGqN
         0h3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dmarc-filter:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=0L1vuNMoGZhcgQGrvrS6z1xwzCDv7uc8Wjz48fSMCbQ=;
        b=XXXS/mXEtbbuEwfJY8iQmFOb7fb5++3dQyKxFHiq9oevJMwiIAfCq2gsO1IpwS3u0b
         ycBiNxYIyeUL+xaEqyoShxRYffCvaA1L0D4W5rQ5xgVgtAy8P0MaSBPlT/OxAyLOzlTE
         rMuNJBqesKozlReduXTcvFPW6pgJDIrQ12X+ZZmX034JAkXRCUjPRTdkjFu0+TYgwc/e
         qsXE8bBeEmw+BSvlKHaDqqkBgk5SdtA+2OM9/THsCuF3lSVdPI6DSPrIoRIyfls0cNvU
         9jcIAXfFjMn2iKcyWRQ4ASXCL8a2NLnERdWQbdpmS/07F2Ps6DeRDr+v3+3nWf62y0wS
         9RRA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=n1AmC4ug;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=RrXG3Uxt;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=n1AmC4ug;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=RrXG3Uxt;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 31EAE60863
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org,
	sulrich@codeaurora.org,
	timur@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Sinan Kaya <okaya@codeaurora.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frederick Lawler <fred@fredlawl.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Juan J. Alvarez" <jjalvare@linux.vnet.ibm.com>,
	Russell Currey <ruscur@russell.cc>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Keith Busch <keith.busch@intel.com>,
	Tyler Baicar <tbaicar@codeaurora.org>,
	"Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] PCI/AER: Try slot reset before secondary bus reset
Date: Thu, 19 Apr 2018 15:56:24 -0400
Message-Id: <1524167784-5911-2-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524167784-5911-1-git-send-email-okaya@codeaurora.org>
References: <1524167784-5911-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598205773144621610?=
X-GMAIL-MSGID: =?utf-8?q?1598205773144621610?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The endpoint observing AER_FATAL error might be connected to a PCI hotplug
slot. Performing secondary bus reset on a hotplug slot causes PCI link
up/down interrupts.

Hotplug driver removes the device from system when a link down interrupt
is observed and performs re-enumeration when link up interrupt is observed.

This conflicts with what this code is trying to do. Try secondary bus
reset only if pci_reset_slot() fails/unsupported.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/pcie/aer/aerdrv.c      | 3 ++-
 drivers/pci/pcie/aer/aerdrv_core.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aer/aerdrv.c b/drivers/pci/pcie/aer/aerdrv.c
index 779b387..4eaa524 100644
--- a/drivers/pci/pcie/aer/aerdrv.c
+++ b/drivers/pci/pcie/aer/aerdrv.c
@@ -318,7 +318,8 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 	reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
 	pci_write_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, reg32);
 
-	pci_reset_bridge_secondary_bus(dev);
+	if (pci_reset_slot(dev->slot))
+		pci_reset_bridge_secondary_bus(dev);
 	pci_printk(KERN_DEBUG, dev, "Root Port link has been reset\n");
 
 	/* Clear Root Error Status */
diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index 0ea5acc..a915b0e6 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -407,7 +407,8 @@ static pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
  */
 static pci_ers_result_t default_reset_link(struct pci_dev *dev)
 {
-	pci_reset_bridge_secondary_bus(dev);
+	if (pci_reset_slot(dev->slot))
+		pci_reset_bridge_secondary_bus(dev);
 	pci_printk(KERN_DEBUG, dev, "downstream link has been reset\n");
 	return PCI_ERS_RESULT_RECOVERED;
 }
-- 
2.7.4
