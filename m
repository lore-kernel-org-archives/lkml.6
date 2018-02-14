Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967185AbeBNKaI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 05:30:08 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40283 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967052AbeBNKaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 05:30:07 -0500
X-Google-Smtp-Source: AH8x226R3fhtyu+OjC1jj2Aquie7feyGe8Mi2Iy2XIGtC1LPtOqwbuYSxMlxWJNuAxkEhxj+8hfvcQ==
Date: Wed, 14 Feb 2018 16:00:02 +0530
From: gaurav jindal <gauravjindal1104@gmail.com>
To: peterz@infradead.org, mingo@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH]sched: completion: use bool in try_wait_for_completion
Message-ID: <20180214103002.GA15068@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use bool in place of int in the function try_wait_for_completion.

Signed-off-by: Gaurav Jindal<gauravjindal1104@gmail.com>

---

diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
index 0926aef..3e15e8d 100644
--- a/kernel/sched/completion.c
+++ b/kernel/sched/completion.c
@@ -283,7 +283,7 @@ int __sched wait_for_completion_killable(struct completion *x)
 bool try_wait_for_completion(struct completion *x)
 {
        unsigned long flags;
-       int ret = 1;
+       bool ret = true;

        /*
         * Since x->done will need to be locked only
@@ -292,11 +292,11 @@ bool try_wait_for_completion(struct completion *x)
         * return early in the blocking case.
         */
        if (!READ_ONCE(x->done))
-               return 0;
+               return false;

        spin_lock_irqsave(&x->wait.lock, flags);
        if (!x->done)
-               ret = 0;
+               ret = false;
        else if (x->done != UINT_MAX)
                x->done--;
        spin_unlock_irqrestore(&x->wait.lock, flags);
