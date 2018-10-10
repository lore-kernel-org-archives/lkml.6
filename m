Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6426C32788
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 03:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74C002087D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 03:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-iscsi.org header.i=@linux-iscsi.org header.b="WT0UJO1l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74C002087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-iscsi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbeJJKvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 06:51:19 -0400
Received: from mail.linux-iscsi.org ([67.23.28.174]:53477 "EHLO
        linux-iscsi.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbeJJKvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 06:51:18 -0400
Received: from linux-iscsi.org (localhost [127.0.0.1])
        by linux-iscsi.org (Postfix) with ESMTP id 6EC3540AC2;
        Wed, 10 Oct 2018 03:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=linux-iscsi.org;
        s=default.private; t=1539141800; bh=zMTIUP2MlU7RLc8HUIrGlFL38x6A20f
        dcgWjRxMRT/A=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
         References; b=WT0UJO1lQdF1AziyAfRtFE455csTHdgqRJCXpS2BLSTfNMdiA+Ng
        nTrfoQTabWzbiY2CH5FjE2/rQs/osuAiTWuSbnN9nt2zDoZ+fgJnAdEXKfQ79XQ+PDl
        Jtpc+jadFPKr6L+S5f1TMkGSBXrQBP3nfaf4zS56hAwtBh0ayKRg=
From:   "Nicholas A. Bellinger" <nab@linux-iscsi.org>
To:     target-devel <target-devel@vger.kernel.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mike Christie <mchristi@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Nicholas Bellinger <nab@linux-iscsi.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 2/2] target: Fix target_wait_for_sess_cmds breakage with active signals
Date:   Wed, 10 Oct 2018 03:23:10 +0000
Message-Id: <1539141790-13557-3-git-send-email-nab@linux-iscsi.org>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1539141790-13557-1-git-send-email-nab@linux-iscsi.org>
References: <1539141790-13557-1-git-send-email-nab@linux-iscsi.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Bellinger <nab@linux-iscsi.org>

With the addition of commit 00d909a107 in v4.19-rc, it incorrectly assumes no
signals will be pending for task_struct executing the normal session shutdown
and I/O quiesce code-path.

For example, iscsi-target and iser-target issue SIGINT to all kthreads as
part of session shutdown.  This has been the behaviour since day one.

As-is when signals are pending with se_cmds active in se_sess->sess_cmd_list,
wait_event_interruptible_lock_irq_timeout() returns a negative number and
immediately kills the machine because of the do while (ret <= 0) loop that
was added in commit 00d909a107 to spin while backend I/O is taking any
amount of extended time (say 30 seconds) to complete.

Here's what it looks like in action with debug plus delayed backend I/O
completion:

[ 4951.909951] se_sess: 000000003e7e08fa before target_wait_for_sess_cmds
[ 4951.914600] target_wait_for_sess_cmds: signal_pending: 1
[ 4951.918015] wait_event_interruptible_lock_irq_timeout ret: -512 signal_pending: 1 loop count: 0
[ 4951.921639] wait_event_interruptible_lock_irq_timeout ret: -512 signal_pending: 1 loop count: 1
[ 4951.921944] wait_event_interruptible_lock_irq_timeout ret: -512 signal_pending: 1 loop count: 2
[ 4951.921944] wait_event_interruptible_lock_irq_timeout ret: -512 signal_pending: 1 loop count: 3
[ 4951.921944] wait_event_interruptible_lock_irq_timeout ret: -512 signal_pending: 1 loop count: 4
[ 4951.921944] wait_event_interruptible_lock_irq_timeout ret: -512 signal_pending: 1 loop count: 5
[ 4951.921944] wait_event_interruptible_lock_irq_timeout ret: -512 signal_pending: 1 loop count: 6
[ 4951.921944] wait_event_interruptible_lock_irq_timeout ret: -512 signal_pending: 1 loop count: 7
[ 4951.921944] wait_event_interruptible_lock_irq_timeout ret: -512 signal_pending: 1 loop count: 8
[ 4951.921944] wait_event_interruptible_lock_irq_timeout ret: -512 signal_pending: 1 loop count: 9

... followed by the usual RCU CPU stalls and deadlock.

There was never a case pre commit 00d909a107 where wait_for_complete(&se_cmd->cmd_wait_comp)
was able to be interruptted, so to address this for v4.19+ moving forward go ahead and
use wait_event_lock_irq_timeout() instead so new code works with all fabric drivers.

Also for commit 00d909a107, fix a minor regression in target_release_cmd_kref()
to only wake_up the new se_sess->cmd_list_wq only when shutdown has actually
been triggered via se_sess->sess_tearing_down.

Fixes: 00d909a107 ("scsi: target: Make the session shutdown code also wait for commands that are being aborted")
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Mike Christie <mchristi@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
Tested-by: Nicholas Bellinger <nab@linux-iscsi.org>
Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>
---
 drivers/target/target_core_transport.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/target/target_core_transport.c b/drivers/target/target_core_transport.c
index 86c0156..fc3093d2 100644
--- a/drivers/target/target_core_transport.c
+++ b/drivers/target/target_core_transport.c
@@ -2754,7 +2754,7 @@ static void target_release_cmd_kref(struct kref *kref)
 	if (se_sess) {
 		spin_lock_irqsave(&se_sess->sess_cmd_lock, flags);
 		list_del_init(&se_cmd->se_cmd_list);
-		if (list_empty(&se_sess->sess_cmd_list))
+		if (se_sess->sess_tearing_down && list_empty(&se_sess->sess_cmd_list))
 			wake_up(&se_sess->cmd_list_wq);
 		spin_unlock_irqrestore(&se_sess->sess_cmd_lock, flags);
 	}
@@ -2907,7 +2907,7 @@ void target_wait_for_sess_cmds(struct se_session *se_sess)
 
 	spin_lock_irq(&se_sess->sess_cmd_lock);
 	do {
-		ret = wait_event_interruptible_lock_irq_timeout(
+		ret = wait_event_lock_irq_timeout(
 				se_sess->cmd_list_wq,
 				list_empty(&se_sess->sess_cmd_list),
 				se_sess->sess_cmd_lock, 180 * HZ);
-- 
1.9.1

