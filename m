Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752852AbeC2MGW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 08:06:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52744 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752300AbeC2MGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 08:06:20 -0400
From: Andreas Gruenbacher <agruenba@redhat.com>
To: cluster-devel@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        NeilBrown <neilb@suse.com>, Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Tom Herbert <tom@quantonium.net>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v2 1/2] lockref: Add lockref_put_not_zero
Date: Thu, 29 Mar 2018 14:06:11 +0200
Message-Id: <20180329120612.6104-2-agruenba@redhat.com>
In-Reply-To: <20180329120612.6104-1-agruenba@redhat.com>
References: <20180329120612.6104-1-agruenba@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Put a lockref unless the lockref is dead or its count would become zero.
This is the same as lockref_put_or_lock except that the lock is never
left held.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 include/linux/lockref.h |  1 +
 lib/lockref.c           | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/linux/lockref.h b/include/linux/lockref.h
index 2eac32095113..99f17cc8e163 100644
--- a/include/linux/lockref.h
+++ b/include/linux/lockref.h
@@ -37,6 +37,7 @@ struct lockref {
 extern void lockref_get(struct lockref *);
 extern int lockref_put_return(struct lockref *);
 extern int lockref_get_not_zero(struct lockref *);
+extern int lockref_put_not_zero(struct lockref *);
 extern int lockref_get_or_lock(struct lockref *);
 extern int lockref_put_or_lock(struct lockref *);
 
diff --git a/lib/lockref.c b/lib/lockref.c
index 47169ed7e964..3d468b53d4c9 100644
--- a/lib/lockref.c
+++ b/lib/lockref.c
@@ -80,6 +80,34 @@ int lockref_get_not_zero(struct lockref *lockref)
 }
 EXPORT_SYMBOL(lockref_get_not_zero);
 
+/**
+ * lockref_put_not_zero - Decrements count unless count <= 1 before decrement
+ * @lockref: pointer to lockref structure
+ * Return: 1 if count updated successfully or 0 if count would become zero
+ */
+int lockref_put_not_zero(struct lockref *lockref)
+{
+	int retval;
+
+	CMPXCHG_LOOP(
+		new.count--;
+		if (old.count <= 1)
+			return 0;
+	,
+		return 1;
+	);
+
+	spin_lock(&lockref->lock);
+	retval = 0;
+	if (lockref->count > 1) {
+		lockref->count--;
+		retval = 1;
+	}
+	spin_unlock(&lockref->lock);
+	return retval;
+}
+EXPORT_SYMBOL(lockref_put_not_zero);
+
 /**
  * lockref_get_or_lock - Increments count unless the count is 0 or dead
  * @lockref: pointer to lockref structure
-- 
2.14.3
