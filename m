Return-Path: <arend.vanspriel@broadcom.com>
X-Google-Smtp-Source: AH8x2244MHAztF4C9ifFqQXJ7aixlvlklzaE3Nxd3wqMjHYHQGAauZiFlu/dNu4J/JIGwt1NK2jV
ARC-Seal: i=1; a=rsa-sha256; t=1519210242; cv=none;
        d=google.com; s=arc-20160816;
        b=HvPhhIKPYEQnRLZf8iMR3E49GTD5oXOq3zIAKUB65nB96jewII8mSoebayjdW0+QqR
         DiuCLzyES9d6Znwqt2kshhH6akc3hmVVJ/ob1WTH5VVtcBMdSJLP366JVUe5rkfhMWCI
         p12UaQdfunjAjeJ8ayOp8vVREHrbJGBUgToeq/BrA+CXDRZa/0Kz6otpysx5t/hFuG9v
         Mw5YA6dBH9FFctJ8dvAyDSrN6ngIWZRoYTDpsaDbhL132Xteh6iBD2W+wdLT+7v/pJgm
         q/ExloCyBe7yFeCHLYD31pYP9OgMnddPYaGMCLAqLVWi8t2w1RDU4NiGQU6XGil6HmqV
         djJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=/K7/NHOASgC/wM2XG2m2e3XJZCLYDUCK9CfXK+ni91E=;
        b=ZR/AA9r+X/HwMnroQ9UhIfkElF/A2o2XA15HCS898MtQ1dR4iEUbw1tqn2Eeb8KVPV
         MLPlWzbUUIyJfIiz5sdNKmHgIa+ONjUHbJMpnYPdBb+pwvv194GyOb9gkT/zOi2RETx1
         uStUAyqzaFwBWGeJzoNx6oPpYSitmhTt3KPbvumV0s+RVfAXInD4oX3ugs3NRcHoPDvT
         3TD8ead+1nSkFJ9I4rawHZOrCah2mcCnK7Aybszow37yRL939PzN+RwHjjLuu/5a3u3s
         DMxj4edvvLUouPPmiCGi6dKLCCShsxkgog9SXfyaV+wZo6M5HY9dunhyWTTd3xklthIx
         Vr/g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of arend.vanspriel@broadcom.com designates 192.19.229.170 as permitted sender) smtp.mailfrom=arend.vanspriel@broadcom.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=broadcom.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of arend.vanspriel@broadcom.com designates 192.19.229.170 as permitted sender) smtp.mailfrom=arend.vanspriel@broadcom.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=broadcom.com
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Kalle Valo <kvalo@codeaurora.org>,
	Marcel Holtmann <marcel@holtmann.org>
Cc: linux-wireless@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH 2/3] mwifiex: support sysfs initiated device coredump
Date: Wed, 21 Feb 2018 11:50:19 +0100
Message-Id: <1519210220-22437-3-git-send-email-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519210220-22437-1-git-send-email-arend.vanspriel@broadcom.com>
References: <1519210220-22437-1-git-send-email-arend.vanspriel@broadcom.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593007398864870404?=
X-GMAIL-MSGID: =?utf-8?q?1593007398864870404?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Since commit 3c47d19ff4dc ("drivers: base: add coredump driver ops")
it is possible to initiate a device coredump from user-space. This
patch adds support for it adding the .coredump() driver callback.
As there is no longer a need to initiate it through debugfs remove
that code.

Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 drivers/net/wireless/marvell/mwifiex/debugfs.c | 31 +-------------------------
 drivers/net/wireless/marvell/mwifiex/pcie.c    | 19 ++++++++++++++--
 drivers/net/wireless/marvell/mwifiex/sdio.c    | 13 +++++++++++
 drivers/net/wireless/marvell/mwifiex/usb.c     | 14 ++++++++++++
 4 files changed, 45 insertions(+), 32 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/debugfs.c b/drivers/net/wireless/marvell/mwifiex/debugfs.c
