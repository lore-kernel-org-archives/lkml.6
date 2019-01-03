Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A07CC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 18:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 247DB217F5
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 18:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hTmg+DGu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfACSpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 13:45:36 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40987 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbfACSpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 13:45:32 -0500
Received: by mail-wr1-f66.google.com with SMTP id x10so34477141wrs.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 10:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=loqk+YaJssCyhGzAFNinnRGb50LrNU13L8MGywEfc18=;
        b=hTmg+DGuRIQF2vlqz/Vhl1D+/+mvgPMsjqLDHi0P1rk+WOre7zmTu5qqGxv3MuZCCE
         UmLGhAKFZbzdsd4JMY8pdmgI4HYcHr4YnHntxG+Gt//m4C9Qndntnz8PKfjmfZeLTDpd
         K0fspUq1NKHV5A284NV0qPwtJ8DdvroBOj8kdD2qczrMK2lmGiPk5KVZxusGtbJdfqwR
         UUZxn2Qs6thHtP1o2ZG8BwsnsoATqNMckkznlYwnbdZQ8C3QDsxrTRM76uXF0vMqJHwb
         NV6DgqPzaJ4SZY9nrBP+8lLvzwTIs4vFYaq5Eyd/Nw+pUV8pY0KTWdZ5qFjegRMm8Ha4
         w6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=loqk+YaJssCyhGzAFNinnRGb50LrNU13L8MGywEfc18=;
        b=Ph+VROwYsBEwMG77ySO1CuN1yY7QXdCZk1HS9mZQe2ikJozJhr+j/lbunFBiOq1znl
         aRcqvnzCI4pYj28qS/YLktZ7fkb1WMI4lJ76XNBAHwwLyO+baCTB/eJZjhxO4Nkd0uWV
         dWSHbVi4UbELNh8HKP2exdUmkVzvfc1UaARQeyZ7tWm7Y4HeWAb3LUmcqN2p+l94k357
         hS/vpuVM41F/j6xZnBzsOW1sgS9+r4YjV4tUsxYy71QQApvJJ0pRqmGktXa2c6y1utTv
         olIuOUQmr3I4xQ5cBgpDzW7oa1W4zqCVJJtUXXdPH8o5X+AoPIxwMHX4QTu1OLeps3Gb
         Z1EQ==
X-Gm-Message-State: AJcUukdjRHP6yT3HwcvrmhvqOHumeXpWs//bGBbllzglpxBd7U2ng2fA
        XQhkvdUtIY82PSlvL8YoiQNKdA==
X-Google-Smtp-Source: ALg8bN4jM3MVHQyzwSzizLWeommEZcTAUOfqxGGPUDgiXkfn7dghhnI866UT0Yj3Z9dcwdbzSDIU7w==
X-Received: by 2002:adf:e34b:: with SMTP id n11mr39771740wrj.91.1546541130566;
        Thu, 03 Jan 2019 10:45:30 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:13:8ce:d7fa:9f4c:492])
        by smtp.gmail.com with ESMTPSA id t12sm52236944wrr.65.2019.01.03.10.45.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jan 2019 10:45:29 -0800 (PST)
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sparse@vger.kernel.org, linux-mm@kvack.org,
        linux-kbuild@vger.kernel.org
Cc:     Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Jann Horn <jannh@google.com>,
        Mark Brand <markbrand@google.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Vishwath Mohan <vishwath@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v3 3/3] kasan: fix krealloc handling for tag-based mode
Date:   Thu,  3 Jan 2019 19:45:21 +0100
Message-Id: <bb2a71d17ed072bcc528cbee46fcbd71a6da3be4.1546540962.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
In-Reply-To: <cover.1546540962.git.andreyknvl@google.com>
References: <cover.1546540962.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now tag-based KASAN can retag the memory that is reallocated via
krealloc and return a differently tagged pointer even if the same slab
object gets used and no reallocated technically happens.

There are a few issues with this approach. One is that krealloc callers
can't rely on comparing the return value with the passed argument to
check whether reallocation happened. Another is that if a caller knows
that no reallocation happened, that it can access object memory through
the old pointer, which leads to false positives. Look at nf_ct_ext_add()
to see an example.

