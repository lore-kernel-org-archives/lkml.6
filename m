Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966545AbeEJPuM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 11:50:12 -0400
Received: from smtprelay0037.hostedemail.com ([216.40.44.37]:52403 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S966225AbeEJPqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 11:46:14 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:69:327:355:379:541:800:960:966:968:973:988:989:1042:1260:1345:1359:1437:1605:1730:1747:1777:1792:1801:2196:2198:2199:2200:2393:2559:2562:2895:2904:3138:3139:3140:3141:3142:3165:3865:3866:3867:3868:3870:3871:3872:3874:4250:4321:4385:4605:5007:6117:6119:6261:6755:7875:7903:7904:9010:9040:10004:10848:11026:11473:11658:11914:12043:12219:12291:12294:12296:12438:12555:12679:12683:12740:12895:12986:13149:13161:13229:13230:14394:21080:21324:21433:21451:21611:21627:21740:30003:30025:30029:30030:30034:30045:30054:30069:30070:30074:30080:30083,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: ray52_18da76269a25d
X-Filterd-Recvd-Size: 29217
From: Joe Perches <joe@perches.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: [PATCH 02/18] lib: Use pr_fmt
Date: Thu, 10 May 2018 08:45:28 -0700
Message-Id: <3dcb6d8f61280d20b8d893ba0b95b4b318570aed.1525964382.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <cover.1525964381.git.joe@perches.com>
References: <cover.1525964381.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometime in the future, it would be useful to convert pr_fmt from a
default simple define to use a default prefix with KBUILD_MODNAME.

There are files in lib/ that use pr_<level>, some with an embedded
prefix, that also do not have a specific pr_fmt define.

Add pr_fmt for those files.

There are some differences in output as some logging output now is
prefixed with the appropriate KBUILD_MODNAME.

Miscellanea:

o Simplify debugging macros to only require a single function definition
  by moving #define DEBUG into the definition and removing the empty
  function definition
o Function alignment neatening
o Use %s, __func__ instead of embedding function names as strings
o Add missing newline terminations

Signed-off-by: Joe Perches <joe@perches.com>
---
 lib/cpu_rmap.c           | 15 +++++-------
 lib/crc32test.c          |  2 ++
 lib/earlycpio.c          |  5 ++--
 lib/find_bit_benchmark.c |  2 ++
 lib/kobject.c            | 36 ++++++++++++++--------------
 lib/kobject_uevent.c     | 27 ++++++++++-----------
 lib/nmi_backtrace.c      |  3 +++
 lib/percpu_ida.c         |  4 +++-
 lib/percpu_test.c        |  2 ++
 lib/random32.c           | 10 ++++----
 lib/stmp_device.c        |  2 ++
 lib/string.c             |  2 ++
 lib/swiotlb.c            |  4 +++-
 lib/test_debug_virtual.c |  2 ++
 lib/test_rhashtable.c    | 44 ++++++++++++++++++----------------
 lib/test_sort.c          |  2 ++
 lib/ubsan.c              | 61 ++++++++++++++++++++++++------------------------
 17 files changed, 122 insertions(+), 101 deletions(-)

diff --git a/lib/cpu_rmap.c b/lib/cpu_rmap.c
index f610b2a10b3e..2d7204928c60 100644
--- a/lib/cpu_rmap.c
+++ b/lib/cpu_rmap.c
@@ -7,6 +7,8 @@
  * by the Free Software Foundation, incorporated herein by reference.
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/cpu_rmap.h>
 #include <linux/interrupt.h>
 #include <linux/export.h>
@@ -110,26 +112,21 @@ static bool cpu_rmap_copy_neigh(struct cpu_rmap *rmap, unsigned int cpu,
 	return false;
 }
 
-#ifdef DEBUG
 static void debug_print_rmap(const struct cpu_rmap *rmap, const char *prefix)
 {
+#ifdef DEBUG
 	unsigned index;
 	unsigned int cpu;
 
-	pr_info("cpu_rmap %p, %s:\n", rmap, prefix);
+	pr_info("%p, %s:\n", rmap, prefix);
 
 	for_each_possible_cpu(cpu) {
 		index = rmap->near[cpu].index;
 		pr_info("cpu %d -> obj %u (distance %u)\n",
 			cpu, index, rmap->near[cpu].dist);
 	}
-}
-#else
-static inline void
-debug_print_rmap(const struct cpu_rmap *rmap, const char *prefix)
-{
-}
 #endif
+}
 
 /**
  * cpu_rmap_add - add object to a rmap
@@ -258,7 +255,7 @@ irq_cpu_rmap_notify(struct irq_affinity_notify *notify, const cpumask_t *mask)
 
 	rc = cpu_rmap_update(glue->rmap, glue->index, mask);
 	if (rc)
-		pr_warning("irq_cpu_rmap_notify: update failed: %d\n", rc);
+		pr_warn("%s: update failed: %d\n", __func__, rc);
 }
 
 /**
diff --git a/lib/crc32test.c b/lib/crc32test.c
index 97d6a57cefcc..63bb08ccb6f3 100644
--- a/lib/crc32test.c
+++ b/lib/crc32test.c
@@ -24,6 +24,8 @@
  * Version 2.  See the file COPYING for more details.
  */
 
