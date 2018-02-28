Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752604AbeB1NhU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 08:37:20 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:43375 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752213AbeB1NhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 08:37:18 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Jan Kara <jack@suse.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?q?Ernesto=20A=2E=20Fern=C3=A1ndez?=
        <ernesto.mnd.fernandez@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Andreas Gruenbacher <agruenba@redhat.com>, Tejun Heo <tj@kernel.org>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ext2: fix FS_IOMAP dependency
Date: Wed, 28 Feb 2018 14:36:46 +0100
Message-Id: <20180228133659.1933887-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:QLgoVtqwo+OE9Zuf9mowFLDKV5iWIlW9HOA1em3McnlLF3lU4Km
 dCYtwuC/P9AJA8w689lWfFbM0x/sdzCJBVku5MKlUkJzrW6XkrNr5mysw5MGFgKQ0bmqWG5
 ZjCxEQ8QaaeK/18OHA4LeQo+1pEBQmivcVEdTGCaMwvoml+nJDviohWOYP3Z69+37/uxd77
 GlOa2Oqfcbl4GKHXTkzJg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6A5+WzYm0XE=:reiuR2Vt6axJUZQosR2pLL
 vYLQKPhfOzWcfEFerS2BdaMoq9CUABzn5O7spC65xLeWcoozzUB5yV3e9Z0tODG6h7mZvWLDW
 vmkIh1eKndQvAqXXnlw7xIVh1YkM0bKBbSMkhXxkR2RUhaxTH8D3WCiilk+v5Zjcv/AF5YT79
 5fVXpv/DzLOlOWNJUNGVI+sE9zXXRZzmd2RBLg4AXDXFQiLXdY+asKZ1g06Pic3X0XvxnbT+K
 CortUVmU37rk1V2s9p4OUQozfn/fvYsf9xGA4QgCJNMjYw2ONTWntfOC5wb18YVpTLaT4HFLI
 3wgZvoFqaiFRrYvPM7aQyxcPHjElc+v3VOPm+wQKzB4/CxGVa8uSF08c+bJdvfMQAzTjUbbdx
 GT8+k4ufnd6gVW3MIe95r/LtmAUTZPXeZxAYzMZq/cn/wE9iuZ98ve7CKkRW1PdO+zjek/l0n
 cM1v0xR477iXteX2DEa9FBDL36qA9+g34J347rgCbeWNJlUPa4XyIEcnOk55nLNGkYFfvzeb4
 DqRrpuDuikH+IR8hOWsbPnFMTzm2kNGCMP6FUqktiWjDBzn8iSvtkYcyu2mIwbAUS3CZ/yTGI
 r/hB00GPruKGyaR7b7Wqu52XgbrV0PdFPMP2ZsAaISORj1TD1agYULLS/a2bgf/FlBrTmTe/a
 XG3KFTRATk38xhwwea/phnc1E4UxRNgaisWxa4hHVRef3fxocdagwS/OrtudZqGmSgzhA8JuV
 KJjtdebXKCkN0bgKxjp75+zTM3GP9TR0Ezthjw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I ran into a randconfig link error on next-20180228 that appears to have
been caused by an older patch:

fs/ext2/inode.o: In function `ext2_setattr':
inode.c:(.text+0x19eb): undefined reference to `iomap_zero_range'

This adds a compile-time conditional around the code path so the
compiler can optimize out the reference in configurations that don't
need it anyway.

Fixes: 00697eed386d ("ext2: use iomap_zero_range() for zeroing truncated page in DAX path")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/ext2/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 5d5e9f7b98d6..6e6db0ab3bd6 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -1296,7 +1296,7 @@ static int ext2_setsize(struct inode *inode, loff_t newsize)
 
 	inode_dio_wait(inode);
 
-	if (IS_DAX(inode)) {
+	if (IS_ENABLED(CONFIG_FS_DAX) && IS_DAX(inode)) {
 		error = iomap_zero_range(inode, newsize,
 					 PAGE_ALIGN(newsize) - newsize, NULL,
 					 &ext2_iomap_ops);
-- 
2.9.0
