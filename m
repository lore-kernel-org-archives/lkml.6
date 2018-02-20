Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751886AbeBTM6d (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 07:58:33 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39396 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751712AbeBTM6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 07:58:31 -0500
X-Google-Smtp-Source: AH8x226GI528+7JpHxNN70Wg2tqUGxYphL7mxV9Qu13f92whz/5ryrIjXPYW15hcJ9rpKqm3VmfCdQ==
From: "=?UTF-8?q?Christian=20K=C3=B6nig?="
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] locking/ww_mutex: add ww_mutex_is_owned_by function v3
Date: Tue, 20 Feb 2018 13:58:26 +0100
Message-Id: <20180220125829.27060-1-christian.koenig@amd.com>
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

v2: split amdgpu changes into separate patch as suggested by Alex
v3: change logic as suggested by Daniel

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 include/linux/ww_mutex.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/ww_mutex.h b/include/linux/ww_mutex.h
index 39fda195bf78..14e4149d3d9d 100644
--- a/include/linux/ww_mutex.h
+++ b/include/linux/ww_mutex.h
@@ -358,4 +358,21 @@ static inline bool ww_mutex_is_locked(struct ww_mutex *lock)
 	return mutex_is_locked(&lock->base);
 }
 
+/**
+ * ww_mutex_is_owned_by - is the w/w mutex locked by this task in that context
+ * @lock: the mutex to be queried
+ * @ctx: the w/w acquire context to test
+ *
+ * If @ctx is not NULL test if the mutex is owned by this context.
+ * If @ctx is NULL test if the mutex is owned by the current thread.
+ */
+static inline bool ww_mutex_is_owned_by(struct ww_mutex *lock,
+					struct ww_acquire_ctx *ctx)
+{
+	if (ctx)
+		return likely(READ_ONCE(lock->ctx) == ctx);
+	else
+		return likely(__mutex_owner(&lock->base) == current);
+}
+
 #endif
-- 
2.14.1
