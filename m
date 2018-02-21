Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932253AbeBUJWo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 04:22:44 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34010 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932069AbeBUJWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 04:22:42 -0500
X-Google-Smtp-Source: AH8x227jMGczSSOuCiK8+7wfdluixQhR7JLBcDrNMe1kGt5gLXs0shfRwzQ0q2s8bXI47FPCB9W8dw==
From: "=?UTF-8?q?Christian=20K=C3=B6nig?="
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To: peterz@infradead.org, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] locking/ww_mutex: add ww_mutex_is_owned_by function v5
Date: Wed, 21 Feb 2018 10:22:39 +0100
Message-Id: <20180221092239.5184-1-christian.koenig@amd.com>
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
v5: fix stupid typo and improve kerneldoc

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 include/linux/ww_mutex.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/ww_mutex.h b/include/linux/ww_mutex.h
index 39fda195bf78..6355de00239d 100644
--- a/include/linux/ww_mutex.h
+++ b/include/linux/ww_mutex.h
@@ -358,4 +358,24 @@ static inline bool ww_mutex_is_locked(struct ww_mutex *lock)
 	return mutex_is_locked(&lock->base);
 }
 
+/**
+ * ww_mutex_is_owned_by - is the w/w mutex locked by this task in that context
+ * @lock: the mutex to be queried
+ * @ctx: the w/w acquire context to test
+ *
+ * If @ctx is not NULL test if the mutex is owned by this context.
+ * If @ctx is NULL test if the mutex is owned by the current thread and not
+ * locked in any context, i.e. acquired using either ww_mutex_trylock() or
+ * ww_mutex_lock() without supplying a &ww_acquire_ctx.
+ */
+static inline bool ww_mutex_is_owned_by(struct ww_mutex *lock,
+					struct ww_acquire_ctx *ctx)
+{
+	if (ctx)
+		return likely(READ_ONCE(lock->ctx) == ctx);
+
+	return likely(__mutex_owner(&lock->base) == current) &&
+		likely(READ_ONCE(lock->ctx) == NULL);
+}
+
 #endif
-- 
2.14.1
