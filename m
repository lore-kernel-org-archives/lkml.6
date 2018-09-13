Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCB1C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD30420854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:54:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD30420854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730966AbeIMTDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:03:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33796 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727644AbeIMTDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:03:53 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D4A01CE7;
        Thu, 13 Sep 2018 13:54:16 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Pasha Tatashin <Pavel.Tatashin@microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 060/197] mm: make DEFERRED_STRUCT_PAGE_INIT explicitly depend on SPARSEMEM
Date:   Thu, 13 Sep 2018 15:30:09 +0200
Message-Id: <20180913131843.922934107@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Rapoport <rppt@linux.vnet.ibm.com>

[ Upstream commit d39f8fb4b7776dcb09ec3bf7a321547083078ee3 ]

The deferred memory initialization relies on section definitions, e.g
PAGES_PER_SECTION, that are only available when CONFIG_SPARSEMEM=y on
most architectures.

Initially DEFERRED_STRUCT_PAGE_INIT depended on explicit
ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT configuration option, but since
the commit 2e3ca40f03bb13709df4 ("mm: relax deferred struct page
requirements") this requirement was relaxed and now it is possible to
enable DEFERRED_STRUCT_PAGE_INIT on architectures that support
DISCONTINGMEM and NO_BOOTMEM which causes build failures.

For instance, setting SMP=y and DEFERRED_STRUCT_PAGE_INIT=y on arc
causes the following build failure:

    CC      mm/page_alloc.o
  mm/page_alloc.c: In function 'update_defer_init':
  mm/page_alloc.c:321:14: error: 'PAGES_PER_SECTION'
  undeclared (first use in this function); did you mean 'USEC_PER_SEC'?
        (pfn & (PAGES_PER_SECTION - 1)) == 0) {
                ^~~~~~~~~~~~~~~~~
                USEC_PER_SEC
  mm/page_alloc.c:321:14: note: each undeclared identifier is reported only once for each function it appears in
  In file included from include/linux/cache.h:5:0,
                   from include/linux/printk.h:9,
                   from include/linux/kernel.h:14,
                   from include/asm-generic/bug.h:18,
                   from arch/arc/include/asm/bug.h:32,
                   from include/linux/bug.h:5,
                   from include/linux/mmdebug.h:5,
                   from include/linux/mm.h:9,
                   from mm/page_alloc.c:18:
  mm/page_alloc.c: In function 'deferred_grow_zone':
  mm/page_alloc.c:1624:52: error: 'PAGES_PER_SECTION' undeclared (first use in this function); did you mean 'USEC_PER_SEC'?
    unsigned long nr_pages_needed = ALIGN(1 << order, PAGES_PER_SECTION);
                                                      ^
  include/uapi/linux/kernel.h:11:47: note: in definition of macro '__ALIGN_KERNEL_MASK'
   #define __ALIGN_KERNEL_MASK(x, mask) (((x) + (mask)) & ~(mask))
                                                 ^~~~
  include/linux/kernel.h:58:22: note: in expansion of macro '__ALIGN_KERNEL'
   #define ALIGN(x, a)  __ALIGN_KERNEL((x), (a))
                        ^~~~~~~~~~~~~~
  mm/page_alloc.c:1624:34: note: in expansion of macro 'ALIGN'
    unsigned long nr_pages_needed = ALIGN(1 << order, PAGES_PER_SECTION);
                                    ^~~~~
  In file included from include/asm-generic/bug.h:18:0,
                   from arch/arc/include/asm/bug.h:32,
                   from include/linux/bug.h:5,
                   from include/linux/mmdebug.h:5,
                   from include/linux/mm.h:9,
                   from mm/page_alloc.c:18:
  mm/page_alloc.c: In function 'free_area_init_node':
  mm/page_alloc.c:6379:50: error: 'PAGES_PER_SECTION' undeclared (first use in this function); did you mean 'USEC_PER_SEC'?
    pgdat->static_init_pgcnt = min_t(unsigned long, PAGES_PER_SECTION,
                                                    ^
  include/linux/kernel.h:812:22: note: in definition of macro '__typecheck'
     (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                        ^
  include/linux/kernel.h:836:24: note: in expansion of macro '__safe_cmp'
    __builtin_choose_expr(__safe_cmp(x, y), \
                          ^~~~~~~~~~
  include/linux/kernel.h:904:27: note: in expansion of macro '__careful_cmp'
   #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
                             ^~~~~~~~~~~~~
  mm/page_alloc.c:6379:29: note: in expansion of macro 'min_t'
    pgdat->static_init_pgcnt = min_t(unsigned long, PAGES_PER_SECTION,
                               ^~~~~
  include/linux/kernel.h:836:2: error: first argument to '__builtin_choose_expr' not a constant
    __builtin_choose_expr(__safe_cmp(x, y), \
    ^
  include/linux/kernel.h:904:27: note: in expansion of macro '__careful_cmp'
   #define min_t(type, x, y) __careful_cmp((type)(x), (type)(y), <)
                             ^~~~~~~~~~~~~
  mm/page_alloc.c:6379:29: note: in expansion of macro 'min_t'
    pgdat->static_init_pgcnt = min_t(unsigned long, PAGES_PER_SECTION,
                               ^~~~~
  scripts/Makefile.build:317: recipe for target 'mm/page_alloc.o' failed

Let's make the DEFERRED_STRUCT_PAGE_INIT explicitly depend on SPARSEMEM
as the systems that support DISCONTIGMEM do not seem to have that huge
amounts of memory that would make DEFERRED_STRUCT_PAGE_INIT relevant.

Link: http://lkml.kernel.org/r/1530279308-24988-1-git-send-email-rppt@linux.vnet.ibm.com
Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Pasha Tatashin <Pavel.Tatashin@microsoft.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -635,7 +635,7 @@ config DEFERRED_STRUCT_PAGE_INIT
 	bool "Defer initialisation of struct pages to kthreads"
 	default n
 	depends on NO_BOOTMEM
-	depends on !FLATMEM
+	depends on SPARSEMEM
 	depends on !NEED_PER_CPU_KM
 	help
 	  Ordinarily all struct pages are initialised during early boot in a


