Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934522AbeE1V6U (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 17:58:20 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:42229 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934473AbeE1V6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 17:58:12 -0400
X-Google-Smtp-Source: AB8JxZp4EZUFXYLUZUi9gwIQ+ZpIY/2YF9b6wExhsRwkaPjgUxGH01NvhOddjS82hWaPA2lvmnJZ1g==
From: Christian Brauner <christian@brauner.io>
To: linux-kernel@vger.kernel.org
Cc: ebiederm@xmission.com, gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, oleg@redhat.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v1 08/20] signal: simplify rt_sigaction()
Date: Mon, 28 May 2018 23:53:43 +0200
Message-Id: <20180528215355.16119-9-christian@brauner.io>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528215355.16119-1-christian@brauner.io>
References: <20180528215355.16119-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The goto is not needed and does not add any clarity. Simply return -EINVAL
on unexpected sigset_t struct size directly.

Signed-off-by: Christian Brauner <christian@brauner.io>
---
v0->v1:
* patch unchanged
---
 kernel/signal.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 3af140048366..7095fa11af15 100644
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
