Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754273AbeBGBQi convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 20:16:38 -0500
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:47284 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754189AbeBGBQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 20:16:37 -0500
From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To: Punit Agrawal <punit.agrawal@arm.com>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm: hwpoison: disable memory error handling on 1GB
 hugepage
Thread-Topic: [PATCH v2] mm: hwpoison: disable memory error handling on 1GB
 hugepage
Thread-Index: AQHTnu0gPYXLibQ98UmzH7feYbNX3qOXjWiA
Date: Wed, 7 Feb 2018 01:14:57 +0000
Message-ID: <20180207011455.GA15214@hori1.linux.bs1.fc.nec.co.jp>
References: <20180130013919.GA19959@hori1.linux.bs1.fc.nec.co.jp>
 <1517284444-18149-1-git-send-email-n-horiguchi@ah.jp.nec.com>
 <87inbbjx2w.fsf@e105922-lin.cambridge.arm.com>
In-Reply-To: <87inbbjx2w.fsf@e105922-lin.cambridge.arm.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.128.101.10]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <6B62D0280E0A10418C5802502EDC15BD@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Punit,

On Mon, Feb 05, 2018 at 03:05:43PM +0000, Punit Agrawal wrote:
> Naoya Horiguchi <n-horiguchi@ah.jp.nec.com> writes:
> 
> > Recently the following BUG was reported:
> >
> >     Injecting memory failure for pfn 0x3c0000 at process virtual address 0x7fe300000000
> >     Memory failure: 0x3c0000: recovery action for huge page: Recovered
> >     BUG: unable to handle kernel paging request at ffff8dfcc0003000
> >     IP: gup_pgd_range+0x1f0/0xc20
> >     PGD 17ae72067 P4D 17ae72067 PUD 0
> >     Oops: 0000 [#1] SMP PTI
> >     ...
> >     CPU: 3 PID: 5467 Comm: hugetlb_1gb Not tainted 4.15.0-rc8-mm1-abc+ #3
> >     Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.9.3-1.fc25 04/01/2014
> >
> > You can easily reproduce this by calling madvise(MADV_HWPOISON) twice on
> > a 1GB hugepage. This happens because get_user_pages_fast() is not aware
> > of a migration entry on pud that was created in the 1st madvise() event.
> 
> Maybe I'm doing something wrong but I wasn't able to reproduce the issue
> using the test at the end. I get -
> 
>     $ sudo ./hugepage
> 
>     Poisoning page...once
>     [  121.295771] Injecting memory failure for pfn 0x8300000 at process virtual address 0x400000000000
>     [  121.386450] Memory failure: 0x8300000: recovery action for huge page: Recovered
> 
>     Poisoning page...once again
>     madvise: Bad address
> 
> What am I missing?

The test program below is exactly what I intended, so you did right testing.
I try to guess what could happen. The related code is like below:

  static int gup_pud_range(p4d_t p4d, unsigned long addr, unsigned long end,
                           int write, struct page **pages, int *nr)
  {
          ...
          do {
                  pud_t pud = READ_ONCE(*pudp);

                  next = pud_addr_end(addr, end);
                  if (pud_none(pud))
                          return 0;
                  if (unlikely(pud_huge(pud))) {
                          if (!gup_huge_pud(pud, pudp, addr, next, write,
                                            pages, nr))
                                  return 0;

pud_none() always returns false for hwpoison entry in any arch.
I guess that pud_huge() could behave in undefined manner for hwpoison entry
because pud_huge() assumes that a given pud has the present bit set, which
is not true for hwpoison entry. As a result, pud_huge() checks an irrelevant
bit used for other purpose depending on non-present page table format of
each arch.
If pud_huge() returns false for hwpoison entry, we try to go to the lower
level and the kernel highly likely to crash. So I guess your kernel fell back
the slow path and somehow ended up with returning EFAULT.

So I don't think that the above test result means that errors are properly
handled, and the proposed patch should help for arm64.

Thanks,
Naoya Horiguchi

> 
> 
> --------- >8 ---------
> #include <stdio.h>
> #include <string.h>
> #include <sys/mman.h>
> 
> int main(int argc, char *argv[])
> {
> 	int flags = MAP_HUGETLB | MAP_ANONYMOUS | MAP_PRIVATE;
> 	int prot = PROT_READ | PROT_WRITE;
> 	size_t hugepage_sz;
> 	void *hugepage;
> 	int ret;
> 
> 	hugepage_sz = 1024 * 1024 * 1024; /* 1GB */
> 	hugepage = mmap(NULL, hugepage_sz, prot, flags, -1, 0);
> 	if (hugepage == MAP_FAILED) {
> 		perror("mmap");
> 		return 1;
> 	}
> 
> 	memset(hugepage, 'b', hugepage_sz);
> 	getchar();
> 
> 	printf("Poisoning page...once\n");
> 	ret = madvise(hugepage, hugepage_sz, MADV_HWPOISON);
> 	if (ret) {
> 		perror("madvise");
> 		return 1;
> 	}
> 	getchar();
> 
> 	printf("Poisoning page...once again\n");
> 	ret = madvise(hugepage, hugepage_sz, MADV_HWPOISON);
> 	if (ret) {
> 		perror("madvise");
> 		return 1;
> 	}
> 	getchar();
> 
> 	memset(hugepage, 'c', hugepage_sz);
> 	ret = munmap(hugepage, hugepage_sz);
> 	if (ret) {
> 		perror("munmap");
> 		return 1;
> 	}
> 	
> 	return 0;
> }
> 
