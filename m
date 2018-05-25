Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030382AbeEYVK3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 17:10:29 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:45943 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030215AbeEYVK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 17:10:28 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Jean Delvare <jdelvare@suse.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <wsa@the-dreams.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: i801: mark PM functions as __maybe_unused
Date: Fri, 25 May 2018 23:09:46 +0200
Message-Id: <20180525210952.1861881-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:CjoKwSHAKJNuasF0wc15cV580fDH7K240GtXv1lS6Ba4Lcf5U4V
 yVI1837OdxJC/qW4OdkcKCYHKsoOF9B+KKXJ91wB8B+daib3BONCWdS8CUvUftmU97dmz35
 PT8TE8iLpDl8Em7nvHEWgrgcRS0jGWdWwUuKaO/8Uus+OUcFM+HfMqlb0WDnG/FqVRGoXGG
 i0RsZ91SpjcruNQRYXWhg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lDsks6AogT0=:wiqyVgsAZ1cwTMKrXDeXH+
 9lncBvlXjjGL1t4EqY4NSIndYUwVKPytLCxzR8KoZ7NpYIvGRFoWBvhOC+9YpkWW5n4Peb9ib
 PyKc++Nfb7/jTxsd21wvWq8f95gKLf8aEggyI00653vRirzVewOqy9637JvfJTzzenKtSPVZB
 8/i9X73SysBXqbQoGjK5umlvMlB6TrSyMklV/+0h6Gm5ktDh/iIj/P83er04tNgrm8veWT9Uz
 oUqUi65mJOkBluaYWPy+O0ZlVtaeJs0R8KRzV3kpiX35gooRradRjublpuYsBA6oNxDlu1+8B
 mMclUYBubs0pJAb6sUITnF6nQgspPZ+SuoyPG5JZuYhTle28/55eNTyJb1f872nfC5qXgpiER
 ahIgeTs1uBsFp1oystOl9Nva9rqQS3qnEuP05njdROOrbFEI0AvqCkow9iqSxijRXEauDqYEy
 /sPdBkwXHL3vqAcG8VU7n/eX3cGNF0QYYE666zU2s6+wkzAnc+qVoAq5iJsRtkhbOY/W1iab+
 4HGuCLJY0SmOYDFT4q1paYPDCGCtuQ0Wb1FOqmNZhwFBxhPnaTekaO4SOhRs3BN18cO3AHdea
 /dM3FX9h40Yn4aHvQjzgezN1r4SMl1cPLsneVhOT9/CoTWEpC2mFj//TxUwVe55/OAN9wTgFE
 qi/PDEnBNLw02keV6Jbu+9JeGg7JHLIY7BHtJECCvKFOJHo59ZmwcY0HVraYyHXjA7xM=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changing from UNIVERSAL_DEV_PM_OPS to SIMPLE_DEV_PM_OPS caused a harmless
warning in configurations without CONFIG_PM_SLEEP:

drivers/i2c/busses/i2c-i801.c:1723:12: error: 'i801_resume' defined but not used [-Werror=unused-function]
 static int i801_resume(struct device *dev)
            ^~~~~~~~~~~
drivers/i2c/busses/i2c-i801.c:1714:12: error: 'i801_suspend' defined but not used [-Werror=unused-function]
 static int i801_suspend(struct device *dev)

This removes the incorrect #ifdef and instead marks both functions as
__maybe_unused, which is a more robust way to express the same thing.

Fixes: a9c8088c7988 ("i2c: i801: Don't restore config registers on runtime PM")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/i2c/busses/i2c-i801.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index ed07f9002710..d6d46e7a5376 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -1710,8 +1710,7 @@ static void i801_shutdown(struct pci_dev *dev)
 	pci_write_config_byte(dev, SMBHSTCFG, priv->original_hstcfg);
 }
 
-#ifdef CONFIG_PM
-static int i801_suspend(struct device *dev)
+static int __maybe_unused i801_suspend(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	struct i801_priv *priv = pci_get_drvdata(pci_dev);
@@ -1720,7 +1719,7 @@ static int i801_suspend(struct device *dev)
 	return 0;
 }
 
-static int i801_resume(struct device *dev)
+static int __maybe_unused i801_resume(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	struct i801_priv *priv = pci_get_drvdata(pci_dev);
@@ -1729,7 +1728,6 @@ static int i801_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(i801_pm_ops, i801_suspend, i801_resume);
 
-- 
2.9.0
