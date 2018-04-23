Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754150AbeDWDEN (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 23:04:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44524 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754016AbeDWDD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 23:03:56 -0400
Date: Sun, 22 Apr 2018 20:03:49 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: Michal Hocko <mhocko@kernel.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, Zi Yan <zi.yan@sent.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: shmem: enable thp migration (Re: [PATCH v1] mm:
 consider non-anonymous thp as unmovable page)
Message-ID: <20180423030349.GB2308@bombadil.infradead.org>
References: <20180403083451.GG5501@dhcp22.suse.cz>
 <20180403105411.hknofkbn6rzs26oz@node.shutemov.name>
 <20180405085927.GC6312@dhcp22.suse.cz>
 <20180405122838.6a6b35psizem4tcy@node.shutemov.name>
 <20180405124830.GJ6312@dhcp22.suse.cz>
 <20180405134045.7axuun6d7ufobzj4@node.shutemov.name>
 <20180405150547.GN6312@dhcp22.suse.cz>
 <20180405155551.wchleyaf4rxooj6m@node.shutemov.name>
 <20180405160317.GP6312@dhcp22.suse.cz>
 <20180406030706.GA2434@hori1.linux.bs1.fc.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406030706.GA2434@hori1.linux.bs1.fc.nec.co.jp>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 06, 2018 at 03:07:11AM +0000, Naoya Horiguchi wrote:
> Subject: [PATCH] mm: enable thp migration for shmem thp

This patch is buggy, but not in a significant way:

> @@ -524,13 +524,26 @@ int migrate_page_move_mapping(struct address_space *mapping,
>  	}
>  
>  	radix_tree_replace_slot(&mapping->i_pages, pslot, newpage);

^^^ this line should have been deleted

> +	if (PageTransHuge(page)) {
> +		int i;
> +		int index = page_index(page);
> +
> +		for (i = 0; i < HPAGE_PMD_NR; i++) {
^^^ or this iteration should start at 1
> +			pslot = radix_tree_lookup_slot(&mapping->i_pages,
> +						       index + i);
> +			radix_tree_replace_slot(&mapping->i_pages, pslot,
> +						newpage + i);
> +		}
> +	} else {
> +		radix_tree_replace_slot(&mapping->i_pages, pslot, newpage);
^^^ and if the second option, then we don't need this line
> +	}

So either this:

-	radix_tree_replace_slot(&mapping->i_pages, pslot, newpage);
+	if (PageTransHuge(page)) {
+		int i;
+		int index = page_index(page);
+
+		for (i = 0; i < HPAGE_PMD_NR; i++) {
+			pslot = radix_tree_lookup_slot(&mapping->i_pages,
+						       index + i);
+			radix_tree_replace_slot(&mapping->i_pages, pslot,
+						newpage + i);
+		}
+	} else {
+		radix_tree_replace_slot(&mapping->i_pages, pslot, newpage);
+	}

Or this:

 	radix_tree_replace_slot(&mapping->i_pages, pslot, newpage);
+	if (PageTransHuge(page)) {
+		int i;
+		int index = page_index(page);
+
+		for (i = 1; i < HPAGE_PMD_NR; i++) {
+			pslot = radix_tree_lookup_slot(&mapping->i_pages,
+						       index + i);
+			radix_tree_replace_slot(&mapping->i_pages, pslot,
+						newpage + i);
+		}
+	}

The second one is shorter and involves fewer lookups ...
