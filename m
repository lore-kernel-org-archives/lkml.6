Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968605AbeE1Prk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:47:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:55486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1034843AbeE1Pra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 11:47:30 -0400
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: fix to let caller retry allocating block address
Date: Mon, 28 May 2018 23:47:18 +0800
Message-Id: <20180528154719.22920-1-chao@kernel.org>
X-Mailer: git-send-email 2.16.2.17.g38e79b1fd
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

Configure io_bits with 2 and enable LFS mode, generic/013 reports below dmesg:

BUG: unable to handle kernel NULL pointer dereference at 00000104
*pdpt = 0000000029b7b001 *pde = 0000000000000000
Oops: 0002 [#1] PREEMPT SMP
Modules linked in: crc32_generic zram f2fs(O) rfcomm bnep bluetooth ecdh_generic snd_intel8x0 snd_ac97_codec ac97_bus snd_pcm snd_seq_midi snd_seq_midi_event snd_rawmidi snd_seq pcbc joydev snd_seq_device aesni_intel snd_timer aes_i586 snd crypto_simd cryptd soundcore i2c_piix4 serio_raw mac_hid video parport_pc ppdev lp parport hid_generic psmouse usbhid hid e1000
CPU: 0 PID: 11161 Comm: fsstress Tainted: G           O      4.17.0-rc2 #38
Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
EIP: f2fs_submit_page_write+0x28d/0x550 [f2fs]
EFLAGS: 00010206 CPU: 0
EAX: e863dcd8 EBX: 00000000 ECX: 00000100 EDX: 00000200
ESI: e863dcf4 EDI: f6f82768 EBP: e863dbb0 ESP: e863db74
 DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
CR0: 80050033 CR2: 00000104 CR3: 29a62020 CR4: 000406f0
Call Trace:
 do_write_page+0x6f/0xc0 [f2fs]
 write_data_page+0x4a/0xd0 [f2fs]
 do_write_data_page+0x327/0x630 [f2fs]
 __write_data_page+0x34b/0x820 [f2fs]
 __f2fs_write_data_pages+0x42d/0x8c0 [f2fs]
 f2fs_write_data_pages+0x27/0x30 [f2fs]
 do_writepages+0x1a/0x70
 __filemap_fdatawrite_range+0x94/0xd0
 filemap_write_and_wait_range+0x3d/0xa0
 __generic_file_write_iter+0x11a/0x1f0
 f2fs_file_write_iter+0xdd/0x3b0 [f2fs]
 __vfs_write+0xd2/0x150
 vfs_write+0x9b/0x190
 ksys_write+0x45/0x90
 sys_write+0x16/0x20
 do_fast_syscall_32+0xaa/0x22c
 entry_SYSENTER_32+0x4c/0x7b
EIP: 0xb7fc8c51
EFLAGS: 00000246 CPU: 0
EAX: ffffffda EBX: 00000003 ECX: 09cde000 EDX: 00001000
ESI: 00000003 EDI: 00001000 EBP: 00000000 ESP: bfbded38
 DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b
Code: e8 f9 77 34 c9 8b 45 e0 8b 80 b8 00 00 00 39 45 d8 0f 84 bb 02 00 00 8b 45 e0 8b 80 b8 00 00 00 8d 50 d8 8b 08 89 55 f0 8b 50 04 <89> 51 04 89 0a c7 00 00 01 00 00 c7 40 04 00 02 00 00 8b 45 dc
EIP: f2fs_submit_page_write+0x28d/0x550 [f2fs] SS:ESP: 0068:e863db74
CR2: 0000000000000104
---[ end trace 4cac79c0d1305ee6 ]---

allocate_data_block will submit all sequential pending IOs sorted by a
FIFO list, If we failed to submit other user's IO due to unaligned write,
we will retry to allocate new block address for current IO, then it will
initialize fio.list again, if fio was in the list before, it can break
FIFO list, result in above panic.

Thread A			Thread B
- do_write_page
 - allocate_data_block
  - list_add_tail
  : fioA cached in FIFO list.
				- do_write_page
				 - allocate_data_block
				  - list_add_tail
				  : fioB cached in FIFO list.
				 - f2fs_submit_page_write
				 : fail to submit IO
				 - allocate_data_block
				  - INIT_LIST_HEAD
 - f2fs_submit_page_write
  - list_del  <-- NULL pointer dereference

This patch adds fio.retry parameter to indicate failure status for each
IO, and avoid bailing out if there is still pending IO in FIFO list for
fixing.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c    | 14 ++++++--------
 fs/f2fs/f2fs.h    |  3 ++-
 fs/f2fs/gc.c      |  5 +++--
 fs/f2fs/segment.c | 11 ++++++-----
 4 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 31c2edb217ec..97e6df852f37 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -462,13 +462,12 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
 	return 0;
 }
 
