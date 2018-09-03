Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DATE_IN_PAST_12_24,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11E8C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 13:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61EE620659
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 13:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWRgw8hd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61EE620659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbeIDRuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 13:50:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:37910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbeIDRuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 13:50:04 -0400
Received: from localhost.localdomain (unknown [49.65.250.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BD9D20867;
        Tue,  4 Sep 2018 13:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536067495;
        bh=lNb2A4ATK/KXE8de64XHCMfdbB4bwER+vR+VEGe6M64=;
        h=From:To:Cc:Subject:Date:From;
        b=eWRgw8hditfERJM5S+1vTZczlq9wjuDm2s3Kfwszh4w4iYG8noXTOyVInugE9iIkW
         rrLUak26i744yp4jmB7HrTthSHjUZ7HtMQuc6z2PqujC5E8QOsg12uAwypJdZswbfL
         BvI9qcU4TuixRAIFLfxZI5K37n6mIXwOVL0XPv/k=
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     vicencb@gmail.com, yuchao0@huawei.com,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] f2fs: fix to avoid NULL pointer dereference on se->discard_map
Date:   Tue,  4 Sep 2018 03:52:17 +0800
Message-Id: <20180903195217.5968-1-chao@kernel.org>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

https://bugzilla.kernel.org/show_bug.cgi?id=200951

These is a NULL pointer dereference issue reported in bugzilla:

Hi,
in the setup there is a SATA SSD connected to a SATA-to-USB bridge.

The disc is "Samsung SSD 850 PRO 256G" which supports TRIM.
There are four partitions:
 sda1: FAT  /boot
 sda2: F2FS /
 sda3: F2FS /home
 sda4: F2FS

The bridge is ASMT1153e which uses the "uas" driver.
There is no TRIM pass-through, so, when mounting it reports:
 mounting with "discard" option, but the device does not support discard

The USB host is USB3.0 and UASP capable. It is the one on RK3399.

Given this everything works fine, except there is no TRIM support.

In order to enable TRIM a new UDEV rule is added [1]:
 /etc/udev/rules.d/10-sata-bridge-trim.rules:
 ACTION=="add|change", ATTRS{idVendor}=="174c", ATTRS{idProduct}=="55aa", SUBSYSTEM=="scsi_disk", ATTR{provisioning_mode}="unmap"
After reboot any F2FS write hangs forever and dmesg reports:
 Unable to handle kernel NULL pointer dereference

Also tested on a x86_64 system: works fine even with TRIM enabled.
 same disc
 same bridge
 different usb host controller
 different cpu architecture
 not root filesystem

Regards,
  Vicenç.

[1] Post #5 in https://bbs.archlinux.org/viewtopic.php?id=236280

 Unable to handle kernel NULL pointer dereference at virtual address 000000000000003e
 Mem abort info:
   ESR = 0x96000004
   Exception class = DABT (current EL), IL = 32 bits
   SET = 0, FnV = 0
   EA = 0, S1PTW = 0
 Data abort info:
   ISV = 0, ISS = 0x00000004
   CM = 0, WnR = 0
 user pgtable: 4k pages, 48-bit VAs, pgdp = 00000000626e3122
 [000000000000003e] pgd=0000000000000000
 Internal error: Oops: 96000004 [#1] SMP
 Modules linked in: overlay snd_soc_hdmi_codec rc_cec dw_hdmi_i2s_audio dw_hdmi_cec snd_soc_simple_card snd_soc_simple_card_utils snd_soc_rockchip_i2s rockchip_rga snd_soc_rockchip_pcm rockchipdrm videobuf2_dma_sg v4l2_mem2mem rtc_rk808 videobuf2_memops analogix_dp videobuf2_v4l2 videobuf2_common dw_hdmi dw_wdt cec rc_core videodev drm_kms_helper media drm rockchip_thermal rockchip_saradc realtek drm_panel_orientation_quirks syscopyarea sysfillrect sysimgblt fb_sys_fops dwmac_rk stmmac_platform stmmac pwm_bl squashfs loop crypto_user gpio_keys hid_kensington
 CPU: 5 PID: 957 Comm: nvim Not tainted 4.19.0-rc1-1-ARCH #1
 Hardware name: Sapphire-RK3399 Board (DT)
 pstate: 00000005 (nzcv daif -PAN -UAO)
 pc : update_sit_entry+0x304/0x4b0
 lr : update_sit_entry+0x108/0x4b0
 sp : ffff00000ca13bd0
 x29: ffff00000ca13bd0 x28: 000000000000003e
 x27: 0000000000000020 x26: 0000000000080000
 x25: 0000000000000048 x24: ffff8000ebb85cf8
 x23: 0000000000000253 x22: 00000000ffffffff
 x21: 00000000000535f2 x20: 00000000ffffffdf
 x19: ffff8000eb9e6800 x18: ffff8000eb9e6be8
 x17: 0000000007ce6926 x16: 000000001c83ffa8
 x15: 0000000000000000 x14: ffff8000f602df90
 x13: 0000000000000006 x12: 0000000000000040
 x11: 0000000000000228 x10: 0000000000000000
 x9 : 0000000000000000 x8 : 0000000000000000
 x7 : 00000000000535f2 x6 : ffff8000ebff3440
 x5 : ffff8000ebff3440 x4 : ffff8000ebe3a6c8
 x3 : 00000000ffffffff x2 : 0000000000000020
 x1 : 0000000000000000 x0 : ffff8000eb9e5800
 Process nvim (pid: 957, stack limit = 0x0000000063a78320)
 Call trace:
  update_sit_entry+0x304/0x4b0
  f2fs_invalidate_blocks+0x98/0x140
  truncate_node+0x90/0x400
  f2fs_remove_inode_page+0xe8/0x340
  f2fs_evict_inode+0x2b0/0x408
  evict+0xe0/0x1e0
  iput+0x160/0x260
  do_unlinkat+0x214/0x298
  __arm64_sys_unlinkat+0x3c/0x68
  el0_svc_handler+0x94/0x118
  el0_svc+0x8/0xc
 Code: f9400800 b9488400 36080140 f9400f01 (387c4820)
 ---[ end trace a0f21a307118c477 ]---

The reason is it is possible to enable discard flag on block queue via
UDEV, but during mount, f2fs will initialize se->discard_map only if
this flag is set, once the flag is set after mount, f2fs may dereference
NULL pointer on se->discard_map.

So this patch does below changes to fix this issue:
- initialize and update se->discard_map all the time.
- don't clear DISCARD option if device has no QUEUE_FLAG_DISCARD flag
during mount.
- don't issue small discard on zoned block device.
- introduce some functions to enhance the readability.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- rebase to last dev branch.
 fs/f2fs/debug.c   |  3 +--
 fs/f2fs/f2fs.h    | 15 ++++++++---
 fs/f2fs/file.c    |  2 +-
 fs/f2fs/segment.c | 65 ++++++++++++++++++++---------------------------
 fs/f2fs/super.c   | 16 +++---------
 5 files changed, 46 insertions(+), 55 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 214a968962a1..ebe649d9793c 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -190,8 +190,7 @@ static void update_mem_info(struct f2fs_sb_info *sbi)
 	si->base_mem += MAIN_SEGS(sbi) * sizeof(struct seg_entry);
 	si->base_mem += f2fs_bitmap_size(MAIN_SEGS(sbi));
 	si->base_mem += 2 * SIT_VBLOCK_MAP_SIZE * MAIN_SEGS(sbi);
-	if (f2fs_discard_en(sbi))
-		si->base_mem += SIT_VBLOCK_MAP_SIZE * MAIN_SEGS(sbi);
+	si->base_mem += SIT_VBLOCK_MAP_SIZE * MAIN_SEGS(sbi);
 	si->base_mem += SIT_VBLOCK_MAP_SIZE;
 	if (sbi->segs_per_sec > 1)
 		si->base_mem += MAIN_SECS(sbi) * sizeof(struct sec_entry);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 96bde026636f..b575ec75ef87 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3399,11 +3399,20 @@ static inline int get_blkz_type(struct f2fs_sb_info *sbi,
 }
 #endif
 
-static inline bool f2fs_discard_en(struct f2fs_sb_info *sbi)
+static inline bool f2fs_hw_should_discard(struct f2fs_sb_info *sbi)
 {
-	struct request_queue *q = bdev_get_queue(sbi->sb->s_bdev);
+	return f2fs_sb_has_blkzoned(sbi->sb);
+}
 
-	return blk_queue_discard(q) || f2fs_sb_has_blkzoned(sbi->sb);
+static inline bool f2fs_hw_support_discard(struct f2fs_sb_info *sbi)
+{
+	return blk_queue_discard(bdev_get_queue(sbi->sb->s_bdev));
+}
+
+static inline bool f2fs_realtime_discard_enable(struct f2fs_sb_info *sbi)
+{
+	return (test_opt(sbi, DISCARD) && f2fs_hw_support_discard(sbi)) ||
+					f2fs_hw_should_discard(sbi);
 }
 
 static inline void set_opt_mode(struct f2fs_sb_info *sbi, unsigned int mt)
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 5474aaa274b9..ca66b3eb197a 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1978,7 +1978,7 @@ static int f2fs_ioc_fitrim(struct file *filp, unsigned long arg)
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	if (!blk_queue_discard(q))
+	if (!f2fs_hw_support_discard(F2FS_SB(sb)))
 		return -EOPNOTSUPP;
 
 	if (copy_from_user(&range, (struct fstrim_range __user *)arg,
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 30779aaa9dba..c372ff755818 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1725,11 +1725,11 @@ static bool add_discard_addrs(struct f2fs_sb_info *sbi, struct cp_control *cpc,
 	struct list_head *head = &SM_I(sbi)->dcc_info->entry_list;
 	int i;
 
-	if (se->valid_blocks == max_blocks || !f2fs_discard_en(sbi))
+	if (se->valid_blocks == max_blocks || !f2fs_hw_support_discard(sbi))
 		return false;
 
 	if (!force) {
-		if (!test_opt(sbi, DISCARD) || !se->valid_blocks ||
+		if (!f2fs_realtime_discard_enable(sbi) || !se->valid_blocks ||
 			SM_I(sbi)->dcc_info->nr_discards >=
 				SM_I(sbi)->dcc_info->max_discards)
 			return false;
@@ -1835,7 +1835,7 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
 				dirty_i->nr_dirty[PRE]--;
 		}
 
-		if (!test_opt(sbi, DISCARD))
+		if (!f2fs_realtime_discard_enable(sbi))
 			continue;
 
 		if (force && start >= cpc->trim_start &&
@@ -2025,8 +2025,7 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
 			del = 0;
 		}
 
-		if (f2fs_discard_en(sbi) &&
-			!f2fs_test_and_set_bit(offset, se->discard_map))
+		if (!f2fs_test_and_set_bit(offset, se->discard_map))
 			sbi->discard_blks--;
 
 		/* don't overwrite by SSR to keep node chain */
@@ -2054,8 +2053,7 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
 			del = 0;
 		}
 
-		if (f2fs_discard_en(sbi) &&
-			f2fs_test_and_clear_bit(offset, se->discard_map))
+		if (f2fs_test_and_clear_bit(offset, se->discard_map))
 			sbi->discard_blks++;
 	}
 	if (!f2fs_test_bit(offset, se->ckpt_valid_map))
@@ -2671,7 +2669,7 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 	 * discard option. User configuration looks like using runtime discard
 	 * or periodic fstrim instead of it.
 	 */
-	if (test_opt(sbi, DISCARD))
+	if (f2fs_realtime_discard_enable(sbi))
 		goto out;
 
 	start_block = START_BLOCK(sbi, start_segno);
@@ -3762,13 +3760,11 @@ static int build_sit_info(struct f2fs_sb_info *sbi)
 			return -ENOMEM;
 #endif
 
-		if (f2fs_discard_en(sbi)) {
-			sit_i->sentries[start].discard_map
-				= f2fs_kzalloc(sbi, SIT_VBLOCK_MAP_SIZE,
-								GFP_KERNEL);
-			if (!sit_i->sentries[start].discard_map)
-				return -ENOMEM;
-		}
+		sit_i->sentries[start].discard_map
+			= f2fs_kzalloc(sbi, SIT_VBLOCK_MAP_SIZE,
+							GFP_KERNEL);
+		if (!sit_i->sentries[start].discard_map)
+			return -ENOMEM;
 	}
 
 	sit_i->tmp_map = f2fs_kzalloc(sbi, SIT_VBLOCK_MAP_SIZE, GFP_KERNEL);
@@ -3916,18 +3912,16 @@ static int build_sit_entries(struct f2fs_sb_info *sbi)
 				total_node_blocks += se->valid_blocks;
 
 			/* build discard map only one time */
-			if (f2fs_discard_en(sbi)) {
-				if (is_set_ckpt_flags(sbi, CP_TRIMMED_FLAG)) {
-					memset(se->discard_map, 0xff,
-						SIT_VBLOCK_MAP_SIZE);
-				} else {
-					memcpy(se->discard_map,
-						se->cur_valid_map,
-						SIT_VBLOCK_MAP_SIZE);
-					sbi->discard_blks +=
-						sbi->blocks_per_seg -
-						se->valid_blocks;
-				}
+			if (is_set_ckpt_flags(sbi, CP_TRIMMED_FLAG)) {
+				memset(se->discard_map, 0xff,
+					SIT_VBLOCK_MAP_SIZE);
+			} else {
+				memcpy(se->discard_map,
+					se->cur_valid_map,
+					SIT_VBLOCK_MAP_SIZE);
+				sbi->discard_blks +=
+					sbi->blocks_per_seg -
+					se->valid_blocks;
 			}
 
 			if (sbi->segs_per_sec > 1)
@@ -3965,16 +3959,13 @@ static int build_sit_entries(struct f2fs_sb_info *sbi)
 		if (IS_NODESEG(se->type))
 			total_node_blocks += se->valid_blocks;
 
-		if (f2fs_discard_en(sbi)) {
-			if (is_set_ckpt_flags(sbi, CP_TRIMMED_FLAG)) {
-				memset(se->discard_map, 0xff,
-							SIT_VBLOCK_MAP_SIZE);
-			} else {
-				memcpy(se->discard_map, se->cur_valid_map,
-							SIT_VBLOCK_MAP_SIZE);
-				sbi->discard_blks += old_valid_blocks;
-				sbi->discard_blks -= se->valid_blocks;
-			}
+		if (is_set_ckpt_flags(sbi, CP_TRIMMED_FLAG)) {
+			memset(se->discard_map, 0xff, SIT_VBLOCK_MAP_SIZE);
+		} else {
+			memcpy(se->discard_map, se->cur_valid_map,
+						SIT_VBLOCK_MAP_SIZE);
+			sbi->discard_blks += old_valid_blocks;
+			sbi->discard_blks -= se->valid_blocks;
 		}
 
 		if (sbi->segs_per_sec > 1) {
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 53d70b64fea1..5cad0f7687e9 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -360,7 +360,6 @@ static int f2fs_check_quota_options(struct f2fs_sb_info *sbi)
 static int parse_options(struct super_block *sb, char *options)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
-	struct request_queue *q;
 	substring_t args[MAX_OPT_ARGS];
 	char *p, *name;
 	int arg = 0;
@@ -415,14 +414,7 @@ static int parse_options(struct super_block *sb, char *options)
 				return -EINVAL;
 			break;
 		case Opt_discard:
-			q = bdev_get_queue(sb->s_bdev);
-			if (blk_queue_discard(q)) {
-				set_opt(sbi, DISCARD);
-			} else if (!f2fs_sb_has_blkzoned(sb)) {
-				f2fs_msg(sb, KERN_WARNING,
-					"mounting with \"discard\" option, but "
-					"the device does not support discard");
-			}
+			set_opt(sbi, DISCARD);
 			break;
 		case Opt_nodiscard:
 			if (f2fs_sb_has_blkzoned(sb)) {
@@ -1032,7 +1024,8 @@ static void f2fs_put_super(struct super_block *sb)
 	/* be sure to wait for any on-going discard commands */
 	dropped = f2fs_wait_discard_bios(sbi);
 
-	if (f2fs_discard_en(sbi) && !sbi->discard_blks && !dropped) {
+	if ((f2fs_hw_support_discard(sbi) || f2fs_hw_should_discard(sbi)) &&
+					!sbi->discard_blks && !dropped) {
 		struct cp_control cpc = {
 			.reason = CP_UMOUNT | CP_TRIMMED,
 		};
@@ -1399,8 +1392,7 @@ static void default_options(struct f2fs_sb_info *sbi)
 	set_opt(sbi, NOHEAP);
 	sbi->sb->s_flags |= SB_LAZYTIME;
 	set_opt(sbi, FLUSH_MERGE);
-	if (blk_queue_discard(bdev_get_queue(sbi->sb->s_bdev)))
-		set_opt(sbi, DISCARD);
+	set_opt(sbi, DISCARD);
 	if (f2fs_sb_has_blkzoned(sbi->sb))
 		set_opt_mode(sbi, F2FS_MOUNT_LFS);
 	else
-- 
2.18.0

