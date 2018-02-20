Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752046AbeBTOtu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 09:49:50 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34942 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751379AbeBTOts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 09:49:48 -0500
X-Google-Smtp-Source: AH8x226N/LjOjxYOIxDI579XApXWihExP5HcAuV/O5t77wOdXxvDkKeDchzBILY3I8SFg85AaOeQeQ==
From: "=?UTF-8?q?Christian=20K=C3=B6nig?="
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To: peterz@infradead.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] locking/ww_mutex: add ww_mutex_is_owned_by function v4
Date: Tue, 20 Feb 2018 15:49:46 +0100
Message-Id: <20180220144946.2510-1-christian.koenig@amd.com>
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
v4: fix test in case ctx is NULL

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 include/linux/ww_mutex.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/ww_mutex.h b/include/linux/ww_mutex.h
index 39fda195bf78..fea4acc0bcbc 100644
--- a/include/linux/ww_mutex.h
+++ b/include/linux/ww_mutex.h
@@ -358,4 +358,23 @@ static inline bool ww_mutex_is_locked(struct ww_mutex *lock)
 	return mutex_is_locked(&lock->base);
 }
 
+/**
+ * ww_mutex_is_owned_by - is the w/w mutex locked by this task in that context
+ * @lock: the mutex to be queried
+ * @ctx: the w/w acquire context to test
+ *
+ * If @ctx is not NULL test if the mutex is owned by this context.
+ * If @ctx is NULL test if the mutex is owned by the current thread and not
+ * locked in any context.
+ */
+static inline bool ww_mutex_is_owned_by(struct ww_mutex *lock,
+					struct ww_acquire_ctx *ctx)
+{
+	if (ctx)
+		return likely(READ_ONCE(lock->ctx) == ctx);
+
+	return likely(__mutex_owner(&lock->base) == current) &&
+		likely(READ_ONCE(lock->ctx) == NULL;
+}
+
 #endif
-- 
2.14.1