-int f2fs_submit_page_write(struct f2fs_io_info *fio)
+void f2fs_submit_page_write(struct f2fs_io_info *fio)
 {
 	struct f2fs_sb_info *sbi = fio->sbi;
 	enum page_type btype = PAGE_TYPE_OF_BIO(fio->type);
 	struct f2fs_bio_info *io = sbi->write_io[btype] + fio->temp;
 	struct page *bio_page;
-	int err = 0;
 
 	f2fs_bug_on(sbi, is_read_io(fio->op));
 
@@ -478,7 +477,7 @@ int f2fs_submit_page_write(struct f2fs_io_info *fio)
 		spin_lock(&io->io_lock);
 		if (list_empty(&io->io_list)) {
 			spin_unlock(&io->io_lock);
-			goto out_fail;
+			goto out;
 		}
 		fio = list_first_entry(&io->io_list,
 						struct f2fs_io_info, list);
@@ -505,9 +504,9 @@ int f2fs_submit_page_write(struct f2fs_io_info *fio)
 	if (io->bio == NULL) {
 		if ((fio->type == DATA || fio->type == NODE) &&
 				fio->new_blkaddr & F2FS_IO_SIZE_MASK(sbi)) {
-			err = -EAGAIN;
 			dec_page_count(sbi, WB_DATA_TYPE(bio_page));
-			goto out_fail;
+			fio->retry = true;
+			goto skip;
 		}
 		io->bio = __bio_alloc(sbi, fio->new_blkaddr, fio->io_wbc,
 						BIO_MAX_PAGES, false,
@@ -527,12 +526,11 @@ int f2fs_submit_page_write(struct f2fs_io_info *fio)
 	f2fs_trace_ios(fio, 0);
 
 	trace_f2fs_submit_page_write(fio->page, fio);
-
+skip:
 	if (fio->in_list)
 		goto next;
-out_fail:
+out:
 	up_write(&io->io_rwsem);
-	return err;
 }
 
 static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index da43959b725a..c8e7f34ca290 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1011,6 +1011,7 @@ struct f2fs_io_info {
 	int need_lock;		/* indicate we need to lock cp_rwsem */
 	bool in_list;		/* indicate fio is in io_list */
 	bool is_meta;		/* indicate borrow meta inode mapping or not */
+	bool retry;		/* need to reallocate block address */
 	enum iostat_type io_type;	/* io type */
 	struct writeback_control *io_wbc; /* writeback control */
 };
@@ -2930,7 +2931,7 @@ void f2fs_submit_merged_write_cond(struct f2fs_sb_info *sbi,
 				enum page_type type);
 void f2fs_flush_merged_writes(struct f2fs_sb_info *sbi);
 int f2fs_submit_page_bio(struct f2fs_io_info *fio);
-int f2fs_submit_page_write(struct f2fs_io_info *fio);
+void f2fs_submit_page_write(struct f2fs_io_info *fio);
 struct block_device *f2fs_target_device(struct f2fs_sb_info *sbi,
 			block_t blk_addr, struct bio *bio);
 int f2fs_target_device_index(struct f2fs_sb_info *sbi, block_t blkaddr);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 885032fc3a61..5e632ed27dcd 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -603,6 +603,7 @@ static void move_data_block(struct inode *inode, block_t bidx,
 		.op_flags = 0,
 		.encrypted_page = NULL,
 		.in_list = false,
+		.retry = false,
 	};
 	struct dnode_of_data dn;
 	struct f2fs_summary sum;
@@ -697,8 +698,8 @@ static void move_data_block(struct inode *inode, block_t bidx,
 	fio.op = REQ_OP_WRITE;
 	fio.op_flags = REQ_SYNC;
 	fio.new_blkaddr = newaddr;
-	err = f2fs_submit_page_write(&fio);
-	if (err) {
+	f2fs_submit_page_write(&fio);
+	if (fio.retry) {
 		if (PageWriteback(fio.encrypted_page))
 			end_page_writeback(fio.encrypted_page);
 		goto put_page_out;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 76947f2856bf..50c781448a72 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2715,6 +2715,7 @@ void allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 
 		INIT_LIST_HEAD(&fio->list);
 		fio->in_list = true;
+		fio->retry = false;
 		io = sbi->write_io[fio->type] + fio->temp;
 		spin_lock(&io->io_lock);
 		list_add_tail(&fio->list, &io->io_list);
@@ -2750,7 +2751,6 @@ static void update_device_state(struct f2fs_io_info *fio)
 static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
 {
 	int type = __get_segment_type(fio);
-	int err;
 	bool keep_order = (test_opt(fio->sbi, LFS) && type == CURSEG_COLD_DATA);
 
 	if (keep_order)
@@ -2760,13 +2760,14 @@ static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
 			&fio->new_blkaddr, sum, type, fio, true);
 
 	/* writeout dirty page into bdev */
-	err = f2fs_submit_page_write(fio);
-	if (err == -EAGAIN) {
+	f2fs_submit_page_write(fio);
+	if (fio->retry) {
 		fio->old_blkaddr = fio->new_blkaddr;
 		goto reallocate;
-	} else if (!err) {
-		update_device_state(fio);
 	}
+
+	update_device_state(fio);
+
 	if (keep_order)
 		up_read(&fio->sbi->io_order_lock);
 }
-- 
2.16.2.17.g38e79b1fd
