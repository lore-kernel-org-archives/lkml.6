Return-Path: <baijiaju1990@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523286241; cv=none;
        d=google.com; s=arc-20160816;
        b=SG/Q8GMAxWVEVv6mZ8+Hg9VJ0lSDIsOCs09zPwTLa//t4ANAF6o0wbzU3mpfersJuo
         QNGxexs5wo2PnIu+yiztxy0BGW7LPn00ckRh2ZZ8OqIiNVZ07V9s925Rl/poAFi5DAGF
         vMuxxLPcdMrE79O8hxg2z8kq6mNMV1heszPYLtmEjWNA/oLGMZV/PoR3p4NBLxt6XGI0
         +i+dfoHEVgGYGBWzGKZkY0QPIzqLCCRu5SjtrbE9BOSfnLimWy2kD1dH4fqyLQN28f0H
         tYMi0qF1dTcbbTwNQP3Nep9sqEt+6o8xeGbsLuqygYsMWnlnBBv0msC1NIl2nBgYwQjo
         2E6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=BXD7mZaw6n7Frr/mGvCeKqk3NudOAoZm/oyIbjL/Fsg=;
        b=rKjbVXLFeTp7ftW3bpFRW0l6soxyIQBJ6q7t+lgAEUu8QxiUhIOdqccuWRKA+bwudr
         BBFVG339PtTnjWQsbYPxYkvh2AEN0XMHw9KjEsta8dopjuLhmU3a1J4UvH47w3BJ7W29
         9pE2gQr9ave2pDuDWVGTU/jwTCicXzzG/mHiMfBwuKQeph0uUUFeIDT/7bDnV/wRjXg7
         OBANgxSjMyK/d2FV8gKirAzh9o8uz4Fkxr1cIuVrgyZfhg4aJyw0KOGDgBDD4LYmeIrM
         VeclMQepNt10Su4Urq6L3Ai387huWmZUbWGDF8JcRQ20vURiNueETQI+hLRl7PnUuS6T
         jKuw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=HdwMeUCu;
       spf=pass (google.com: domain of baijiaju1990@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=baijiaju1990@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=HdwMeUCu;
       spf=pass (google.com: domain of baijiaju1990@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=baijiaju1990@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4/c+DFpoeGXrd2Ox8tv4BLnW0L1d7ek3RvbBaFRrvSidr4Pi/MZ2WkE/zRgt9iuv+VwzW9Vkg==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: boris.ostrovsky@oracle.com,
	jgross@suse.com,
	gregkh@linuxfoundation.org
Cc: xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org,
	Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 2/4] xen: xen-pciback: Replace GFP_ATOMIC with GFP_KERNEL in pcistub_init_device
Date: Mon,  9 Apr 2018 23:03:53 +0800
Message-Id: <1523286233-26392-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597281393611063565?=
X-GMAIL-MSGID: =?utf-8?q?1597281393611063565?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

pcistub_init_device() is never called in atomic context.

The call chain ending up at pcistub_init_device() is:
[1] pcistub_init_device() <- pcistub_seize() <- pcistub_probe()
[2] pcistub_init_device() <- pcistub_init_devices_late() <- 
	xen_pcibk_init()
pcistub_probe() is only set as ".probe" in struct pci_driver.
xen_pcibk_init() is is only set as a parameter of module_init().
These functions are not called in atomic context.

Despite never getting called from atomic context,
pcistub_init_device() calls kzalloc() with GFP_ATOMIC,
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
index 9e480fd..bf8c0d3 100644
--- a/drivers/xen/xen-pciback/pci_stub.c
+++ b/drivers/xen/xen-pciback/pci_stub.c
@@ -364,7 +364,7 @@ static int pcistub_init_device(struct pci_dev *dev)
 	 * here and then to call kfree(pci_get_drvdata(psdev->dev)).
 	 */
 	dev_data = kzalloc(sizeof(*dev_data) +  strlen(DRV_NAME "[]")
-				+ strlen(pci_name(dev)) + 1, GFP_ATOMIC);
+				+ strlen(pci_name(dev)) + 1, GFP_KERNEL);
 	if (!dev_data) {
 		err = -ENOMEM;
 		goto out;
-- 
1.9.1