index db2872d..0745393 100644
--- a/drivers/net/wireless/marvell/mwifiex/debugfs.c
+++ b/drivers/net/wireless/marvell/mwifiex/debugfs.c
@@ -154,34 +154,6 @@
 }
 
 /*
- * Proc device dump read handler.
- *
- * This function is called when the 'device_dump' file is opened for
- * reading.
- * This function dumps driver information and firmware memory segments
- * (ex. DTCM, ITCM, SQRAM etc.) for
- * debugging.
- */
-static ssize_t
-mwifiex_device_dump_read(struct file *file, char __user *ubuf,
-			 size_t count, loff_t *ppos)
-{
-	struct mwifiex_private *priv = file->private_data;
-
-	/* For command timeouts, USB firmware will automatically emit
-	 * firmware dump events, so we don't implement device_dump().
-	 * For user-initiated dumps, we trigger it ourselves.
-	 */
-	if (priv->adapter->iface_type == MWIFIEX_USB)
-		mwifiex_send_cmd(priv, HostCmd_CMD_FW_DUMP_EVENT,
-				 HostCmd_ACT_GEN_SET, 0, NULL, true);
-	else
-		priv->adapter->if_ops.device_dump(priv->adapter);
-
-	return 0;
-}
-
-/*
  * Proc getlog file read handler.
  *
  * This function is called when the 'getlog' file is opened for reading
@@ -980,7 +952,6 @@
 MWIFIEX_DFS_FILE_READ_OPS(info);
 MWIFIEX_DFS_FILE_READ_OPS(debug);
 MWIFIEX_DFS_FILE_READ_OPS(getlog);
-MWIFIEX_DFS_FILE_READ_OPS(device_dump);
 MWIFIEX_DFS_FILE_OPS(regrdwr);
 MWIFIEX_DFS_FILE_OPS(rdeeprom);
 MWIFIEX_DFS_FILE_OPS(memrw);
@@ -1011,7 +982,7 @@
 	MWIFIEX_DFS_ADD_FILE(getlog);
 	MWIFIEX_DFS_ADD_FILE(regrdwr);
 	MWIFIEX_DFS_ADD_FILE(rdeeprom);
-	MWIFIEX_DFS_ADD_FILE(device_dump);
+
 	MWIFIEX_DFS_ADD_FILE(memrw);
 	MWIFIEX_DFS_ADD_FILE(hscfg);
 	MWIFIEX_DFS_ADD_FILE(histogram);
diff --git a/drivers/net/wireless/marvell/mwifiex/pcie.c b/drivers/net/wireless/marvell/mwifiex/pcie.c
index 97a6199..0959526 100644
--- a/drivers/net/wireless/marvell/mwifiex/pcie.c
+++ b/drivers/net/wireless/marvell/mwifiex/pcie.c
@@ -320,6 +320,20 @@ static void mwifiex_pcie_shutdown(struct pci_dev *pdev)
 	return;
 }
 
+static int mwifiex_pcie_coredump(struct device *dev)
+{
+	struct pci_dev *pdev;
+	struct pcie_service_card *card;
+
+	pdev = container_of(dev, struct pci_dev, dev);
+	card = pci_get_drvdata(pdev);
+
+	if (!test_and_set_bit(MWIFIEX_IFACE_WORK_DEVICE_DUMP,
+			      &card->work_flags))
+		schedule_work(&card->work);
+	return 0;
+}
+
 static const struct pci_device_id mwifiex_ids[] = {
 	{
 		PCIE_VENDOR_ID_MARVELL, PCIE_DEVICE_ID_MARVELL_88W8766P,
@@ -415,11 +429,12 @@ static SIMPLE_DEV_PM_OPS(mwifiex_pcie_pm_ops, mwifiex_pcie_suspend,
 	.id_table = mwifiex_ids,
 	.probe    = mwifiex_pcie_probe,
 	.remove   = mwifiex_pcie_remove,
-#ifdef CONFIG_PM_SLEEP
 	.driver   = {
+		.coredump = mwifiex_pcie_coredump,
+#ifdef CONFIG_PM_SLEEP
 		.pm = &mwifiex_pcie_pm_ops,
-	},
 #endif
+	},
 	.shutdown = mwifiex_pcie_shutdown,
 	.err_handler = &mwifiex_pcie_err_handler,
 };
diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wireless/marvell/mwifiex/sdio.c
index a828801..24b9ff3 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.c
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
@@ -466,6 +466,18 @@ static int mwifiex_sdio_suspend(struct device *dev)
 	return ret;
 }
 
+static int mwifiex_sdio_coredump(struct device *dev)
+{
+	struct sdio_func *func = dev_to_sdio_func(dev);
+	struct sdio_mmc_card *card;
+
+	card = sdio_get_drvdata(func);
+	if (!test_and_set_bit(MWIFIEX_IFACE_WORK_DEVICE_DUMP,
+			      &card->work_flags))
+		schedule_work(&card->work);
+	return 0;
+}
+
 /* Device ID for SD8786 */
 #define SDIO_DEVICE_ID_MARVELL_8786   (0x9116)
 /* Device ID for SD8787 */
@@ -515,6 +527,7 @@ static int mwifiex_sdio_suspend(struct device *dev)
 	.remove = mwifiex_sdio_remove,
 	.drv = {
 		.owner = THIS_MODULE,
+		.coredump = mwifiex_sdio_coredump,
 		.pm = &mwifiex_sdio_pm_ops,
 	}
 };
diff --git a/drivers/net/wireless/marvell/mwifiex/usb.c b/drivers/net/wireless/marvell/mwifiex/usb.c
index 4bc2448..83815f6 100644
--- a/drivers/net/wireless/marvell/mwifiex/usb.c
+++ b/drivers/net/wireless/marvell/mwifiex/usb.c
@@ -653,6 +653,17 @@ static void mwifiex_usb_disconnect(struct usb_interface *intf)
 	usb_put_dev(interface_to_usbdev(intf));
 }
 
+static int mwifiex_usb_coredump(struct device *dev)
+{
+	struct usb_interface *intf = to_usb_interface(dev);
+	struct usb_card_rec *card = usb_get_intfdata(intf);
+
+	mwifiex_send_cmd(mwifiex_get_priv(card->adapter, MWIFIEX_BSS_ROLE_ANY),
+			 HostCmd_CMD_FW_DUMP_EVENT, HostCmd_ACT_GEN_SET, 0,
+			 NULL, true);
+	return 0;
+}
+
 static struct usb_driver mwifiex_usb_driver = {
 	.name = "mwifiex_usb",
 	.probe = mwifiex_usb_probe,
@@ -661,6 +672,9 @@ static void mwifiex_usb_disconnect(struct usb_interface *intf)
 	.suspend = mwifiex_usb_suspend,
 	.resume = mwifiex_usb_resume,
 	.soft_unbind = 1,
+	.drvwrap.driver = {
+		.coredump = mwifiex_usb_coredump,
+	},
 };
 
 static int mwifiex_write_data_sync(struct mwifiex_adapter *adapter, u8 *pbuf,
-- 
1.9.1
