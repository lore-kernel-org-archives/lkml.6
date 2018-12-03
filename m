Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D736C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 07:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9E022145D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 07:52:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9E022145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbeLCHw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 02:52:26 -0500
Received: from mail.bootlin.com ([62.4.15.54]:48861 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbeLCHwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 02:52:25 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D1BF020D04; Mon,  3 Dec 2018 08:52:19 +0100 (CET)
Received: from localhost.localdomain (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 9B5B42071D;
        Mon,  3 Dec 2018 08:52:19 +0100 (CET)
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Daniel Santos <daniel.santos@pobox.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-mtd@lists.infradead.org
Subject: Re: jffs2: Fix use of uninitialized delayed_work, lockdep breakage
Date:   Mon,  3 Dec 2018 08:52:19 +0100
Message-Id: <20181203075219.29061-1-boris.brezillon@bootlin.com>
X-Mailer: git-send-email 2.17.1
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: a788c5272769ddbcdbab297cf386413eeac04463
In-Reply-To: <20181019083020.14335-1-daniel.santos@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-10-19 at 08:30:20 UTC, Daniel Santos wrote:
> jffs2_sync_fs makes the assumption that if CONFIG_JFFS2_FS_WRITEBUFFER
> is defined then a write buffer is available and has been initialized.
> However, this does is not the case when the mtd device has no
> out-of-band buffer:
> 
> int jffs2_nand_flash_setup(struct jffs2_sb_info *c)
> {
>         if (!c->mtd->oobsize)
>                 return 0;
> ...
> 
> The resulting call to cancel_delayed_work_sync passing a uninitialized
> (but zeroed) delayed_work struct forces lockdep to become disabled.
> 
> [   90.050639] overlayfs: upper fs does not support tmpfile.
> [   90.652264] INFO: trying to register non-static key.
> [   90.662171] the code is fine but needs lockdep annotation.
> [   90.673090] turning off the locking correctness validator.
> [   90.684021] CPU: 0 PID: 1762 Comm: mount_root Not tainted 4.14.63 #0
> [   90.696672] Stack : 00000000 00000000 80d8f6a2 00000038 805f0000 80444600 8fe364f4 805dfbe7
> [   90.713349]         80563a30 000006e2 8068370c 00000001 00000000 00000001 8e2fdc48 ffffffff
> [   90.730020]         00000000 00000000 80d90000 00000000 00000106 00000000 6465746e 312e3420
> [   90.746690]         6b636f6c 03bf0000 f8000000 20676e69 00000000 80000000 00000000 8e2c2a90
> [   90.763362]         80d90000 00000001 00000000 8e2c2a90 00000003 80260dc0 08052098 80680000
> [   90.780033]         ...
> [   90.784902] Call Trace:
> [   90.789793] [<8000f0d8>] show_stack+0xb8/0x148
> [   90.798659] [<8005a000>] register_lock_class+0x270/0x55c
> [   90.809247] [<8005cb64>] __lock_acquire+0x13c/0xf7c
> [   90.818964] [<8005e314>] lock_acquire+0x194/0x1dc
> [   90.828345] [<8003f27c>] flush_work+0x200/0x24c
> [   90.837374] [<80041dfc>] __cancel_work_timer+0x158/0x210
> [   90.847958] [<801a8770>] jffs2_sync_fs+0x20/0x54
> [   90.857173] [<80125cf4>] iterate_supers+0xf4/0x120
> [   90.866729] [<80158fc4>] sys_sync+0x44/0x9c
> [   90.875067] [<80014424>] syscall_common+0x34/0x58
> 
> Signed-off-by: Daniel Santos <daniel.santos@pobox.com>
> Reviewed-by: Hou Tao <houtao1@huawei.com>

Applied to http://git.infradead.org/linux-mtd.git mtd/next, thanks.

Boris
