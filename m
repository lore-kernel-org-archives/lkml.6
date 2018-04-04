Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751251AbeDDJyo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 05:54:44 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:36883 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750736AbeDDJyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 05:54:43 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Dan Williams <dan.j.williams@intel.com>,
        Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com, Shaohua Li <shli@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dm: fix DAX dependency
Date: Wed,  4 Apr 2018 11:54:15 +0200
Message-Id: <20180404095427.2537184-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:XF3krF2cufn5ZqbP1HwLxfM9yMhIKbJ0j+SUPY/m6Jgd7+zUvrc
 dBe7Tapg94uK6OvZ7XQh3GeSLkg9K3Oic0yNIAw287U+QpUfU8fmnLqM+wM+rb+BvkkM8Zu
 Zg2EJ0a9Hpq1ONgNgEN3xzYtWs3/t6KPPxPt3cUYzKuIg/Eb0OuJ280OiRx+hzCyhzIpZna
 SrRikSFiky6l/69apegbg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nSWNP0NIF80=:ldmkHYkY5GMm6bSTtb/Coo
 oRUrLxXzhmMXyOwh2V1tqqBGBgZSs+9J9nu9/BzT6KldwJLlyU4VBFnyhDP+p8UQNuVsEJ8zN
 ZkTXQb1TDkqsKNK/FwVV7NnXF0cWyD1az2OXJx/oOu0XZ6FQLswJL8B/Cc1mGylmDR1eKWQ/t
 SCmVEphXOoEW5Dxf8SnPqKmsF335xrTQZmXOf77RYJTWLbytDNM4g71JfQIfHv54QaKNhDzNg
 WnY3+pA3vGubntstyDR2UwQiMkhqXkKpx48a656oc2m7V6iWu1be6FY3zmldQiWUXGFP1O3CC
 M/+Aad85y9PtKsjATBCeZZBYieKKlbbUHA+V/fz2viPHN+OEUy8U/IJIFlEoixRW+NlXF5pCj
 vk2Gm5p6itWzMXgTxs4YSvtnetPjO+mhCRto9TX0G8H2tcFcz39/Wjrdaikb8nSd10yHJtRS2
 zhh1uUJyl8Vd6buxl5KfmHRKuiFL+ss2Q4aqw4mcz6dvOlcK6PgurzP9gg9/CPxUrnJ7PpdaC
 xK7pd+fSq+bh62vNbvH61mqMGiT55toiG0fG2LKxVC5MVgIm9GkJV+kVosLxigFTU5zXjPTyf
 W+5F3D4AdN/QMnRm6k3Ul3/zbV1UcWokGzsz2I/ScdAQAs+kI521Ipe9DXHGg7ED8f5MKFDtU
 QISknX5IC9wXJ1rS3jQdXtRK8PlnN0O8zkG7cM77RSSJB0xhLWnafLM7htCsbT72ikI6FgL9x
 NQ1Iu8pSzXCwnvNGCBpc+6KQugc69y2n5c7Fhg==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building device mapper with CONFIG_DAX=m now results in a link error:

drivers/md/dm.o: In function `dm_put_table_device':
dm.c:(.text+0x33c): undefined reference to `put_dax'
drivers/md/dm.o: In function `cleanup_mapped_device':
dm.c:(.text+0x1054): undefined reference to `kill_dax'
dm.c:(.text+0x105c): undefined reference to `put_dax'
drivers/md/dm.o: In function `dm_get_table_device':
dm.c:(.text+0x2744): undefined reference to `dax_get_by_host'
drivers/md/dm-table.o: In function `device_dax_write_cache_enabled':
dm-table.c:(.text+0x1030): undefined reference to `dax_write_cache_enabled'
drivers/md/dm-table.o: In function `dm_table_set_restrictions':
dm-table.c:(.text+0x29b8): undefined reference to `dax_write_cache'

This adds a dependency that prevents the invalid configuration, allowing
a built-in device mapper only if DAX is either built-in as well, or
completely disabled.

Fixes: 4de1c562f7e9 ("dax, dm: allow device-mapper to operate without dax support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
The regression only showed up in linux-next at the start of the merge
window. Any idea what happened?
---
 drivers/md/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
index 49287135b86c..5e5a47c5ff82 100644
--- a/drivers/md/Kconfig
+++ b/drivers/md/Kconfig
@@ -200,6 +200,7 @@ config BLK_DEV_DM_BUILTIN
 
 config BLK_DEV_DM
 	tristate "Device mapper support"
+	depends on DAX || DAX=n
 	select BLK_DEV_DM_BUILTIN
 	---help---
 	  Device-mapper is a low level volume manager.  It works by allowing
-- 
2.9.0
