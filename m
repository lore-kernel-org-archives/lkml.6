Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47009C282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F45820855
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbfBHQDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 11:03:46 -0500
Received: from mga03.intel.com ([134.134.136.65]:39663 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbfBHQDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 11:03:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Feb 2019 08:03:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,348,1544515200"; 
   d="scan'208";a="141803320"
Received: from shivamur-mobl1.gar.corp.intel.com (HELO localhost) ([10.249.254.162])
  by fmsmga002.fm.intel.com with ESMTP; 08 Feb 2019 08:03:39 -0800
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Peter Huewe <PeterHuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        stable@vger.kernel.org
Subject: [PATCH v2 1/2] tpm: Unify the send callback behaviour
Date:   Fri,  8 Feb 2019 18:03:27 +0200
Message-Id: <20190208160328.18715-2-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190208160328.18715-1-jarkko.sakkinen@linux.intel.com>
References: <20190208160328.18715-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The send() callback should never return length as it does not in every
driver except tpm_crb in the success case. The reason is that the main
transmit functionality only cares about whether the transmit was
successful or not and ignores the count completely.

Cc: stable@vger.kernel.org
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/char/tpm/st33zp24/st33zp24.c | 2 +-
 drivers/char/tpm/tpm_atmel.c         | 2 +-
 drivers/char/tpm/tpm_i2c_atmel.c     | 6 +++++-
 drivers/char/tpm/tpm_i2c_infineon.c  | 2 +-
 drivers/char/tpm/tpm_i2c_nuvoton.c   | 2 +-
 drivers/char/tpm/tpm_ibmvtpm.c       | 2 +-
 drivers/char/tpm/tpm_infineon.c      | 2 +-
 drivers/char/tpm/tpm_nsc.c           | 2 +-
 drivers/char/tpm/tpm_vtpm_proxy.c    | 3 +--
 drivers/char/tpm/xen-tpmfront.c      | 2 +-
 10 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/char/tpm/st33zp24/st33zp24.c b/drivers/char/tpm/st33zp24/st33zp24.c
index 64dc560859f2..13dc614b7ebc 100644
--- a/drivers/char/tpm/st33zp24/st33zp24.c
+++ b/drivers/char/tpm/st33zp24/st33zp24.c
@@ -436,7 +436,7 @@ static int st33zp24_send(struct tpm_chip *chip, unsigned char *buf,
 			goto out_err;
 	}
 
-	return len;
+	return 0;
 out_err:
 	st33zp24_cancel(chip);
 	release_locality(chip);
diff --git a/drivers/char/tpm/tpm_atmel.c b/drivers/char/tpm/tpm_atmel.c
index 66a14526aaf4..a290b30a0c35 100644
--- a/drivers/char/tpm/tpm_atmel.c
+++ b/drivers/char/tpm/tpm_atmel.c
@@ -105,7 +105,7 @@ static int tpm_atml_send(struct tpm_chip *chip, u8 *buf, size_t count)
 		iowrite8(buf[i], priv->iobase);
 	}
 
-	return count;
+	return 0;
 }
 
 static void tpm_atml_cancel(struct tpm_chip *chip)
diff --git a/drivers/char/tpm/tpm_i2c_atmel.c b/drivers/char/tpm/tpm_i2c_atmel.c
index 4720b2442ffe..aa11c8a1df5e 100644
--- a/drivers/char/tpm/tpm_i2c_atmel.c
+++ b/drivers/char/tpm/tpm_i2c_atmel.c
@@ -65,7 +65,11 @@ static int i2c_atmel_send(struct tpm_chip *chip, u8 *buf, size_t len)
 	dev_dbg(&chip->dev,
 		"%s(buf=%*ph len=%0zx) -> sts=%d\n", __func__,
 		(int)min_t(size_t, 64, len), buf, len, status);
-	return status;
+
+	if (status < 0)
+		return status;
+
+	return 0;
 }
 
 static int i2c_atmel_recv(struct tpm_chip *chip, u8 *buf, size_t count)
diff --git a/drivers/char/tpm/tpm_i2c_infineon.c b/drivers/char/tpm/tpm_i2c_infineon.c
index 3b490d9d90e7..3b4e9672ff6c 100644
--- a/drivers/char/tpm/tpm_i2c_infineon.c
+++ b/drivers/char/tpm/tpm_i2c_infineon.c
@@ -588,7 +588,7 @@ static int tpm_tis_i2c_send(struct tpm_chip *chip, u8 *buf, size_t len)
 	/* go and do it */
 	iic_tpm_write(TPM_STS(tpm_dev.locality), &sts, 1);
 
