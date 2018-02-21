Return-Path: <arend.vanspriel@broadcom.com>
X-Google-Smtp-Source: AH8x2274z6d+8Lb1Om5rOtZx8oacg3snMow4tgLNXGpek8bQqVG/usHtslwK1fa9p4x6obrxTRW3
ARC-Seal: i=1; a=rsa-sha256; t=1519210242; cv=none;
        d=google.com; s=arc-20160816;
        b=dVwS2ZVu3JQI4J7T82XsIkSrsLztoZVAiyRkb53sW0pmumqhcUFVlRZh3qJoqWDQGG
         38Tc946Oy9BlzcsTd23UOhRNN0nWsnBAX8XqDAJ+gEi4M1zzeugG6M3eJYndHxLFDpcu
         3fkb/34rwcduGzjbC8y9wbeEFH2WA0TupFSH+YUCc2EBKKYXVSYYGmjf7lEwBhH2hD6S
         +4uvLXtfQ9ZeEurnoEM3Q5kmF/L3jHOap91mxDts2wAuI5BT1SLhr5att7U0N2t7iHNv
         QCb3yIca7fPJeu/mX3YCz43as/R25H27Q9TqXwuDEk6M0Qb49su40gHs9IgirHy5rDDC
         I7zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=JFL1UWdNvvwNfSWuKSTcxS0iY+jbR2m6ultW5AVgoNI=;
        b=fSqZnko1HL9rJ9frKTziylYO9K8lowAFBpwV6kN7qKCUpdYBx8ohFNks/Lv1UJ3utq
         bcTRBGtBvUxU9f05XRJBr5Uc6tHaUlbgqIMYhe/acp3kvLwQ29si9UQWtVqxYKr3NOh6
         uhSO/gUn+FzV+jo9Acb63/5RTNOXYKJ1p/pJD9dMxWqyZMPhPlXAZdFv6KChzAiyWMau
         5tNtcczn07uXGfYPISeKeospvDpUDBzRWXVB3alC0R+hb8rov4hxhmRUSdbYJB6KCkUl
         EXhAV9H87RfsjS6tfP9zIqVMU5elYVWF0UMuCJWh5KW3aekF0HLO7Kxt5fXd4IeZD4sa
         JLPg==
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
Subject: [PATCH 3/3] btmrvl: support sysfs initiated firmware coredump
Date: Wed, 21 Feb 2018 11:50:20 +0100
Message-Id: <1519210220-22437-4-git-send-email-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519210220-22437-1-git-send-email-arend.vanspriel@broadcom.com>
References: <1519210220-22437-1-git-send-email-arend.vanspriel@broadcom.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593007399539898108?=
X-GMAIL-MSGID: =?utf-8?q?1593007399539898108?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Since commit 3c47d19ff4dc ("drivers: base: add coredump driver ops")
it is possible to initiate a device coredump from user-space. This
patch adds support for it in btmrvl_sdio adding the .coredump()
driver callback. This makes dump through debugfs obsolete so removing
it.

Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 drivers/bluetooth/btmrvl_debugfs.c | 31 -------------------------------
 drivers/bluetooth/btmrvl_drv.h     |  2 --
 drivers/bluetooth/btmrvl_main.c    |  6 ------
 drivers/bluetooth/btmrvl_sdio.c    | 18 ++++++++++++------
 4 files changed, 12 insertions(+), 45 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_debugfs.c b/drivers/bluetooth/btmrvl_debugfs.c
index 1828ed8..023d35e 100644
--- a/drivers/bluetooth/btmrvl_debugfs.c
+++ b/drivers/bluetooth/btmrvl_debugfs.c
@@ -167,35 +167,6 @@ static ssize_t btmrvl_hscmd_read(struct file *file, char __user *userbuf,
 	.llseek = default_llseek,
 };
 
-static ssize_t btmrvl_fwdump_write(struct file *file, const char __user *ubuf,
-				   size_t count, loff_t *ppos)
-{
-	struct btmrvl_private *priv = file->private_data;
-	char buf[16];
-	bool result;
-
-	memset(buf, 0, sizeof(buf));
-
-	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
-		return -EFAULT;
-
-	if (strtobool(buf, &result))
-		return -EINVAL;
-
-	if (!result)
-		return -EINVAL;
-
-	btmrvl_firmware_dump(priv);
-
-	return count;
-}
-
-static const struct file_operations btmrvl_fwdump_fops = {
-	.write	= btmrvl_fwdump_write,
-	.open	= simple_open,
-	.llseek = default_llseek,
-};
-
 void btmrvl_debugfs_init(struct hci_dev *hdev)
 {
 	struct btmrvl_private *priv = hci_get_drvdata(hdev);
@@ -226,8 +197,6 @@ void btmrvl_debugfs_init(struct hci_dev *hdev)
 			    priv, &btmrvl_hscmd_fops);
 	debugfs_create_file("hscfgcmd", 0644, dbg->config_dir,
 			    priv, &btmrvl_hscfgcmd_fops);
