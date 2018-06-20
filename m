Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C1CC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36F1D20693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:34:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36F1D20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754926AbeFTJet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:34:49 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42273 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754517AbeFTJeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 05:34:44 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5K9XrLL3447126
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 20 Jun 2018 02:33:53 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5K9XpFd3447123;
        Wed, 20 Jun 2018 02:33:51 -0700
Date:   Wed, 20 Jun 2018 02:33:51 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Waiman Long <tipbot@zytor.com>
Message-ID: <tip-03eeafdd9ab06a770d42c2b264d50dff7e2f4eee@git.kernel.org>
Cc:     dave@stgolabs.net, arnd@arndb.de, linux-kernel@vger.kernel.org,
        g.schenk@eckelmann.de, peterz@infradead.org, tglx@linutronix.de,
        longman@redhat.com, mingo@kernel.org, hpa@zytor.com,
        dan.j.williams@intel.com
Reply-To: dan.j.williams@intel.com, hpa@zytor.com, mingo@kernel.org,
          longman@redhat.com, tglx@linutronix.de, peterz@infradead.org,
          g.schenk@eckelmann.de, linux-kernel@vger.kernel.org,
          arnd@arndb.de, dave@stgolabs.net
In-Reply-To: <1527168398-4291-1-git-send-email-longman@redhat.com>
References: <1527168398-4291-1-git-send-email-longman@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/urgent] locking/rwsem: Fix up_read_non_owner() warning
 with DEBUG_RWSEMS
Git-Commit-ID: 03eeafdd9ab06a770d42c2b264d50dff7e2f4eee
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  03eeafdd9ab06a770d42c2b264d50dff7e2f4eee
Gitweb:     https://git.kernel.org/tip/03eeafdd9ab06a770d42c2b264d50dff7e2f4eee
Author:     Waiman Long <longman@redhat.com>
AuthorDate: Thu, 24 May 2018 09:26:38 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 20 Jun 2018 11:29:23 +0200

locking/rwsem: Fix up_read_non_owner() warning with DEBUG_RWSEMS

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

---
 kernel/locking/rwsem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index bc1e507be9ff..776308d2fa9e 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -181,6 +181,7 @@ void down_read_non_owner(struct rw_semaphore *sem)
 	might_sleep();
 
 	__down_read(sem);
+	rwsem_set_reader_owned(sem);
 }
 
 EXPORT_SYMBOL(down_read_non_owner);
