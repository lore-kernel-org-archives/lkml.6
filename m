Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755372AbeE1Nuj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:50:39 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39750 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755313AbeE1Ntl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 09:49:41 -0400
X-Google-Smtp-Source: ADUXVKIRIlmPJOurrGFYLYHL703neuaLwkzMkoSzFyQHJk0WfPlPENBvbe3KgB5umBwNQe8Wkck8Yg==
From: Christian Brauner <christian@brauner.io>
To: linux-kernel@vger.kernel.org
Cc: ebiederm@xmission.com, gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, oleg@redhat.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH 8/8] signal: simplify rt_sigaction()
Date: Mon, 28 May 2018 15:49:16 +0200
Message-Id: <20180528134916.7568-9-christian@brauner.io>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528134916.7568-1-christian@brauner.io>
References: <20180528134916.7568-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The goto is not needed and does not add any clarity. Simply return -EINVAL
on unexpected sigset_t struct size directly.

Signed-off-by: Christian Brauner <christian@brauner.io>
---
 kernel/signal.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 42a7b067a49c..96c58de43ddf 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3741,24 +3741,21 @@ SYSCALL_DEFINE4(rt_sigaction, int, sig,
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
+	if (act)
 		if (copy_from_user(&new_sa.sa, act, sizeof(new_sa.sa)))
 			return -EFAULT;
-	}
 
 	ret = do_sigaction(sig, act ? &new_sa : NULL, oact ? &old_sa : NULL);
-
-	if (!ret && oact) {
+	if (!ret && oact)
 		if (copy_to_user(oact, &old_sa.sa, sizeof(old_sa.sa)))
 			return -EFAULT;
-	}
-out:
+
 	return ret;
 }
 #ifdef CONFIG_COMPAT
-- 
2.17.0
