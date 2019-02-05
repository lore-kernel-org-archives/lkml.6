Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBCEC282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECCCB20821
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbfBEJOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 04:14:10 -0500
Received: from mga06.intel.com ([134.134.136.31]:62072 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727828AbfBEJOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 04:14:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2019 01:14:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,562,1539673200"; 
   d="scan'208";a="124051370"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.172])
  by orsmga003.jf.intel.com with ESMTP; 05 Feb 2019 01:14:04 -0800
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, roberto.sassu@huawei.com,
        zohar@linux.ibm.com, jgg@ziepe.ca,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        stable@vger.kernel.org
Subject: [PATCH v3] tpm: Fix some name collisions with drivers/char/tpm.h
Date:   Tue,  5 Feb 2019 11:14:00 +0200
Message-Id: <20190205091400.29019-1-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Rename TPM_BUFSIZE defined in drivers/char/tpm/st33zp24/st33zp24.h to
  ST33ZP24_BUFSIZE.
* Rename TPM_BUFSIZE defined in drivers/char/tpm/tpm_i2c_infineon.c to
  TPM_I2C_INFINEON_BUFSIZE.
* Rename TPM_RETRY in tpm_i2c_nuvoton to TPM_I2C_RETRIES.
* Remove TPM_HEADER_SIZE from tpm_i2c_nuvoton.

Cc: stable@vger.kernel.org
Fixes: bf38b8710892 ("tpm/tpm_i2c_stm_st33: Split tpm_i2c_tpm_st33 in 2 layers (core + phy)")
Fixes: aad628c1d91a ("char/tpm: Add new driver for Infineon I2C TIS TPM")
Fixes: 32d33b29ba07 ("TPM: Retry SaveState command in suspend path")
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
v3:
* Fix two name collisions in tpm_i2c_nuvoton.
* Fix short summary.
* Fix compilation error in tpm_i2c_infineon (forgot to stage one diff
  to v2).
v2:
* Fix also the name collision in tpm_ic2_infineon.
 drivers/char/tpm/st33zp24/i2c.c      |  2 +-
 drivers/char/tpm/st33zp24/spi.c      |  2 +-
 drivers/char/tpm/st33zp24/st33zp24.h |  4 ++--
 drivers/char/tpm/tpm_i2c_infineon.c  | 15 ++++++++-------
 drivers/char/tpm/tpm_i2c_nuvoton.c   | 16 +++++++---------
 5 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/char/tpm/st33zp24/i2c.c b/drivers/char/tpm/st33zp24/i2c.c
index be5d1abd3e8e..8390c5b54c3b 100644
--- a/drivers/char/tpm/st33zp24/i2c.c
+++ b/drivers/char/tpm/st33zp24/i2c.c
@@ -33,7 +33,7 @@
 
 struct st33zp24_i2c_phy {
 	struct i2c_client *client;
-	u8 buf[TPM_BUFSIZE + 1];
+	u8 buf[ST33ZP24_BUFSIZE + 1];
 	int io_lpcpd;
 };
 
diff --git a/drivers/char/tpm/st33zp24/spi.c b/drivers/char/tpm/st33zp24/spi.c
index d7909ab287a8..ff019a1e3c68 100644
--- a/drivers/char/tpm/st33zp24/spi.c
+++ b/drivers/char/tpm/st33zp24/spi.c
@@ -63,7 +63,7 @@
  * some latency byte before the answer is available (max 15).
  * We have 2048 + 1024 + 15.
  */
-#define ST33ZP24_SPI_BUFFER_SIZE (TPM_BUFSIZE + (TPM_BUFSIZE / 2) +\
+#define ST33ZP24_SPI_BUFFER_SIZE (ST33ZP24_BUFSIZE + (ST33ZP24_BUFSIZE / 2) +\
 				  MAX_SPI_LATENCY)
 
 
diff --git a/drivers/char/tpm/st33zp24/st33zp24.h b/drivers/char/tpm/st33zp24/st33zp24.h
index 6f4a4198af6a..20da0a84988d 100644
--- a/drivers/char/tpm/st33zp24/st33zp24.h
+++ b/drivers/char/tpm/st33zp24/st33zp24.h
@@ -18,8 +18,8 @@
 #ifndef __LOCAL_ST33ZP24_H__
 #define __LOCAL_ST33ZP24_H__
 
