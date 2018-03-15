Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751667AbeCOMfj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 08:35:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34100 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750726AbeCOMfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 08:35:38 -0400
Message-Id: <20180315123202.893686246@infradead.org>
User-Agent: quilt/0.63-1
Date: Thu, 15 Mar 2018 13:19:13 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>,
        David Howells <dhowells@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Chris Mason <clm@fb.com>, Anna Schumaker <anna.schumaker@netapp.com>,
        Joel Becker <jlbec@evilplan.org>, James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        George Spelvin <linux@sciencehorizons.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH 11/11] sched/wait: Improve __var_waitqueue()
References: <20180315121902.942902000@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-wait_var-11.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we fixed hash_64 to not suck, there is no need to play games to
attempt to improve the hash value on 64bit. Also, since we don't use
the bit value for the variables, use hash_ptr() directly.

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: George Spelvin <linux@sciencehorizons.net>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/wait_bit.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

--- a/kernel/sched/wait_bit.c
+++ b/kernel/sched/wait_bit.c
@@ -151,12 +151,7 @@ EXPORT_SYMBOL(wake_up_bit);
 
 wait_queue_head_t *__var_waitqueue(void *p)
 {
-	if (BITS_PER_LONG == 64) {
-		unsigned long q = (unsigned long)p;
-
-		return bit_waitqueue((void *)(q & ~1), q & 1);
-	}
-	return bit_waitqueue(p, 0);
+	return bit_wait_table + hash_ptr(p, WAIT_TABLE_BITS);
 }
 EXPORT_SYMBOL(__var_waitqueue);
 
