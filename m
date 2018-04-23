Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754302AbeDWH0Y convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 03:26:24 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:56592 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754003AbeDWHXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 03:23:33 -0400
From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To: Matthew Wilcox <willy@infradead.org>
CC: Michal Hocko <mhocko@kernel.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, Zi Yan <zi.yan@sent.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: shmem: enable thp migration (Re: [PATCH v1] mm:
 consider non-anonymous thp as unmovable page)
Thread-Topic: [PATCH] mm: shmem: enable thp migration (Re: [PATCH v1] mm:
 consider non-anonymous thp as unmovable page)
Thread-Index: AQHTzVRbJLbJcuvidESXEazGlmX3mKQNLd6AgABH3IA=
Date: Mon, 23 Apr 2018 07:21:02 +0000
Message-ID: <20180423072101.GA12157@hori1.linux.bs1.fc.nec.co.jp>
References: <20180403105411.hknofkbn6rzs26oz@node.shutemov.name>
 <20180405085927.GC6312@dhcp22.suse.cz>
 <20180405122838.6a6b35psizem4tcy@node.shutemov.name>
 <20180405124830.GJ6312@dhcp22.suse.cz>
 <20180405134045.7axuun6d7ufobzj4@node.shutemov.name>
 <20180405150547.GN6312@dhcp22.suse.cz>
 <20180405155551.wchleyaf4rxooj6m@node.shutemov.name>
 <20180405160317.GP6312@dhcp22.suse.cz>
 <20180406030706.GA2434@hori1.linux.bs1.fc.nec.co.jp>
 <20180423030349.GB2308@bombadil.infradead.org>
In-Reply-To: <20180423030349.GB2308@bombadil.infradead.org>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.51.8.81]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <22FC510A8042CA49A7593738BC3A9C6F@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 22, 2018 at 08:03:49PM -0700, Matthew Wilcox wrote:
> On Fri, Apr 06, 2018 at 03:07:11AM +0000, Naoya Horiguchi wrote:
> > Subject: [PATCH] mm: enable thp migration for shmem thp
> 
> This patch is buggy, but not in a significant way:
> 
> > @@ -524,13 +524,26 @@ int migrate_page_move_mapping(struct address_space *mapping,
> >  	}
> >  
> >  	radix_tree_replace_slot(&mapping->i_pages, pslot, newpage);
> 
> ^^^ this line should have been deleted
> 
> > +	if (PageTransHuge(page)) {
> > +		int i;
> > +		int index = page_index(page);
> > +
> > +		for (i = 0; i < HPAGE_PMD_NR; i++) {
> ^^^ or this iteration should start at 1
> > +			pslot = radix_tree_lookup_slot(&mapping->i_pages,
> > +						       index + i);
> > +			radix_tree_replace_slot(&mapping->i_pages, pslot,
> > +						newpage + i);
> > +		}
> > +	} else {
> > +		radix_tree_replace_slot(&mapping->i_pages, pslot, newpage);
> ^^^ and if the second option, then we don't need this line
> > +	}
> 
> So either this:
> 
> -	radix_tree_replace_slot(&mapping->i_pages, pslot, newpage);
> +	if (PageTransHuge(page)) {
> +		int i;
> +		int index = page_index(page);
> +
> +		for (i = 0; i < HPAGE_PMD_NR; i++) {
> +			pslot = radix_tree_lookup_slot(&mapping->i_pages,
> +						       index + i);
> +			radix_tree_replace_slot(&mapping->i_pages, pslot,
> +						newpage + i);
> +		}
> +	} else {
> +		radix_tree_replace_slot(&mapping->i_pages, pslot, newpage);
> +	}
> 
> Or this:
> 
>  	radix_tree_replace_slot(&mapping->i_pages, pslot, newpage);
> +	if (PageTransHuge(page)) {
> +		int i;
> +		int index = page_index(page);
> +
> +		for (i = 1; i < HPAGE_PMD_NR; i++) {
> +			pslot = radix_tree_lookup_slot(&mapping->i_pages,
> +						       index + i);
> +			radix_tree_replace_slot(&mapping->i_pages, pslot,
> +						newpage + i);
> +		}
> +	}
> 
> The second one is shorter and involves fewer lookups ...

Hi Matthew,

Thank you for poinitng out, I like the second one.
The original patch is now in upsteam, so I wrote a patch on it.

Thanks,
Naoya

--------
From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Date: Sun, 22 Apr 2018 20:03:49 -0700
Subject: [PATCH] mm: migrate: fix double call of radix_tree_replace_slot()

radix_tree_replace_slot() is called twice for head page, it's
obviously a bug. Let's fix it.

Fixes: e71769ae5260 ("mm: enable thp migration for shmem thp")
Reported-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
---
 mm/migrate.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 568433023831..8c0af0f7cab1 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -528,14 +528,12 @@ int migrate_page_move_mapping(struct address_space *mapping,
 		int i;
 		int index = page_index(page);
 
-		for (i = 0; i < HPAGE_PMD_NR; i++) {
+		for (i = 1; i < HPAGE_PMD_NR; i++) {
 			pslot = radix_tree_lookup_slot(&mapping->i_pages,
 						       index + i);
 			radix_tree_replace_slot(&mapping->i_pages, pslot,
 						newpage + i);
 		}
-	} else {
-		radix_tree_replace_slot(&mapping->i_pages, pslot, newpage);
 	}
 
 	/*
-- 
2.7.4
