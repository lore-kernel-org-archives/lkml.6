Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751886AbeDGQQK (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 12:16:10 -0400
Received: from mga18.intel.com ([134.134.136.126]:46521 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751387AbeDGQQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 12:16:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,419,1517904000";
   d="scan'208";a="30891379"
From: Tomas Winkler <tomas.winkler@intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH] tpm: tpm_crb: relinquish locality on error path.
Date: Sat,  7 Apr 2018 19:12:36 +0300
Message-Id: <20180407161236.22969-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In crb_map_io() function, __crb_request_locality() is called prior
to crb_cmd_ready(), but if one of the consecutive function fails
the flow bails out instead of trying to relinquish locality.
This patch adds goto jump to __crb_relinquish_locality() on the error path.

Fixes: 888d867df441 (tpm: cmd_ready command can be issued only after granting locality)
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/char/tpm/tpm_crb.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index 7f78482cd157..34fbc6cb097b 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -511,8 +511,10 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 
 	priv->regs_t = crb_map_res(dev, priv, &io_res, buf->control_address,
 				   sizeof(struct crb_regs_tail));
-	if (IS_ERR(priv->regs_t))
-		return PTR_ERR(priv->regs_t);
+	if (IS_ERR(priv->regs_t)) {
+		ret = PTR_ERR(priv->regs_t);
+		goto out_relinquish_locality;
+	}
 
 	/*
 	 * PTT HW bug w/a: wake up the device to access
@@ -520,7 +522,7 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 	 */
 	ret = crb_cmd_ready(dev, priv);
 	if (ret)
-		return ret;
+		goto out_relinquish_locality;
 
 	pa_high = ioread32(&priv->regs_t->ctrl_cmd_pa_high);
 	pa_low  = ioread32(&priv->regs_t->ctrl_cmd_pa_low);
@@ -565,6 +567,8 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 
 	crb_go_idle(dev, priv);
 
+out_relinquish_locality:
+
 	__crb_relinquish_locality(dev, priv, 0);
 
 	return ret;
-- 
2.14.3
