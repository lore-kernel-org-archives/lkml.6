Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AC5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 01:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D0820989
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 01:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbfBYBOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 20:14:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57938 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725991AbfBYBO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 20:14:29 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AD6003097029;
        Mon, 25 Feb 2019 01:14:29 +0000 (UTC)
Received: from llong.com (ovpn-120-116.rdu2.redhat.com [10.10.120.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DDFA36013A;
        Mon, 25 Feb 2019 01:14:26 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: [PATCH-tip] locking/qspinlock: Remove unnecessary BUG_ON() call
Date:   Sun, 24 Feb 2019 20:14:13 -0500
Message-Id: <1551057253-3231-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 25 Feb 2019 01:14:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the > 4 nesting levels case handled by the commit d682b596d993
("locking/qspinlock: Handle > 4 slowpath nesting levels"), the BUG_ON()
call in encode_tail() will never be triggered. Remove it.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/qspinlock.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 21ee51b..5e9247d 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -124,9 +124,6 @@ static inline __pure u32 encode_tail(int cpu, int idx)
 {
 	u32 tail;
 
-#ifdef CONFIG_DEBUG_SPINLOCK
-	BUG_ON(idx > 3);
-#endif
 	tail  = (cpu + 1) << _Q_TAIL_CPU_OFFSET;
 	tail |= idx << _Q_TAIL_IDX_OFFSET; /* assume < 4 */
 
-- 
1.8.3.1

