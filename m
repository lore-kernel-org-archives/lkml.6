Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934925AbeCEMwC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 07:52:02 -0500
Received: from mga17.intel.com ([192.55.52.151]:27472 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933902AbeCEMv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 07:51:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,426,1515484800";
   d="scan'208";a="179983168"
From: Tomas Winkler <tomas.winkler@intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH 2/2] tpm: fix buffer type in tpm_transimt/_cmd
Date: Mon,  5 Mar 2018 14:48:26 +0200
Message-Id: <20180305124826.5160-2-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180305124826.5160-1-tomas.winkler@intel.com>
References: <20180305124826.5160-1-tomas.winkler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. The buffer cannot be const as it is used both for send and receive.
2. Drop useless casting to u8 *, as this is already a
type of 'buf' parameter, it has just masked the 'const' issue.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/char/tpm/tpm-interface.c | 8 ++++----
 drivers/char/tpm/tpm.h           | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index cafec634181a..4afd95c83612 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -475,7 +475,7 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
 	if (rc)
 		goto out;
 
-	rc = chip->ops->send(chip, (u8 *) buf, count);
+	rc = chip->ops->send(chip, buf, count);
 	if (rc < 0) {
 		if (rc != -EPIPE)
 			dev_err(&chip->dev,
@@ -512,7 +512,7 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
 	goto out;
 
 out_recv:
-	len = chip->ops->recv(chip, (u8 *) buf, bufsiz);
+	len = chip->ops->recv(chip, buf, bufsiz);
 	if (len < 0) {
 		rc = len;
 		dev_err(&chip->dev,
@@ -567,7 +567,7 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
  *     A positive number for a TPM error.
  */
 ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_space *space,
-			 const void *buf, size_t bufsiz,
+			 void *buf, size_t bufsiz,
 			 size_t min_rsp_body_length, unsigned int flags,
 			 const char *desc)
 {
@@ -575,7 +575,7 @@ ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_space *space,
 	int err;
 	ssize_t len;
 
-	len = tpm_transmit(chip, space, (u8 *)buf, bufsiz, flags);
+	len = tpm_transmit(chip, space, buf, bufsiz, flags);
 	if (len <  0)
 		return len;
 
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index b82b924d763c..50dcbf3b60aa 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -520,7 +520,7 @@ enum tpm_transmit_flags {
 ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
 		     u8 *buf, size_t bufsiz, unsigned int flags);
 ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_space *space,
-			 const void *buf, size_t bufsiz,
+			 void *buf, size_t bufsiz,
 			 size_t min_rsp_body_length, unsigned int flags,
 			 const char *desc);
 int tpm_startup(struct tpm_chip *chip);
-- 
2.14.3