-	debugfs_create_file("fw_dump", 0200, dbg->config_dir,
-			    priv, &btmrvl_fwdump_fops);
 
 	dbg->status_dir = debugfs_create_dir("status", hdev->debugfs);
 	debugfs_create_u8("curpsmode", 0444, dbg->status_dir,
diff --git a/drivers/bluetooth/btmrvl_drv.h b/drivers/bluetooth/btmrvl_drv.h
index fc3caf4..f045454 100644
--- a/drivers/bluetooth/btmrvl_drv.h
+++ b/drivers/bluetooth/btmrvl_drv.h
@@ -110,7 +110,6 @@ struct btmrvl_private {
 				u8 *payload, u16 nb);
 	int (*hw_wakeup_firmware)(struct btmrvl_private *priv);
 	int (*hw_process_int_status)(struct btmrvl_private *priv);
-	void (*firmware_dump)(struct btmrvl_private *priv);
 	spinlock_t driver_lock;		/* spinlock used by driver */
 #ifdef CONFIG_DEBUG_FS
 	void *debugfs_data;
@@ -183,7 +182,6 @@ struct btmrvl_event {
 int btmrvl_enable_ps(struct btmrvl_private *priv);
 int btmrvl_prepare_command(struct btmrvl_private *priv);
 int btmrvl_enable_hs(struct btmrvl_private *priv);
-void btmrvl_firmware_dump(struct btmrvl_private *priv);
 
 #ifdef CONFIG_DEBUG_FS
 void btmrvl_debugfs_init(struct hci_dev *hdev);
diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index b280d46..e5cf14d 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -358,12 +358,6 @@ int btmrvl_prepare_command(struct btmrvl_private *priv)
 	return ret;
 }
 
-void btmrvl_firmware_dump(struct btmrvl_private *priv)
-{
-	if (priv->firmware_dump)
-		priv->firmware_dump(priv);
-}
-
 static int btmrvl_tx_pkt(struct btmrvl_private *priv, struct sk_buff *skb)
 {
 	int ret = 0;
diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 7dbb446..0f02025 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -1311,9 +1311,11 @@ rdwr_status btmrvl_sdio_rdwr_firmware(struct btmrvl_private *priv,
 }
 
 /* This function dump sdio register and memory data */
-static void btmrvl_sdio_dump_firmware(struct btmrvl_private *priv)
+static int btmrvl_sdio_coredump(struct device *dev)
 {
-	struct btmrvl_sdio_card *card = priv->btmrvl_dev.card;
+	struct sdio_func *func = dev_to_sdio_func(dev);
+	struct btmrvl_sdio_card *card;
+	struct btmrvl_private *priv;
 	int ret = 0;
 	unsigned int reg, reg_start, reg_end;
 	enum rdwr_status stat;
@@ -1321,12 +1323,15 @@ static void btmrvl_sdio_dump_firmware(struct btmrvl_private *priv)
 	u8 dump_num = 0, idx, i, read_reg, doneflag = 0;
 	u32 memory_size, fw_dump_len = 0;
 
+	card = sdio_get_drvdata(func);
+	priv = card->priv;
+
 	/* dump sdio register first */
 	btmrvl_sdio_dump_regs(priv);
 
 	if (!card->supports_fw_dump) {
 		BT_ERR("Firmware dump not supported for this card!");
-		return;
+		return -ENODATA;
 	}
 
 	for (idx = 0; idx < ARRAY_SIZE(mem_type_mapping_tbl); idx++) {
@@ -1445,12 +1450,12 @@ static void btmrvl_sdio_dump_firmware(struct btmrvl_private *priv)
 	sdio_release_host(card->func);
 
 	if (fw_dump_len == 0)
-		return;
+		return -ENODATA;
 
 	fw_dump_data = vzalloc(fw_dump_len+1);
 	if (!fw_dump_data) {
 		BT_ERR("Vzalloc fw_dump_data fail!");
-		return;
+		return -ENOMEM;
 	}
 	fw_dump_ptr = fw_dump_data;
 
@@ -1487,6 +1492,7 @@ static void btmrvl_sdio_dump_firmware(struct btmrvl_private *priv)
 	 */
 	dev_coredumpv(&card->func->dev, fw_dump_data, fw_dump_len, GFP_KERNEL);
 	BT_INFO("== btmrvl firmware dump to /sys/class/devcoredump end");
+	return 0;
 }
 
 static int btmrvl_sdio_probe(struct sdio_func *func,
@@ -1547,7 +1553,6 @@ static int btmrvl_sdio_probe(struct sdio_func *func,
 	priv->hw_host_to_card = btmrvl_sdio_host_to_card;
 	priv->hw_wakeup_firmware = btmrvl_sdio_wakeup_fw;
 	priv->hw_process_int_status = btmrvl_sdio_process_int_status;
-	priv->firmware_dump = btmrvl_sdio_dump_firmware;
 
 	if (btmrvl_register_hdev(priv)) {
 		BT_ERR("Register hdev failed!");
@@ -1717,6 +1722,7 @@ static int btmrvl_sdio_resume(struct device *dev)
 	.remove		= btmrvl_sdio_remove,
 	.drv = {
 		.owner = THIS_MODULE,
+		.coredump = btmrvl_sdio_coredump,
 		.pm = &btmrvl_sdio_pm_ops,
 	}
 };
-- 
1.9.1
