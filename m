Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751848AbeB1DRz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 22:17:55 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:56448 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751646AbeB1DRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 22:17:54 -0500
From: Yunlong Song <yunlong.song@huawei.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>, <yuchao0@huawei.com>,
        <yunlong.song@icloud.com>, <yunlong.song@huawei.com>
CC: <miaoxie@huawei.com>, <bintian.wang@huawei.com>,
        <shengyong1@huawei.com>, <heyunlei@huawei.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4] Revert "f2fs crypto: avoid unneeded memory allocation in ->readdir"
Date: Wed, 28 Feb 2018 11:17:37 +0800
Message-ID: <1519787857-107910-1-git-send-email-yunlong.song@huawei.com>
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1519463698-60555-1-git-send-email-yunlong.song@huawei.com>
References: <1519463698-60555-1-git-send-email-yunlong.song@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.113.189.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit e06f86e61d7a67fe6e826010f57aa39c674f4b1b.

Conflicts:
	fs/f2fs/dir.c

In some platforms (such as arm), high memory is used, then the
decrypting filename will cause panic, the reason see commit
569cf1876a32e574ba8a7fb825cd91bafd003882 ("f2fs crypto: allocate buffer
for decrypting filename"):

 We got dentry pages from high_mem, and its address space directly goes into the
 decryption path via f2fs_fname_disk_to_usr.
 But, sg_init_one assumes the address is not from high_mem, so we can get this
 panic since it doesn't call kmap_high but kunmap_high is triggered at the end.

 kernel BUG at ../../../../../../kernel/mm/highmem.c:290!
 Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
 ...
  (kunmap_high+0xb0/0xb8) from [<c0114534>] (__kunmap_atomic+0xa0/0xa4)
  (__kunmap_atomic+0xa0/0xa4) from [<c035f028>] (blkcipher_walk_done+0x128/0x1ec)
  (blkcipher_walk_done+0x128/0x1ec) from [<c0366c24>] (crypto_cbc_decrypt+0xc0/0x170)
  (crypto_cbc_decrypt+0xc0/0x170) from [<c0367148>] (crypto_cts_decrypt+0xc0/0x114)
  (crypto_cts_decrypt+0xc0/0x114) from [<c035ea98>] (async_decrypt+0x40/0x48)
  (async_decrypt+0x40/0x48) from [<c032ca34>] (f2fs_fname_disk_to_usr+0x124/0x304)
  (f2fs_fname_disk_to_usr+0x124/0x304) from [<c03056fc>] (f2fs_fill_dentries+0xac/0x188)
  (f2fs_fill_dentries+0xac/0x188) from [<c03059c8>] (f2fs_readdir+0x1f0/0x300)
  (f2fs_readdir+0x1f0/0x300) from [<c0218054>] (vfs_readdir+0x90/0xb4)
  (vfs_readdir+0x90/0xb4) from [<c0218418>] (SyS_getdents64+0x64/0xcc)
  (SyS_getdents64+0x64/0xcc) from [<c0105ba0>] (ret_fast_syscall+0x0/0x30)

Howerver, later patch:
commit e06f86e61d7a ("f2fs crypto: avoid unneeded memory allocation in ->readdir")
reverts the codes, which causes panic again in arm, so fix it back to the old version.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/dir.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index f00b5ed..de2e295 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -825,9 +825,16 @@ int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
 			int save_len = fstr->len;
 			int err;
 
+			de_name.name = f2fs_kmalloc(sbi, de_name.len, GFP_NOFS);
+			if (!de_name.name)
+				return -ENOMEM;
+
+			memcpy(de_name.name, d->filename[bit_pos], de_name.len);
+
 			err = fscrypt_fname_disk_to_usr(d->inode,
 						(u32)de->hash_code, 0,
 						&de_name, fstr);
+			kfree(de_name.name);
 			if (err)
 				return err;
 
-- 
1.8.5.2
