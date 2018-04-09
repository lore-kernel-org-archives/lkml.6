Return-Path: <baijiaju1990@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523286227; cv=none;
        d=google.com; s=arc-20160816;
        b=g6g09g1oK+bDcD4vAOVLGYYGL84yqIVUGqywKIEYvv80QT2A6qKQgvErhpmiJ2G/46
         Eoe37Rglj4+stwSpd8GlLv730/f/QCOAVHyDq5CE32vtVYKuRWVvmkEPZh33h1QB/r16
         o+3xKXeB40nIXo08COSq8eVahh1coem56zFT3dGjhwIxtKJTFAo83RSyykK3Ceyti4AM
         A+in8pNGNEeSSPDj2R3qHnTI/vL9YddVgvxtwocPBHXCormzmF100f/RAi0Sv4Ozktkp
         VBG8p40iTFiQTZRdEN9XOlG0NWflLrUOgE+ubB5/BiR3tj76Hj9JWVIODbapiLVb2RFH
         JG2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=ZXYPyUPFYwhXJy/Xb/U+NjeloED+l0xg9qUfo0SfosE=;
        b=vjLNhjz8ZJcKnKw02sFmMan2++apt57LmdQL9RrR/NrYgXftcU4v9pXafls8fq+5mc
         Kyk5HfHplIE/P4G9p98QRUapDHiCWwLoZCOCmLX69tjzE8w540czT78YUL1v/6QvACHZ
         ft9RYfsUFEawki1dOcg3FFwrENqVKx9muLmxBd7oxTiWaEJjnjhjOdr5fAcJagCHupgI
         P9mBk7C80PnLBYwbRH05+2LA+Q0e/5H/K6hzPjDf8+BxITSizugL4dHShV8r5gSv4mma
         YKOvftg2dz9UmgIT6EhK0/MvZPGGi3q3iEYO2sCjajEwfmbwTfpRxSmkp9yWag+0QMUN
         1C3A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=GStMIGOr;
       spf=pass (google.com: domain of baijiaju1990@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=baijiaju1990@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=GStMIGOr;
       spf=pass (google.com: domain of baijiaju1990@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=baijiaju1990@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4+pVhEBG0qup9zD9WW5S/mmEPclyxZcwwaBZrGAzWIqX3+1d1LY4f8whNow4UR6xAcGEYWJ0A==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: boris.ostrovsky@oracle.com,
	jgross@suse.com,
	gregkh@linuxfoundation.org
Cc: xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org,
	Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 1/4] xen: xen-pciback: Replace GFP_ATOMIC with GFP_KERNEL in pcistub_probe
Date: Mon,  9 Apr 2018 23:03:36 +0800
Message-Id: <1523286216-26345-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597281379484745930?=
X-GMAIL-MSGID: =?utf-8?q?1597281379484745930?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

pcistub_probe() is never called in atomic context.
This function is only set as ".probe" in struct pci_driver.

Despite never getting called from atomic context,
pcistub_probe() calls kmalloc() with GFP_ATOMIC,
which does not sleep for allocation.
GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL,
which can sleep and improve the possibility of sucessful allocation.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/xen/xen-pciback/pci_stub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/xen-pciback/pci_stub.c b/drivers/xen/xen-pciback/pci_stub.c
index 9e480fd..95e6ddd 100644
--- a/drivers/xen/xen-pciback/pci_stub.c
+++ b/drivers/xen/xen-pciback/pci_stub.c
@@ -577,7 +577,7 @@ static int pcistub_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		}
 
 		if (!match) {
-			pci_dev_id = kmalloc(sizeof(*pci_dev_id), GFP_ATOMIC);
+			pci_dev_id = kmalloc(sizeof(*pci_dev_id), GFP_KERNEL);
 			if (!pci_dev_id) {
 				err = -ENOMEM;
 				goto out;
-- 
1.9.1
