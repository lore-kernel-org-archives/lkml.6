Return-Path: <maco@android.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522228361; cv=none;
        d=google.com; s=arc-20160816;
        b=BWI+oCXN29bHvHAs/DOwWDaHPMTUzvnFnmDzQOrWpvOWbWafZXDOU8IQPksgr6Cq0p
         8Z0imqwdra4rxFpZEha2n/AEaJ1soSDRjHYNwHuekLT6eXAiYLVNVBcT8IJpCct4dA+1
         AZSP7+NE/ryp0ovZlcL/ZeK6a4EngwtPbkIqFE1XU9WnSCpBm9+waSJCNe3GKLJUmwYV
         Jro4qMAg8CMCNlHRinetwBYwnpqLcXriXoU/jiwXWVmGH//G9w/o1qudMlVEoZXBnk6D
         920SbOzgOFYO0MxNJNha0bT5T4UOJxPY+RLcIt6OAvHFgiWFVKrbhp6tY4ha88IE74kg
         EZRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=mXLpxf52GojLVq2Y3b/TM6I9I8nvGoYMJZ6X74qjnE0=;
        b=W6C0jfuiEIXupSD1/s9xp1fwR/+PDjrczJGJWbHpvAgLZCeOm2wbvQj6FzTBX/ew5G
         3XinCA8/Jm1/B4/lY/S0wL5DJMRXscD19HGvIQQeTLFTArTO7HkfgAsMKbzDD7vb4YaA
         aD2Pqm21PS4NdBCVx2TJnuMgk26RRacW7NkpyOOFtIQsU1cMbCheu5HsdjFfOffdrBUy
         Xy8RWKvQbgKSCdqA9x15wZ8lS2P+Qzpk+7Y4M8tizYjTs1jttVqk3/mjv/700DopniDM
         hVNtlHxmCm9VM9KePnb2mrtRmthGIodRE7QEFnorf/ymsAKWYa3Km9mUmallz/TTam/x
         r3zQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@android.com header.s=20161025 header.b=qFlOlg9s;
       spf=pass (google.com: domain of maco@android.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=maco@android.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=android.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@android.com header.s=20161025 header.b=qFlOlg9s;
       spf=pass (google.com: domain of maco@android.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=maco@android.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=android.com
X-Google-Smtp-Source: AIpwx4+MmIrDGEzTxnavheNndgmla7p3gSf0+05009tdIF3IETP1dNWYmS7UcUAUZwfjufMcnG+CYg==
From: Martijn Coenen <maco@android.com>
To: gregkh@linuxfoundation.org,
	john.stultz@linaro.org,
	tkjos@google.com,
	arve@android.com,
	amit.pundir@linaro.org
Cc: linux-kernel@vger.kernel.org,
	devel@driverdev.osuosl.org,
	maco@google.com,
	Martijn Coenen <maco@android.com>
Subject: [v2] ANDROID: binder: prevent transactions into own process.
Date: Wed, 28 Mar 2018 11:12:33 +0200
Message-Id: <20180328091233.83914-1-maco@android.com>
X-Mailer: git-send-email 2.17.0.rc1.321.gba9d0f2565-goog
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596165622257812617?=
X-GMAIL-MSGID: =?utf-8?q?1596172126429128789?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This can't happen with normal nodes (because you can't get a ref
to a node you own), but it could happen with the context manager;
to make the behavior consistent with regular nodes, reject
transactions into the context manager by the process owning it.

Reported-by: syzbot+09e05aba06723a94d43d@syzkaller.appspotmail.com
Signed-off-by: Martijn Coenen <maco@android.com>
---
Changed in v2:
   - Use target_proc directly to avoid dereference.

 drivers/android/binder.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 764b63a5aade..e578eee31589 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2839,6 +2839,14 @@ static void binder_transaction(struct binder_proc *proc,
 			else
 				return_error = BR_DEAD_REPLY;
 			mutex_unlock(&context->context_mgr_node_lock);
+			if (target_node && target_proc == proc) {
+				binder_user_error("%d:%d got transaction to context manager from process owning it\n",
+						  proc->pid, thread->pid);
+				return_error = BR_FAILED_REPLY;
+				return_error_param = -EINVAL;
+				return_error_line = __LINE__;
+				goto err_invalid_target_handle;
+			}
 		}
 		if (!target_node) {
 			/*
-- 
2.17.0.rc1.321.gba9d0f2565-goog
