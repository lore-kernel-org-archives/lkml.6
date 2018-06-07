Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id dIB+DhRaGVtbDQAAmS7hNA
	; Thu, 07 Jun 2018 16:15:16 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2B3646089E; Thu,  7 Jun 2018 16:15:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 47A0B607E7;
	Thu,  7 Jun 2018 16:15:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 47A0B607E7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934400AbeFGQOq (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:14:46 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39122 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932927AbeFGOI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:08:58 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvay-0005Zu-Co; Thu, 07 Jun 2018 15:08:56 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvax-0002h3-FR; Thu, 07 Jun 2018 15:08:55 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Jaegeuk Kim" <jaegeuk@kernel.org>,
        "Yunlei He" <heyunlei@huawei.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.602960001@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 013/410] f2fs: fix a panic caused by NULL
 flush_cmd_control
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Yunlei He <heyunlei@huawei.com>

commit d4fdf8ba0e5808ba9ad6b44337783bd9935e0982 upstream.

Mount fs with option noflush_merge, boot failed for illegal address
fcc in function f2fs_issue_flush:

        if (!test_opt(sbi, FLUSH_MERGE)) {
                ret = submit_flush_wait(sbi);
                atomic_inc(&fcc->issued_flush);   ->  Here, fcc illegal
                return ret;
        }

Signed-off-by: Yunlei He <heyunlei@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/f2fs/segment.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -273,6 +273,9 @@ int create_flush_cmd_control(struct f2fs
 	spin_lock_init(&fcc->issue_lock);
 	init_waitqueue_head(&fcc->flush_wait_queue);
 	sbi->sm_info->cmd_control_info = fcc;
+	if (!test_opt(sbi, FLUSH_MERGE))
+		return err;
+
 	fcc->f2fs_issue_flush = kthread_run(issue_flush_thread, sbi,
 				"f2fs_flush-%u:%u", MAJOR(dev), MINOR(dev));
 	if (IS_ERR(fcc->f2fs_issue_flush)) {
@@ -1905,7 +1908,7 @@ int build_segment_manager(struct f2fs_sb
 	sm_info->nr_discards = 0;
 	sm_info->max_discards = 0;
 
-	if (test_opt(sbi, FLUSH_MERGE) && !f2fs_readonly(sbi->sb)) {
+	if (!f2fs_readonly(sbi->sb)) {
 		err = create_flush_cmd_control(sbi);
 		if (err)
 			return err;
