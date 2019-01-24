Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C42BC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4068D218D2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548357779;
	bh=HFcseFG8aM3IvFd1IqAuCoYM9o4WcolVzD9T1rdkhgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=onB7kCe+b8y8RTAQcdBGNUE9YT81p8HwkZwIilw1vEkQqLvr080PgcZn9nhCrdO9B
	 eMQaxPEMKwLzR1Iw4YUSSiSaEyjlRJQcIghAH3zpNAAGjtU8qd77y/HJRs32ljhRnV
	 BB0HsVH5a8D4ynXECrOBT3Xu+xdVPN8NrzxqVMuU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbfAXTW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:22:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:47580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729671AbfAXTWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:22:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98A5E218D2;
        Thu, 24 Jan 2019 19:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548357774;
        bh=HFcseFG8aM3IvFd1IqAuCoYM9o4WcolVzD9T1rdkhgc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RfPCrR7ngXro0wlaXE5II7E6VvVPBbNomzylL4qCMT6gaMLZZNw6y3wEjPP0LpkJI
         9tENP+B/oHGVjVRgc44CebTE+OYIT2T8hkzDv9CEoOeLjStoHtvmwoO46NBjE9AOF6
         2xNlsLWopnWCr+ik/GW7NaszgzD7Kn0Gcdoqr52E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Santos <daniel.santos@pobox.com>,
        Hou Tao <houtao1@huawei.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 36/52] jffs2: Fix use of uninitialized delayed_work, lockdep breakage
Date:   Thu, 24 Jan 2019 20:20:00 +0100
Message-Id: <20190124190148.566975600@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190140.879495253@linuxfoundation.org>
References: <20190124190140.879495253@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index f3194e5147fd..0bbc31d10857 100644
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



