Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754677AbeBPIic (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 03:38:32 -0500
Received: from mga04.intel.com ([192.55.52.120]:58656 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754538AbeBPIib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 03:38:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,519,1511856000";
   d="scan'208";a="18189246"
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] tpm: rename TPM_TRANSMIT_RAW -> TPM_TRANSMIT_IGNORE_LOCALITY
Date: Fri, 16 Feb 2018 10:38:18 +0200
Message-Id: <20180216083818.5483-1-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous name does not give any picture of the behaviour.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/char/tpm/tpm-interface.c  | 2 +-
 drivers/char/tpm/tpm.h            | 4 ++--
 drivers/char/tpm/tpm_vtpm_proxy.c | 3 ++-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 9e80a953d693..b355f9a0307b 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -431,7 +431,7 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
 	/* Store the decision as chip->locality will be changed. */
 	need_locality = chip->locality == -1;
 
-	if (!(flags & TPM_TRANSMIT_RAW) &&
+	if (!(flags & TPM_TRANSMIT_IGNORE_LOCALITY) &&
 	    need_locality && chip->ops->request_locality)  {
 		rc = chip->ops->request_locality(chip, 0);
 		if (rc < 0)
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index f895fba4e20d..1b7625623a8f 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -499,8 +499,8 @@ extern const struct file_operations tpmrm_fops;
 extern struct idr dev_nums_idr;
 
 enum tpm_transmit_flags {
-	TPM_TRANSMIT_UNLOCKED	= BIT(0),
-	TPM_TRANSMIT_RAW	= BIT(1),
+	TPM_TRANSMIT_UNLOCKED		= BIT(0),
+	TPM_TRANSMIT_IGNORE_LOCALITY	= BIT(1),
 };
 
 ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_proxy.c
index 1d877cc9af97..f36eaf8d57ff 100644
--- a/drivers/char/tpm/tpm_vtpm_proxy.c
+++ b/drivers/char/tpm/tpm_vtpm_proxy.c
@@ -418,7 +418,8 @@ static int vtpm_proxy_request_locality(struct tpm_chip *chip, int locality)
 	proxy_dev->state |= STATE_DRIVER_COMMAND;
 
 	rc = tpm_transmit_cmd(chip, NULL, buf.data, tpm_buf_length(&buf), 0,
-			      TPM_TRANSMIT_UNLOCKED | TPM_TRANSMIT_RAW,
+			      TPM_TRANSMIT_UNLOCKED |
+			      TPM_TRANSMIT_IGNORE_LOCALITY,
 			      "attempting to set locality");
 
 	proxy_dev->state &= ~STATE_DRIVER_COMMAND;
-- 
2.14.1
