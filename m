Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72EB7C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EA4720827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546975868;
	bh=CbIPBwfBo76sl2qyFn/l9NF/DWR6u4cXB2RjodrXA2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uWFNkg6veO8Btj3hkjpEe1HLOrKUG3vTwNILLrynpnZjRvZ+d6kt+Rx40yJhciH/Q
	 Fd4ttJf9F7P2LHH3yh5+zFCMO/c16jICaJmlQilgyufauKqkK5cVPjoTS6X6RC1WQB
	 j8gL6AaL6bGEvI+p1v7e0Ccs/6MFehlQ2ntLjDcU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730985AbfAHTbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:31:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:39030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730960AbfAHTbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:31:03 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE2952176F;
        Tue,  8 Jan 2019 19:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975862;
        bh=CbIPBwfBo76sl2qyFn/l9NF/DWR6u4cXB2RjodrXA2o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qjr8T8/ToLrp/VUs0s+QefrzKZ4LKTAMcg1LsSvnqy4GrrpdwNOcQ5Q+hP42jlitp
         4vvEd0DE3bPUfETlz2KU8GTMHmQeG70m9/S7g8kYTbT8Be4XvqIjW6U8NxD/kJbtKe
         3oYchDiIw8jYIGf2KsmrS99kOz0EubFkywjgflGA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Gao Xiang <gaoxiang25@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-erofs@lists.ozlabs.org,
        devel@driverdev.osuosl.org
Subject: [PATCH AUTOSEL 4.19 44/97] staging: erofs: fix use-after-free of on-stack `z_erofs_vle_unzip_io'
Date:   Tue,  8 Jan 2019 14:28:53 -0500
Message-Id: <20190108192949.122407-44-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192949.122407-1-sashal@kernel.org>
References: <20190108192949.122407-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gao Xiang <gaoxiang25@huawei.com>

[ Upstream commit 848bd9acdcd00c164b42b14aacec242949ecd471 ]

The root cause is the race as follows:
 Thread #0                         Thread #1

 z_erofs_vle_unzip_kickoff         z_erofs_submit_and_unzip

                                    struct z_erofs_vle_unzip_io io[]
   atomic_add_return()
                                    wait_event()
                                    [end of function]
   wake_up()

Fix it by taking the waitqueue lock between atomic_add_return and
wake_up to close such the race.

kernel message:

Unable to handle kernel paging request at virtual address 97f7052caa1303dc
...
Workqueue: kverityd verity_work
task: ffffffe32bcb8000 task.stack: ffffffe3298a0000
PC is at __wake_up_common+0x48/0xa8
LR is at __wake_up+0x3c/0x58
...
Call trace:
...
[<ffffff94a08ff648>] __wake_up_common+0x48/0xa8
[<ffffff94a08ff8b8>] __wake_up+0x3c/0x58
[<ffffff94a0c11b60>] z_erofs_vle_unzip_kickoff+0x40/0x64
[<ffffff94a0c118e4>] z_erofs_vle_read_endio+0x94/0x134
[<ffffff94a0c83c9c>] bio_endio+0xe4/0xf8
[<ffffff94a1076540>] dec_pending+0x134/0x32c
[<ffffff94a1076f28>] clone_endio+0x90/0xf4
[<ffffff94a0c83c9c>] bio_endio+0xe4/0xf8
[<ffffff94a1095024>] verity_work+0x210/0x368
[<ffffff94a08c4150>] process_one_work+0x188/0x4b4
[<ffffff94a08c45bc>] worker_thread+0x140/0x458
[<ffffff94a08cad48>] kthread+0xec/0x108
[<ffffff94a0883ab4>] ret_from_fork+0x10/0x1c
Code: d1006273 54000260 f9400804 b9400019 (b85fc081)
---[ end trace be9dde154f677cd1 ]---

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/erofs/unzip_vle.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index 14da8cc2246a..0346630b67c8 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -724,13 +724,18 @@ static void z_erofs_vle_unzip_kickoff(void *ptr, int bios)
 	struct z_erofs_vle_unzip_io *io = tagptr_unfold_ptr(t);
 	bool background = tagptr_unfold_tags(t);
 
-	if (atomic_add_return(bios, &io->pending_bios))
+	if (!background) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&io->u.wait.lock, flags);
+		if (!atomic_add_return(bios, &io->pending_bios))
+			wake_up_locked(&io->u.wait);
+		spin_unlock_irqrestore(&io->u.wait.lock, flags);
 		return;
+	}
 
-	if (background)
+	if (!atomic_add_return(bios, &io->pending_bios))
 		queue_work(z_erofs_workqueue, &io->u.work);
-	else
-		wake_up(&io->u.wait);
 }
 
 static inline void z_erofs_vle_read_endio(struct bio *bio)
-- 
2.19.1

