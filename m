Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CE6C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB779206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:41:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB779206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbeIYUtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 16:49:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45864 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729272AbeIYUtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 16:49:20 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 132463001719;
        Tue, 25 Sep 2018 14:41:32 +0000 (UTC)
Received: from llong.com (dhcp-17-8.bos.redhat.com [10.18.17.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0FDDA60BEC;
        Tue, 25 Sep 2018 14:41:30 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>, chuhu@redhat.com,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2 1/2] locking/lockdep: Don't warn class/lock name mismatch for novalidate class
Date:   Tue, 25 Sep 2018 10:41:08 -0400
Message-Id: <1537886469-18227-2-git-send-email-longman@redhat.com>
In-Reply-To: <1537886469-18227-1-git-send-email-longman@redhat.com>
References: <1537886469-18227-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Tue, 25 Sep 2018 14:41:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the special novalidate class (lockdep_set_novalidate_class), multiple
locks with different names may use the same class. The WARN_ON_ONCE()
check in look_up_lock_class() will then report an unnecessary warning.

The current users of lockdep_set_novalidate_class() includes the
device mutex, one mutex and one rwsem in drivers/md/bcache/btree.c.
So the novalidate class is now excluded from the check.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/lockdep.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index dd13f865ad40..10babc35953b 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -693,9 +693,12 @@ look_up_lock_class(const struct lockdep_map *lock, unsigned int subclass)
 		if (class->key == key) {
 			/*
 			 * Huh! same key, different name? Did someone trample
-			 * on some memory? We're most confused.
+			 * on some memory? We're most confused unless it is
+			 * __lockdep_no_validate__ where different locks can
+			 * use the same class.
 			 */
-			WARN_ON_ONCE(class->name != lock->name);
+			WARN_ON_ONCE((key != __lockdep_no_validate__.subkeys) &&
+				     (class->name != lock->name));
 			return class;
 		}
 	}
-- 
2.18.0

