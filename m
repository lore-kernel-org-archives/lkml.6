Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB81CECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F92A2083A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:42:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F92A2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388970AbeIXSog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:44:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59360 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731786AbeIXSog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:44:36 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 99153E1C;
        Mon, 24 Sep 2018 12:42:37 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 193/235] f2fs: do checkpoint in kill_sb
Date:   Mon, 24 Sep 2018 13:52:59 +0200
Message-Id: <20180924113123.679785167@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jaegeuk Kim <jaegeuk@kernel.org>

[ Upstream commit 1cb50f87e10696e8cc61fb62d0d948e11b0e6dc1 ]

When unmounting f2fs in force mode, we can get it stuck by io_schedule()
by some pending IOs in meta_inode.

io_schedule+0xd/0x30
wait_on_page_bit_common+0xc6/0x130
__filemap_fdatawait_range+0xbd/0x100
filemap_fdatawait_keep_errors+0x15/0x40
sync_inodes_sb+0x1cf/0x240
sync_filesystem+0x52/0x90
generic_shutdown_super+0x1d/0x110
kill_f2fs_super+0x28/0x80 [f2fs]
deactivate_locked_super+0x35/0x60
cleanup_mnt+0x36/0x70
task_work_run+0x79/0xa0
exit_to_usermode_loop+0x62/0x70
do_syscall_64+0xdb/0xf0
entry_SYSCALL_64_after_hwframe+0x44/0xa9
0xffffffffffffffff

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/super.c |   16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3106,9 +3106,19 @@ static struct dentry *f2fs_mount(struct
 static void kill_f2fs_super(struct super_block *sb)
 {
 	if (sb->s_root) {
-		set_sbi_flag(F2FS_SB(sb), SBI_IS_CLOSE);
-		f2fs_stop_gc_thread(F2FS_SB(sb));
-		f2fs_stop_discard_thread(F2FS_SB(sb));
+		struct f2fs_sb_info *sbi = F2FS_SB(sb);
+
+		set_sbi_flag(sbi, SBI_IS_CLOSE);
+		f2fs_stop_gc_thread(sbi);
+		f2fs_stop_discard_thread(sbi);
+
+		if (is_sbi_flag_set(sbi, SBI_IS_DIRTY) ||
+				!is_set_ckpt_flags(sbi, CP_UMOUNT_FLAG)) {
+			struct cp_control cpc = {
+				.reason = CP_UMOUNT,
+			};
+			f2fs_write_checkpoint(sbi, &cpc);
+		}
 	}
 	kill_block_super(sb);
 }


