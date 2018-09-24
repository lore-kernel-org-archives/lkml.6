Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE526C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F96E208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:36:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F96E208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbeIXRiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 13:38:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50086 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbeIXRiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 13:38:23 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C44531061;
        Mon, 24 Sep 2018 11:36:44 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Pittman <jpittman@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 017/105] dm kcopyd: avoid softlockup in run_complete_job
Date:   Mon, 24 Sep 2018 13:33:03 +0200
Message-Id: <20180924113115.230510323@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113113.268650190@linuxfoundation.org>
References: <20180924113113.268650190@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Pittman <jpittman@redhat.com>

[ Upstream commit 784c9a29e99eb40b842c29ecf1cc3a79e00fb629 ]

It was reported that softlockups occur when using dm-snapshot ontop of
slow (rbd) storage.  E.g.:

[ 4047.990647] watchdog: BUG: soft lockup - CPU#10 stuck for 22s! [kworker/10:23:26177]
...
[ 4048.034151] Workqueue: kcopyd do_work [dm_mod]
[ 4048.034156] RIP: 0010:copy_callback+0x41/0x160 [dm_snapshot]
...
[ 4048.034190] Call Trace:
[ 4048.034196]  ? __chunk_is_tracked+0x70/0x70 [dm_snapshot]
[ 4048.034200]  run_complete_job+0x5f/0xb0 [dm_mod]
[ 4048.034205]  process_jobs+0x91/0x220 [dm_mod]
[ 4048.034210]  ? kcopyd_put_pages+0x40/0x40 [dm_mod]
[ 4048.034214]  do_work+0x46/0xa0 [dm_mod]
[ 4048.034219]  process_one_work+0x171/0x370
[ 4048.034221]  worker_thread+0x1fc/0x3f0
[ 4048.034224]  kthread+0xf8/0x130
[ 4048.034226]  ? max_active_store+0x80/0x80
[ 4048.034227]  ? kthread_bind+0x10/0x10
[ 4048.034231]  ret_from_fork+0x35/0x40
[ 4048.034233] Kernel panic - not syncing: softlockup: hung tasks

Fix this by calling cond_resched() after run_complete_job()'s callout to
the dm_kcopyd_notify_fn (which is dm-snap.c:copy_callback in the above
trace).

Signed-off-by: John Pittman <jpittman@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/dm-kcopyd.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/md/dm-kcopyd.c
+++ b/drivers/md/dm-kcopyd.c
@@ -454,6 +454,8 @@ static int run_complete_job(struct kcopy
 	if (atomic_dec_and_test(&kc->nr_jobs))
 		wake_up(&kc->destroyq);
 
+	cond_resched();
+
 	return 0;
 }
 


