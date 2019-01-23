Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A92C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 848F120870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbfAWHCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 02:02:25 -0500
Received: from www.osadl.org ([62.245.132.105]:44879 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbfAWHCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 02:02:24 -0500
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id x0N71EDD007908;
        Wed, 23 Jan 2019 08:01:14 +0100
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Jessica Yu <jeyu@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH V3] livepatch: non static warnings fix
Date:   Wed, 23 Jan 2019 07:56:24 +0100
Message-Id: <1548226584-20579-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reported warnings about non-static symbols. For the variables
a simple static attribute is fine - for the functions referenced by
livepatch via klp_func the symbol-names must be unmodified in the
symbol table and the patchable code has to be emitted. The resolution
is to attach __used attribute to the shared statically declared functions.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Suggested-by: Joe Lawrence <joe.lawrence@redhat.com>
Link: https://lkml.org/lkml/2018/12/13/827
---

V2: not all static functions shared need to carry the __noclone
    attribute only those that need to be resolved at runtime by
    livepatch - so drop the unnecessary __noclone attributes as
    well as the Note on __noclone as suggested by Joe Lawrence
    <joe.lawrence@redhat.com> - thanks !

V3: fix the wording as proposed by Joe Lawrence
    <joe.lawrence@redhat.com> to address that this is not only
    about how to fix sparse warnings but also to ensure
    traceable/patchable code still being emitted.

Sparse reported the following findings in 5.0-rc3:

  CHECK   samples/livepatch/livepatch-shadow-mod.c
samples/livepatch/livepatch-shadow-mod.c:99:1: warning: symbol 'dummy_list' was not declared. Should it be static?
samples/livepatch/livepatch-shadow-mod.c:100:1: warning: symbol 'dummy_list_mutex' was not declared. Should it be static?
samples/livepatch/livepatch-shadow-mod.c:107:23: warning: symbol 'dummy_alloc' was not declared. Should it be static?
samples/livepatch/livepatch-shadow-mod.c:132:15: warning: symbol 'dummy_free' was not declared. Should it be static?
samples/livepatch/livepatch-shadow-mod.c:140:15: warning: symbol 'dummy_check' was not declared. Should it be static?

  CHECK   samples/livepatch/livepatch-shadow-fix1.c
samples/livepatch/livepatch-shadow-fix1.c:74:14: warning: symbol 'livepatch_fix1_dummy_alloc' was not declared. Should it be static?
samples/livepatch/livepatch-shadow-fix1.c:116:6: warning: symbol 'livepatch_fix1_dummy_free' was not declared. Should it be static?

  CHECK   samples/livepatch/livepatch-shadow-fix2.c
samples/livepatch/livepatch-shadow-fix2.c:53:6: warning: symbol 'livepatch_fix2_dummy_check' was not declared. Should it be static?
samples/livepatch/livepatch-shadow-fix2.c:81:6: warning: symbol 'livepatch_fix2_dummy_free' was not declared. Should it be static?

Patch was compile tested with: x86_64_defconfig + FTRACE=y
FUNCTION_TRACER=y, SAMPLES=y, LIVEPATCH=y SAMPLE_LIVEPATCH=m
(looks sparse, smatch claan, one coccichek warning left - fix later today)

Patch was runtested with:
   insmod samples/livepatch/livepatch-shadow-mod.ko
   insmod samples/livepatch/livepatch-shadow-fix1.ko
   insmod samples/livepatch/livepatch-shadow-fix2.ko
   echo 0 > /sys/kernel/livepatch/livepatch_shadow_fix2/enabled
   echo 0 > /sys/kernel/livepatch/livepatch_shadow_fix1/enabled
   rmmod livepatch-shadow-fix2
   rmmod livepatch-shadow-fix1
   rmmod livepatch-shadow-mod
and dmesg output compared to previous run.

Patch is against 5.0-rc3 (localversion-next is next-20190123)

 samples/livepatch/livepatch-shadow-fix1.c |  4 ++--
 samples/livepatch/livepatch-shadow-fix2.c |  4 ++--
 samples/livepatch/livepatch-shadow-mod.c  | 11 ++++++-----
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/samples/livepatch/livepatch-shadow-fix1.c b/samples/livepatch/livepatch-shadow-fix1.c
index a5a5cac..67a73e5 100644
--- a/samples/livepatch/livepatch-shadow-fix1.c
+++ b/samples/livepatch/livepatch-shadow-fix1.c
@@ -71,7 +71,7 @@ static int shadow_leak_ctor(void *obj, void *shadow_data, void *ctor_data)
 	return 0;
 }
 
-struct dummy *livepatch_fix1_dummy_alloc(void)
+static struct dummy *livepatch_fix1_dummy_alloc(void)
 {
 	struct dummy *d;
 	void *leak;
@@ -113,7 +113,7 @@ static void livepatch_fix1_dummy_leak_dtor(void *obj, void *shadow_data)
 			 __func__, d, *shadow_leak);
 }
 
-void livepatch_fix1_dummy_free(struct dummy *d)
+static void livepatch_fix1_dummy_free(struct dummy *d)
 {
 	void **shadow_leak;
 
diff --git a/samples/livepatch/livepatch-shadow-fix2.c b/samples/livepatch/livepatch-shadow-fix2.c
index 52de947..91c21d5 100644
--- a/samples/livepatch/livepatch-shadow-fix2.c
+++ b/samples/livepatch/livepatch-shadow-fix2.c
@@ -50,7 +50,7 @@ struct dummy {
 	unsigned long jiffies_expire;
 };
 
-bool livepatch_fix2_dummy_check(struct dummy *d, unsigned long jiffies)
+static bool livepatch_fix2_dummy_check(struct dummy *d, unsigned long jiffies)
 {
 	int *shadow_count;
 
@@ -78,7 +78,7 @@ static void livepatch_fix2_dummy_leak_dtor(void *obj, void *shadow_data)
 			 __func__, d, *shadow_leak);
 }
 
-void livepatch_fix2_dummy_free(struct dummy *d)
+static void livepatch_fix2_dummy_free(struct dummy *d)
 {
 	void **shadow_leak;
 	int *shadow_count;
diff --git a/samples/livepatch/livepatch-shadow-mod.c b/samples/livepatch/livepatch-shadow-mod.c
index 4aa8a88..4d79c6dc 100644
--- a/samples/livepatch/livepatch-shadow-mod.c
+++ b/samples/livepatch/livepatch-shadow-mod.c
@@ -96,15 +96,15 @@ MODULE_DESCRIPTION("Buggy module for shadow variable demo");
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
+static __used noinline struct dummy *dummy_alloc(void)
 {
 	struct dummy *d;
 	void *leak;
@@ -129,7 +129,7 @@ noinline struct dummy *dummy_alloc(void)
 	return d;
 }
 
-noinline void dummy_free(struct dummy *d)
+static __used noinline void dummy_free(struct dummy *d)
 {
 	pr_info("%s: dummy @ %p, expired = %lx\n",
 		__func__, d, d->jiffies_expire);
@@ -137,7 +137,8 @@ noinline void dummy_free(struct dummy *d)
 	kfree(d);
 }
 
-noinline bool dummy_check(struct dummy *d, unsigned long jiffies)
+static __used noinline bool dummy_check(struct dummy *d,
+					   unsigned long jiffies)
 {
 	return time_after(jiffies, d->jiffies_expire);
 }
-- 
2.1.4

