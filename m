Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2F8C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9F5A206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730188AbeLNRAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 12:00:24 -0500
Received: from www.osadl.org ([62.245.132.105]:36103 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729409AbeLNRAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 12:00:24 -0500
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id wBEGxVdj014507;
        Fri, 14 Dec 2018 17:59:31 +0100
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Jessica Yu <jeyu@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH 1/2] livepatch: fix non-static warnings
Date:   Fri, 14 Dec 2018 17:56:09 +0100
Message-Id: <1544806570-21299-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reported warnings about non-static symbols. For the variables a
simple static attribute is fine - for those symbols referenced by
livepatch via klp_func the symbol-names must be unmodified in the
relocation table - to resolve this the __noclone attribute (as 
suggested by Joe Lawrence <joe.lawrence@redhat.com>) is used
for the statically declared functions.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Link: https://lkml.org/lkml/2018/12/13/827
---

sparse reported the following warnings:

  CHECK   samples/livepatch/livepatch-shadow-fix1.c
samples/livepatch/livepatch-shadow-fix1.c:74:14: warning: symbol
 'livepatch_fix1_dummy alloc' was not declared. Should it be static?
samples/livepatch/livepatch-shadow-fix1.c:116:6: warning: symbol
 'livepatch_fix1_dummy free' was not declared. Should it be static?

  CHECK   samples/livepatch/livepatch-shadow-mod.c
samples/livepatch/livepatch-shadow-mod.c:99:1: warning: symbol
 'dummy_list' was not declared. Should it be static?
samples/livepatch/livepatch-shadow-mod.c:100:1: warning: symbol
 'dummy_list_mutex' was not declared. Should it be static?
samples/livepatch/livepatch-shadow-mod.c:107:23: warning: symbol
 'dummy_alloc' was not declared. Should it be static?
samples/livepatch/livepatch-shadow-mod.c:132:15: warning: symbol
 'dummy_free' was not declared. Should it be static?
samples/livepatch/livepatch-shadow-mod.c:140:15: warning: symbol
 'dummy_check' was not declared. Should it be static?

Patch was compile tested with: x86_64_defconfig + FTRACE=y
FUNCTION_TRACER=y, EXPERT=y, LATENCYTOP=y, SAMPLES=y,
SAMPLE_LIVEPATCH=y

Patch was runtested on an Intel i3 with:
   insmod samples/livepatch/livepatch-shadow-mod.ko
   insmod samples/livepatch/livepatch-shadow-fix1.ko
   insmod samples/livepatch/livepatch-shadow-fix2.ko
   echo 0 > /sys/kernel/livepatch/livepatch_shadow_fix2/enabled
   echo 0 > /sys/kernel/livepatch/livepatch_shadow_fix1/enabled
   rmmod livepatch-shadow-fix2
   rmmod livepatch-shadow-fix1
   rmmod livepatch-shadow-mod
and dmesg output checked.

Patch is against 4.20-rc6 (localversion-next is next-20181214)

 samples/livepatch/livepatch-shadow-fix1.c |  4 ++--
 samples/livepatch/livepatch-shadow-mod.c  | 16 +++++++++++-----
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/samples/livepatch/livepatch-shadow-fix1.c b/samples/livepatch/livepatch-shadow-fix1.c
index 49b1355..eaab10f 100644
--- a/samples/livepatch/livepatch-shadow-fix1.c
+++ b/samples/livepatch/livepatch-shadow-fix1.c
@@ -71,7 +71,7 @@ static int shadow_leak_ctor(void *obj, void *shadow_data, void *ctor_data)
 	return 0;
 }
 
-struct dummy *livepatch_fix1_dummy_alloc(void)
+static __noclone struct dummy *livepatch_fix1_dummy_alloc(void)
 {
 	struct dummy *d;
 	void *leak;
@@ -108,7 +108,7 @@ static void livepatch_fix1_dummy_leak_dtor(void *obj, void *shadow_data)
 			 __func__, d, *shadow_leak);
 }
 
-void livepatch_fix1_dummy_free(struct dummy *d)
+static __noclone void livepatch_fix1_dummy_free(struct dummy *d)
 {
 	void **shadow_leak;
 
diff --git a/samples/livepatch/livepatch-shadow-mod.c b/samples/livepatch/livepatch-shadow-mod.c
index 4c54b25..0a72bc2 100644
--- a/samples/livepatch/livepatch-shadow-mod.c
+++ b/samples/livepatch/livepatch-shadow-mod.c
@@ -30,6 +30,11 @@
  * memory leak, please load these modules at your own risk -- some
  * amount of memory may leaked before the bug is patched.
  *
+ * NOTE - the __noclone attribute to those functions that are to be
+ * shared with other modules while being declared static. As livepatch
+ * needs the unmodified symbol names and the usual "static" would
+ * invoke gccs cloning mechanism that renames the functions this
+ * needs to be suppressed with the additional __noclone attribute.
  *
  * Usage
  * -----
@@ -96,15 +101,15 @@ MODULE_DESCRIPTION("Buggy module for shadow variable demo");
  * Keep a list of all the dummies so we can clean up any residual ones
  * on module exit
  */
-LIST_HEAD(dummy_list);
-DEFINE_MUTEX(dummy_list_mutex);
+static LIST_HEAD(dummy_list);
+static DEFINE_MUTEX(dummy_list_mutex);
 
 struct dummy {
 	struct list_head list;
 	unsigned long jiffies_expire;
 };
 
-noinline struct dummy *dummy_alloc(void)
+static __noclone noinline struct dummy *dummy_alloc(void)
 {
 	struct dummy *d;
 	void *leak;
@@ -125,7 +130,7 @@ noinline struct dummy *dummy_alloc(void)
 	return d;
 }
 
-noinline void dummy_free(struct dummy *d)
+static __noclone noinline void dummy_free(struct dummy *d)
 {
 	pr_info("%s: dummy @ %p, expired = %lx\n",
 		__func__, d, d->jiffies_expire);
@@ -133,7 +138,8 @@ noinline void dummy_free(struct dummy *d)
 	kfree(d);
 }
 
-noinline bool dummy_check(struct dummy *d, unsigned long jiffies)
+static __noclone noinline bool dummy_check(struct dummy *d,
+					   unsigned long jiffies)
 {
 	return time_after(jiffies, d->jiffies_expire);
 }
-- 
2.1.4

