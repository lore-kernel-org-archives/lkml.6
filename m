Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034888AbeE1Pro (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:47:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:55514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1034854AbeE1Prc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 11:47:32 -0400
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: fix to avoid accessing cross the boundary
Date: Mon, 28 May 2018 23:47:19 +0800
Message-Id: <20180528154719.22920-2-chao@kernel.org>
X-Mailer: git-send-email 2.16.2.17.g38e79b1fd
In-Reply-To: <20180528154719.22920-1-chao@kernel.org>
References: <20180528154719.22920-1-chao@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

Configure io_bits with 2 and enable LFS mode, generic/017 reports below dmesg:

BUG: unable to handle kernel NULL pointer dereference at 00000039
*pdpt = 000000002fcb2001 *pde = 0000000000000000
Oops: 0000 [#1] PREEMPT SMP
Modules linked in: crc32_generic zram f2fs(O) bnep rfcomm bluetooth ecdh_generic snd_intel8x0 snd_ac97_codec ac97_bus snd_pcm snd_seq_midi snd_seq_midi_event snd_rawmidi pcbc snd_seq joydev aesni_intel aes_i586 snd_seq_device snd_timer crypto_simd cryptd snd soundcore i2c_piix4 serio_raw mac_hid video parport_pc ppdev lp parport hid_generic usbhid psmouse hid e1000
CPU: 2 PID: 20779 Comm: xfs_io Tainted: G           O      4.17.0-rc2 #38
Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
EIP: is_checkpointed_data+0x84/0xd0 [f2fs]
EFLAGS: 00010207 CPU: 2
EAX: 00000000 EBX: f5cd7000 ECX: fffffe32 EDX: 00000039
ESI: 000001cd EDI: ec95fb6c EBP: e264bd80 ESP: e264bd6c
 DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
CR0: 80050033 CR2: 00000039 CR3: 2fe55660 CR4: 000406f0
Call Trace:
 __exchange_data_block+0xb3f/0x1000 [f2fs]
 f2fs_fallocate+0xab9/0x16b0 [f2fs]
 vfs_fallocate+0x17c/0x2d0
 ksys_fallocate+0x42/0x70
 sys_fallocate+0x31/0x40
 do_fast_syscall_32+0xaa/0x22c
 entry_SYSENTER_32+0x4c/0x7b
EIP: 0xb7f98c51
EFLAGS: 00000293 CPU: 2
EAX: ffffffda EBX: 00000003 ECX: 00000008 EDX: 01001000
ESI: 00000000 EDI: 00001000 EBP: 00000000 ESP: bfc0357c
 DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b
Code: 00 00 d3 e8 8b 4d ec 2b 02 8b 55 f0 6b c0 1c 03 41 70 29 d6 8b 93 d0 06 00 00 8b 40 0c 83 ea 01 21 d6 89 f2 89 f1 c1 ea 03 f7 d1 <0f> be 14 10 83 e1 07 b8 01 00 00 00 d3 e0 85 c2 89 f8 0f 95 c3
EIP: is_checkpointed_data+0x84/0xd0 [f2fs] SS:ESP: 0068:e264bd6c
CR2: 0000000000000039
---[ end trace 9a4d4087cce6080a ]---

This is because in recovery flow of __exchange_data_block, we didn't pass olen to
__roll_back_blkaddrs, instead we passed len, which indicates wrong array size, result
in copying random block address into dnode page.

Later, once that random block address was accessed by is_checkpointed_data, it can
cause NULL pointer dereference.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index fab65a0bd4cc..694ef319f979 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1144,7 +1144,7 @@ static int __exchange_data_block(struct inode *src_inode,
 	return 0;
 
 roll_back:
-	__roll_back_blkaddrs(src_inode, src_blkaddr, do_replace, src, len);
+	__roll_back_blkaddrs(src_inode, src_blkaddr, do_replace, src, olen);
 	kvfree(src_blkaddr);
 	kvfree(do_replace);
 	return ret;
-- 
2.16.2.17.g38e79b1fd
