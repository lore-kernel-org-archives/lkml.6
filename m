Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751696AbeDFTwz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 15:52:55 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:39487 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750807AbeDFTwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 15:52:53 -0400
X-Google-Smtp-Source: AIpwx491IZVNBIBKG2jlOea9Q4yRm6i2RLlEO1R2mWvSFAIcL8RVEyhUzpE2FskOFmZxRwucA8kU5A==
From: Mathieu Malaterre <malat@debian.org>
To: tytso@mit.edu
Cc: Milan Kupcevic <milan@debian.org>, Ben Hutchings <ben@decadent.org.uk>,
        Mathieu Malaterre <malat@debian.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fs: Add MODULE_SOFTDEP declarations for hard-coded crypto drivers
Date: Fri,  6 Apr 2018 21:52:31 +0200
Message-Id: <20180406195231.14868-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This helps initramfs builders and other tools to find the full
dependencies of a module.

Debian on powerpc (ppc32) still uses yaboot as default boot loader. Using a
default installation (debian-installer) 64bit and metadata_csum feature are
not setup in ext4. This is discussed in more details at:

https://bugs.debian.org/825110#81

and implemented here:

https://anonscm.debian.org/cgit/d-i/partman-ext3.git/patch/?id=f87dc92157262de1ad8dd3f2343436f08271b4dc

This means that building the kernel as default debian package:

  make ARCH=powerpc XYZ_defconfig
  make -j8 ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu- bindeb-pkg

Will lead to the following boot failure (initramfs prompt):

  /dev/sda3: clean, 127679/305216 files, 11128559/1220703 blocks done.
  [    5.592819] EXT4-fs (sda3): Cannot load crc32c driver.
  mount: mounting /dev/sda3 on /root failed: No such file or directory

Link: https://bugs.debian.org/819725
Link: https://salsa.debian.org/kernel-team/linux/blob/master/debian/patches/bugfix/all/fs-add-module_softdep-declarations-for-hard-coded-cr.patch
Suggested-by: Ben Hutchings <ben@decadent.org.uk>
Cc: Milan Kupcevic <milan@debian.org>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 fs/ext4/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 185f7e61f4cf..10bda040e78f 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5886,5 +5886,6 @@ static void __exit ext4_exit_fs(void)
 MODULE_AUTHOR("Remy Card, Stephen Tweedie, Andrew Morton, Andreas Dilger, Theodore Ts'o and others");
 MODULE_DESCRIPTION("Fourth Extended Filesystem");
 MODULE_LICENSE("GPL");
+MODULE_SOFTDEP("pre: crypto-crc32c");
 module_init(ext4_init_fs)
 module_exit(ext4_exit_fs)
-- 
2.11.0
