Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932364AbeBUMYx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 07:24:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36078 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751877AbeBUMYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 07:24:51 -0500
Date: Wed, 21 Feb 2018 04:24:45 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>, kasan-dev@googlegroups.com
Subject: Re: [PATCH 1/4] vmalloc: add vm_flags argument to internal
 __vmalloc_node()
Message-ID: <20180221122444.GA11791@bombadil.infradead.org>
References: <151670492223.658225.4605377710524021456.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <151670492223.658225.4605377710524021456.stgit@buzz>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 23, 2018 at 01:55:22PM +0300, Konstantin Khlebnikov wrote:
> This allows to set VM_USERMAP in vmalloc_user() and vmalloc_32_user()
> directly at allocation and avoid find_vm_area() call.

While reviewing this patch, I came across this infelicity ...

have I understood correctly?

diff --git a/mm/kasan/kasan.c b/mm/kasan/kasan.c
index e13d911251e7..9060f80b4a41 100644
--- a/mm/kasan/kasan.c
+++ b/mm/kasan/kasan.c
@@ -631,11 +631,10 @@ int kasan_module_alloc(void *addr, size_t size)
 	ret = __vmalloc_node_range(shadow_size, 1, shadow_start,
 			shadow_start + shadow_size,
 			GFP_KERNEL | __GFP_ZERO,
-			PAGE_KERNEL, VM_NO_GUARD, NUMA_NO_NODE,
+			PAGE_KERNEL, VM_NO_GUARD | VM_KASAN, NUMA_NO_NODE,
 			__builtin_return_address(0));
 
 	if (ret) {
-		find_vm_area(addr)->flags |= VM_KASAN;
 		kmemleak_ignore(ret);
 		return 0;
 	}
