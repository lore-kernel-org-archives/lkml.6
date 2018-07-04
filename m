Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088CAC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B431520899
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2M4Fmzl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B431520899
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752946AbeGDNUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 09:20:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:33166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752401AbeGDNUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 09:20:42 -0400
Received: from localhost.localdomain (unknown [121.237.127.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E94C72086A;
        Wed,  4 Jul 2018 13:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530710442;
        bh=dBNh7GremcUsM22Iw6EdUz1lny2DQNi8xfLu5pI6BqA=;
        h=From:To:Cc:Subject:Date:From;
        b=N2M4FmzlzFNOaDXS/YEb3UvwRcGVc43L00TxOvvXMCmpOXNIJUKG6gbs0Ip93ox9t
         RrdfX2JPJomYMeh/NsQnqqoZNsGLlI/Ja8tevipeCc1MU62qjbnSktkV6R6899NT9r
         7DGSHdr2NRWZXLv11CLcVzmIs9/YClM4W57WuJKs=
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2 1/2] f2fs: fix to skip GC if type in SSA and SIT is inconsistent
Date:   Wed,  4 Jul 2018 21:20:05 +0800
Message-Id: <20180704132005.20404-1-chao@kernel.org>
X-Mailer: git-send-email 2.16.2.17.g38e79b1fd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

If segment type in SSA and SIT is inconsistent, we will encounter below
BUG_ON during GC, to avoid this panic, let's just skip doing GC on such
segment.

The bug is triggered with image reported in below link:

https://bugzilla.kernel.org/show_bug.cgi?id=200223

[  388.060262] ------------[ cut here ]------------
[  388.060268] kernel BUG at /home/y00370721/git/devf2fs/gc.c:989!
[  388.061172] invalid opcode: 0000 [#1] SMP
[  388.061773] Modules linked in: f2fs(O) bluetooth ecdh_generic xt_tcpudp iptable_filter ip_tables x_tables lp ttm drm_kms_helper drm intel_rapl sb_edac crct10dif_pclmul crc32_pclmul ghash_clmulni_intel pcbc aesni_intel fb_sys_fops ppdev aes_x86_64 syscopyarea crypto_simd sysfillrect parport_pc joydev sysimgblt glue_helper parport cryptd i2c_piix4 serio_raw mac_hid btrfs hid_generic usbhid hid raid6_pq psmouse pata_acpi floppy
[  388.064247] CPU: 7 PID: 4151 Comm: f2fs_gc-7:0 Tainted: G           O    4.13.0-rc1+ #26
[  388.065306] Hardware name: Xen HVM domU, BIOS 4.1.2_115-900.260_ 11/06/2015
[  388.066058] task: ffff880201583b80 task.stack: ffffc90004d7c000
[  388.069948] RIP: 0010:do_garbage_collect+0xcc8/0xcd0 [f2fs]
[  388.070766] RSP: 0018:ffffc90004d7fc68 EFLAGS: 00010202
[  388.071783] RAX: ffff8801ed227000 RBX: 0000000000000001 RCX: ffffea0007b489c0
[  388.072700] RDX: ffff880000000000 RSI: 0000000000000001 RDI: ffffea0007b489c0
[  388.073607] RBP: ffffc90004d7fd58 R08: 0000000000000003 R09: ffffea0007b489dc
[  388.074619] R10: 0000000000000000 R11: 0052782ab317138d R12: 0000000000000018
[  388.075625] R13: 0000000000000018 R14: ffff880211ceb000 R15: ffff880211ceb000
[  388.076687] FS:  0000000000000000(0000) GS:ffff880214fc0000(0000) knlGS:0000000000000000
[  388.083277] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  388.084536] CR2: 0000000000e18c60 CR3: 00000001ecf2e000 CR4: 00000000001406e0
[  388.085748] Call Trace:
[  388.086690]  ? find_next_bit+0xb/0x10
[  388.088091]  f2fs_gc+0x1a8/0x9d0 [f2fs]
[  388.088888]  ? lock_timer_base+0x7d/0xa0
[  388.090213]  ? try_to_del_timer_sync+0x44/0x60
[  388.091698]  gc_thread_func+0x342/0x4b0 [f2fs]
[  388.092892]  ? wait_woken+0x80/0x80
[  388.094098]  kthread+0x109/0x140
[  388.095010]  ? f2fs_gc+0x9d0/0x9d0 [f2fs]
[  388.096043]  ? kthread_park+0x60/0x60
[  388.097281]  ret_from_fork+0x25/0x30
[  388.098401] Code: ff ff 48 83 e8 01 48 89 44 24 58 e9 27 f8 ff ff 48 83 e8 01 e9 78 fc ff ff 48 8d 78 ff e9 17 fb ff ff 48 83 ef 01 e9 4d f4 ff ff <0f> 0b 66 0f 1f 44 00 00 0f 1f 44 00 00 55 48 89 e5 41 56 41 55
[  388.100864] RIP: do_garbage_collect+0xcc8/0xcd0 [f2fs] RSP: ffffc90004d7fc68
[  388.101810] ---[ end trace 81c73d6e6b7da61d ]---

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2: add missing set_sbi_flag(sbi, SBI_NEED_FSCK).
 fs/f2fs/gc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 9093be6e7a7d..37ab2d10a872 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -986,7 +986,13 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 			goto next;
 
 		sum = page_address(sum_page);
-		f2fs_bug_on(sbi, type != GET_SUM_TYPE((&sum->footer)));
+		if (type != GET_SUM_TYPE((&sum->footer))) {
+			f2fs_msg(sbi->sb, KERN_ERR, "Inconsistent segment (%u) "
+				"type [%d, %d] in SSA and SIT",
+				segno, type, GET_SUM_TYPE((&sum->footer)));
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
+			goto next;
+		}
 
 		/*
 		 * this is to avoid deadlock:
-- 
2.16.2.17.g38e79b1fd

