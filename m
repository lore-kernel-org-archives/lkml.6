Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757062AbeDZUCe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 16:02:34 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:47550 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1756715AbeDZUC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 16:02:27 -0400
From: Julia Cartwright <julia@ni.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
CC: Al Viro <viro@zeniv.linux.org.uk>,
        John Ogness <john.ogness@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Gratian Crisan <gratian.crisan@ni.com>,
        <linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable-rt@vger.kernel.org>
Subject: [PATCH RT] seqlock: provide the same ordering semantics as mainline
Date: Thu, 26 Apr 2018 15:02:03 -0500
Message-ID: <20180426200203.11560-1-julia@ni.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180426192258.GK12238@jcartwri.amer.corp.natinst.com>
References: <20180426192258.GK12238@jcartwri.amer.corp.natinst.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-26_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mainline implementation of read_seqbegin() orders prior loads w.r.t.
the read-side critical section.  Fixup the RT writer-boosting
implementation to provide the same guarantee.

Also, while we're here, update the usage of ACCESS_ONCE() to use
READ_ONCE().

Fixes: e69f15cf77c23 ("seqlock: Prevent rt starvation")
Cc: stable-rt@vger.kernel.org
Signed-off-by: Julia Cartwright <julia@ni.com>
---
Found during code inspection of the RT seqlock implementation.

   Julia

 include/linux/seqlock.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index a59751276b94..597ce5a9e013 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -453,7 +453,7 @@ static inline unsigned read_seqbegin(seqlock_t *sl)
 	unsigned ret;
 
 repeat:
-	ret = ACCESS_ONCE(sl->seqcount.sequence);
+	ret = READ_ONCE(sl->seqcount.sequence);
 	if (unlikely(ret & 1)) {
 		/*
 		 * Take the lock and let the writer proceed (i.e. evtl
@@ -462,6 +462,7 @@ static inline unsigned read_seqbegin(seqlock_t *sl)
 		spin_unlock_wait(&sl->lock);
 		goto repeat;
 	}
+	smp_rmb();
 	return ret;
 }
 #endif
-- 
2.16.1