+#define pr_fmt(fmt) fmt
+
 #include <linux/crc32.h>
 #include <linux/module.h>
 #include <linux/sched.h>
diff --git a/lib/earlycpio.c b/lib/earlycpio.c
index db283ba4d2c1..e98816b13719 100644
--- a/lib/earlycpio.c
+++ b/lib/earlycpio.c
@@ -130,9 +130,8 @@ struct cpio_data find_cpio_data(const char *path, void *data,
 				*nextoff = (long)nptr - (long)data;
 
 			if (ch[C_NAMESIZE] - mypathsize >= MAX_CPIO_FILE_NAME) {
-				pr_warn(
-				"File %s exceeding MAX_CPIO_FILE_NAME [%d]\n",
-				p, MAX_CPIO_FILE_NAME);
+				pr_warn("File %s exceeding MAX_CPIO_FILE_NAME [%d]\n",
+					p, MAX_CPIO_FILE_NAME);
 			}
 			strlcpy(cd.name, p + mypathsize, MAX_CPIO_FILE_NAME);
 
diff --git a/lib/find_bit_benchmark.c b/lib/find_bit_benchmark.c
index 5367ffa5c18f..d59d92c9e73e 100644
--- a/lib/find_bit_benchmark.c
+++ b/lib/find_bit_benchmark.c
@@ -24,6 +24,8 @@
  * - sparse bitmap with few set bits at random positions.
  */
 
+#define pr_fmt(fmt) fmt
+
 #include <linux/bitops.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
diff --git a/lib/kobject.c b/lib/kobject.c
index 18989b5b3b56..2bb9a50da4b0 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -10,6 +10,8 @@
  * about using the kobject interface.
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/kobject.h>
 #include <linux/string.h>
 #include <linux/export.h>
@@ -129,8 +131,8 @@ static void fill_kobj_path(struct kobject *kobj, char *path, int length)
 		*(path + --length) = '/';
 	}
 
-	pr_debug("kobject: '%s' (%p): %s: path = '%s'\n", kobject_name(kobj),
-		 kobj, __func__, path);
+	pr_debug("'%s' (%p): %s: path = '%s'\n",
+		 kobject_name(kobj), kobj, __func__, path);
 }
 
 /**
@@ -220,7 +222,7 @@ static int kobject_add_internal(struct kobject *kobj)
 		kobj->parent = parent;
 	}
 
-	pr_debug("kobject: '%s' (%p): %s: parent: '%s', set: '%s'\n",
+	pr_debug("'%s' (%p): %s: parent: '%s', set: '%s'\n",
 		 kobject_name(kobj), kobj, __func__,
 		 parent ? kobject_name(parent) : "<NULL>",
 		 kobj->kset ? kobject_name(&kobj->kset->kobj) : "<NULL>");
@@ -333,7 +335,7 @@ void kobject_init(struct kobject *kobj, struct kobj_type *ktype)
 	}
 	if (kobj->state_initialized) {
 		/* do not error out as sometimes we can recover */
-		pr_err("kobject (%p): tried to init an initialized object, something is seriously wrong.\n",
+		pr_err("(%p): tried to init an initialized object, something is seriously wrong\n",
 		       kobj);
 		dump_stack();
 	}
@@ -343,7 +345,7 @@ void kobject_init(struct kobject *kobj, struct kobj_type *ktype)
 	return;
 
 error:
-	pr_err("kobject (%p): %s\n", kobj, err_str);
+	pr_err("(%p): %s\n", kobj, err_str);
 	dump_stack();
 }
 EXPORT_SYMBOL(kobject_init);
