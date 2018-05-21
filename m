Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoEuKNi7OebnylHNcEQL149wChwCWbRugR7/7VPo7av7AM9Xp5cbP+KCzEQfpseT+31c/1e
ARC-Seal: i=1; a=rsa-sha256; t=1526937527; cv=none;
        d=google.com; s=arc-20160816;
        b=aNdfr6RM2/Fv/GpbBusLDHQyDngwczNbvhdjb+MY2Uha4+vnoqWqKGulWkKtrfKX0z
         IiJzGx/NCC5X9H8H57Hj0CQmEKGfxla35ivGtnCOIk4QUmd0Iv2Zmlco58uS42qjAie2
         VJnp54AEidw7pKkjPz3yTnICr/RtpmHe9H5ZJh55joHhuBnw4k3DLvTKQZiJ9tMCuZxv
         i0vctXC2r5tHITKnYNloDXb/qg0H3Ey21s/8IkKS0ddfkqb22jCGdKo/PLilypi7ZU1q
         AaWtUk9LlKgz07vTqB3IkdDht2glRdmMArIQyRVnIycrDgoX12Shs7xgV8XJ68sFKYlf
         nBMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=IYlGglrxvdfk6oN+D1cR3zHoSsD7kHpncn0lp5Xe+D8=;
        b=02GUFvEEf/3EYhuaEtx4no849PAJaBDeRpcrb7yMQeR6Vu95P9vt92m5hCUAG7UY48
         o1kHOXSMTF3+7bnLVTzsoMD15pr3sXES4QuNXL34tkKjDI3xHdoDn8CvhDlWLnBU+R8R
         7Wukrpw6syPEJSBSRNgkzBFQQ8fi14f0ljR30U7Uj5+zv234OuItQlc2kBvbXhHOTQlt
         JVDni/RNyvXjX3T01HO5/j58+FjO9Fyn7RwKVEPbTRXvVmXxPj6FVJcHZwIh41ciK5nV
         6H6BTpn3niC/buGrPEZnL+FSA8CBGoRdlXFoFeFGELPZ9DNw2HGpcgxfAUX/6yyANFrc
         Or8A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=YwjlwoY2;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=YwjlwoY2;
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
Subject: [PATCH 4.14 26/95] mm: dont allow deferred pages with NEED_PER_CPU_KM
Date: Mon, 21 May 2018 23:11:16 +0200
Message-Id: <20180521210453.792478845@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109869699407044?=
X-GMAIL-MSGID: =?utf-8?q?1601110044675455507?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -649,6 +649,7 @@ config DEFERRED_STRUCT_PAGE_INIT
 	depends on ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT
 	depends on NO_BOOTMEM && MEMORY_HOTPLUG
 	depends on !FLATMEM
+	depends on !NEED_PER_CPU_KM
 	help
 	  Ordinarily all struct pages are initialised during early boot in a
 	  single thread. On very large machines this can take a considerable
