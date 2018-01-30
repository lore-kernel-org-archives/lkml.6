Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752391AbeA3Bkt convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 29 Jan 2018 20:40:49 -0500
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:58842 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751787AbeA3Bks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jan 2018 20:40:48 -0500
From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To: Michal Hocko <mhocko@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
CC: Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH v1] mm: hwpoison: disable memory error handling on 1GB
 hugepage
Thread-Topic: [PATCH v1] mm: hwpoison: disable memory error handling on 1GB
 hugepage
Thread-Index: AQHTmMpafO+oGbhFhEWyr7Ktre49Y6OJzPgAgAA43YCAAIongIAAfdyA
Date: Tue, 30 Jan 2018 01:39:22 +0000
Message-ID: <20180130013919.GA19959@hori1.linux.bs1.fc.nec.co.jp>
References: <1517207283-15769-1-git-send-email-n-horiguchi@ah.jp.nec.com>
 <20180129063054.GA5205@hori1.linux.bs1.fc.nec.co.jp>
 <20180129095425.GA21609@dhcp22.suse.cz>
 <a1a921dc-3095-41f7-a4db-0de79bf65f8b@oracle.com>
In-Reply-To: <a1a921dc-3095-41f7-a4db-0de79bf65f8b@oracle.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.128.101.9]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <9FBD24293E15124980E3ED3C8E001CC3@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal, Mike,

On Mon, Jan 29, 2018 at 10:08:53AM -0800, Mike Kravetz wrote:
> On 01/29/2018 01:54 AM, Michal Hocko wrote:
> > On Mon 29-01-18 06:30:55, Naoya Horiguchi wrote:
> >> My apology, I forgot to CC to the mailing lists.
> >>
> >> On Mon, Jan 29, 2018 at 03:28:03PM +0900, Naoya Horiguchi wrote:
> >>> Recently the following BUG was reported:
> >>>
> >>>     Injecting memory failure for pfn 0x3c0000 at process virtual address 0x7fe300000000
> >>>     Memory failure: 0x3c0000: recovery action for huge page: Recovered
> >>>     BUG: unable to handle kernel paging request at ffff8dfcc0003000
> >>>     IP: gup_pgd_range+0x1f0/0xc20
> >>>     PGD 17ae72067 P4D 17ae72067 PUD 0
> >>>     Oops: 0000 [#1] SMP PTI
> >>>     ...
> >>>     CPU: 3 PID: 5467 Comm: hugetlb_1gb Not tainted 4.15.0-rc8-mm1-abc+ #3
> >>>     Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.9.3-1.fc25 04/01/2014
> >>>
> >>> You can easily reproduce this by calling madvise(MADV_HWPOISON) twice on
> >>> a 1GB hugepage. This happens because get_user_pages_fast() is not aware
> >>> of a migration entry on pud that was created in the 1st madvise() event.
> > 
> > Do pgd size pages work properly?

PGD size is unsupported now too, and this patch is also disabling that size.

> 
> Adding Anshuman and Aneesh as they added pgd support for power.  And,
> this patch will disable that as well IIUC.

Thanks Mike, I want to have some feedback from PowerPC developers too.

> 
> This patch makes sense for x86.  My only concern/question is for other
> archs which may have huge page sizes defined which are > MAX_ORDER and
> < PUD_SIZE.  These would also be classified as gigantic and impacted
> by this patch.  Do these also have the same issue?

Maybe one clearer way is to use more explicit condition like "page size > PMD_SIZE".

> 
> -- 
> Mike Kravetz
> 
> >>> I think that conversion to pud-aligned migration entry is working,
> >>> but other MM code walking over page table isn't prepared for it.
> >>> We need some time and effort to make all this work properly, so
> >>> this patch avoids the reported bug by just disabling error handling
> >>> for 1GB hugepage.
> > 
> > Can we also get some documentation which would describe all requirements
> > for HWPoison pages to work properly please?

OK, I'll add this.

> > 
> >>> Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> > 
> > Acked-by: Michal Hocko <mhocko@suse.com>
> > 
> > We probably want a backport to stable as well. Although regular process
> > cannot get giga pages easily without admin help it is still not nice to
> > oops like this.

I'll add CC to stable.

Thanks,
Naoya Horiguchi