@@ -356,7 +358,7 @@ static __printf(3, 0) int kobject_add_varg(struct kobject *kobj,
 
 	retval = kobject_set_name_vargs(kobj, fmt, vargs);
 	if (retval) {
-		pr_err("kobject: can not set name properly!\n");
+		pr_err("can not set name properly!\n");
 		return retval;
 	}
 	kobj->parent = parent;
@@ -398,7 +400,7 @@ int kobject_add(struct kobject *kobj, struct kobject *parent,
 		return -EINVAL;
 
 	if (!kobj->state_initialized) {
-		pr_err("kobject '%s' (%p): tried to add an uninitialized object, something is seriously wrong.\n",
+		pr_err("'%s' (%p): tried to add an uninitialized object, something is seriously wrong.n",
 		       kobject_name(kobj), kobj);
 		dump_stack();
 		return -EINVAL;
@@ -616,36 +618,36 @@ static void kobject_cleanup(struct kobject *kobj)
 	struct kobj_type *t = get_ktype(kobj);
 	const char *name = kobj->name;
 
-	pr_debug("kobject: '%s' (%p): %s, parent %p\n",
+	pr_debug("'%s' (%p): %s, parent %p\n",
 		 kobject_name(kobj), kobj, __func__, kobj->parent);
 
 	if (t && !t->release)
-		pr_debug("kobject: '%s' (%p): does not have a release() function, it is broken and must be fixed.\n",
+		pr_debug("'%s' (%p): does not have a release() function, it is broken and must be fixed.\n",
 			 kobject_name(kobj), kobj);
 
 	/* send "remove" if the caller did not do it but sent "add" */
 	if (kobj->state_add_uevent_sent && !kobj->state_remove_uevent_sent) {
-		pr_debug("kobject: '%s' (%p): auto cleanup 'remove' event\n",
+		pr_debug("'%s' (%p): auto cleanup 'remove' event\n",
 			 kobject_name(kobj), kobj);
 		kobject_uevent(kobj, KOBJ_REMOVE);
 	}
 
 	/* remove from sysfs if the caller did not do it */
 	if (kobj->state_in_sysfs) {
-		pr_debug("kobject: '%s' (%p): auto cleanup kobject_del\n",
+		pr_debug("'%s' (%p): auto cleanup kobject_del\n",
 			 kobject_name(kobj), kobj);
 		kobject_del(kobj);
 	}
 
 	if (t && t->release) {
-		pr_debug("kobject: '%s' (%p): calling ktype release\n",
+		pr_debug("'%s' (%p): calling ktype release\n",
 			 kobject_name(kobj), kobj);
 		t->release(kobj);
 	}
 
 	/* free name if we allocated it */
 	if (name) {
-		pr_debug("kobject: '%s': free name\n", name);
+		pr_debug("'%s': free name\n", name);
 		kfree_const(name);
 	}
 }
@@ -663,8 +665,8 @@ static void kobject_release(struct kref *kref)
 	struct kobject *kobj = container_of(kref, struct kobject, kref);
 #ifdef CONFIG_DEBUG_KOBJECT_RELEASE
 	unsigned long delay = HZ + HZ * (get_random_int() & 0x3);
-	pr_info("kobject: '%s' (%p): %s, parent %p (delayed %ld)\n",
-		 kobject_name(kobj), kobj, __func__, kobj->parent, delay);
+	pr_info("'%s' (%p): %s, parent %p (delayed %ld)\n",
+		kobject_name(kobj), kobj, __func__, kobj->parent, delay);
 	INIT_DELAYED_WORK(&kobj->release, kobject_delayed_cleanup);
 
 	schedule_delayed_work(&kobj->release, delay);
@@ -693,7 +695,7 @@ EXPORT_SYMBOL(kobject_put);
 
 static void dynamic_kobj_release(struct kobject *kobj)
 {
-	pr_debug("kobject: (%p): %s\n", kobj, __func__);
+	pr_debug("(%p): %s\n", kobj, __func__);
 	kfree(kobj);
 }
 
@@ -863,7 +865,7 @@ EXPORT_SYMBOL_GPL(kset_find_obj);
 static void kset_release(struct kobject *kobj)
 {
 	struct kset *kset = container_of(kobj, struct kset, kobj);
-	pr_debug("kobject: '%s' (%p): %s\n",
+	pr_debug("'%s' (%p): %s\n",
 		 kobject_name(kobj), kobj, __func__);
 	kfree(kset);
 }
diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index 63d0816ab23b..c4b2453f7c16 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -13,6 +13,8 @@
  *	Greg Kroah-Hartman	<greg@kroah.com>
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/spinlock.h>
 #include <linux/string.h>
 #include <linux/kobject.h>
@@ -464,8 +466,7 @@ int kobject_uevent_env(struct kobject *kobj, enum kobject_action action,
 	int i = 0;
 	int retval = 0;
 
-	pr_debug("kobject: '%s' (%p): %s\n",
-		 kobject_name(kobj), kobj, __func__);
+	pr_debug("'%s' (%p): %s\n", kobject_name(kobj), kobj, __func__);
 
 	/* search the kset we belong to */
 	top_kobj = kobj;
@@ -473,9 +474,8 @@ int kobject_uevent_env(struct kobject *kobj, enum kobject_action action,
 		top_kobj = top_kobj->parent;
 
 	if (!top_kobj->kset) {
-		pr_debug("kobject: '%s' (%p): %s: attempted to send uevent "
-			 "without kset!\n", kobject_name(kobj), kobj,
-			 __func__);
+		pr_debug("'%s' (%p): %s: attempted to send uevent without kset!\n",
+			 kobject_name(kobj), kobj, __func__);
 		return -EINVAL;
 	}
 
@@ -484,16 +484,14 @@ int kobject_uevent_env(struct kobject *kobj, enum kobject_action action,
 
 	/* skip the event, if uevent_suppress is set*/
 	if (kobj->uevent_suppress) {
-		pr_debug("kobject: '%s' (%p): %s: uevent_suppress "
-				 "caused the event to drop!\n",
-				 kobject_name(kobj), kobj, __func__);
+		pr_debug("'%s' (%p): %s: uevent_suppress caused the event to drop!\n",
+			 kobject_name(kobj), kobj, __func__);
 		return 0;
 	}
 	/* skip the event, if the filter returns zero. */
 	if (uevent_ops && uevent_ops->filter)
 		if (!uevent_ops->filter(kset, kobj)) {
-			pr_debug("kobject: '%s' (%p): %s: filter function "
-				 "caused the event to drop!\n",
+			pr_debug("'%s' (%p): %s: filter function caused the event to drop!\n",
 				 kobject_name(kobj), kobj, __func__);
 			return 0;
 		}
@@ -504,8 +502,8 @@ int kobject_uevent_env(struct kobject *kobj, enum kobject_action action,
 	else
 		subsystem = kobject_name(&kset->kobj);
 	if (!subsystem) {
-		pr_debug("kobject: '%s' (%p): %s: unset subsystem caused the "
-			 "event to drop!\n", kobject_name(kobj), kobj,
+		pr_debug("'%s' (%p): %s: unset subsystem caused the event to drop!\n",
+			 kobject_name(kobj), kobj,
 			 __func__);
 		return 0;
 	}
@@ -546,9 +544,8 @@ int kobject_uevent_env(struct kobject *kobj, enum kobject_action action,
 	if (uevent_ops && uevent_ops->uevent) {
 		retval = uevent_ops->uevent(kset, kobj, env);
 		if (retval) {
-			pr_debug("kobject: '%s' (%p): %s: uevent() returned "
-				 "%d\n", kobject_name(kobj), kobj,
-				 __func__, retval);
+			pr_debug("'%s' (%p): %s: uevent() returned %d\n",
+				 kobject_name(kobj), kobj, __func__, retval);
 			goto exit;
 		}
 	}
diff --git a/lib/nmi_backtrace.c b/lib/nmi_backtrace.c
index 61a6b5aab07e..5141d7072c99 100644
--- a/lib/nmi_backtrace.c
+++ b/lib/nmi_backtrace.c
@@ -13,6 +13,9 @@
  *
  *  Bits copied from original nmi.c file
  */
+
+#define pr_fmt(fmt) fmt
+
 #include <linux/cpumask.h>
 #include <linux/delay.h>
 #include <linux/kprobes.h>
diff --git a/lib/percpu_ida.c b/lib/percpu_ida.c
index 6016f1deb1f5..4283e4f9092e 100644
--- a/lib/percpu_ida.c
+++ b/lib/percpu_ida.c
@@ -14,6 +14,8 @@
  * General Public License for more details.
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/mm.h>
 #include <linux/bitmap.h>
 #include <linux/bitops.h>
@@ -299,7 +301,7 @@ int __percpu_ida_init(struct percpu_ida *pool, unsigned long nr_tags,
 
 	/* Guard against overflow */
 	if (nr_tags > (unsigned) INT_MAX + 1) {
-		pr_err("percpu_ida_init(): nr_tags too large\n");
+		pr_err("%s: nr_tags too large\n", __func__);
 		return -EINVAL;
 	}
 
diff --git a/lib/percpu_test.c b/lib/percpu_test.c
index 0b5d14dadd1a..349ef717a0d9 100644
--- a/lib/percpu_test.c
+++ b/lib/percpu_test.c
@@ -1,3 +1,5 @@
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/module.h>
 
 /* validate @native and @pcp counter values match @expected */
diff --git a/lib/random32.c b/lib/random32.c
index 4aaa76404d56..8de1ac412588 100644
--- a/lib/random32.c
+++ b/lib/random32.c
@@ -32,6 +32,8 @@
  * s1 > 1, s2 > 7, s3 > 15, s4 > 127.
  */
 
+#define pr_fmt(fmt) "prandom: " fmt
+
 #include <linux/types.h>
 #include <linux/percpu.h>
 #include <linux/export.h>
@@ -437,9 +439,9 @@ static void __init prandom_state_selftest(void)
 	}
 
 	if (error)
-		pr_warn("prandom: seed boundary self test failed\n");
+		pr_warn("seed boundary self test failed\n");
 	else
-		pr_info("prandom: seed boundary self test passed\n");
+		pr_info("seed boundary self test passed\n");
 
 	for (i = 0; i < ARRAY_SIZE(test2); i++) {
 		struct rnd_state state;
@@ -458,8 +460,8 @@ static void __init prandom_state_selftest(void)
 	}
 
 	if (errors)
-		pr_warn("prandom: %d/%d self tests failed\n", errors, runs);
+		pr_warn("%d/%d self tests failed\n", errors, runs);
 	else
-		pr_info("prandom: %d self tests passed\n", runs);
+		pr_info("%d self tests passed\n", runs);
 }
 #endif
diff --git a/lib/stmp_device.c b/lib/stmp_device.c
index a904656f4fd7..e06dea3c9a7a 100644
--- a/lib/stmp_device.c
+++ b/lib/stmp_device.c
@@ -12,6 +12,8 @@
  * (at your option) any later version.
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/io.h>
 #include <linux/errno.h>
 #include <linux/delay.h>
diff --git a/lib/string.c b/lib/string.c
index 2c0900a5d51a..19c032243185 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -20,6 +20,8 @@
  * -  Kissed strtok() goodbye
  */
 
+#define pr_fmt(fmt) fmt
+
 #include <linux/types.h>
 #include <linux/string.h>
 #include <linux/ctype.h>
diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index bd1e0c5ba1b8..ca70b081bf3c 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -17,6 +17,8 @@
  * 08/12/11 beckyb	Add highmem support
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/cache.h>
 #include <linux/dma-direct.h>
 #include <linux/mm.h>
@@ -165,7 +167,7 @@ void swiotlb_print_info(void)
 	unsigned char *vstart, *vend;
 
 	if (no_iotlb_memory) {
-		pr_warn("software IO TLB: No low mem\n");
+		pr_warn("No low mem\n");
 		return;
 	}
 
diff --git a/lib/test_debug_virtual.c b/lib/test_debug_virtual.c
index b9cdeecc19dc..97b9ecfc6a83 100644
--- a/lib/test_debug_virtual.c
+++ b/lib/test_debug_virtual.c
@@ -1,3 +1,5 @@
+#define pr_fmt(fmt) fmt
+
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/export.h>
diff --git a/lib/test_rhashtable.c b/lib/test_rhashtable.c
index f4000c137dbe..cd5a3cea1ac3 100644
--- a/lib/test_rhashtable.c
+++ b/lib/test_rhashtable.c
@@ -13,6 +13,8 @@
  * Self Test
  **************************************************************************/
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/init.h>
 #include <linux/jhash.h>
 #include <linux/kernel.h>
@@ -132,7 +134,7 @@ static int insert_retry(struct rhashtable *ht, struct test_obj *obj,
 	} while (err == -EBUSY);
 
 	if (enomem_retries)
-		pr_info(" %u insertions retried after -ENOMEM\n",
+		pr_info("%u insertions retried after -ENOMEM\n",
 			enomem_retries);
 
 	return err ? : retries;
@@ -184,7 +186,7 @@ static void test_bucket_stats(struct rhashtable *ht, unsigned int entries)
 
 	err = rhashtable_walk_init(ht, &hti, GFP_KERNEL);
 	if (err) {
-		pr_warn("Test failed: allocation error");
+		pr_warn("Test failed: allocation error\n");
 		return;
 	}
 
@@ -207,11 +209,11 @@ static void test_bucket_stats(struct rhashtable *ht, unsigned int entries)
 	rhashtable_walk_stop(&hti);
 	rhashtable_walk_exit(&hti);
 
-	pr_info("  Traversal complete: counted=%u, nelems=%u, entries=%d, table-jumps=%u\n",
+	pr_info("Traversal complete: counted=%u, nelems=%u, entries=%d, table-jumps=%u\n",
 		total, atomic_read(&ht->nelems), entries, chain_len);
 
 	if (total != atomic_read(&ht->nelems) || total != entries)
-		pr_warn("Test failed: Total count mismatch ^^^");
+		pr_warn("Test failed: Total count mismatch ^^^\n");
 }
 
 static s64 __init test_rhashtable(struct rhashtable *ht, struct test_obj *array,
@@ -226,7 +228,7 @@ static s64 __init test_rhashtable(struct rhashtable *ht, struct test_obj *array,
 	 * Insertion Test:
 	 * Insert entries into table with all keys even numbers
 	 */
-	pr_info("  Adding %d keys\n", entries);
+	pr_info("Adding %d keys\n", entries);
 	start = ktime_get_ns();
 	for (i = 0; i < entries; i++) {
 		struct test_obj *obj = &array[i];
@@ -240,7 +242,7 @@ static s64 __init test_rhashtable(struct rhashtable *ht, struct test_obj *array,
 	}
 
 	if (insert_retries)
-		pr_info("  %u insertions retried due to memory pressure\n",
+		pr_info("%u insertions retried due to memory pressure\n",
 			insert_retries);
 
 	test_bucket_stats(ht, entries);
@@ -250,7 +252,7 @@ static s64 __init test_rhashtable(struct rhashtable *ht, struct test_obj *array,
 
 	test_bucket_stats(ht, entries);
 
-	pr_info("  Deleting %d keys\n", entries);
+	pr_info("Deleting %d keys\n", entries);
 	for (i = 0; i < entries; i++) {
 		struct test_obj_val key = {
 			.id = i * 2,
@@ -267,7 +269,7 @@ static s64 __init test_rhashtable(struct rhashtable *ht, struct test_obj *array,
 	}
 
 	end = ktime_get_ns();
-	pr_info("  Duration of test: %lld ns\n", end - start);
+	pr_info("Duration of test: %lld ns\n", end - start);
 
 	return end - start;
 }
@@ -481,7 +483,7 @@ static int __init test_rhashtable_max(struct test_obj *array,
 		err = 0;
 	} else {
 		pr_info("insert element %u should have failed with %d, got %d\n",
-				ht.max_elems, -E2BIG, err);
+			ht.max_elems, -E2BIG, err);
 		if (err == 0)
 			err = -1;
 	}
@@ -611,13 +613,14 @@ static int thread_lookup_test(struct thread_data *tdata)
 
 		obj = rhashtable_lookup_fast(&ht, &key, test_rht_params);
 		if (obj && (tdata->objs[i].value.id == TEST_INSERT_FAIL)) {
-			pr_err("  found unexpected object %d-%d\n", key.tid, key.id);
+			pr_err("found unexpected object %d-%d\n",
+			       key.tid, key.id);
 			err++;
 		} else if (!obj && (tdata->objs[i].value.id != TEST_INSERT_FAIL)) {
-			pr_err("  object %d-%d not found!\n", key.tid, key.id);
+			pr_err("object %d-%d not found!\n", key.tid, key.id);
 			err++;
 		} else if (obj && memcmp(&obj->value, &key, sizeof(key))) {
-			pr_err("  wrong object returned (got %d-%d, expected %d-%d)\n",
+			pr_err("wrong object returned (got %d-%d, expected %d-%d)\n",
 			       obj->value.tid, obj->value.id, key.tid, key.id);
 			err++;
 		}
@@ -634,7 +637,7 @@ static int threadfunc(void *data)
 
 	up(&prestart_sem);
 	if (down_interruptible(&startup_sem))
-		pr_err("  thread[%d]: down_interruptible failed\n", tdata->id);
+		pr_err("thread[%d]: down_interruptible failed\n", tdata->id);
 
 	for (i = 0; i < tdata->entries; i++) {
 		tdata->objs[i].value.id = i;
@@ -643,18 +646,18 @@ static int threadfunc(void *data)
 		if (err > 0) {
 			insert_retries += err;
 		} else if (err) {
-			pr_err("  thread[%d]: rhashtable_insert_fast failed\n",
+			pr_err("thread[%d]: rhashtable_insert_fast failed\n",
 			       tdata->id);
 			goto out;
 		}
 	}
 	if (insert_retries)
-		pr_info("  thread[%d]: %u insertions retried due to memory pressure\n",
+		pr_info("thread[%d]: %u insertions retried due to memory pressure\n",
 			tdata->id, insert_retries);
 
 	err = thread_lookup_test(tdata);
 	if (err) {
-		pr_err("  thread[%d]: rhashtable_lookup_test failed\n",
+		pr_err("thread[%d]: rhashtable_lookup_test failed\n",
 		       tdata->id);
 		goto out;
 	}
@@ -666,7 +669,7 @@ static int threadfunc(void *data)
 			err = rhashtable_remove_fast(&ht, &tdata->objs[i].node,
 			                             test_rht_params);
 			if (err) {
-				pr_err("  thread[%d]: rhashtable_remove_fast failed\n",
+				pr_err("thread[%d]: rhashtable_remove_fast failed\n",
 				       tdata->id);
 				goto out;
 			}
@@ -676,7 +679,7 @@ static int threadfunc(void *data)
 		}
 		err = thread_lookup_test(tdata);
 		if (err) {
-			pr_err("  thread[%d]: rhashtable_lookup_test (2) failed\n",
+			pr_err("thread[%d]: rhashtable_lookup_test (2) failed\n",
 			       tdata->id);
 			goto out;
 		}
@@ -738,7 +741,8 @@ static int __init test_rht_init(void)
 	}
 
 	pr_info("test if its possible to exceed max_size %d: %s\n",
-			test_rht_params.max_size, test_rhashtable_max(objs, entries) == 0 ?
+		test_rht_params.max_size,
+		test_rhashtable_max(objs, entries) == 0 ?
 			"no, ok" : "YES, failed");
 	vfree(objs);
 
@@ -784,7 +788,7 @@ static int __init test_rht_init(void)
 			started_threads++;
 	}
 	if (down_interruptible(&prestart_sem))
-		pr_err("  down interruptible failed\n");
+		pr_err("down interruptible failed\n");
 	for (i = 0; i < tcount; i++)
 		up(&startup_sem);
 	for (i = 0; i < tcount; i++) {
diff --git a/lib/test_sort.c b/lib/test_sort.c
index 385c0ed5202f..4ee9b64a34ef 100644
--- a/lib/test_sort.c
+++ b/lib/test_sort.c
@@ -1,3 +1,5 @@
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/sort.h>
 #include <linux/slab.h>
 #include <linux/module.h>
diff --git a/lib/ubsan.c b/lib/ubsan.c
index 59fee96c29a0..c16fccf5277d 100644
--- a/lib/ubsan.c
+++ b/lib/ubsan.c
@@ -10,6 +10,8 @@
  *
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/bitops.h>
 #include <linux/bug.h>
 #include <linux/ctype.h>
@@ -49,10 +51,11 @@ static bool was_reported(struct source_location *location)
 }
 
 static void print_source_location(const char *prefix,
-				struct source_location *loc)
+				  struct source_location *loc)
 {
-	pr_err("%s %s:%d:%d\n", prefix, loc->file_name,
-		loc->line & LINE_MASK, loc->column & COLUMN_MASK);
+	pr_err("%s %s:%d:%d\n",
+	       prefix, loc->file_name,
+	       loc->line & LINE_MASK, loc->column & COLUMN_MASK);
 }
 
 static bool suppress_report(struct source_location *loc)
@@ -149,16 +152,14 @@ static void ubsan_prologue(struct source_location *location,
 	current->in_ubsan++;
 	spin_lock_irqsave(&report_lock, *flags);
 
-	pr_err("========================================"
-		"========================================\n");
-	print_source_location("UBSAN: Undefined behaviour in", location);
+	pr_err("================================================================================\n");
+	print_source_location("Undefined behaviour in", location);
 }
 
 static void ubsan_epilogue(unsigned long *flags)
 {
 	dump_stack();
-	pr_err("========================================"
-		"========================================\n");
+	pr_err("================================================================================\n");
 	spin_unlock_irqrestore(&report_lock, *flags);
 	current->in_ubsan--;
 }
@@ -182,9 +183,9 @@ static void handle_overflow(struct overflow_data *data, unsigned long lhs,
 	pr_err("%s integer overflow:\n",
 		type_is_signed(type) ? "signed" : "unsigned");
 	pr_err("%s %c %s cannot be represented in type %s\n",
-		lhs_val_str,
-		op,
-		rhs_val_str,
+	       lhs_val_str,
+	       op,
+	       rhs_val_str,
 		type->type_name);
 
 	ubsan_epilogue(&flags);
@@ -229,7 +230,7 @@ void __ubsan_handle_negate_overflow(struct overflow_data *data,
 	val_to_string(old_val_str, sizeof(old_val_str), data->type, old_val);
 
 	pr_err("negation of %s cannot be represented in type %s:\n",
-		old_val_str, data->type->type_name);
+	       old_val_str, data->type->type_name);
 
 	ubsan_epilogue(&flags);
 }
@@ -252,7 +253,7 @@ void __ubsan_handle_divrem_overflow(struct overflow_data *data,
 
 	if (type_is_signed(data->type) && get_signed_val(data->type, rhs) == -1)
 		pr_err("division of %s by -1 cannot be represented in type %s\n",
-			rhs_val_str, data->type->type_name);
+		       rhs_val_str, data->type->type_name);
 	else
 		pr_err("division by zero\n");
 
@@ -270,8 +271,8 @@ static void handle_null_ptr_deref(struct type_mismatch_data_common *data)
 	ubsan_prologue(data->location, &flags);
 
 	pr_err("%s null pointer of type %s\n",
-		type_check_kinds[data->type_check_kind],
-		data->type->type_name);
+	       type_check_kinds[data->type_check_kind],
+	       data->type->type_name);
 
 	ubsan_epilogue(&flags);
 }
@@ -287,8 +288,8 @@ static void handle_misaligned_access(struct type_mismatch_data_common *data,
 	ubsan_prologue(data->location, &flags);
 
 	pr_err("%s misaligned address %p for type %s\n",
-		type_check_kinds[data->type_check_kind],
-		(void *)ptr, data->type->type_name);
+	       type_check_kinds[data->type_check_kind],
+	       (void *)ptr, data->type->type_name);
 	pr_err("which requires %ld byte alignment\n", data->alignment);
 
 	ubsan_epilogue(&flags);
@@ -304,8 +305,8 @@ static void handle_object_size_mismatch(struct type_mismatch_data_common *data,
 
 	ubsan_prologue(data->location, &flags);
 	pr_err("%s address %p with insufficient space\n",
-		type_check_kinds[data->type_check_kind],
-		(void *) ptr);
+	       type_check_kinds[data->type_check_kind],
+	       (void *)ptr);
 	pr_err("for an object of type %s\n", data->type->type_name);
 	ubsan_epilogue(&flags);
 }
@@ -381,8 +382,8 @@ void __ubsan_handle_out_of_bounds(struct out_of_bounds_data *data,
 	ubsan_prologue(&data->location, &flags);
 
 	val_to_string(index_str, sizeof(index_str), data->index_type, index);
-	pr_err("index %s is out of range for type %s\n", index_str,
-		data->array_type->type_name);
+	pr_err("index %s is out of range for type %s\n",
+	       index_str, data->array_type->type_name);
 	ubsan_epilogue(&flags);
 }
 EXPORT_SYMBOL(__ubsan_handle_out_of_bounds);
@@ -410,17 +411,15 @@ void __ubsan_handle_shift_out_of_bounds(struct shift_out_of_bounds_data *data,
 	else if (get_unsigned_val(rhs_type, rhs) >=
 		type_bit_width(lhs_type))
 		pr_err("shift exponent %s is too large for %u-bit type %s\n",
-			rhs_str,
-			type_bit_width(lhs_type),
-			lhs_type->type_name);
+		       rhs_str,
+		       type_bit_width(lhs_type),
+		       lhs_type->type_name);
 	else if (val_is_negative(lhs_type, lhs))
-		pr_err("left shift of negative value %s\n",
-			lhs_str);
+		pr_err("left shift of negative value %s\n", lhs_str);
 	else
-		pr_err("left shift of %s by %s places cannot be"
-			" represented in type %s\n",
-			lhs_str, rhs_str,
-			lhs_type->type_name);
+		pr_err("left shift of %s by %s places cannot be represented in type %s\n",
+		       lhs_str, rhs_str,
+		       lhs_type->type_name);
 
 	ubsan_epilogue(&flags);
 }
@@ -453,7 +452,7 @@ void __ubsan_handle_load_invalid_value(struct invalid_value_data *data,
 	val_to_string(val_str, sizeof(val_str), data->type, val);
 
 	pr_err("load of value %s is not a valid value for type %s\n",
-		val_str, data->type->type_name);
+	       val_str, data->type->type_name);
 
 	ubsan_epilogue(&flags);
 }
-- 
2.15.0
