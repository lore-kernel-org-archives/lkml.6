Return-Path: <colin.king@canonical.com>
X-Google-Smtp-Source: AIpwx4+CwT1BdmCo412t5alavUddAQrsE3s3ZkQIX9pPzzxAQbwgkCVWm0vhvcdbY6qSGm0XH74A
ARC-Seal: i=1; a=rsa-sha256; t=1523031706; cv=none;
        d=google.com; s=arc-20160816;
        b=L+MYrLRpxPB+ZleLog6jScATBRnObTjbpnVHR7RJW0EG4AXR3SHPHC0pp+f9n4/ua8
         fksTCjbaSuQPvUBZrEux0tn4gIcgUoE0tAEu/cWMTX1NDnfBwQfdV25X02oEH6l5Alft
         EFMjPmwoQUF3zvCLxtU/+E3qK8B74mqeIuWOre3e96JJPIymI0ZFQ3efknuxCpQORMAC
         PXdje1v68zctY84wXANO6T4/6oBLrkfUvvWWyBjTilSRqKAmKApwmbEADBSqnD/q3Ass
         vVHdOg7ErMCTJCXaV3XHf9ZQ2S9mLfRdv2As05CIdU2u4slDLzzw9xo+x1+riEsAP9P8
         aXRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:arc-authentication-results;
        bh=u/SQU1lkYzVGbf8K7TxLHT8P/TmCLdKNjtuVDN2HLsk=;
        b=g5eCIgrxBjzUELXjIBi+dGp2HytYSDTRZJaY+0bx+QXQarB1i9mTtgk1l+VdlgMa09
         1zOuRhPp8ES3gmGjNbAFq9mJFEh/boptHruJ1QXV4flmu+Z4+ASBAXT1FJHP32wU3W3R
         ejImnIshkeZqDHxmmyU+XFYaQM1+/0NEltbf1VlUvxjd9pRgkXfPfzzetnvgqA/0Hs84
         /HTTlXEzjD7Km3FuQc9J7xZTsMO5T+y5LTPqVp1bNBbXSBMVK9F+XPIGvydoEmGf+bOr
         /aNLBW5hYWDaPvX+ZNNRtVNyx2f32tHh/CmQj6x3SU0L4lxjlJ7iDM1dDDgjXdhUHTnZ
         C5UQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of colin.king@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=colin.king@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of colin.king@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=colin.king@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
From: Colin King <colin.king@canonical.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-integrity@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tpm: st33zp24: remove redundant null check on chip
Date: Fri,  6 Apr 2018 17:21:44 +0100
Message-Id: <20180406162144.14717-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597014495178816118?=
X-GMAIL-MSGID: =?utf-8?q?1597014495178816118?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Currently chip is being dereferenced by the call to dev_get_drvdata
before it is being null checked, however, chip can never be null, so
this check is misleading and redundant. Remove it.

Detected by CoverityScan, CID#1357806 ("Dereference before null check")

Signed-off-by: Colin Ian King <colin.king@canonical.com>

---

V2: don't check for null, just remove redundant null check,
    thanks to Jason Gunthorpe for spotting that.

---
 drivers/char/tpm/st33zp24/st33zp24.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/char/tpm/st33zp24/st33zp24.c b/drivers/char/tpm/st33zp24/st33zp24.c
index f95b9c75175b..abd675bec88c 100644
--- a/drivers/char/tpm/st33zp24/st33zp24.c
+++ b/drivers/char/tpm/st33zp24/st33zp24.c
@@ -373,8 +373,6 @@ static int st33zp24_send(struct tpm_chip *chip, unsigned char *buf,
 	int ret;
 	u8 data;
 
-	if (!chip)
-		return -EBUSY;
 	if (len < TPM_HEADER_SIZE)
 		return -EBUSY;
 
-- 
2.15.1
