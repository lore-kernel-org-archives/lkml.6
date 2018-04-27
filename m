Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757950AbeD0Rv7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 13:51:59 -0400
Received: from mga01.intel.com ([192.55.52.88]:20542 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757514AbeD0Rtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 13:49:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,336,1520924400";
   d="scan'208";a="36700513"
Subject: [PATCH 2/9] x86, pkeys, selftests: save off 'prot' for allocations
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
        linuxram@us.ibm.com, tglx@linutronix.de, dave.hansen@intel.com,
        mpe@ellerman.id.au, mingo@kernel.org, akpm@linux-foundation.org,
        shuah@kernel.org
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 27 Apr 2018 10:45:30 -0700
References: <20180427174527.0031016C@viggo.jf.intel.com>
In-Reply-To: <20180427174527.0031016C@viggo.jf.intel.com>
Message-Id: <20180427174530.E50654BA@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

This makes it possible to to tell what 'prot' a given allocation
is supposed to have.  That way, if we want to change just the
pkey, we know what 'prot' to pass to mprotect_pkey().

Also, keep a record of the most recent allocation so the tests
can easily find it.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ram Pai <linuxram@us.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Michael Ellermen <mpe@ellerman.id.au>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>
---

 b/tools/testing/selftests/x86/protection_keys.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff -puN tools/testing/selftests/x86/protection_keys.c~pkeys-update-selftests-store-malloc-record tools/testing/selftests/x86/protection_keys.c
--- a/tools/testing/selftests/x86/protection_keys.c~pkeys-update-selftests-store-malloc-record	2018-03-26 10:22:34.301170195 -0700
+++ b/tools/testing/selftests/x86/protection_keys.c	2018-03-26 10:22:34.305170195 -0700
@@ -674,10 +674,12 @@ int mprotect_pkey(void *ptr, size_t size
 struct pkey_malloc_record {
 	void *ptr;
 	long size;
+	int prot;
 };
 struct pkey_malloc_record *pkey_malloc_records;
+struct pkey_malloc_record *pkey_last_malloc_record;
 long nr_pkey_malloc_records;
-void record_pkey_malloc(void *ptr, long size)
+void record_pkey_malloc(void *ptr, long size, int prot)
 {
 	long i;
 	struct pkey_malloc_record *rec = NULL;
@@ -709,6 +711,8 @@ void record_pkey_malloc(void *ptr, long
 		(int)(rec - pkey_malloc_records), rec, ptr, size);
 	rec->ptr = ptr;
 	rec->size = size;
+	rec->prot = prot;
+	pkey_last_malloc_record = rec;
 	nr_pkey_malloc_records++;
 }
 
@@ -753,7 +757,7 @@ void *malloc_pkey_with_mprotect(long siz
 	pkey_assert(ptr != (void *)-1);
 	ret = mprotect_pkey((void *)ptr, PAGE_SIZE, prot, pkey);
 	pkey_assert(!ret);
-	record_pkey_malloc(ptr, size);
+	record_pkey_malloc(ptr, size, prot);
 	rdpkru();
 
 	dprintf1("%s() for pkey %d @ %p\n", __func__, pkey, ptr);
@@ -774,7 +778,7 @@ void *malloc_pkey_anon_huge(long size, i
 	size = ALIGN_UP(size, HPAGE_SIZE * 2);
 	ptr = mmap(NULL, size, PROT_NONE, MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
 	pkey_assert(ptr != (void *)-1);
-	record_pkey_malloc(ptr, size);
+	record_pkey_malloc(ptr, size, prot);
 	mprotect_pkey(ptr, size, prot, pkey);
 
 	dprintf1("unaligned ptr: %p\n", ptr);
@@ -847,7 +851,7 @@ void *malloc_pkey_hugetlb(long size, int
 	pkey_assert(ptr != (void *)-1);
 	mprotect_pkey(ptr, size, prot, pkey);
 
-	record_pkey_malloc(ptr, size);
+	record_pkey_malloc(ptr, size, prot);
 
 	dprintf1("mmap()'d hugetlbfs for pkey %d @ %p\n", pkey, ptr);
 	return ptr;
@@ -869,7 +873,7 @@ void *malloc_pkey_mmap_dax(long size, in
 
 	mprotect_pkey(ptr, size, prot, pkey);
 
-	record_pkey_malloc(ptr, size);
+	record_pkey_malloc(ptr, size, prot);
 
 	dprintf1("mmap()'d for pkey %d @ %p\n", pkey, ptr);
 	close(fd);
_
