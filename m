Return-Path: <sudipm.mukherjee@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518032887; cv=none;
        d=google.com; s=arc-20160816;
        b=HIOaqCNfdk74bpQ3zt8ocndu5iXh+sMpkvNnl4/OXAmlISM42uSJrOop3o5cm6ZUyw
         EAtmGMBwReoB2mYfJ8C4AsoZhmWwEfjuDusUMdonfPiYV+V3uG7DNJDUXNDoLVvtGL5B
         UcJFF1UVJYyCnifI1HaeEqs9pxXMy2fSQX12eQPpwNbEzgi0w3VZHBowvSiUHVCN30UJ
         GlkqGKQs578zSxL8qzYgepSsdAFGPowPIszJ6OMcBoC7tV451JN6xm1FmgVcj0YKnKo+
         1f+sjnmKxRAReMPvD+vYFD18IKjAiVwFJA4K//s75vqTSEuBE+0DvIEQKcxqOcCf1gZM
         GwlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=14Zl1FQlJrUUERtDPClgfg1aoAi4immGz2CuSNtXJko=;
        b=n/X7el4V3mBubuBISDrm8fUCBLvTgzZH538ev0HP5kVyRHSrYnbFHtC9ZXFdOTAL0b
         ec4qRK0A86HldXsR/O/JLSveUjFiyFdglZC3Mb15W/2wyA/oTUWtk2mSKch1PoCGnsOH
         CjAVbck0maXgRc+4Glc/wRMVBEEf9FWM2Q/C8M9gawT4RtCAxT8FvHfYOMu0su7xx7vf
         4uZsjcpm7LBFdaAIgJOk52Tev1DWaTS7KsmIQoBxD74lk4nOlQX+k3yFn7/8qPLg4jPq
         E2H54Ia0O3S/1F2gQh1VOgKTX1/gnOWCaQV37qUuksSRVmBB0STZD3hheQWTeiLJ7UPM
         eBWw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=cSBwwqYz;
       spf=pass (google.com: domain of sudipm.mukherjee@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sudipm.mukherjee@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=cSBwwqYz;
       spf=pass (google.com: domain of sudipm.mukherjee@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sudipm.mukherjee@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x22528Ns5ge06N7TNTUjBShQ1o4TmlL61iTC+Ef/Peam4gpAW/LP7nr4z/rJhC8GrYIHiO4Dyfw==
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 05/12] parport: PCI core handles power state for us
Date: Wed,  7 Feb 2018 19:47:52 +0000
Message-Id: <1518032879-5844-5-git-send-email-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1518032879-5844-1-git-send-email-sudipm.mukherjee@gmail.com>
References: <1518032879-5844-1-git-send-email-sudipm.mukherjee@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591772852855463970?=
X-GMAIL-MSGID: =?utf-8?q?1591772852855463970?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andy Shevchenko <andy.shevchenko@gmail.com>

There is no need to repeat the work that is already done in the PCI
driver core. The patch removes excerpts from suspend and resume
callbacks.

Note that there is no more calls performed to enable or disable a PCI
device during suspend-resume cycle. Nowadays they seems to be
superflous. Someone can read more in [1].

While here, convert calls to new driver API.

[1] https://www.kernel.org/doc/ols/2009/ols2009-pages-319-330.pdf

Tested-by: Nikola Ciprich <nikola.ciprich@linuxbox.cz>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/parport/parport_serial.c | 40 ++++++++++++----------------------------
 1 file changed, 12 insertions(+), 28 deletions(-)

diff --git a/drivers/parport/parport_serial.c b/drivers/parport/parport_serial.c
index 53a3eae..d0a5bc5 100644
--- a/drivers/parport/parport_serial.c
+++ b/drivers/parport/parport_serial.c
@@ -664,57 +664,41 @@ static void parport_serial_pci_remove(struct pci_dev *dev)
 	return;
 }
 
-#ifdef CONFIG_PM
-static int parport_serial_pci_suspend(struct pci_dev *dev, pm_message_t state)
+static int __maybe_unused parport_serial_pci_suspend(struct device *dev)
 {
-	struct parport_serial_private *priv = pci_get_drvdata(dev);
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct parport_serial_private *priv = pci_get_drvdata(pdev);
 
 	if (priv->serial)
 		pciserial_suspend_ports(priv->serial);
 
 	/* FIXME: What about parport? */
-
-	pci_save_state(dev);
-	pci_set_power_state(dev, pci_choose_state(dev, state));
 	return 0;
 }
 
-static int parport_serial_pci_resume(struct pci_dev *dev)
+static int __maybe_unused parport_serial_pci_resume(struct device *dev)
 {
-	struct parport_serial_private *priv = pci_get_drvdata(dev);
-	int err;
-
-	pci_set_power_state(dev, PCI_D0);
-	pci_restore_state(dev);
-
-	/*
-	 * The device may have been disabled.  Re-enable it.
-	 */
-	err = pci_enable_device(dev);
-	if (err) {
-		printk(KERN_ERR "parport_serial: %s: error enabling "
-			"device for resume (%d)\n", pci_name(dev), err);
-		return err;
-	}
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct parport_serial_private *priv = pci_get_drvdata(pdev);
 
 	if (priv->serial)
 		pciserial_resume_ports(priv->serial);
 
 	/* FIXME: What about parport? */
-
 	return 0;
 }
-#endif
+
+static SIMPLE_DEV_PM_OPS(parport_serial_pm_ops,
+			 parport_serial_pci_suspend, parport_serial_pci_resume);
 
 static struct pci_driver parport_serial_pci_driver = {
 	.name		= "parport_serial",
 	.id_table	= parport_serial_pci_tbl,
 	.probe		= parport_serial_pci_probe,
 	.remove		= parport_serial_pci_remove,
-#ifdef CONFIG_PM
-	.suspend	= parport_serial_pci_suspend,
-	.resume		= parport_serial_pci_resume,
-#endif
+	.driver         = {
+		.pm     = &parport_serial_pm_ops,
+	},
 };
 
 
-- 
2.7.4
