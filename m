Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754725AbeEHHjB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 03:39:01 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:39718 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754492AbeEHHjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 03:39:00 -0400
X-Google-Smtp-Source: AB8JxZr4P263+/92TErBr6X7Yk/jBca0wypZU+juYM9f8PxBQ7LbX80IUXMTJcHJ5VUweU9lC68XXw==
From: Anders Roxell <anders.roxell@linaro.org>
To: jdelvare@suse.com
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] i2c: i801: mark PM functions as __maybe_unused
Date: Tue,  8 May 2018 09:38:52 +0200
Message-Id: <20180508073852.16840-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.17.0
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

This marks the affected functions as __maybe_unused.

Fixes: a9c8088c7988 ("i2c: i801: Don't restore config registers on runtime PM")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/i2c/busses/i2c-i801.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index ed07f9002710..ff18c6ed2bec 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -1711,7 +1711,7 @@ static void i801_shutdown(struct pci_dev *dev)
 }
 
 #ifdef CONFIG_PM
-static int i801_suspend(struct device *dev)
+static int __maybe_unused i801_suspend(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	struct i801_priv *priv = pci_get_drvdata(pci_dev);
@@ -1720,7 +1720,7 @@ static int i801_suspend(struct device *dev)
 	return 0;
 }
 
-static int i801_resume(struct device *dev)
+static int __maybe_unused i801_resume(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	struct i801_priv *priv = pci_get_drvdata(pci_dev);
-- 
2.17.0
