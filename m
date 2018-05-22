Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751391AbeEVJzW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 05:55:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33058 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751229AbeEVJzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 05:55:19 -0400
From: David Hildenbrand <david@redhat.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev@googlegroups.com (open list:KASAN)
Subject: [PATCH v1 1/2] kasan: free allocated shadow memory on MEM_CANCEL_OFFLINE
Date: Tue, 22 May 2018 11:55:14 +0200
Message-Id: <20180522095515.2735-2-david@redhat.com>
In-Reply-To: <20180522095515.2735-1-david@redhat.com>
References: <20180522095515.2735-1-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have to free memory again when we cancel onlining, otherwise a later
onlining attempt will fail.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/kasan/kasan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/kasan/kasan.c b/mm/kasan/kasan.c
index 135ce2838c89..8baefe1a674b 100644
--- a/mm/kasan/kasan.c
+++ b/mm/kasan/kasan.c
@@ -867,6 +867,7 @@ static int __meminit kasan_mem_notifier(struct notifier_block *nb,
 		kmemleak_ignore(ret);
 		return NOTIFY_OK;
 	}
+	case MEM_CANCEL_OFFLINE:
 	case MEM_OFFLINE: {
 		struct vm_struct *vm;
 
-- 
2.17.0
