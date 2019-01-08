Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADE4C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0993620645
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546975679;
	bh=HywN864SVKIN2CpUdBZL26z4S1wjWXTSoW4kReZv2Os=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FwOHk3PLMUOgS1O4hQfv21e0QSpJz1RnPvHeXIp75kArQ806KrGq5zpqkspdmK82U
	 D/zYNOAYqGAjWDrs4DWhuvt+ob88ix4GNsIynnTf1uTsYRXAr3XL1dlmkVvotCVZb5
	 dgs0Im0+Upe7bzpey+ZYFaE/IX7mpVsjJu0/7GHM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729844AbfAHT15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:27:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:34320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729115AbfAHT1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:27:51 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC618217D9;
        Tue,  8 Jan 2019 19:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975670;
        bh=HywN864SVKIN2CpUdBZL26z4S1wjWXTSoW4kReZv2Os=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lII/uSa+s6OH8/OOk9+L1gYXtJphTdz3QaWn3RzLYDsH2u8RAcefQvmeov3Qbg+K6
         zHPCpfnRIPtchTOobrLhtgAYQrscbxPf7Z/NBqHgDOBnBERz0T0zIENd+/BPGAPxJV
         /Y0UiD6cH2w+4X/iT2fXgPqRB4S9ikL9JPu1bFWI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Daniel Santos <daniel.santos@pobox.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Sasha Levin <sashal@kernel.org>, linux-mtd@lists.infradead.org
Subject: [PATCH AUTOSEL 4.20 042/117] jffs2: Fix use of uninitialized delayed_work, lockdep breakage
Date:   Tue,  8 Jan 2019 14:25:10 -0500
Message-Id: <20190108192628.121270-42-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192628.121270-1-sashal@kernel.org>
References: <20190108192628.121270-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Santos <daniel.santos@pobox.com>

[ Upstream commit a788c5272769ddbcdbab297cf386413eeac04463 ]

jffs2_sync_fs makes the assumption that if CONFIG_JFFS2_FS_WRITEBUFFER
is defined then a write buffer is available and has been initialized.
However, this does is not the case when the mtd device has no
out-of-band buffer:

int jffs2_nand_flash_setup(struct jffs2_sb_info *c)
{
        if (!c->mtd->oobsize)
                return 0;
...

The resulting call to cancel_delayed_work_sync passing a uninitialized
(but zeroed) delayed_work struct forces lockdep to become disabled.

[   90.050639] overlayfs: upper fs does not support tmpfile.
[   90.652264] INFO: trying to register non-static key.
[   90.662171] the code is fine but needs lockdep annotation.
[   90.673090] turning off the locking correctness validator.
[   90.684021] CPU: 0 PID: 1762 Comm: mount_root Not tainted 4.14.63 #0
[   90.696672] Stack : 00000000 00000000 80d8f6a2 00000038 805f0000 80444600 8fe364f4 805dfbe7
[   90.713349]         80563a30 000006e2 8068370c 00000001 00000000 00000001 8e2fdc48 ffffffff
[   90.730020]         00000000 00000000 80d90000 00000000 00000106 00000000 6465746e 312e3420
[   90.746690]         6b636f6c 03bf0000 f8000000 20676e69 00000000 80000000 00000000 8e2c2a90
[   90.763362]         80d90000 00000001 00000000 8e2c2a90 00000003 80260dc0 08052098 80680000
[   90.780033]         ...
[   90.784902] Call Trace:
[   90.789793] [<8000f0d8>] show_stack+0xb8/0x148
[   90.798659] [<8005a000>] register_lock_class+0x270/0x55c
[   90.809247] [<8005cb64>] __lock_acquire+0x13c/0xf7c
[   90.818964] [<8005e314>] lock_acquire+0x194/0x1dc
[   90.828345] [<8003f27c>] flush_work+0x200/0x24c
[   90.837374] [<80041dfc>] __cancel_work_timer+0x158/0x210
[   90.847958] [<801a8770>] jffs2_sync_fs+0x20/0x54
[   90.857173] [<80125cf4>] iterate_supers+0xf4/0x120
[   90.866729] [<80158fc4>] sys_sync+0x44/0x9c
[   90.875067] [<80014424>] syscall_common+0x34/0x58

Signed-off-by: Daniel Santos <daniel.santos@pobox.com>
Reviewed-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jffs2/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
index 902a7dd10e5c..bb6ae387469f 100644
--- a/fs/jffs2/super.c
+++ b/fs/jffs2/super.c
@@ -101,7 +101,8 @@ static int jffs2_sync_fs(struct super_block *sb, int wait)
 	struct jffs2_sb_info *c = JFFS2_SB_INFO(sb);
 
 #ifdef CONFIG_JFFS2_FS_WRITEBUFFER
-	cancel_delayed_work_sync(&c->wbuf_dwork);
+	if (jffs2_is_writebuffered(c))
+		cancel_delayed_work_sync(&c->wbuf_dwork);
 #endif
 
 	mutex_lock(&c->alloc_sem);
-- 
2.19.1

