Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752321AbeENJdf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 05:33:35 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:37336 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751449AbeENJdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 05:33:33 -0400
X-Google-Smtp-Source: AB8JxZrFvoX57+mVP8B7crC8GU9rnIhOOfAd+Xj4uHBq5bPp4F/nDy/Vrj8D4BDGRLN9Vdo1k/RlKg==
From: Anders Roxell <anders.roxell@linaro.org>
To: jdelvare@suse.com
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v2] i2c: i801: fix unused-function warning
Date: Mon, 14 May 2018 11:33:26 +0200
Message-Id: <20180514093326.30314-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180510152719.6e37b10e@endymion>
References: <20180510152719.6e37b10e@endymion>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_PM, we get a harmless build warning:
drivers/i2c/busses/i2c-i801.c:1723:12: warning: ‘i801_resume’ defined but not used [-Wunused-function]
 static int i801_resume(struct device *dev)
            ^~~~~~~~~~~
drivers/i2c/busses/i2c-i801.c:1714:12: warning: ‘i801_suspend’ defined but not used [-Wunused-function]
 static int i801_suspend(struct device *dev)
            ^~~~~~~~~~~~

Follow design pattern from other drivers like i2c-brcmstb, i2c-mpc,
i2c-ocores, i2c-pnx, i2c-puv3, i2c-st, i2c-stu300 and i2c-mux-pca954x
and changing the ifdef CONFIG_PM to CONFIG_PM_SLEEP.

Fixes: a9c8088c7988 ("i2c: i801: Don't restore config registers on runtime PM")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/i2c/busses/i2c-i801.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index ed07f9002710..954fb3f3b7fc 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -1710,7 +1710,7 @@ static void i801_shutdown(struct pci_dev *dev)
 	pci_write_config_byte(dev, SMBHSTCFG, priv->original_hstcfg);
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int i801_suspend(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
-- 
2.17.0
