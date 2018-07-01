Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF81C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C781252FF
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:36:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C781252FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031299AbeGAQgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:36:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35990 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031259AbeGAQgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:36:25 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BEB2349B;
        Sun,  1 Jul 2018 16:36:24 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 151/157] slub: fix failure when we delete and create a slab cache
Date:   Sun,  1 Jul 2018 18:23:43 +0200
Message-Id: <20180701160900.760470433@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160852.287307684@linuxfoundation.org>
References: <20180701160852.287307684@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

commit d50d82faa0c964e31f7a946ba8aba7c715ca7ab0 upstream.

In kernel 4.17 I removed some code from dm-bufio that did slab cache
merging (commit 21bb13276768: "dm bufio: remove code that merges slab
caches") - both slab and slub support merging caches with identical
attributes, so dm-bufio now just calls kmem_cache_create and relies on
implicit merging.

This uncovered a bug in the slub subsystem - if we delete a cache and
immediatelly create another cache with the same attributes, it fails
because of duplicate filename in /sys/kernel/slab/.  The slub subsystem
offloads freeing the cache to a workqueue - and if we create the new
cache before the workqueue runs, it complains because of duplicate
filename in sysfs.

This patch fixes the bug by moving the call of kobject_del from
sysfs_slab_remove_workfn to shutdown_cache.  kobject_del must be called
while we hold slab_mutex - so that the sysfs entry is deleted before a
cache with the same attributes could be created.

Running device-mapper-test-suite with:

  dmtest run --suite thin-provisioning -n /commit_failure_causes_fallback/

triggered:

  Buffer I/O error on dev dm-0, logical block 1572848, async page read
  device-mapper: thin: 253:1: metadata operation 'dm_pool_alloc_data_block' failed: error = -5
  device-mapper: thin: 253:1: aborting current metadata transaction
  sysfs: cannot create duplicate filename '/kernel/slab/:a-0000144'
  CPU: 2 PID: 1037 Comm: kworker/u48:1 Not tainted 4.17.0.snitm+ #25
  Hardware name: Supermicro SYS-1029P-WTR/X11DDW-L, BIOS 2.0a 12/06/2017
  Workqueue: dm-thin do_worker [dm_thin_pool]
  Call Trace:
   dump_stack+0x5a/0x73
   sysfs_warn_dup+0x58/0x70
   sysfs_create_dir_ns+0x77/0x80
   kobject_add_internal+0xba/0x2e0
   kobject_init_and_add+0x70/0xb0
   sysfs_slab_add+0xb1/0x250
   __kmem_cache_create+0x116/0x150
   create_cache+0xd9/0x1f0
   kmem_cache_create_usercopy+0x1c1/0x250
   kmem_cache_create+0x18/0x20
   dm_bufio_client_create+0x1ae/0x410 [dm_bufio]
   dm_block_manager_create+0x5e/0x90 [dm_persistent_data]
   __create_persistent_data_objects+0x38/0x940 [dm_thin_pool]
   dm_pool_abort_metadata+0x64/0x90 [dm_thin_pool]
   metadata_operation_failed+0x59/0x100 [dm_thin_pool]
   alloc_data_block.isra.53+0x86/0x180 [dm_thin_pool]
   process_cell+0x2a3/0x550 [dm_thin_pool]
   do_worker+0x28d/0x8f0 [dm_thin_pool]
   process_one_work+0x171/0x370
   worker_thread+0x49/0x3f0
   kthread+0xf8/0x130
   ret_from_fork+0x35/0x40
  kobject_add_internal failed for :a-0000144 with -EEXIST, don't try to register things with the same name in the same directory.
  kmem_cache_create(dm_bufio_buffer-16) failed with error -17

Link: http://lkml.kernel.org/r/alpine.LRH.2.02.1806151817130.6333@file01.intranet.prod.int.rdu2.redhat.com
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Reported-by: Mike Snitzer <snitzer@redhat.com>
Tested-by: Mike Snitzer <snitzer@redhat.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/slub_def.h |    4 ++++
 mm/slab_common.c         |    4 ++++
 mm/slub.c                |    7 ++++++-
 3 files changed, 14 insertions(+), 1 deletion(-)

--- a/include/linux/slub_def.h
+++ b/include/linux/slub_def.h
@@ -151,8 +151,12 @@ struct kmem_cache {
 
 #ifdef CONFIG_SYSFS
 #define SLAB_SUPPORTS_SYSFS
+void sysfs_slab_unlink(struct kmem_cache *);
 void sysfs_slab_release(struct kmem_cache *);
 #else
+static inline void sysfs_slab_unlink(struct kmem_cache *s)
+{
+}
 static inline void sysfs_slab_release(struct kmem_cache *s)
 {
 }
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -546,10 +546,14 @@ static int shutdown_cache(struct kmem_ca
 	list_del(&s->list);
 
 	if (s->flags & SLAB_TYPESAFE_BY_RCU) {
+#ifdef SLAB_SUPPORTS_SYSFS
+		sysfs_slab_unlink(s);
+#endif
 		list_add_tail(&s->list, &slab_caches_to_rcu_destroy);
 		schedule_work(&slab_caches_to_rcu_destroy_work);
 	} else {
 #ifdef SLAB_SUPPORTS_SYSFS
+		sysfs_slab_unlink(s);
 		sysfs_slab_release(s);
 #else
 		slab_kmem_cache_release(s);
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5660,7 +5660,6 @@ static void sysfs_slab_remove_workfn(str
 	kset_unregister(s->memcg_kset);
 #endif
 	kobject_uevent(&s->kobj, KOBJ_REMOVE);
-	kobject_del(&s->kobj);
 out:
 	kobject_put(&s->kobj);
 }
@@ -5745,6 +5744,12 @@ static void sysfs_slab_remove(struct kme
 	schedule_work(&s->kobj_remove_work);
 }
 
+void sysfs_slab_unlink(struct kmem_cache *s)
+{
+	if (slab_state >= FULL)
+		kobject_del(&s->kobj);
+}
+
 void sysfs_slab_release(struct kmem_cache *s)
 {
 	if (slab_state >= FULL)


