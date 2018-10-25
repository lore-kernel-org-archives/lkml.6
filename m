Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C68ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C269D2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="z654yQXi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C269D2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbeJYWuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:50:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:59626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729586AbeJYWuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:50:19 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 555F221479;
        Thu, 25 Oct 2018 14:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477042;
        bh=FhLrn+XztXFFX/rXyBLqONaUNwxcyoreUuxnApOWVvo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z654yQXiHbgLtIGNoqG7jRkTl1USI3WqIB5476+lCA+IV6u5tYKInHFfgL1zl9C9A
         FQ8rKQAwCIq7KLYirjA6wbWFClFN70wBuOiygJ/Jz4BgU0Kb0RwQN0puLCbU8IZc4S
         r81elNSkI3fRlFp7mQdDe7wLhjWpTUyPN9gHks+w=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Kosina <jkosina@suse.cz>, David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 08/65] btrfs: cleaner_kthread() doesn't need explicit freeze
Date:   Thu, 25 Oct 2018 10:16:08 -0400
Message-Id: <20181025141705.213937-8-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141705.213937-1-sashal@kernel.org>
References: <20181025141705.213937-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Kosina <jkosina@suse.cz>

[ Upstream commit 838fe1887765f4cc679febea60d87d2a06bd300e ]

cleaner_kthread() is not marked freezable, and therefore calling
try_to_freeze() in its context is a pointless no-op.

In addition to that, as has been clearly demonstrated by 80ad623edd2d
("Revert "btrfs: clear PF_NOFREEZE in cleaner_kthread()"), it's perfectly
valid / legal for cleaner_kthread() to stay scheduled out in an arbitrary
place during suspend (in that particular example that was waiting for
reading of extent pages), so there is no need to leave any traces of
freezer in this kthread.

Fixes: 80ad623edd2d ("Revert "btrfs: clear PF_NOFREEZE in cleaner_kthread()")
Fixes: 696249132158 ("btrfs: clear PF_NOFREEZE in cleaner_kthread()")
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/disk-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index ae6e3a30e61e..a2001abbe379 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1820,7 +1820,7 @@ static int cleaner_kthread(void *arg)
 		 */
 		btrfs_delete_unused_bgs(root->fs_info);
 sleep:
-		if (!try_to_freeze() && !again) {
+		if (!again) {
 			set_current_state(TASK_INTERRUPTIBLE);
 			if (!kthread_should_stop())
 				schedule();
-- 
2.17.1