-	return len;
+	return 0;
 out_err:
 	tpm_tis_i2c_ready(chip);
 	/* The TPM needs some time to clean up here,
diff --git a/drivers/char/tpm/tpm_i2c_nuvoton.c b/drivers/char/tpm/tpm_i2c_nuvoton.c
index 5700cc2ddee1..315a3b4548f7 100644
--- a/drivers/char/tpm/tpm_i2c_nuvoton.c
+++ b/drivers/char/tpm/tpm_i2c_nuvoton.c
@@ -465,7 +465,7 @@ static int i2c_nuvoton_send(struct tpm_chip *chip, u8 *buf, size_t len)
 	}
 
 	dev_dbg(dev, "%s() -> %zd\n", __func__, len);
-	return len;
+	return 0;
 }
 
 static bool i2c_nuvoton_req_canceled(struct tpm_chip *chip, u8 status)
diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
index 07b5a487d0c8..aeae3222723c 100644
--- a/drivers/char/tpm/tpm_ibmvtpm.c
+++ b/drivers/char/tpm/tpm_ibmvtpm.c
@@ -192,7 +192,7 @@ static int tpm_ibmvtpm_send(struct tpm_chip *chip, u8 *buf, size_t count)
 		rc = 0;
 		ibmvtpm->tpm_processing_cmd = false;
 	} else
-		rc = count;
+		rc = 0;
 
 	spin_unlock(&ibmvtpm->rtce_lock);
 	return rc;
diff --git a/drivers/char/tpm/tpm_infineon.c b/drivers/char/tpm/tpm_infineon.c
index d8f10047fbba..97f6d4fe0aee 100644
--- a/drivers/char/tpm/tpm_infineon.c
+++ b/drivers/char/tpm/tpm_infineon.c
@@ -354,7 +354,7 @@ static int tpm_inf_send(struct tpm_chip *chip, u8 * buf, size_t count)
 	for (i = 0; i < count; i++) {
 		wait_and_send(chip, buf[i]);
 	}
-	return count;
+	return 0;
 }
 
 static void tpm_inf_cancel(struct tpm_chip *chip)
diff --git a/drivers/char/tpm/tpm_nsc.c b/drivers/char/tpm/tpm_nsc.c
index 5d6cce74cd3f..9bee3c5eb4bf 100644
--- a/drivers/char/tpm/tpm_nsc.c
+++ b/drivers/char/tpm/tpm_nsc.c
@@ -226,7 +226,7 @@ static int tpm_nsc_send(struct tpm_chip *chip, u8 * buf, size_t count)
 	}
 	outb(NSC_COMMAND_EOC, priv->base + NSC_COMMAND);
 
-	return count;
+	return 0;
 }
 
 static void tpm_nsc_cancel(struct tpm_chip *chip)
diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_proxy.c
index 26a2be555288..d74f3de74ae6 100644
--- a/drivers/char/tpm/tpm_vtpm_proxy.c
+++ b/drivers/char/tpm/tpm_vtpm_proxy.c
@@ -335,7 +335,6 @@ static int vtpm_proxy_is_driver_command(struct tpm_chip *chip,
 static int vtpm_proxy_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t count)
 {
 	struct proxy_dev *proxy_dev = dev_get_drvdata(&chip->dev);
-	int rc = 0;
 
 	if (count > sizeof(proxy_dev->buffer)) {
 		dev_err(&chip->dev,
@@ -366,7 +365,7 @@ static int vtpm_proxy_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t count)
 
 	wake_up_interruptible(&proxy_dev->wq);
 
-	return rc;
+	return 0;
 }
 
 static void vtpm_proxy_tpm_op_cancel(struct tpm_chip *chip)
diff --git a/drivers/char/tpm/xen-tpmfront.c b/drivers/char/tpm/xen-tpmfront.c
index 1259e935fd58..4e2d00cb0d81 100644
--- a/drivers/char/tpm/xen-tpmfront.c
+++ b/drivers/char/tpm/xen-tpmfront.c
@@ -173,7 +173,7 @@ static int vtpm_send(struct tpm_chip *chip, u8 *buf, size_t count)
 		return -ETIME;
 	}
 
-	return count;
+	return 0;
 }
 
 static int vtpm_recv(struct tpm_chip *chip, u8 *buf, size_t count)
-- 
2.19.1

