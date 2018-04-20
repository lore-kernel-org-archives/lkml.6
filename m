Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754427AbeDTJDR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 05:03:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40651 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754159AbeDTJDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 05:03:15 -0400
From: Colin King <colin.king@canonical.com>
To: Intel SCU Linux support <intel-linux-scu@intel.com>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] isci: Fix infinite loop in while loop
Date: Fri, 20 Apr 2018 10:03:10 +0100
Message-Id: <20180420090310.714-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

In the case when the phy_mask is bitwise anded with the
phy_index bit is zero the continue statement currently jumps
to the next iteration of the while loop and phy_index is
never actually incremented, potentially causing an infinite
loop if phy_index is less than SCI_MAX_PHS. Fix this by
jumping to the increment of phy_index.

[ The goto is used to save one more level of nesting that
makes the code far wider than 80 columns. ]

Fixes: 80aebef7c112 ("[SCSI] isci: Fix a infinite loop.")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/isci/port_config.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/isci/port_config.c b/drivers/scsi/isci/port_config.c
index edb7be786c65..55dc7c1dbc2b 100644
--- a/drivers/scsi/isci/port_config.c
+++ b/drivers/scsi/isci/port_config.c
@@ -293,7 +293,7 @@ sci_mpc_agent_validate_phy_configuration(struct isci_host *ihost,
 		 *       This is expected and required to add the phy to the port. */
 		while (phy_index < SCI_MAX_PHYS) {
 			if ((phy_mask & (1 << phy_index)) == 0)
-				continue;
+				goto next_index;
 			sci_phy_get_sas_address(&ihost->phys[phy_index],
 						     &phy_assigned_address);
 
@@ -311,6 +311,7 @@ sci_mpc_agent_validate_phy_configuration(struct isci_host *ihost,
 					      &ihost->phys[phy_index]);
 
 			assigned_phy_mask |= (1 << phy_index);
+next_index:
 			phy_index++;
 		}
 
-- 
2.17.0
