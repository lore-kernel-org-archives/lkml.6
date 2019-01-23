Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A393DC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AECA218A2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbfAWWXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 17:23:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57834 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726249AbfAWWXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 17:23:32 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 20E67461FF;
        Wed, 23 Jan 2019 22:23:32 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-120-127.rdu2.redhat.com [10.10.120.127])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7FF865D964;
        Wed, 23 Jan 2019 22:23:29 +0000 (UTC)
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
Subject: [PATCH v4 1/9] mm/mmu_notifier: contextual information for event enums
Date:   Wed, 23 Jan 2019 17:23:07 -0500
Message-Id: <20190123222315.1122-2-jglisse@redhat.com>
In-Reply-To: <20190123222315.1122-1-jglisse@redhat.com>
References: <20190123222315.1122-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 23 Jan 2019 22:23:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

CPU page table update can happens for many reasons, not only as a result
of a syscall (munmap(), mprotect(), mremap(), madvise(), ...) but also
as a result of kernel activities (memory compression, reclaim, migration,
...).

This patch introduce a set of enums that can be associated with each of
the events triggering a mmu notifier. Latter patches take advantages of
those enum values.

    - UNMAP: munmap() or mremap()
    - CLEAR: page table is cleared (migration, compaction, reclaim, ...)
    - PROTECTION_VMA: change in access protections for the range
    - PROTECTION_PAGE: change in access protections for page in the range
    - SOFT_DIRTY: soft dirtyness tracking

Being able to identify munmap() and mremap() from other reasons why the
page table is cleared is important to allow user of mmu notifier to
update their own internal tracking structure accordingly (on munmap or
mremap it is not longer needed to track range of virtual address as it
becomes invalid).

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
 include/linux/mmu_notifier.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index 4050ec1c3b45..abc9dbb7bcb6 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -10,6 +10,36 @@
 struct mmu_notifier;
 struct mmu_notifier_ops;
 
+/**
+ * enum mmu_notifier_event - reason for the mmu notifier callback
+ * @MMU_NOTIFY_UNMAP: either munmap() that unmap the range or a mremap() that
+ * move the range
+ *
+ * @MMU_NOTIFY_CLEAR: clear page table entry (many reasons for this like
+ * madvise() or replacing a page by another one, ...).
+ *
+ * @MMU_NOTIFY_PROTECTION_VMA: update is due to protection change for the range
+ * ie using the vma access permission (vm_page_prot) to update the whole range
+ * is enough no need to inspect changes to the CPU page table (mprotect()
+ * syscall)
+ *
+ * @MMU_NOTIFY_PROTECTION_PAGE: update is due to change in read/write flag for
+ * pages in the range so to mirror those changes the user must inspect the CPU
+ * page table (from the end callback).
+ *
+ * @MMU_NOTIFY_SOFT_DIRTY: soft dirty accounting (still same page and same
+ * access flags). User should soft dirty the page in the end callback to make
+ * sure that anyone relying on soft dirtyness catch pages that might be written
+ * through non CPU mappings.
+ */
+enum mmu_notifier_event {
+	MMU_NOTIFY_UNMAP = 0,
+	MMU_NOTIFY_CLEAR,
+	MMU_NOTIFY_PROTECTION_VMA,
+	MMU_NOTIFY_PROTECTION_PAGE,
+	MMU_NOTIFY_SOFT_DIRTY,
+};
+
 #ifdef CONFIG_MMU_NOTIFIER
 
 /*
-- 
2.17.2

