Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F956C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0F362154B
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqE4zpmT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0F362154B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732573AbeKLISN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:18:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:35400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732500AbeKLISM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:18:12 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05AAE22419;
        Sun, 11 Nov 2018 22:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975297;
        bh=74JmcqTBfH/o9uNtqdzb91UOrlidlCTDzDsWPsKAICM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kqE4zpmTHTqK8LRgXBscWz8ltIZ9KeIO2ZxRpS1/EnptAtu2nSve8uOrDK5W6xr+f
         GChhB8MkL5UYM4HcjTlEZ42GHq3mJ9OYZM4M4o1zkFUUO7TbVJWyiKsVKZtlFPMRB+
         Wumpc9L2k7kmtZWI7jwWWQMb1n8BYAFMccEhDL78=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Mike Christie <mchristi@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Nicholas Bellinger <nab@linux-iscsi.org>,
        "Bryant G. Ly" <bly@catalogicsoftware.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.19 215/361] scsi: sched/wait: Add wait_event_lock_irq_timeout for TASK_UNINTERRUPTIBLE usage
Date:   Sun, 11 Nov 2018 14:19:22 -0800
Message-Id: <20181111221650.055492978@linuxfoundation.org>
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

commit 25ab0bc334b43bbbe4eabc255006ce42a9424da2 upstream.

Short of reverting commit 00d909a10710 ("scsi: target: Make the session
shutdown code also wait for commands that are being aborted") for v4.19,
target-core needs a wait_event_t macro can be executed using
TASK_UNINTERRUPTIBLE to function correctly with existing fabric drivers that
expect to run with signals pending during session shutdown and active se_cmd
I/O quiesce.

The most notable is iscsi-target/iser-target, while ibmvscsi_tgt invokes
session shutdown logic from userspace via configfs attribute that could also
potentially have signals pending.

So go ahead and introduce wait_event_lock_irq_timeout() to achieve this, and
update + rename __wait_event_lock_irq_timeout() to make it accept 'state' as a
parameter.

Fixes: 00d909a10710 ("scsi: target: Make the session shutdown code also wait for commands that are being aborted")
Cc: <stable@vger.kernel.org> # v4.19+
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Mike Christie <mchristi@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Nicholas Bellinger <nab@linux-iscsi.org>
Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>
Reviewed-by: Bryant G. Ly <bly@catalogicsoftware.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/wait.h |   20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -1052,10 +1052,9 @@ do {										\
 	__ret;									\
 })
 
-#define __wait_event_interruptible_lock_irq_timeout(wq_head, condition,		\
-						    lock, timeout)		\
+#define __wait_event_lock_irq_timeout(wq_head, condition, lock, timeout, state)	\
 	___wait_event(wq_head, ___wait_cond_timeout(condition),			\
-		      TASK_INTERRUPTIBLE, 0, timeout,				\
+		      state, 0, timeout,					\
 		      spin_unlock_irq(&lock);					\
 		      __ret = schedule_timeout(__ret);				\
 		      spin_lock_irq(&lock));
@@ -1089,8 +1088,19 @@ do {										\
 ({										\
 	long __ret = timeout;							\
 	if (!___wait_cond_timeout(condition))					\
-		__ret = __wait_event_interruptible_lock_irq_timeout(		\
-					wq_head, condition, lock, timeout);	\
+		__ret = __wait_event_lock_irq_timeout(				\
+					wq_head, condition, lock, timeout,	\
+					TASK_INTERRUPTIBLE);			\
+	__ret;									\
+})
+
+#define wait_event_lock_irq_timeout(wq_head, condition, lock, timeout)		\
+({										\
+	long __ret = timeout;							\
+	if (!___wait_cond_timeout(condition))					\
+		__ret = __wait_event_lock_irq_timeout(				\
+					wq_head, condition, lock, timeout,	\
+					TASK_UNINTERRUPTIBLE);			\
 	__ret;									\
 })
 


