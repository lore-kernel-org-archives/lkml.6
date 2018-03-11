Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932190AbeCKSwx (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 14:52:53 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36946 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932137AbeCKSwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 14:52:51 -0400
X-Google-Smtp-Source: AG47ELveOZjiXJTuL4ztF1wrz3dV6j88wthFnsqu2Aepu4xc33PKrQLxkG0cHFsoNEJ7xoQoWVC2Wg==
From: =?UTF-8?q?Jaros=C5=82aw=20Janik?= <jaroslaw.janik@gmail.com>
To: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jaros=C5=82aw=20Janik?= <jaroslaw.janik@gmail.com>
Subject: [PATCH] nvme-pci: disable APST for Samsung NVMe SSD 960 EVO + ASUS PRIME Z370-A
Date: Sun, 11 Mar 2018 19:51:56 +0100
Message-Id: <20180311185156.3807-1-jaroslaw.janik@gmail.com>
X-Mailer: git-send-email 2.16.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yet another "incompatible" Samsung NVMe SSD 960 EVO and Asus motherboard
combination. 960 EVO device disappears from PCIe bus within few minutes
after boot-up when APST is in use and never gets back. Forcing
NVME_QUIRK_NO_APST is the only way to make this drive work with this
particular motherboard. NVME_QUIRK_NO_DEEPEST_PS doesn't work, upgrading
motherboard's BIOS didn't help either.
Since this is a desktop motherboard, the only drawback of not using APST
is increased device temperature.

Signed-off-by: Jarosław Janik <jaroslaw.janik@gmail.com>
---
 drivers/nvme/host/pci.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5933a5c732e8..3bfaf083ca0b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2460,10 +2460,13 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 	} else if (pdev->vendor == 0x144d && pdev->device == 0xa804) {
 		/*
 		 * Samsung SSD 960 EVO drops off the PCIe bus after system
-		 * suspend on a Ryzen board, ASUS PRIME B350M-A.
+		 * suspend on a Ryzen board, ASUS PRIME B350M-A, as well as
+		 * within few minutes after bootup on a Coffee Lake board -
+		 * ASUS PRIME Z370-A
 		 */
 		if (dmi_match(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC.") &&
-		    dmi_match(DMI_BOARD_NAME, "PRIME B350M-A"))
+		    (dmi_match(DMI_BOARD_NAME, "PRIME B350M-A") ||
+		     dmi_match(DMI_BOARD_NAME, "PRIME Z370-A")))
 			return NVME_QUIRK_NO_APST;
 	}
 
-- 
2.16.1
