Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965371AbeEYKUG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 06:20:06 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55287 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936009AbeEYKUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 06:20:04 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>, bigeasy@linutronix.de
Subject: [PATCH 1/2] kernel/SRCU: provide a static initializer
Date: Fri, 25 May 2018 12:19:57 +0200
Message-Id: <20180525101958.13277-2-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180525101958.13277-1-bigeasy@linutronix.de>
References: <20180525101958.13277-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are macros for static initializer for the three out of four
possible notifier types, that are:
	ATOMIC_NOTIFIER_HEAD()
	BLOCKING_NOTIFIER_HEAD()
	RAW_NOTIFIER_HEAD()

This patch provides a static initilizer for the forth type to make it
complete.

Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/notifier.h | 34 +++++++++++++++++++++++++++++-----
 include/linux/srcutiny.h |  6 +++---
 include/linux/srcutree.h |  6 +++---
 3 files changed, 35 insertions(+), 11 deletions(-)

diff --git a/include/linux/notifier.h b/include/linux/notifier.h
index 6d731110e0db..f35c7bf76143 100644
--- a/include/linux/notifier.h
+++ b/include/linux/notifier.h
@@ -43,9 +43,7 @@
  * in srcu_notifier_call_chain(): no cache bounces and no memory barriers.
  * As compensation, srcu_notifier_chain_unregister() is rather expensive.
  * SRCU notifier chains should be used when the chain will be called very
- * often but notifier_blocks will seldom be removed.  Also, SRCU notifier
- * chains are slightly more difficult to use because they require special
- * runtime initialization.
+ * often but notifier_blocks will seldom be removed.
  */
=20
 struct notifier_block;
@@ -91,7 +89,7 @@ struct srcu_notifier_head {
 		(name)->head =3D NULL;		\
 	} while (0)
=20
-/* srcu_notifier_heads must be initialized and cleaned up dynamically */
+/* srcu_notifier_heads must be cleaned up dynamically */
 extern void srcu_init_notifier_head(struct srcu_notifier_head *nh);
 #define srcu_cleanup_notifier_head(name)	\
 		cleanup_srcu_struct(&(name)->srcu);
@@ -104,7 +102,13 @@ extern void srcu_init_notifier_head(struct srcu_notifi=
er_head *nh);
 		.head =3D NULL }
 #define RAW_NOTIFIER_INIT(name)	{				\
 		.head =3D NULL }
-/* srcu_notifier_heads cannot be initialized statically */
+
+#define SRCU_NOTIFIER_INIT(name, pcpu)				\
+	{							\
+		.mutex =3D __MUTEX_INITIALIZER(name.mutex),	\
+		.head =3D NULL,					\
+		.srcu =3D __SRCU_STRUCT_INIT(name.srcu, pcpu),	\
+	}
=20
 #define ATOMIC_NOTIFIER_HEAD(name)				\
 	struct atomic_notifier_head name =3D			\
@@ -116,6 +120,26 @@ extern void srcu_init_notifier_head(struct srcu_notifi=
er_head *nh);
 	struct raw_notifier_head name =3D				\
 		RAW_NOTIFIER_INIT(name)
=20
+#ifdef CONFIG_TREE_SRCU
+#define _SRCU_NOTIFIER_HEAD(name, mod)				\
+	static DEFINE_PER_CPU(struct srcu_data,			\
+			name##_head_srcu_data);			\
+	mod struct srcu_notifier_head name =3D			\
+			SRCU_NOTIFIER_INIT(name, name##_head_srcu_data)
+
+#else
+#define _SRCU_NOTIFIER_HEAD(name, mod)				\
+	mod struct srcu_notifier_head name =3D			\
+			SRCU_NOTIFIER_INIT(name, name)
+
+#endif
+
+#define SRCU_NOTIFIER_HEAD(name)				\
+	_SRCU_NOTIFIER_HEAD(name, /* not static */)
+
+#define SRCU_NOTIFIER_HEAD_STATIC(name)				\
+	_SRCU_NOTIFIER_HEAD(name, static)
+
 #ifdef __KERNEL__
=20
 extern int atomic_notifier_chain_register(struct atomic_notifier_head *nh,
diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
index 261471f407a5..f41d2fb09f87 100644
--- a/include/linux/srcutiny.h
+++ b/include/linux/srcutiny.h
@@ -43,7 +43,7 @@ struct srcu_struct {
=20
 void srcu_drive_gp(struct work_struct *wp);
=20
-#define __SRCU_STRUCT_INIT(name)					\
+#define __SRCU_STRUCT_INIT(name, __ignored)				\
 {									\
 	.srcu_wq =3D __SWAIT_QUEUE_HEAD_INITIALIZER(name.srcu_wq),	\
 	.srcu_cb_tail =3D &name.srcu_cb_head,				\
@@ -56,9 +56,9 @@ void srcu_drive_gp(struct work_struct *wp);
  * Tree SRCU, which needs some per-CPU data.
  */
 #define DEFINE_SRCU(name) \
-	struct srcu_struct name =3D __SRCU_STRUCT_INIT(name)
+	struct srcu_struct name =3D __SRCU_STRUCT_INIT(name, name)
 #define DEFINE_STATIC_SRCU(name) \
-	static struct srcu_struct name =3D __SRCU_STRUCT_INIT(name)
+	static struct srcu_struct name =3D __SRCU_STRUCT_INIT(name, name)
=20
 void synchronize_srcu(struct srcu_struct *sp);
=20
diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 4eda108abee0..745d4ca4dd50 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -104,9 +104,9 @@ struct srcu_struct {
 #define SRCU_STATE_SCAN1	1
 #define SRCU_STATE_SCAN2	2
=20
-#define __SRCU_STRUCT_INIT(name)					\
+#define __SRCU_STRUCT_INIT(name, pcpu_name)				\
 	{								\
-		.sda =3D &name##_srcu_data,				\
+		.sda =3D &pcpu_name,					\
 		.lock =3D __SPIN_LOCK_UNLOCKED(name.lock),		\
 		.srcu_gp_seq_needed =3D 0 - 1,				\
 		__SRCU_DEP_MAP_INIT(name)				\
@@ -133,7 +133,7 @@ struct srcu_struct {
  */
 #define __DEFINE_SRCU(name, is_static)					\
 	static DEFINE_PER_CPU(struct srcu_data, name##_srcu_data);\
-	is_static struct srcu_struct name =3D __SRCU_STRUCT_INIT(name)
+	is_static struct srcu_struct name =3D __SRCU_STRUCT_INIT(name, name##_src=
u_data)
 #define DEFINE_SRCU(name)		__DEFINE_SRCU(name, /* not static */)
 #define DEFINE_STATIC_SRCU(name)	__DEFINE_SRCU(name, static)
=20
--=20
2.17.0
