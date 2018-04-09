Return-Path: <baijiaju1990@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523286273; cv=none;
        d=google.com; s=arc-20160816;
        b=R9DHtAUOFcXikIviDYEju35sujvFtmCQEc8dBeB9g8eWZ6GeHsda6NaSNseKoGyhlb
         8poILBC9yShIeKcmmoKD4YdZH4x1dkqvRMVgiJXpKF9F/rhUD7injjOJwhMC2rr9MGLe
         rZc0BgTe3BsNMDhEWMDvQ7Mj9rpOdwHqHXmr9jvynnP4h5K7E83aD6JprvWC0lJnCSgN
         YoCeeaX+wvRaUZfhbf7jcWVdeJ7suonxJEiAxJjI5JAJM6feNiKvjsV5/gCm2PyILm8w
         rG0Jc0kZxdWjPqB7fK/VpkfvO4f0PBbOZpT5MEtZRcBMKaXMc8PTB3EUti5RKw0DcbIf
         uZtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=HEA4yhbWURGN1SuyljplXkLYK/2wPIn7mLIwgffK+bk=;
        b=GevZeDMfZKMnrKTR/BlfG4FqBeV1K5VuKZ1NNgAg7y7kKuuIU6j7eAjQqnwCDSsKdS
         tXbr3VhNdB/nBXiF/FK1FdZYYOCjdMzJ3appIE01jQ4MGFpRbXc2SM8FbdG0HsDC6ckn
         xcvZQRUuo/AZU0/ozOs/4VECEQMpwjsMLSOlW1bL9CRiFpX/7ph635LudyJeleMJOR8u
         Jr/WbJB0KChCUcYvPIxgLoJ/zKrD2pyTah6rfoDvXKLhaODGHrX/oAnhQkf66GU3EvOw
         MA2pnl0y683acqdrcsTmWpIMqNMCpm6r8OBuSvcEe7h3SHr4Esjddixm666S93QZJn6K
         KAXw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=I304OD2+;
       spf=pass (google.com: domain of baijiaju1990@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=baijiaju1990@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=I304OD2+;
       spf=pass (google.com: domain of baijiaju1990@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=baijiaju1990@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx48KvNv0GvFU79LwxqyLBbCx4+6IRyGApSU3vaEp/CQIZTKt+WAqCqKr/VKjHMo8zXDCgqEA5w==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: boris.ostrovsky@oracle.com,
	jgross@suse.com,
	gregkh@linuxfoundation.org
Cc: xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org,
	Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 4/4] xen: xen-pciback: Replace GFP_ATOMIC with GFP_KERNEL in xen_pcibk_config_quirks_init
Date: Mon,  9 Apr 2018 23:04:25 +0800
Message-Id: <1523286265-26501-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597281427505336972?=
X-GMAIL-MSGID: =?utf-8?q?1597281427505336972?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

xen_pcibk_config_quirks_init() is never called in atomic context.

The call chains ending up at xen_pcibk_config_quirks_init() are:
[1] xen_pcibk_config_quirks_init() <- xen_pcibk_config_init_dev() <- 
	pcistub_init_device() <- pcistub_seize() <- pcistub_probe()
[2] xen_pcibk_config_quirks_init() <- xen_pcibk_config_init_dev() <- 
	pcistub_init_device() <- pcistub_init_devices_late() <- 
	xen_pcibk_init()
pcistub_probe() is only set as ".probe" in struct pci_driver.
xen_pcibk_init() is is only set as a parameter of module_init().
These functions are not called in atomic context.

Despite never getting called from atomic context,
xen_pcibk_config_quirks_init() calls kzalloc() with GFP_ATOMIC,
which does not sleep for allocation.
GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL,
which can sleep and improve the possibility of sucessful allocation.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/xen/xen-pciback/conf_space_quirks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/xen-pciback/conf_space_quirks.c b/drivers/xen/xen-pciback/conf_space_quirks.c
index 7476791..e3df3f9 100644
--- a/drivers/xen/xen-pciback/conf_space_quirks.c
+++ b/drivers/xen/xen-pciback/conf_space_quirks.c
@@ -94,7 +94,7 @@ int xen_pcibk_config_quirks_init(struct pci_dev *dev)
 	struct xen_pcibk_config_quirk *quirk;
 	int ret = 0;
 
-	quirk = kzalloc(sizeof(*quirk), GFP_ATOMIC);
+	quirk = kzalloc(sizeof(*quirk), GFP_KERNEL);
 	if (!quirk) {
 		ret = -ENOMEM;
 		goto out;
-- 
1.9.1
