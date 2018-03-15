Return-Path: <andriy.shevchenko@linux.intel.com>
X-Google-Smtp-Source: AG47ELtBGi5Nd2zcs4VNkHgxsIodPXPIZ/7NR6SAo4ELFPezRxPMQ6wd4ayTRaJEBItogJGu+KTp
ARC-Seal: i=1; a=rsa-sha256; t=1521120226; cv=none;
        d=google.com; s=arc-20160816;
        b=TWp1nPcKyePSU269/Pd9Vfh7cwESXjTkAfaEJRInIHf1XiPdD34NpsK7Z9ofORok40
         xzUn0D9eJ2HqggAr/q/zouCN/M0wS2b7ZOHcOI2Pj5A2OjQJq8IYRwMVlaGbH52K+lKW
         Pi53cgCabXU8gJzyuKTWHCPZVhGnet1xjHBlxEhgL1S/WMpMhnSaC3ILDOa845lnHycv
         4sF5wFfAH1/3KuQaQO8DrC+9lzAHEHlklyvjFVZhBWbGQB6jdtEHMFrc3bkmz9s+e2Bm
         +bir/0PKzDxB1Iu7oYCp52X+nRYO4ImO+eInWBqC45wOFJHg8B5W9X2m+Kyb2uWT7MX7
         EZWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=2dWIrGqUZlWMDXyLJw/orhwveCGbU9yATLfjHS7NQOA=;
        b=grGSP5SoOLW9g3ATMeuAjty9KXtrSS4RMp8k+Dc5A+7iVXz0m6AhFHWuF5DJ5N8yev
         4uehsOi7spGwtsKg9ZXxB7QJ+HU+TMzVJX3LgXKFgE3Zib8J+jRujuNUt2I7sI4om7bw
         v+NpaK7K8haTKlN8GSI5n5LTgIIrcNpY62668rcPfDExnulYbww7rXBtTP1qGbpUUbfo
         cbjYuD1wbAvavIjQCJo5HM+KWwlQPwiyfvXYOl23+pwGo7I0/AP1O4Nqdhw0CaptVn8d
         tUCbcQCyKeNsuN+n2o4JmIhf2/vTsbzmYsWaj0BHg5gVGyu2DqvrxyiOXDUvcbnATmNl
         4uvQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 134.134.136.100 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 134.134.136.100 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,310,1517904000";
   d="scan'208";a="211820063"
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] lib/kobject: Join string literals back
Date: Thu, 15 Mar 2018 15:23:43 +0200
Message-Id: <20180315132343.83346-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.16.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595010162847719045?=
X-GMAIL-MSGID: =?utf-8?q?1595010162847719045?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

There is no need to split string literals. Moreover, it would be simpler
to grep for an actual code line, when debugging, by using almost any
part of the string literal in question.

While here, replace printk(LEVEL) by pr_lvl() macros.

No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/kobject.c | 39 ++++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/lib/kobject.c b/lib/kobject.c
index afd5a3fc6123..e1d1f290bf35 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -204,8 +204,9 @@ static int kobject_add_internal(struct kobject *kobj)
 		return -ENOENT;
 
 	if (!kobj->name || !kobj->name[0]) {
-		WARN(1, "kobject: (%p): attempted to be registered with empty "
-			 "name!\n", kobj);
+		WARN(1,
+		     "kobject: (%p): attempted to be registered with empty name!\n",
+		     kobj);
 		return -EINVAL;
 	}
 
@@ -232,9 +233,8 @@ static int kobject_add_internal(struct kobject *kobj)
 
 		/* be noisy on error issues */
 		if (error == -EEXIST)
