Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034085AbeEXRFZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 13:05:25 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:44046 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034052AbeEXRFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 13:05:22 -0400
X-Google-Smtp-Source: AB8JxZravvXG1DH7izccJOilsuSAh1FrrxSLCRSmSZ2MGPqRx1Qc/cGfZctSKspvPYcbyYlbmp90Ow==
From: Ivan Bornyakov <brnkv.i1@gmail.com>
To: intel-linux-scu@intel.com
Cc: artur.paszkiewicz@intel.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ivan Bornyakov <brnkv.i1@gmail.com>
Subject: [PATCH] scsi: isci: fix memcmp casting
Date: Thu, 24 May 2018 20:06:28 +0300
Message-Id: <20180524170628.24204-1-brnkv.i1@gmail.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memcmp() returns int, but variable of type u8 is used to store it. When
casting int to u8, one can lose significant bits and get 0 from non-0
value returned by the memcmp().

Signed-off-by: Ivan Bornyakov <brnkv.i1@gmail.com>
---
 drivers/scsi/isci/host.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/isci/host.c b/drivers/scsi/isci/host.c
index 1ee3868ade07..dd5f41e86639 100644
--- a/drivers/scsi/isci/host.c
+++ b/drivers/scsi/isci/host.c
@@ -1786,7 +1786,7 @@ static void power_control_timeout(struct timer_list *t)
 				 * them out of await_sas_power state.
 				 */
 				if (requester != NULL && requester != iphy) {
-					u8 other = memcmp(requester->frame_rcvd.iaf.sas_addr,
+					int other = memcmp(requester->frame_rcvd.iaf.sas_addr,
 							  iphy->frame_rcvd.iaf.sas_addr,
 							  sizeof(requester->frame_rcvd.iaf.sas_addr));
 
@@ -1840,7 +1840,7 @@ void sci_controller_power_control_queue_insert(struct isci_host *ihost,
 		struct isci_phy *current_phy;
 
 		for (i = 0; i < SCI_MAX_PHYS; i++) {
-			u8 other;
+			int other;
 			current_phy = &ihost->phys[i];
 
 			other = memcmp(current_phy->frame_rcvd.iaf.sas_addr,
-- 
2.16.1
