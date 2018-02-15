Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1166367AbeBOSWo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 13:22:44 -0500
Received: from mga14.intel.com ([192.55.52.115]:3049 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1166314AbeBOSWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 13:22:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,517,1511856000";
   d="scan'208";a="35068986"
From: Joe Konno <joe.konno@linux.intel.com>
To: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ard.biesheuvel@linaro.org, matthew.garrett@nebula.com, jk@ozlabs.org,
        ak@linux.intel.com, tony.luck@intel.com
Subject: [PATCH 1/2] fs/efivarfs: restrict inode permissions
Date: Thu, 15 Feb 2018 10:22:07 -0800
Message-Id: <20180215182208.35003-2-joe.konno@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180215182208.35003-1-joe.konno@linux.intel.com>
References: <20180215182208.35003-1-joe.konno@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joe Konno <joe.konno@intel.com>

Efivarfs nodes are created with group and world readable permissions.
Reading certain EFI variables trigger SMIs. So, this is a potential DoS
surface.

Make permissions more restrictive-- only the owner may read or write to
created inodes.

Suggested-by: Andi Kleen <ak@linux.intel.com>
Reported-by: Tony Luck <tony.luck@intel.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Matthew Garrett <matthew.garrett@nebula.com>
Cc: Jeremy Kerr <jk@ozlabs.org>
Cc: linux-efi@vger.kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Joe Konno <joe.konno@intel.com>
---
 fs/efivarfs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 5b68e4294faa..ca98c4e31eb7 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -145,7 +145,7 @@ static int efivarfs_callback(efi_char16_t *name16, efi_guid_t vendor,
 
 	name[len + EFI_VARIABLE_GUID_LEN+1] = '\0';
 
-	inode = efivarfs_get_inode(sb, d_inode(root), S_IFREG | 0644, 0,
+	inode = efivarfs_get_inode(sb, d_inode(root), S_IFREG | 0600, 0,
 				   is_removable);
 	if (!inode)
 		goto fail_name;
@@ -207,7 +207,7 @@ static int efivarfs_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_d_op		= &efivarfs_d_ops;
 	sb->s_time_gran         = 1;
 
-	inode = efivarfs_get_inode(sb, NULL, S_IFDIR | 0755, 0, true);
+	inode = efivarfs_get_inode(sb, NULL, S_IFDIR | 0700, 0, true);
 	if (!inode)
 		return -ENOMEM;
 	inode->i_op = &efivarfs_dir_inode_operations;
-- 
2.14.1
