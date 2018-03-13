Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752698AbeCMNGn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 09:06:43 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:51383 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752148AbeCMNGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 09:06:39 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Daniel Scheller <d.scheller@gmx.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Binoy Jayan <binoy.jayan@linaro.org>,
        Jasmin Jessich <jasmin@anw.at>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] media: ngene: avoid unused variable warning
Date: Tue, 13 Mar 2018 14:06:03 +0100
Message-Id: <20180313130620.4040088-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:Myv6Px8M0WMU6D8ZJUfRw2C7jtFb+5aD4cEwDiK1xgDuxE4/V+0
 WcFrWYK+NGQq8TyjwIdoUOzQQYYfj7oiunNLEl23XYYJfeY1+5tGTO+wDMQLeib1lG0jXlF
 9srCiZGImcgRbCwEMrvR1Geyn+r9ckrggM1QhdwEg4aLr3Oid42NiMopM9gQaCwnK+n/FY/
 VGRXP+we/EJovJBYK6AFw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:opZVlE3RE5c=:c/2RwKTPE5+mETkklB3zQ6
 gA+L9gP/VehaXxIEotS+g4gJFnfIpvPze5HGXUgXoYf74yJXEYicz5O1XNUluZUnohw2PV5wP
 a5ab2ataLBHGQvj3qXKi3BGYW98JSsSWUCfLnNcZ2KasP+bVwIohuXjn34xqvtMg1A7Q7l7ST
 CgJlYeXbe+62+q0neKIbrBnVtR3oo1s8C3wGEA4pUYktHKebGdeQKqps3wb4/fXatulEUa3iM
 7rsz3uB5DnqFttyitF6vw9duFQ5ky+8AD5xjMWsEIr/MlwcFsYGED84ILSsneh+C0yKM0VbMn
 34nFviO4Fff/QF4AQ2henfv/X8kb6H6zYcrx6K1HWLdu6bcMYVNRiXKA1IogTinROLHKXyOoF
 xkA5gMHlWa4jteODp3QCs+R/3de2myhKl93OPEYqhx6f6Bkv5aMVWe1+TM5HWzdwYX18v7tRK
 O4uSj8v5fcYkpTE5NngADZv4yaqwO+NUJyyju5yiOV9yfdpqxmxeomkcnVH/zwawLSYvgfhnz
 6Xeqb8u82Iey0slV8kbEYhYZ7bArMdum2dl21htYRdQTyJCpPj3VS39rMh3dmUaRYebrlUSyf
 +62dDpyQh8CX32qu2t+fSzxIA9RPavCWcCmhP0vG4KqrfltyGWCipVXt7W1c6nGLawmob1F7E
 1FOlUnfrk3CwXaUHvAJSuVLUjOs6SOt++XEIYUISzOyjwBozQLAgKVK3xsl/wy3Db9tAT+pO7
 KvEg4ybCYoKb42+2/gasE2DBY5NpjKXSJDlDYw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newly added pdev variable is only used in an #ifdef, causing a
build warning without CONFIG_PCI_MSI, unless we move the declaration
inside the same #ifdef:

drivers/media/pci/ngene/ngene-core.c: In function 'ngene_start':
drivers/media/pci/ngene/ngene-core.c:1328:17: error: unused variable 'pdev' [-Werror=unused-variable]

Fixes: 6795bf626482 ("media: ngene: convert kernellog printing from printk() to dev_*() macros")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/media/pci/ngene/ngene-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/ngene/ngene-core.c b/drivers/media/pci/ngene/ngene-core.c
index 3b9a1bfaf6c0..25f16833a475 100644
--- a/drivers/media/pci/ngene/ngene-core.c
+++ b/drivers/media/pci/ngene/ngene-core.c
@@ -1325,7 +1325,6 @@ static int ngene_buffer_config(struct ngene *dev)
 
 static int ngene_start(struct ngene *dev)
 {
-	struct device *pdev = &dev->pci_dev->dev;
 	int stat;
 	int i;
 
@@ -1359,6 +1358,7 @@ static int ngene_start(struct ngene *dev)
 #ifdef CONFIG_PCI_MSI
 	/* enable MSI if kernel and card support it */
 	if (pci_msi_enabled() && dev->card_info->msi_supported) {
+		struct device *pdev = &dev->pci_dev->dev;
 		unsigned long flags;
 
 		ngwritel(0, NGENE_INT_ENABLE);
-- 
2.9.0