Fix this by keeping the same tag if the memory don't actually gets
reallocated during krealloc.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/common.c | 63 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 43 insertions(+), 20 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 44390392d4c9..73c9cbfdedf4 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -347,28 +347,43 @@ void kasan_poison_object_data(struct kmem_cache *cache, void *object)
 }
 
 /*
- * Since it's desirable to only call object contructors once during slab
- * allocation, we preassign tags to all such objects. Also preassign tags for
- * SLAB_TYPESAFE_BY_RCU slabs to avoid use-after-free reports.
- * For SLAB allocator we can't preassign tags randomly since the freelist is
- * stored as an array of indexes instead of a linked list. Assign tags based
- * on objects indexes, so that objects that are next to each other get
- * different tags.
- * After a tag is assigned, the object always gets allocated with the same tag.
- * The reason is that we can't change tags for objects with constructors on
- * reallocation (even for non-SLAB_TYPESAFE_BY_RCU), because the constructor
- * code can save the pointer to the object somewhere (e.g. in the object
- * itself). Then if we retag it, the old saved pointer will become invalid.
+ * This function assigns a tag to an object considering the following:
+ * 1. A cache might have a constructor, which might save a pointer to a slab
+ *    object somewhere (e.g. in the object itself). We preassign a tag for
+ *    each object in caches with constructors during slab creation and reuse
+ *    the same tag each time a particular object is allocated.
+ * 2. A cache might be SLAB_TYPESAFE_BY_RCU, which means objects can be
+ *    accessed after being freed. We preassign tags for objects in these
+ *    caches as well.
+ * 3. For SLAB allocator we can't preassign tags randomly since the freelist
+ *    is stored as an array of indexes instead of a linked list. Assign tags
+ *    based on objects indexes, so that objects that are next to each other
+ *    get different tags.
  */
-static u8 assign_tag(struct kmem_cache *cache, const void *object, bool new)
+static u8 assign_tag(struct kmem_cache *cache, const void *object,
+			bool init, bool krealloc)
 {
+	/* Reuse the same tag for krealloc'ed objects. */
+	if (krealloc)
+		return get_tag(object);
+
+	/*
+	 * If the cache neither has a constructor nor has SLAB_TYPESAFE_BY_RCU
+	 * set, assign a tag when the object is being allocated (init == false).
+	 */
 	if (!cache->ctor && !(cache->flags & SLAB_TYPESAFE_BY_RCU))
-		return new ? KASAN_TAG_KERNEL : random_tag();
+		return init ? KASAN_TAG_KERNEL : random_tag();
 
+	/* For caches that either have a constructor or SLAB_TYPESAFE_BY_RCU: */
 #ifdef CONFIG_SLAB
+	/* For SLAB assign tags based on the object index in the freelist. */
 	return (u8)obj_to_index(cache, virt_to_page(object), (void *)object);
 #else
-	return new ? random_tag() : get_tag(object);
+	/*
+	 * For SLUB assign a random tag during slab creation, otherwise reuse
+	 * the already assigned tag.
+	 */
+	return init ? random_tag() : get_tag(object);
 #endif
 }
 
@@ -384,7 +399,8 @@ void * __must_check kasan_init_slab_obj(struct kmem_cache *cache,
 	__memset(alloc_info, 0, sizeof(*alloc_info));
 
 	if (IS_ENABLED(CONFIG_KASAN_SW_TAGS))
-		object = set_tag(object, assign_tag(cache, object, true));
+		object = set_tag(object,
+				assign_tag(cache, object, true, false));
 
 	return (void *)object;
 }
@@ -450,8 +466,8 @@ bool kasan_slab_free(struct kmem_cache *cache, void *object, unsigned long ip)
 	return __kasan_slab_free(cache, object, ip, true);
 }
 
-void * __must_check kasan_kmalloc(struct kmem_cache *cache, const void *object,
-					size_t size, gfp_t flags)
+static void *__kasan_kmalloc(struct kmem_cache *cache, const void *object,
+				size_t size, gfp_t flags, bool krealloc)
 {
 	unsigned long redzone_start;
 	unsigned long redzone_end;
@@ -469,7 +485,7 @@ void * __must_check kasan_kmalloc(struct kmem_cache *cache, const void *object,
 				KASAN_SHADOW_SCALE_SIZE);
 
 	if (IS_ENABLED(CONFIG_KASAN_SW_TAGS))
-		tag = assign_tag(cache, object, false);
+		tag = assign_tag(cache, object, false, krealloc);
 
 	/* Tag is ignored in set_tag without CONFIG_KASAN_SW_TAGS */
 	kasan_unpoison_shadow(set_tag(object, tag), size);
@@ -481,6 +497,12 @@ void * __must_check kasan_kmalloc(struct kmem_cache *cache, const void *object,
 
 	return set_tag(object, tag);
 }
+
+void * __must_check kasan_kmalloc(struct kmem_cache *cache, const void *object,
+				size_t size, gfp_t flags)
+{
+	return __kasan_kmalloc(cache, object, size, flags, false);
+}
 EXPORT_SYMBOL(kasan_kmalloc);
 
 void * __must_check kasan_kmalloc_large(const void *ptr, size_t size,
@@ -520,7 +542,8 @@ void * __must_check kasan_krealloc(const void *object, size_t size, gfp_t flags)
 	if (unlikely(!PageSlab(page)))
 		return kasan_kmalloc_large(object, size, flags);
 	else
-		return kasan_kmalloc(page->slab_cache, object, size, flags);
+		return __kasan_kmalloc(page->slab_cache, object, size,
+						flags, true);
 }
 
 void kasan_poison_kfree(void *ptr, unsigned long ip)
-- 
2.20.1.415.g653613c723-goog

