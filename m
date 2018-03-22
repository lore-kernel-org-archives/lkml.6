Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751876AbeCVRem (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 13:34:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34036 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751796AbeCVRei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 13:34:38 -0400
Date: Thu, 22 Mar 2018 10:15:03 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Aaron Lu <aaron.lu@intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kemi Wang <kemi.wang@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [RFC PATCH v2 2/4] mm/__free_one_page: skip merge for order-0
 page unless compaction failed
Message-ID: <20180322171503.GH28468@bombadil.infradead.org>
References: <20180320085452.24641-1-aaron.lu@intel.com>
 <20180320085452.24641-3-aaron.lu@intel.com>
 <7b1988e9-7d50-d55e-7590-20426fb257af@suse.cz>
 <20180320141101.GB2033@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180320141101.GB2033@intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2018 at 10:11:01PM +0800, Aaron Lu wrote:
> > > A new document file called "struct_page_filed" is added to explain
> > > the newly reused field in "struct page".
> > 
> > Sounds rather ad-hoc for a single field, I'd rather document it via
> > comments.
> 
> Dave would like to have a document to explain all those "struct page"
> fields that are repurposed under different scenarios and this is the
> very start of the document :-)
> 
> I probably should have explained the intent of the document more.

Dave and I are in agreement on "Shouldn't struct page be better documented".
I came up with this a few weeks ago; never quite got round to turning it
into a patch:

+---+-----------+-----------+--------------+----------+--------+--------------+
| B | slab      | pagecache | tail 1       | anon     | tail 1 | hugetlb      |
+===+===========+===========+==============+==========+========+==============+
| 0 | flags                                                                   |
+---+                                                                         |
| 4 |                                                                         |
+---+-----------+-----------+--------------+----------+--------+--------------+
| 8 | s_mem     | mapping   | cmp_mapcount | anon_vma | defer  | mapping      |
+---+           |           +--------------+          | list   |              |
|12 |           |           |              |          |        |              |
+---+-----------+-----------+--------------+----------+        +--------------+
|16 | freelist  | index                               |        | index        |
+---+           |                                     |        | (shifted)    |
|20 |           |                                     |        |              |
+---+-----------+-------------------------------------+--------+--------------+
|24 | counters  | mapcount                                                    |
+---+           +-----------+--------------+----------+--------+--------------+
|28 |           | refcount  |              |          |        | refcount     |
+---+-----------+-----------+--------------+----------+--------+--------------+
|32 | next      | lru       | cmpd_head    |                   | lru          |
+---+           |           |              +-------------------+              +
|36 |           |           |              |                   |              |
+---+-----------+           +--------------+-------------------+              +
|40 | pages     |           | dtor / order |                   |              |
+---+-----------+           +--------------+-------------------+              +
|44 | pobjects  |           |              |                   |              |
+---+-----------+-----------+--------------+----------------------------------+
|48 | slb_cache | private   |              |                                  |
+---+           |           +--------------+----------------------------------+
|52 |           |           |              |                                  |
+---+-----------+-----------+--------------+----------------------------------+
