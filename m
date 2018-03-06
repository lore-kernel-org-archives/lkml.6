Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753383AbeCFJhr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 04:37:47 -0500
Received: from mga05.intel.com ([192.55.52.43]:18438 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753297AbeCFJho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 04:37:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,430,1515484800";
   d="scan'208";a="25580127"
From: Tomas Winkler <tomas.winkler@intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH V2] tpm_crb: use __le64 annotated variable for response buffer address
Date: Tue,  6 Mar 2018 11:34:15 +0200
Message-Id: <20180306093415.12356-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use __le64 annotated variable for response buffer address as this is
read in little endian format form the register.

This suppresses sparse warning
drivers/char/tpm/tpm_crb.c:558:18: warning: cast to restricted __le64

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
V2: Add more info into the commit message

 drivers/char/tpm/tpm_crb.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index acfcdc6f31af..29fecdea0b2d 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -489,6 +489,7 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 	u32 pa_high, pa_low;
 	u64 cmd_pa;
 	u32 cmd_size;
+	__le64 __rsp_pa;
 	u64 rsp_pa;
 	u32 rsp_size;
 	int ret;
@@ -554,8 +555,8 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 		goto out;
 	}
 
-	memcpy_fromio(&rsp_pa, &priv->regs_t->ctrl_rsp_pa, 8);
-	rsp_pa = le64_to_cpu(rsp_pa);
+	memcpy_fromio(&__rsp_pa, &priv->regs_t->ctrl_rsp_pa, 8);
+	rsp_pa = le64_to_cpu(__rsp_pa);
 	rsp_size = crb_fixup_cmd_size(dev, &io_res, rsp_pa,
 				      ioread32(&priv->regs_t->ctrl_rsp_size));
 
-- 
2.14.3
