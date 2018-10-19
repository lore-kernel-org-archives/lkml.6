Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC0BECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A1B72083E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cBc7QY4e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A1B72083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbeJSQf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 12:35:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55097 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbeJSQf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 12:35:56 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BF6AD108161;
        Fri, 19 Oct 2018 04:30:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id; s=sasl; bh=QUNmTNyo2hUgM5LzL4ACzNLl61g
        =; b=cBc7QY4eSuZDP0fWuULMX8aHqqsUagf2++XW9rwxW62hkAn0ydvm6q8IPma
        OK+RazMJ/p0edX+yTFb39nI1CmsFS7tqYmNXjb0gkCbFKyvo0D/al0OFEgI7i7e2
        3PfaiFVVE2fpYoCym+HN0boAICXtNgS8XkJfJx2Li924bfAU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id; q=dns; s=sasl; b=ARwWJ3p1TDwwWzMrXSNQQ
        3l1X0LXBTZV+G9CLEO0ToeO9HOwiosh4PSEeNTyQ1ckj80el6Lxqa0li2p8bueYn
        jbEIhvzkEIopq3PVhcjnl0lNNvFEGqrLr4myXReTsanE25fadDSLUtcWFVIdjypX
        0ubYR20hHKpSK3H0K3PQ2E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B6B2A108160;
        Fri, 19 Oct 2018 04:30:50 -0400 (EDT)
Received: from love.attlocal.net (unknown [76.215.41.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C0BE610815F;
        Fri, 19 Oct 2018 04:30:49 -0400 (EDT)
From:   Daniel Santos <daniel.santos@pobox.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Daniel Santos <daniel.santos@pobox.com>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-mtd@lists.infradead.org
Subject: [PATCH] jffs2: Fix use of uninitialized delayed_work, lockdep breakage
Date:   Fri, 19 Oct 2018 03:30:20 -0500
Message-Id: <20181019083020.14335-1-daniel.santos@pobox.com>
X-Mailer: git-send-email 2.16.4
X-Pobox-Relay-ID: 48D4DB48-D379-11E8-9AAA-063AD72159A7-06139138!pb-smtp1.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 fs/jffs2/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
index 793ad30970ff..cae4ecda3c50 100644
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
2.16.4

