Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754352AbeDMNbz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 09:31:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37696 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753254AbeDMNby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 09:31:54 -0400
From: David Hildenbrand <david@redhat.com>
To: linux-mm@kvack.org
Cc: Dave Young <dyoung@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Marc-Andre Lureau <marcandre.lureau@redhat.com>,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>
Subject: [PATCH RFC 4/8] kdump: expose PG_offline
Date: Fri, 13 Apr 2018 15:31:51 +0200
Message-Id: <20180413133151.3199-1-david@redhat.com>
In-Reply-To: <20180413131632.1413-1-david@redhat.com>
References: <20180413131632.1413-1-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows user space to skip pages that are offline when dumping. This is
especially relevant when dealing with pages that have been unplugged in
the context of virtualization, and their backing storage has already
been freed.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 kernel/crash_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index a93590cdd9e1..d6f21b19aeb3 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -463,6 +463,9 @@ static int __init crash_save_vmcoreinfo_init(void)
 #ifdef CONFIG_HUGETLB_PAGE
 	VMCOREINFO_NUMBER(HUGETLB_PAGE_DTOR);
 #endif
+#ifdef CONFIG_MEMORY_HOTPLUG
+	VMCOREINFO_NUMBER(PG_offline);
+#endif
 
 	arch_crash_save_vmcoreinfo();
 	update_vmcoreinfo_note();
-- 
2.14.3