-#define TPM_WRITE_DIRECTION             0x80
-#define TPM_BUFSIZE                     2048
+#define TPM_WRITE_DIRECTION	0x80
+#define ST33ZP24_BUFSIZE	2048
 
 struct st33zp24_dev {
 	struct tpm_chip *chip;
diff --git a/drivers/char/tpm/tpm_i2c_infineon.c b/drivers/char/tpm/tpm_i2c_infineon.c
index 9086edc9066b..3b490d9d90e7 100644
--- a/drivers/char/tpm/tpm_i2c_infineon.c
+++ b/drivers/char/tpm/tpm_i2c_infineon.c
@@ -26,8 +26,7 @@
 #include <linux/wait.h>
 #include "tpm.h"
 
-/* max. buffer size supported by our TPM */
-#define TPM_BUFSIZE 1260
+#define TPM_I2C_INFINEON_BUFSIZE 1260
 
 /* max. number of iterations after I2C NAK */
 #define MAX_COUNT 3
@@ -63,11 +62,13 @@ enum i2c_chip_type {
 	UNKNOWN,
 };
 
-/* Structure to store I2C TPM specific stuff */
 struct tpm_inf_dev {
 	struct i2c_client *client;
 	int locality;
-	u8 buf[TPM_BUFSIZE + sizeof(u8)]; /* max. buffer size + addr */
+	/* In addition to the data itself, the buffer must fit the 7-bit I2C
+	 * address and the direction bit.
+	 */
+	u8 buf[TPM_I2C_INFINEON_BUFSIZE + 1];
 	struct tpm_chip *chip;
 	enum i2c_chip_type chip_type;
 	unsigned int adapterlimit;
@@ -219,7 +220,7 @@ static int iic_tpm_write_generic(u8 addr, u8 *buffer, size_t len,
 		.buf = tpm_dev.buf
 	};
 
-	if (len > TPM_BUFSIZE)
+	if (len > TPM_I2C_INFINEON_BUFSIZE)
 		return -EINVAL;
 
 	if (!tpm_dev.client->adapter->algo->master_xfer)
@@ -527,8 +528,8 @@ static int tpm_tis_i2c_send(struct tpm_chip *chip, u8 *buf, size_t len)
 	u8 retries = 0;
 	u8 sts = TPM_STS_GO;
 
-	if (len > TPM_BUFSIZE)
-		return -E2BIG;	/* command is too long for our tpm, sorry */
+	if (len > TPM_I2C_INFINEON_BUFSIZE)
+		return -E2BIG;
 
 	if (request_locality(chip, 0) < 0)
 		return -EBUSY;
diff --git a/drivers/char/tpm/tpm_i2c_nuvoton.c b/drivers/char/tpm/tpm_i2c_nuvoton.c
index 217f7f1cbde8..5700cc2ddee1 100644
--- a/drivers/char/tpm/tpm_i2c_nuvoton.c
+++ b/drivers/char/tpm/tpm_i2c_nuvoton.c
@@ -35,14 +35,12 @@
 #include "tpm.h"
 
 /* I2C interface offsets */
-#define TPM_STS                0x00
-#define TPM_BURST_COUNT        0x01
-#define TPM_DATA_FIFO_W        0x20
-#define TPM_DATA_FIFO_R        0x40
-#define TPM_VID_DID_RID        0x60
-/* TPM command header size */
-#define TPM_HEADER_SIZE        10
-#define TPM_RETRY      5
+#define TPM_STS			0x00
+#define TPM_BURST_COUNT		0x01
+#define TPM_DATA_FIFO_W		0x20
+#define TPM_DATA_FIFO_R		0x40
+#define TPM_VID_DID_RID		0x60
+#define TPM_I2C_RETRIES		5
 /*
  * I2C bus device maximum buffer size w/o counting I2C address or command
  * i.e. max size required for I2C write is 34 = addr, command, 32 bytes data
@@ -292,7 +290,7 @@ static int i2c_nuvoton_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 		dev_err(dev, "%s() count < header size\n", __func__);
 		return -EIO;
 	}
-	for (retries = 0; retries < TPM_RETRY; retries++) {
+	for (retries = 0; retries < TPM_I2C_RETRIES; retries++) {
 		if (retries > 0) {
 			/* if this is not the first trial, set responseRetry */
 			i2c_nuvoton_write_status(client,
-- 
2.19.1

