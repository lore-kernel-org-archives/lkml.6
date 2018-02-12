Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932719AbeBLWVt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:21:49 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:37972 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932628AbeBLWVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:21:46 -0500
From: Mike Kravetz <mike.kravetz@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Michal Hocko <mhocko@kernel.org>, Christopher Lameter <cl@linux.com>,
        Guy Shattah <sguy@mellanox.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Michal Nazarewicz <mina86@mina86.com>,
        Vlastimil Babka <vbabka@suse.cz>, David Nellans <dnellans@nvidia.com>,
        Laura Abbott <labbott@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [RFC PATCH 0/3] Interface for higher order contiguous allocations
Date: Mon, 12 Feb 2018 14:20:53 -0800
Message-Id: <20180212222056.9735-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.13.6
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8803 signatures=668668
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=904
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802120282
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches came out of the "[RFC] mmap(MAP_CONTIG)" discussions at:
http://lkml.kernel.org/r/21f1ec96-2822-1189-1c95-79a2bb491571@oracle.com

One suggestion in that thread was to create a friendlier interface that
could be used by drivers and others outside core mm code to allocate a
contiguous set of pages.  The alloc_contig_range() interface is used for
this purpose today by CMA and gigantic page allocation.  However, this is
not a general purpose interface.  So, wrap alloc_contig_range() in the
more general interface:

struct page *find_alloc_contig_pages(unsigned int order, gfp_t gfp, int nid,
					nodemask_t *nodemask)

No underlying changes are made to increase the likelihood that a contiguous
set of pages can be found and allocated.  Therefore, any user of this
interface must deal with failure.  The hope is that this interface will be
able to satisfy some use cases today.

If the "rate of failure" is too high to be useful, then more work can be put
into methods to help increase the rate of successful allocations.  Such a
proposal was recently sent by Christoph Lameter "[RFC] Protect larger order
pages from breaking up":
http://lkml.kernel.org/r/alpine.DEB.2.20.1802091311090.3059@nuc-kabylake

find_alloc_contig_pages() uses the same logic that exists today for scanning
zones to look for contiguous ranges suitable for gigantic pages.  The last
patch in the series changes gigantic page allocation to use the new interface.

Mike Kravetz (3):
  mm: make start_isolate_page_range() fail if already isolated
  mm: add find_alloc_contig_pages() interface
  mm/hugetlb: use find_alloc_contig_pages() to allocate gigantic pages

 include/linux/gfp.h | 12 +++++++
 mm/hugetlb.c        | 88 ++++--------------------------------------------
 mm/page_alloc.c     | 97 +++++++++++++++++++++++++++++++++++++++++++++++++----
 mm/page_isolation.c | 10 +++++-
 4 files changed, 118 insertions(+), 89 deletions(-)

-- 
2.13.6
