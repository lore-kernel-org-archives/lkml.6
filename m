Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753485AbeBGHNj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 02:13:39 -0500
Received: from mga06.intel.com ([134.134.136.31]:24519 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752682AbeBGHNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 02:13:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,471,1511856000";
   d="scan'208";a="16151230"
From: Wei Wang <wei.w.wang@intel.com>
To: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org,
        akpm@linux-foundation.org
Cc: pbonzini@redhat.com, wei.w.wang@intel.com,
        liliang.opensource@gmail.com, yang.zhang.wz@gmail.com,
        quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com,
        huangzhichao@huawei.com
Subject: [PATCH v27 3/4] mm/page_poison: expose page_poisoning_enabled to kernel modules
Date: Wed,  7 Feb 2018 14:54:30 +0800
Message-Id: <1517986471-15185-4-git-send-email-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517986471-15185-1-git-send-email-wei.w.wang@intel.com>
References: <1517986471-15185-1-git-send-email-wei.w.wang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some usages, e.g. virtio-balloon, a kernel module needs to know if
page poisoning is in use. This patch exposes the page_poisoning_enabled
function to kernel modules.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Michael S. Tsirkin <mst@redhat.com>
---
 mm/page_poison.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/page_poison.c b/mm/page_poison.c
index e83fd44..c08d02a 100644
--- a/mm/page_poison.c
+++ b/mm/page_poison.c
@@ -30,6 +30,11 @@ bool page_poisoning_enabled(void)
 		debug_pagealloc_enabled()));
 }
 
+/**
+ * page_poisoning_enabled - check if page poisoning is enabled
+ *
+ * Return true if page poisoning is enabled, or false if not.
+ */
 static void poison_page(struct page *page)
 {
 	void *addr = kmap_atomic(page);
@@ -37,6 +42,7 @@ static void poison_page(struct page *page)
 	memset(addr, PAGE_POISON, PAGE_SIZE);
 	kunmap_atomic(addr);
 }
+EXPORT_SYMBOL_GPL(page_poisoning_enabled);
 
 static void poison_pages(struct page *page, int n)
 {
-- 
2.7.4
