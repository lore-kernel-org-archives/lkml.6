Return-Path: <sudipm.mukherjee@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518032888; cv=none;
        d=google.com; s=arc-20160816;
        b=GmEjwmLewXrS53YvB9vBY4JdYdKlTr2Z1kEqU/UHsUSaXIy/roKwtnuCWmf7eZhwah
         EIoR/CemeyZoUYIAJWkqIazQE+4O0d3iG4m68UngNOQrtTRYU1NVt1BHYs1yfpM4nDtI
         rh1xdilyTzE7g6WKeW2yy3JZ5ryceyltYYHeSmzELjUZyl3G0ZJkc2P5G7g+YailPuJs
         UcHdUybkpFqVELc7vfPRVAEKQz5TUNnrgQN4rv4N9O8mqGdnziX9lyx2OkKTQTUDS8xE
         cZ8p2VKUMX06gHLfJoCkDqt7fyaby+ELJGwgsVXSJCgrGgs/Bn0PDQ/dHEYs+YKNgFw6
         VjPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=qxMy8rlf3ap9tfgBMEL2dAI1bk45PJLbvVtBXb1JWyU=;
        b=P4W3GLmQEZf28uWKAquXA+RYmvNv0UnnqABSeXKS/fY2fNlQgPDBrNigqfe5NVCcFB
         s6Uc9S1dbXXbp4eT+OsVOkF4Pzicooad8KIvT6xSMIqf7PEIlbk6+on/aQb3iRhiRVwm
         vhstDBBNgj8XIjifS5D2BypyeVgXGyQ+MaxqyaRRsEG6T+xepYjfr+woLID+xhleI69p
         U8ezs2WXfM+8dYexdHnZSfy+6jXCsbDafjN74RaI1Ulh6oLTvKEDCQur6D61JzGZxCDs
         AZNAX7JfdK6UC0yAX663jPuULwUM3EzaLBjK0mQ9mXjgREy+R1adClJmd2FuAVraSk9z
         jZjA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=OkT2vJA/;
       spf=pass (google.com: domain of sudipm.mukherjee@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sudipm.mukherjee@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=OkT2vJA/;
       spf=pass (google.com: domain of sudipm.mukherjee@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sudipm.mukherjee@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x2260RZ0FvVMtRuXlvDlfgLSvyrKMIfHQPRw2P5wQH7f/f0r4/KRIL4pi1CJsHfEpkQ99uzInrA==
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 06/12] parport: Convert to use managed functions pcim_* and devm_*
Date: Wed,  7 Feb 2018 19:47:53 +0000
Message-Id: <1518032879-5844-6-git-send-email-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1518032879-5844-1-git-send-email-sudipm.mukherjee@gmail.com>
References: <1518032879-5844-1-git-send-email-sudipm.mukherjee@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591772853398225035?=
X-GMAIL-MSGID: =?utf-8?q?1591772853398225035?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

This makes the error handling much more simpler than open-coding everything
and in addition makes the probe function smaller an tidier.

Tested-by: Nikola Ciprich <nikola.ciprich@linuxbox.cz>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/parport/parport_serial.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/parport/parport_serial.c b/drivers/parport/parport_serial.c
index d0a5bc5..050eeb0 100644
--- a/drivers/parport/parport_serial.c
+++ b/drivers/parport/parport_serial.c
@@ -620,27 +620,23 @@ static int parport_serial_pci_probe(struct pci_dev *dev,
 	struct parport_serial_private *priv;
 	int err;
 
-	priv = kzalloc (sizeof *priv, GFP_KERNEL);
+	priv = devm_kzalloc(&dev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
+
 	pci_set_drvdata (dev, priv);
 
-	err = pci_enable_device (dev);
-	if (err) {
-		kfree (priv);
+	err = pcim_enable_device(dev);
+	if (err)
 		return err;
-	}
 
-	if (parport_register (dev, id)) {
-		kfree (priv);
+	if (parport_register(dev, id))
 		return -ENODEV;
-	}
 
 	if (serial_register (dev, id)) {
 		int i;
 		for (i = 0; i < priv->num_par; i++)
 			parport_pc_unregister_port (priv->port[i]);
-		kfree (priv);
 		return -ENODEV;
 	}
 
@@ -660,7 +656,6 @@ static void parport_serial_pci_remove(struct pci_dev *dev)
 	for (i = 0; i < priv->num_par; i++)
 		parport_pc_unregister_port (priv->port[i]);
 
-	kfree (priv);
 	return;
 }
 
-- 
2.7.4