-			WARN(1, "%s failed for %s with "
-			     "-EEXIST, don't try to register things with "
-			     "the same name in the same directory.\n",
+			WARN(1,
+			     "%s failed for %s with -EEXIST, don't try to register things with the same name in the same directory.\n",
 			     __func__, kobject_name(kobj));
 		else
 			WARN(1, "%s failed for %s (error: %d parent: %s)\n",
@@ -334,8 +334,8 @@ void kobject_init(struct kobject *kobj, struct kobj_type *ktype)
 	}
 	if (kobj->state_initialized) {
 		/* do not error out as sometimes we can recover */
-		printk(KERN_ERR "kobject (%p): tried to init an initialized "
-		       "object, something is seriously wrong.\n", kobj);
+		pr_err("kobject (%p): tried to init an initialized object, something is seriously wrong.\n",
+		       kobj);
 		dump_stack();
 	}
 
@@ -344,7 +344,7 @@ void kobject_init(struct kobject *kobj, struct kobj_type *ktype)
 	return;
 
 error:
-	printk(KERN_ERR "kobject (%p): %s\n", kobj, err_str);
+	pr_err("kobject (%p): %s\n", kobj, err_str);
 	dump_stack();
 }
 EXPORT_SYMBOL(kobject_init);
@@ -357,7 +357,7 @@ static __printf(3, 0) int kobject_add_varg(struct kobject *kobj,
 
 	retval = kobject_set_name_vargs(kobj, fmt, vargs);
 	if (retval) {
-		printk(KERN_ERR "kobject: can not set name properly!\n");
+		pr_err("kobject: can not set name properly!\n");
 		return retval;
 	}
 	kobj->parent = parent;
@@ -399,8 +399,7 @@ int kobject_add(struct kobject *kobj, struct kobject *parent,
 		return -EINVAL;
 
 	if (!kobj->state_initialized) {
-		printk(KERN_ERR "kobject '%s' (%p): tried to add an "
-		       "uninitialized object, something is seriously wrong.\n",
+		pr_err("kobject '%s' (%p): tried to add an uninitialized object, something is seriously wrong.\n",
 		       kobject_name(kobj), kobj);
 		dump_stack();
 		return -EINVAL;
@@ -590,9 +589,9 @@ struct kobject *kobject_get(struct kobject *kobj)
 {
 	if (kobj) {
 		if (!kobj->state_initialized)
-			WARN(1, KERN_WARNING "kobject: '%s' (%p): is not "
-			       "initialized, yet kobject_get() is being "
-			       "called.\n", kobject_name(kobj), kobj);
+			WARN(1, KERN_WARNING
+				"kobject: '%s' (%p): is not initialized, yet kobject_get() is being called.\n",
+			     kobject_name(kobj), kobj);
 		kref_get(&kobj->kref);
 	}
 	return kobj;
@@ -622,8 +621,7 @@ static void kobject_cleanup(struct kobject *kobj)
 		 kobject_name(kobj), kobj, __func__, kobj->parent);
 
 	if (t && !t->release)
-		pr_debug("kobject: '%s' (%p): does not have a release() "
-			 "function, it is broken and must be fixed.\n",
+		pr_debug("kobject: '%s' (%p): does not have a release() function, it is broken and must be fixed.\n",
 			 kobject_name(kobj), kobj);
 
 	/* send "remove" if the caller did not do it but sent "add" */
@@ -686,9 +684,9 @@ void kobject_put(struct kobject *kobj)
 {
 	if (kobj) {
 		if (!kobj->state_initialized)
-			WARN(1, KERN_WARNING "kobject: '%s' (%p): is not "
-			       "initialized, yet kobject_put() is being "
-			       "called.\n", kobject_name(kobj), kobj);
+			WARN(1, KERN_WARNING
+				"kobject: '%s' (%p): is not initialized, yet kobject_put() is being called.\n",
+			     kobject_name(kobj), kobj);
 		kref_put(&kobj->kref, kobject_release);
 	}
 }
@@ -752,8 +750,7 @@ struct kobject *kobject_create_and_add(const char *name, struct kobject *parent)
 
 	retval = kobject_add(kobj, parent, "%s", name);
 	if (retval) {
-		printk(KERN_WARNING "%s: kobject_add error: %d\n",
-		       __func__, retval);
+		pr_warn("%s: kobject_add error: %d\n", __func__, retval);
 		kobject_put(kobj);
 		kobj = NULL;
 	}
-- 
2.16.1
