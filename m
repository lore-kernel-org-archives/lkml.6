Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752104AbeFBKhu (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 06:37:50 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37087 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751538AbeFBKhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 06:37:12 -0400
X-Google-Smtp-Source: ADUXVKK79KnExofbCl1Qg1w+9hMCrf9Y3JiHa+tghPu5KbuFFRsgBswC68Y5pMn67MewgJDCdzp4CA==
From: Christian Brauner <christian@brauner.io>
To: linux-kernel@vger.kernel.org
Cc: ebiederm@xmission.com, gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, oleg@redhat.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v3 05/17] signal: simplify rt_sigaction()
Date: Sat,  2 Jun 2018 12:36:41 +0200
Message-Id: <20180602103653.18181-6-christian@brauner.io>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180602103653.18181-1-christian@brauner.io>
References: <20180602103653.18181-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The goto is not needed and does not add any clarity. Simply return -EINVAL
on unexpected sigset_t struct size directly.

Signed-off-by: Christian Brauner <christian@brauner.io>
Acked-by: Oleg Nesterov <oleg@redhat.com>
---
v2->v3:
* added Oleg's Acked-by
v1->v2:
* [Christoph Hellwig] additional cleanups
v0->v1:
* unchanged
---
 kernel/signal.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index e17ae40ee6bd..21508900805b 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3735,25 +3735,23 @@ SYSCALL_DEFINE4(rt_sigaction, int, sig,
 		size_t, sigsetsize)
 {
 	struct k_sigaction new_sa, old_sa;
-	int ret = -EINVAL;
+	int ret;
 
 	/* XXX: Don't preclude handling different sized sigset_t's.  */
 	if (sigsetsize != sizeof(sigset_t))
-		goto out;
+		return -EINVAL;
 
-	if (act) {
-		if (copy_from_user(&new_sa.sa, act, sizeof(new_sa.sa)))
-			return -EFAULT;
-	}
+	if (act && copy_from_user(&new_sa.sa, act, sizeof(new_sa.sa)))
+		return -EFAULT;
 
 	ret = do_sigaction(sig, act ? &new_sa : NULL, oact ? &old_sa : NULL);
+	if (ret)
+		return ret;
 
-	if (!ret && oact) {
-		if (copy_to_user(oact, &old_sa.sa, sizeof(old_sa.sa)))
-			return -EFAULT;
-	}
-out:
-	return ret;
+	if (oact && copy_to_user(oact, &old_sa.sa, sizeof(old_sa.sa)))
+		return -EFAULT;
+
+	return 0;
 }
 #ifdef CONFIG_COMPAT
 COMPAT_SYSCALL_DEFINE4(rt_sigaction, int, sig,
-- 
2.17.0
