Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3917C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83B982147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbfBSLoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 06:44:07 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:51833 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfBSLoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 06:44:06 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gw3oi-0005mr-Bw; Tue, 19 Feb 2019 11:44:04 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jan Kara <jack@suse.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][udf-next] udf: don't call mark_buffer_dirty on a null bh pointer
Date:   Tue, 19 Feb 2019 11:44:03 +0000
Message-Id: <20190219114403.24771-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a null check on the pointer bh to avoid a null pointer dereference
on bh->b_data however later bh is passed to mark_buffer_dirty that can also
cause a null pointer dereference on bh.  Avoid this potential null pointer
dereference by moving the call to mark_buffer_dirty inside the null checked
block.

Fixes: e8b4274735e4 ("udf: finalize integrity descriptor before writeback")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/udf/super.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/udf/super.c b/fs/udf/super.c
index a6940d90bedd..b7e9a83d39db 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -2336,13 +2336,13 @@ static int udf_sync_fs(struct super_block *sb, int wait)
 
 			lvid = (struct logicalVolIntegrityDesc *)bh->b_data;
 			udf_finalize_lvid(lvid);
-		}
 
-		/*
-		 * Blockdevice will be synced later so we don't have to submit
-		 * the buffer for IO
-		 */
-		mark_buffer_dirty(bh);
+			/*
+			 * Blockdevice will be synced later so we don't have
+			 * to submit the buffer for IO
+			 */
+			mark_buffer_dirty(bh);
+		}
 		sbi->s_lvid_dirty = 0;
 	}
 	mutex_unlock(&sbi->s_alloc_mutex);
-- 
2.20.1

