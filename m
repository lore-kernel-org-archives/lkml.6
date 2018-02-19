Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752459AbeBSJ4O (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 04:56:14 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39401 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752335AbeBSJ4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 04:56:12 -0500
X-Google-Smtp-Source: AH8x227TDge1jKAv1tD5Oi5pYa/bj3AArKmwYUu4IUD0RcLCdp/il/fSLKI2IUk2u/Bh1LA0axNcEQ==
From: "=?UTF-8?q?Christian=20K=C3=B6nig?="
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/4] locking/ww_mutex: add ww_mutex_is_owned_by function
Date: Mon, 19 Feb 2018 10:56:07 +0100
Message-Id: <20180219095610.2747-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

amdgpu needs to verify if userspace sends us valid addresses and the simplest
way of doing this is to check if the buffer object is locked with the ticket
of the current submission.

Clean up the access to the ww_mutex internals by providing a function
for this and extend the check to the thread owning the underlying mutex.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 include/linux/ww_mutex.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/ww_mutex.h b/include/linux/ww_mutex.h
index 39fda195bf78..dd580db289e8 100644
--- a/include/linux/ww_mutex.h
+++ b/include/linux/ww_mutex.h
@@ -358,4 +358,21 @@ static inline bool ww_mutex_is_locked(struct ww_mutex *lock)
 	return mutex_is_locked(&lock->base);
 }
 
+/**
+ * ww_mutex_is_owned_by - is the w/w mutex locked by this task in that context
+ * @lock: the mutex to be queried
+ * @task: the task structure to check
+ * @ctx: the w/w acquire context to test
+ *
+ * Returns true if the mutex is locked in the context by the given task, false
+ * otherwise.
+ */
+static inline bool ww_mutex_is_owned_by(struct ww_mutex *lock,
+					struct task_struct *task,
+					struct ww_acquire_ctx *ctx)
+{
+	return likely(__mutex_owner(&lock->base) == task) &&
+		READ_ONCE(lock->ctx) == ctx;
+}
+
 #endif
-- 
2.14.1
