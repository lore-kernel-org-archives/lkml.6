Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755062AbeDCI0k convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 04:26:40 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:57551 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754850AbeDCI0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 04:26:39 -0400
From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To: Michal Hocko <mhocko@kernel.org>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] mm: consider non-anonymous thp as unmovable page
Thread-Topic: [PATCH v1] mm: consider non-anonymous thp as unmovable page
Thread-Index: AQHTywbBR3VGVrQJfUWs9ILMOA3NvqPuFnMAgAAG4YA=
Date: Tue, 3 Apr 2018 08:24:06 +0000
Message-ID: <20180403082405.GA23809@hori1.linux.bs1.fc.nec.co.jp>
References: <1522730788-24530-1-git-send-email-n-horiguchi@ah.jp.nec.com>
 <20180403075928.GC5501@dhcp22.suse.cz>
In-Reply-To: <20180403075928.GC5501@dhcp22.suse.cz>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.128.101.8]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <95C456C3C9681E43A23D653F1A98C7B7@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 03, 2018 at 09:59:28AM +0200, Michal Hocko wrote:
> On Tue 03-04-18 13:46:28, Naoya Horiguchi wrote:
> > My testing for the latest kernel supporting thp migration found out an
> > infinite loop in offlining the memory block that is filled with shmem
> > thps.  We can get out of the loop with a signal, but kernel should
> > return with failure in this case.
> >
> > What happens in the loop is that scan_movable_pages() repeats returning
> > the same pfn without any progress. That's because page migration always
> > fails for shmem thps.
>
> Why does it fail? Shmem pages should be movable without any issues.

.. because try_to_unmap_one() explicitly skips unmapping for migration.

  #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
                  /* PMD-mapped THP migration entry */
                  if (!pvmw.pte && (flags & TTU_MIGRATION)) {
                          VM_BUG_ON_PAGE(PageHuge(page) || !PageTransCompound(page), page);
  
                          if (!PageAnon(page))
                                  continue;
  
                          set_pmd_migration_entry(&pvmw, page);
                          continue;
                  }
  #endif

When I implemented this code, I felt hard to work on both of anon thp
and shmem thp at one time, so I separated the proposal into smaller steps.
Shmem uses pagecache so we need some non-trivial effort (including testing)
to extend thp migration for shmem. But I think it's a reasonable next step.

Thanks,
Naoya Horiguchi
