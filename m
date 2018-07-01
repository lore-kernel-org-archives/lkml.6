Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DD9C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 314D0253D0
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:42:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 314D0253D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032181AbeGAQmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:42:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37602 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031929AbeGAQmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:42:18 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 573D6ACC;
        Sun,  1 Jul 2018 16:42:17 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Waiman Long <longman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Gavin Schenk <g.schenk@eckelmann.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-nfs@vger.kernel.org
Subject: [PATCH 4.17 126/220] locking/rwsem: Fix up_read_non_owner() warning with DEBUG_RWSEMS
Date:   Sun,  1 Jul 2018 18:22:30 +0200
Message-Id: <20180701160913.605670833@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Waiman Long <longman@redhat.com>

commit 03eeafdd9ab06a770d42c2b264d50dff7e2f4eee upstream.

It was found that the use of up_read_non_owner() in NFS was causing
the following warning when DEBUG_RWSEMS was configured.

  DEBUG_LOCKS_WARN_ON(sem->owner != ((struct task_struct *)(1UL << 0)))

Looking into the rwsem.c file, it was discovered that the corresponding
down_read_non_owner() function was not setting the owner field properly.
This is fixed now, and the warning should be gone.

Fixes: 5149cbac4235 ("locking/rwsem: Add DEBUG_RWSEMS to look for lock/unlock mismatches")
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Gavin Schenk <g.schenk@eckelmann.de>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-nfs@vger.kernel.org
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/1527168398-4291-1-git-send-email-longman@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/locking/rwsem.c |    1 +
 1 file changed, 1 insertion(+)

--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -181,6 +181,7 @@ void down_read_non_owner(struct rw_semap
 	might_sleep();
 
 	__down_read(sem);
+	rwsem_set_reader_owned(sem);
 }
 
 EXPORT_SYMBOL(down_read_non_owner);


