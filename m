Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CE4C0044C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DBC520839
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mCw0n8SR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DBC520839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732899AbeKLJrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:47:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:34210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732545AbeKLISN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:18:13 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 578F8208A3;
        Sun, 11 Nov 2018 22:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975297;
        bh=cux8fSc2fDv2yXExKQ8ySzYqNEu9wlubW/+MtZzv4kM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mCw0n8SRDgutq5fBiO6WTcRZMdQzxkEG3lD+2E+nqGedQoJusmtQu0k0D6CHUobow
         q28rtSrR+PLXnky3rc/8m2Nif+qTb1EqV/2uAjYYdCSVqnZxWxBu6SUzBHA3dhlUv2
         eZYjKLLgfSaQw8CD4lp/Smz2qPBXnxSRLcu3UoG8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Mike Christie <mchristi@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
        Nicholas Bellinger <nab@linux-iscsi.org>,
        "Bryant G. Ly" <bly@catalogicsoftware.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.19 216/361] scsi: target: Fix target_wait_for_sess_cmds breakage with active signals
Date:   Sun, 11 Nov 2018 14:19:23 -0800
Message-Id: <20181111221650.189093046@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Bellinger <nab@linux-iscsi.org>

commit 38fe73cc2c96fbc9942b07220f2a4f1bab37392d upstream.

With the addition of commit 00d909a10710 ("scsi: target: Make the session
shutdown code also wait for commands that are being aborted") in v4.19-rc, it
incorrectly assumes no signals will be pending for task_struct executing the
normal session shutdown and I/O quiesce code-path.

For example, iscsi-target and iser-target issue SIGINT to all kthreads as part
of session shutdown.  This has been the behaviour since day one.

As-is when signals are pending with se_cmds active in se_sess->sess_cmd_list,
wait_event_interruptible_lock_irq_timeout() returns a negative number and
immediately kills the machine because of the do while (ret <= 0) loop that was
added in commit 00d909a107 to spin while backend I/O is taking any amount of
extended time (say 30 seconds) to complete.

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

There was never a case pre commit 00d909a107 where
wait_for_complete(&se_cmd->cmd_wait_comp) was able to be interrupted, so to
address this for v4.19+ moving forward go ahead and use
wait_event_lock_irq_timeout() instead so new code works with all fabric
drivers.

Also for commit 00d909a107, fix a minor regression in
target_release_cmd_kref() to only wake_up the new se_sess->cmd_list_wq only
when shutdown has actually been triggered via se_sess->sess_tearing_down.

Fixes: 00d909a10710 ("scsi: target: Make the session shutdown code also wait for commands that are being aborted")
Cc: <stable@vger.kernel.org> # v4.19+
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Mike Christie <mchristi@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
Tested-by: Nicholas Bellinger <nab@linux-iscsi.org>
Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>
Reviewed-by: Bryant G. Ly <bly@catalogicsoftware.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/target/target_core_transport.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/target/target_core_transport.c
+++ b/drivers/target/target_core_transport.c
@@ -2754,7 +2754,7 @@ static void target_release_cmd_kref(stru
 	if (se_sess) {
 		spin_lock_irqsave(&se_sess->sess_cmd_lock, flags);
 		list_del_init(&se_cmd->se_cmd_list);
-		if (list_empty(&se_sess->sess_cmd_list))
+		if (se_sess->sess_tearing_down && list_empty(&se_sess->sess_cmd_list))
 			wake_up(&se_sess->cmd_list_wq);
 		spin_unlock_irqrestore(&se_sess->sess_cmd_lock, flags);
 	}
@@ -2907,7 +2907,7 @@ void target_wait_for_sess_cmds(struct se
 
 	spin_lock_irq(&se_sess->sess_cmd_lock);
 	do {
-		ret = wait_event_interruptible_lock_irq_timeout(
+		ret = wait_event_lock_irq_timeout(
 				se_sess->cmd_list_wq,
 				list_empty(&se_sess->sess_cmd_list),
 				se_sess->sess_cmd_lock, 180 * HZ);


