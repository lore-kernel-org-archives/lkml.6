Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753291AbeE3LRT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:17:19 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:32840 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752605AbeE3LHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:07:09 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Hannes Reinecke" <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Tyrel Datwyler" <tyreld@linux.vnet.ibm.com>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.283678190@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 066/153] scsi: ibmvfc: fix misdefined reserved field
 in ibmvfc_fcp_rsp_info
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>

commit c39813652700f3df552b6557530f1e5f782dbe2f upstream.

The fcp_rsp_info structure as defined in the FC spec has an initial 3
bytes reserved field. The ibmvfc driver mistakenly defined this field as
4 bytes resulting in the rsp_code field being defined in what should be
the start of the second reserved field and thus always being reported as
zero by the driver.

Ideally, we should wire ibmvfc up with libfc for the sake of code
deduplication, and ease of maintaining standardized structures in a
single place. However, for now simply fixup the definition in ibmvfc for
backporting to distros on older kernels. Wiring up with libfc will be
done in a followup patch.

Reported-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/scsi/ibmvscsi/ibmvfc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/scsi/ibmvscsi/ibmvfc.h
+++ b/drivers/scsi/ibmvscsi/ibmvfc.h
@@ -365,7 +365,7 @@ enum ibmvfc_fcp_rsp_info_codes {
 };
 
 struct ibmvfc_fcp_rsp_info {
-	u16 reserved;
+	u8 reserved[3];
 	u8 rsp_code;
 	u8 reserved2[4];
 }__attribute__((packed, aligned (2)));
