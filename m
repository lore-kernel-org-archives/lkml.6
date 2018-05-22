Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751429AbeEVJzh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 05:55:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44764 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750707AbeEVJzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 05:55:21 -0400
From: David Hildenbrand <david@redhat.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev@googlegroups.com (open list:KASAN)
Subject: [PATCH v1 2/2] kasan: fix memory hotplug during boot
Date: Tue, 22 May 2018 11:55:15 +0200
Message-Id: <20180522095515.2735-3-david@redhat.com>
In-Reply-To: <20180522095515.2735-1-david@redhat.com>
References: <20180522095515.2735-1-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using module_init() is wrong. E.g. ACPI adds and onlines memory before
our memory notifier gets registered.

This makes sure that ACPI memory detected during boot up will not
result in a kernel crash.

Easily reproducable with QEMU, just specify a DIMM when starting up.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/kasan/kasan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/kasan/kasan.c b/mm/kasan/kasan.c
index 8baefe1a674b..04b60d2b607c 100644
--- a/mm/kasan/kasan.c
+++ b/mm/kasan/kasan.c
@@ -892,5 +892,5 @@ static int __init kasan_memhotplug_init(void)
 	return 0;
 }
 
-module_init(kasan_memhotplug_init);
+core_initcall(kasan_memhotplug_init);
 #endif
-- 
2.17.0
