Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C26B0C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9041920811
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545299112;
	bh=KZKyehFYVbnxFHu+ie+5RvTgr7dZOjRvRRbH8o9Gh6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AXfrgJKO1oKeA2jhLY7apoW4G9k8pnxB/0iuoUzpIOeYQ5hULr7gjI61PjZ7E5N5E
	 9I606wFv9M8mjZXMPnnJ8zADmC5iH8yITejKnVRLPkckbB91MBVWOStvOS0XtX/MEe
	 ItbVXa3cYs2DF7owFOubyk2MPiYIOXyCcQSl96cM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730818AbeLTJVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:21:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:59694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730984AbeLTJVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:21:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5D3721720;
        Thu, 20 Dec 2018 09:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297671;
        bh=KZKyehFYVbnxFHu+ie+5RvTgr7dZOjRvRRbH8o9Gh6c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D04866VhV9HhVEjhyL4ZLhMnGAWDM1UxNNNrqtB5J8vdMIyzB8HS1AlCRmaT5iVX8
         gMZlA2LHb279jY7ChxfwSU4bGUT61bjCTDS12K6SwYKWO9EDkLXgH3h85g72mgjT5C
         Fo/SJjpqLEGWF/QYkkFBG1xWs/0IOAilSY7ib024=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yunlei He <heyunlei@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4.4 15/40] f2fs: fix a panic caused by NULL flush_cmd_control
Date:   Thu, 20 Dec 2018 10:18:27 +0100
Message-Id: <20181220085827.086876444@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085826.212663515@linuxfoundation.org>
References: <20181220085826.212663515@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
[bwh: Backported to 4.9: adjust context]
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/f2fs/segment.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -398,6 +398,9 @@ int create_flush_cmd_control(struct f2fs
 	init_waitqueue_head(&fcc->flush_wait_queue);
 	init_llist_head(&fcc->issue_list);
 	SM_I(sbi)->cmd_control_info = fcc;
+	if (!test_opt(sbi, FLUSH_MERGE))
+		return err;
+
 	fcc->f2fs_issue_flush = kthread_run(issue_flush_thread, sbi,
 				"f2fs_flush-%u:%u", MAJOR(dev), MINOR(dev));
 	if (IS_ERR(fcc->f2fs_issue_flush)) {
@@ -2316,7 +2319,7 @@ int build_segment_manager(struct f2fs_sb
 
 	INIT_LIST_HEAD(&sm_info->sit_entry_set);
 
-	if (test_opt(sbi, FLUSH_MERGE) && !f2fs_readonly(sbi->sb)) {
+	if (!f2fs_readonly(sbi->sb)) {
 		err = create_flush_cmd_control(sbi);
 		if (err)
 			return err;


