Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751173AbeCIKoj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 05:44:39 -0500
Received: from mga04.intel.com ([192.55.52.120]:65142 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751113AbeCIKoi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 05:44:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,445,1515484800";
   d="scan'208";a="23282162"
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Jordan Glover <Golden_Miller83@protonmail.ch>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH] thunderbolt: Prevent crash when ICM firmware is not running
Date: Fri,  9 Mar 2018 13:44:34 +0300
Message-Id: <20180309104434.64412-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Lenovo ThinkPad Yoga 370 (and possibly some other Lenovo models as
well) the Thunderbolt host controller sometimes comes up in such way
that the ICM firmware is not running properly. This is most likely an
issue in BIOS/firmware but as side-effect driver crashes the kernel due
to NULL pointer dereference:

  BUG: unable to handle kernel NULL pointer dereference at 0000000000000980
  IP: pci_write_config_dword+0x5/0x20
  Call Trace:
   pcie2cio_write+0x3b/0x70 [thunderbolt]
   icm_driver_ready+0x168/0x260 [thunderbolt]
   ? tb_ctl_start+0x50/0x70 [thunderbolt]
   tb_domain_add+0x73/0xf0 [thunderbolt]
   nhi_probe+0x182/0x300 [thunderbolt]
   local_pci_probe+0x42/0xa0
   ? pci_match_device+0xd9/0x100
   pci_device_probe+0x146/0x1b0
   driver_probe_device+0x315/0x480
   ...

Instead of crashing update the driver to bail out gracefully if we
encounter such situation.

Fixes: f67cf491175a ("thunderbolt: Add support for Internal Connection Manager (ICM)")
Reported-by: Jordan Glover <Golden_Miller83@protonmail.ch>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: stable@vger.kernel.org
---
 drivers/thunderbolt/icm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index 6b1041677604..2d2ceda9aa26 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -1452,6 +1452,9 @@ static int icm_firmware_reset(struct tb *tb, struct tb_nhi *nhi)
 	struct icm *icm = tb_priv(tb);
 	u32 val;
 
+	if (!icm->upstream_port)
+		return -ENODEV;
+
 	/* Put ARC to wait for CIO reset event to happen */
 	val = ioread32(nhi->iobase + REG_FW_STS);
 	val |= REG_FW_STS_CIO_RESET_REQ;
-- 
2.16.1
