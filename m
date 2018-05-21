Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpSLHCIJd/XJf4RotvBjzfUUcP/XMOOhlfnpoq4ZYhmfYUl2DkRX72pXfAgnUgTBsqMspQY
ARC-Seal: i=1; a=rsa-sha256; t=1526937360; cv=none;
        d=google.com; s=arc-20160816;
        b=DV0AYDp/y+LjiZA/1uWjXE2VfWykTEdguXzJOTGTM8DiYHcATnI+CIJGKEJ7LolTIP
         B9CTPx/0FSF6C7bHTWb2UQOpy4CCk88Y7dOXxs/FqJqglQW1ebhlhp+2/By7rO8viXgR
         DnhKFlrXXjybr4rnZU6+ibaZNw5js84hahsi6z1oUsIDk1mwkKgOWP2Y8bHwk8xC6PVc
         IXIpb6mgoPzJrl+Q1hWZTdeS9Zhfyz6nkDlwQdy00GyHk6ppJa/fcMhnrNBkbhq7dtNf
         2QeMTaMtdNWE/3LJeTpwlDjRck9JoYDsnRW5e+uT5Ou+8xzYwG6zskCBPw78ROp2SZXY
         Fl8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=/sgFgAQfefnrq+w2IqTESLp+EP4D7bM8lp/HBFQ47Ss=;
        b=mz9mD5DoZaQBnfZyUpk+mBBqGylAd1fvrjxakhYD8xd4So3EpAmwxN2BAHDUEyXxQq
         nTTmY5vs+D++JuqCzF7ycXmSgt4RiNST7WJaFGZNOCRESlJNvEyQWfIXV0vhjvf0kUoG
         iLeEuKj2Vcy4WD1e9BH45Ky5J1cwNcqGyQGh/RWevEcMc67asmE+Jf2Z8i0rjq5DKREn
         bWbtAKHlRqRBHwXz+uY3eYK5vvOHNCit8hAZMIu+RbVev+MNQ4TYpPzUHc6aXVa4e14l
         UbCHIItL9m47liIE25DB3V/g7Oz+lk3LqJfSR2+ZMXfFNDe3HCzfiAA4eYwBJ5tH66H4
         GIlA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=E1ChVXHa;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=E1ChVXHa;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Pavel Tatashin <pasha.tatashin@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Steven Sistare <steven.sistare@oracle.com>,
	Daniel Jordan <daniel.m.jordan@oracle.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Fengguang Wu <fengguang.wu@intel.com>,
	Dennis Zhou <dennisszhou@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.9 19/87] mm: dont allow deferred pages with NEED_PER_CPU_KM
Date: Mon, 21 May 2018 23:10:55 +0200
Message-Id: <20180521210422.069818654@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109869699407044?=
X-GMAIL-MSGID: =?utf-8?q?1601109869699407044?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pavel Tatashin <pasha.tatashin@oracle.com>

commit ab1e8d8960b68f54af42b6484b5950bd13a4054b upstream.

It is unsafe to do virtual to physical translations before mm_init() is
called if struct page is needed in order to determine the memory section
number (see SECTION_IN_PAGE_FLAGS).  This is because only in mm_init()
we initialize struct pages for all the allocated memory when deferred
struct pages are used.

My recent fix in commit c9e97a1997 ("mm: initialize pages on demand
during boot") exposed this problem, because it greatly reduced number of
pages that are initialized before mm_init(), but the problem existed
even before my fix, as Fengguang Wu found.

Below is a more detailed explanation of the problem.

We initialize struct pages in four places:

1. Early in boot a small set of struct pages is initialized to fill the
   first section, and lower zones.

2. During mm_init() we initialize "struct pages" for all the memory that
   is allocated, i.e reserved in memblock.

3. Using on-demand logic when pages are allocated after mm_init call
   (when memblock is finished)

4. After smp_init() when the rest free deferred pages are initialized.

The problem occurs if we try to do va to phys translation of a memory
between steps 1 and 2.  Because we have not yet initialized struct pages
for all the reserved pages, it is inherently unsafe to do va to phys if
the translation itself requires access of "struct page" as in case of
this combination: CONFIG_SPARSE && !CONFIG_SPARSE_VMEMMAP

The following path exposes the problem:

  start_kernel()
   trap_init()
    setup_cpu_entry_areas()
     setup_cpu_entry_area(cpu)
      get_cpu_gdt_paddr(cpu)
       per_cpu_ptr_to_phys(addr)
        pcpu_addr_to_page(addr)
         virt_to_page(addr)
          pfn_to_page(__pa(addr) >> PAGE_SHIFT)

We disable this path by not allowing NEED_PER_CPU_KM with deferred
struct pages feature.

The problems are discussed in these threads:
  http://lkml.kernel.org/r/20180418135300.inazvpxjxowogyge@wfg-t540p.sh.intel.com
  http://lkml.kernel.org/r/20180419013128.iurzouiqxvcnpbvz@wfg-t540p.sh.intel.com
  http://lkml.kernel.org/r/20180426202619.2768-1-pasha.tatashin@oracle.com

Link: http://lkml.kernel.org/r/20180515175124.1770-1-pasha.tatashin@oracle.com
Fixes: 3a80a7fa7989 ("mm: meminit: initialise a subset of struct pages if CONFIG_DEFERRED_STRUCT_PAGE_INIT is set")
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Sistare <steven.sistare@oracle.com>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Fengguang Wu <fengguang.wu@intel.com>
Cc: Dennis Zhou <dennisszhou@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -666,6 +666,7 @@ config DEFERRED_STRUCT_PAGE_INIT
 	depends on ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT
 	depends on NO_BOOTMEM && MEMORY_HOTPLUG
 	depends on !FLATMEM
+	depends on !NEED_PER_CPU_KM
 	help
 	  Ordinarily all struct pages are initialised during early boot in a
 	  single thread. On very large machines this can take a considerable
