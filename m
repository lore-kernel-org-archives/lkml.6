Return-Path: <colin.king@canonical.com>
X-Google-Smtp-Source: AIpwx4/4aczN5Htxb/+ZgqA3tsYb8Vq08SqTCB3Suda12mj6bVv7B2uDECOSa9Z+G4xm0w2/C2i0
ARC-Seal: i=1; a=rsa-sha256; t=1523030745; cv=none;
        d=google.com; s=arc-20160816;
        b=F++RHbBDMcUYUL4FeXLKL7XrdiOAi65enihTtXpru+AqUf6Rt0vGGg6pfeC3YWmQdr
         ojDEuPzBhvIQ8t4Cbezle8ue5EZpJwBB9sMZqLgUbzP1Zz968opQNFLBHLylbbrsWqfi
         qjp4vgYBlYNJKMXB6p05SPHwf4tdo6OE3nMBdoWZ/bKSTG3O4/jR3goWCsMF4T0FTOTh
         BwrLfW/fx43kMeQ7lUl+lB9UqOlC/F3NslB33DvCsWZDduXvPk6zUvdxaiPek1eAVeuh
         Bhi/HdkDc3ojNJ9GG/eLiYR93MhvcHquSsJ+N4mVs/+MOh2AkNh9Fk42AC6P9glRvtH4
         DIvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:arc-authentication-results;
        bh=TVyIsjLGHEys34mfrmN9tPYE8FfXua2eNm8rj+tbWBU=;
        b=J3boLHVZNbLZvl+zbkwxdjuevJ1l1Oeuhh4VzZErfJowzLIdV/PIgLgW4N6KtTtuL+
         o6pYVzD9qPoOwU056BR1Rm0Van+p3IMGigFVE0oXcviIRbuGAjqV9BSwuMC5T1kW8UJ2
         pY3hKxmNkaPyMQuHvzlZXiOA4qeEDPNUGlDDcCquNP1okPEahU+c2fbM48eA2RkgkkXk
         /i1irYBswNLahdOAmcoc6xdVvJk4WLoFM/m+09LUURYyuVYsyn3uqHpcThwpf3ThSU9r
         KUK066gyByLCGD+9PNma2wUU0WcDGlgMxbVJQo1SVpEfDH2cWFR1ySM/hTBGZ+Ou0TEP
         k5Zg==
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
Subject: [PATCH] tpm: st33zp24: check if chip is null before dereferencing
Date: Fri,  6 Apr 2018 17:05:41 +0100
Message-Id: <20180406160541.8188-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597013487117318145?=
X-GMAIL-MSGID: =?utf-8?q?1597013487117318145?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Currently chip is being dereferenced by the call to dev_get_drvdata
before it is being null checked, hence we have a potential null
pointer dereference bug. Fix this by only dereferencing it after the
null check.

Detected by CoverityScan, CID#1357806 ("Dereference before null check")

Fixes: 9e0d39d8a6a0 ("tpm: Remove useless priv field in struct tpm_vendor_specific")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/char/tpm/st33zp24/st33zp24.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/st33zp24/st33zp24.c b/drivers/char/tpm/st33zp24/st33zp24.c
index f95b9c75175b..476865d66a0e 100644
--- a/drivers/char/tpm/st33zp24/st33zp24.c
+++ b/drivers/char/tpm/st33zp24/st33zp24.c
@@ -367,7 +367,7 @@ static irqreturn_t tpm_ioserirq_handler(int irq, void *dev_id)
 static int st33zp24_send(struct tpm_chip *chip, unsigned char *buf,
 			 size_t len)
 {
-	struct st33zp24_dev *tpm_dev = dev_get_drvdata(&chip->dev);
+	struct st33zp24_dev *tpm_dev;
 	u32 status, i, size, ordinal;
 	int burstcnt = 0;
 	int ret;
@@ -378,6 +378,7 @@ static int st33zp24_send(struct tpm_chip *chip, unsigned char *buf,
 	if (len < TPM_HEADER_SIZE)
 		return -EBUSY;
 
+	tpm_dev = dev_get_drvdata(&chip->dev);
 	ret = request_locality(chip);
 	if (ret < 0)
 		return ret;
-- 
2.15.1
