Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF65C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4293F20856
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfAWWXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 17:23:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54554 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727335AbfAWWXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 17:23:52 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 067D8432C1;
        Wed, 23 Jan 2019 22:23:52 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-120-127.rdu2.redhat.com [10.10.120.127])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5CF0E5D965;
        Wed, 23 Jan 2019 22:23:49 +0000 (UTC)
From:   jglisse@redhat.com
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Jan Kara <jack@suse.cz>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, kvm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v4 8/9] gpu/drm/i915: optimize out the case when a range is updated to read only
Date:   Wed, 23 Jan 2019 17:23:14 -0500
Message-Id: <20190123222315.1122-9-jglisse@redhat.com>
In-Reply-To: <20190123222315.1122-1-jglisse@redhat.com>
References: <20190123222315.1122-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 23 Jan 2019 22:23:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

When range of virtual address is updated read only and corresponding
user ptr object are already read only it is pointless to do anything.
Optimize this case out.

Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <mawilcox@microsoft.com>
Cc: Ross Zwisler <zwisler@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: kvm@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-rdma@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/i915/i915_gem_userptr.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/i915/i915_gem_userptr.c b/drivers/gpu/drm/i915/i915_gem_userptr.c
index 9558582c105e..23330ac3d7ea 100644
--- a/drivers/gpu/drm/i915/i915_gem_userptr.c
+++ b/drivers/gpu/drm/i915/i915_gem_userptr.c
@@ -59,6 +59,7 @@ struct i915_mmu_object {
 	struct interval_tree_node it;
 	struct list_head link;
 	struct work_struct work;
+	bool read_only;
 	bool attached;
 };
 
@@ -119,6 +120,7 @@ static int i915_gem_userptr_mn_invalidate_range_start(struct mmu_notifier *_mn,
 		container_of(_mn, struct i915_mmu_notifier, mn);
 	struct i915_mmu_object *mo;
 	struct interval_tree_node *it;
+	bool update_to_read_only;
 	LIST_HEAD(cancelled);
 	unsigned long end;
 
@@ -128,6 +130,8 @@ static int i915_gem_userptr_mn_invalidate_range_start(struct mmu_notifier *_mn,
 	/* interval ranges are inclusive, but invalidate range is exclusive */
 	end = range->end - 1;
 
+	update_to_read_only = mmu_notifier_range_update_to_read_only(range);
+
 	spin_lock(&mn->lock);
 	it = interval_tree_iter_first(&mn->objects, range->start, end);
 	while (it) {
@@ -145,6 +149,17 @@ static int i915_gem_userptr_mn_invalidate_range_start(struct mmu_notifier *_mn,
 		 * object if it is not in the process of being destroyed.
 		 */
 		mo = container_of(it, struct i915_mmu_object, it);
+
+		/*
+		 * If it is already read only and we are updating to
+		 * read only then we do not need to change anything.
+		 * So save time and skip this one.
+		 */
+		if (update_to_read_only && mo->read_only) {
+			it = interval_tree_iter_next(it, range->start, end);
+			continue;
+		}
+
 		if (kref_get_unless_zero(&mo->obj->base.refcount))
 			queue_work(mn->wq, &mo->work);
 
@@ -270,6 +285,7 @@ i915_gem_userptr_init__mmu_notifier(struct drm_i915_gem_object *obj,
 	mo->mn = mn;
 	mo->obj = obj;
 	mo->it.start = obj->userptr.ptr;
+	mo->read_only = i915_gem_object_is_readonly(obj);
 	mo->it.last = obj->userptr.ptr + obj->base.size - 1;
 	INIT_WORK(&mo->work, cancel_userptr);
 
-- 
2.17.2

