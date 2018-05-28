Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425269AbeE1QWZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 12:22:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:59708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933961AbeE1KLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:11:31 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Carlo Pisani <carlojpisani@gmail.com>,
        Kyle McMartin <kyle@mcmartin.ca>,
        Grant Grundler <grantgrundler@gmail.com>, Helge Deller <deller@gmx.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 131/185] parisc/pci: Switch LBA PCI bus from Hard Fail to Soft Fail mode
Date: Mon, 28 May 2018 12:02:52 +0200
Message-Id: <20180528100104.528728026@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100050.700971285@linuxfoundation.org>
References: <20180528100050.700971285@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Helge Deller <deller@gmx.de>

[ Upstream commit b845f66f78bf42a4ce98e5cfe0e94fab41dd0742 ]

Carlo Pisani noticed that his C3600 workstation behaved unstable during heavy
I/O on the PCI bus with a VIA VT6421 IDE/SATA PCI card.

To avoid such instability, this patch switches the LBA PCI bus from Hard Fail
mode into Soft Fail mode. In this mode the bus will return -1UL for timed out
MMIO transactions, which is exactly how the x86 (and most other architectures)
PCI busses behave.

This patch is based on a proposal by Grant Grundler and Kyle McMartin 10
years ago:
https://www.spinics.net/lists/linux-parisc/msg01027.html

Cc: Carlo Pisani <carlojpisani@gmail.com>
Cc: Kyle McMartin <kyle@mcmartin.ca>
Reviewed-by: Grant Grundler <grantgrundler@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/parisc/lba_pci.c |   20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

--- a/drivers/parisc/lba_pci.c
+++ b/drivers/parisc/lba_pci.c
@@ -1366,9 +1366,27 @@ lba_hw_init(struct lba_device *d)
 		WRITE_REG32(stat, d->hba.base_addr + LBA_ERROR_CONFIG);
 	}
 
-	/* Set HF mode as the default (vs. -1 mode). */
+
+	/*
+	 * Hard Fail vs. Soft Fail on PCI "Master Abort".
+	 *
+	 * "Master Abort" means the MMIO transaction timed out - usually due to
+	 * the device not responding to an MMIO read. We would like HF to be
+	 * enabled to find driver problems, though it means the system will
+	 * crash with a HPMC.
+	 *
+	 * In SoftFail mode "~0L" is returned as a result of a timeout on the
+	 * pci bus. This is like how PCI busses on x86 and most other
+	 * architectures behave.  In order to increase compatibility with
+	 * existing (x86) PCI hardware and existing Linux drivers we enable
+	 * Soft Faul mode on PA-RISC now too.
+	 */
         stat = READ_REG32(d->hba.base_addr + LBA_STAT_CTL);
+#if defined(ENABLE_HARDFAIL)
 	WRITE_REG32(stat | HF_ENABLE, d->hba.base_addr + LBA_STAT_CTL);
+#else
+	WRITE_REG32(stat & ~HF_ENABLE, d->hba.base_addr + LBA_STAT_CTL);
+#endif
 
 	/*
 	** Writing a zero to STAT_CTL.rf (bit 0) will clear reset signal
