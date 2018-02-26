Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751568AbeBZTLr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 14:11:47 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:51284 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750941AbeBZTLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 14:11:45 -0500
From: Mike Kravetz <mike.kravetz@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Michal Nazarewicz <mina86@mina86.com>,
        Michal Hocko <mhocko@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 0/1] make start_isolate_page_range() thread safe
Date: Mon, 26 Feb 2018 11:10:53 -0800
Message-Id: <20180226191054.14025-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.13.6
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8816 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=675
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802260245
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch was included in the RFC series "Interface for higher order
contiguous allocations".
http://lkml.kernel.org/r/20180212222056.9735-1-mike.kravetz@oracle.com

Since there have been few comments on the RFC and this patch addresses
a real issue with the current code, I am sending it separately.

To verify this is a real issue, I created a large CMA area at boot time.
I wrote some code to exercise large allocations and frees via cma_alloc()
and cma_release().  At the same time, I had a script just allocate and
free gigantic pages via the sysfs interface.

After a little bit of running, 'free memory' on the system went to
zero.  After 'stopping' the tests, I observed that most zone normal
page blocks were marked as MIGRATE_ISOLATE.  Hence 'not available'.

I suspect there are few (if any) systems employing both CMA and
dynamic gigantic huge page allocation.  However, it is probably a
good idea to fix this issue.  Because this is so unlikely, I am not
sure if this should got to stable releases as well.

Mike Kravetz (1):
  mm: make start_isolate_page_range() fail if already isolated

 mm/page_alloc.c     |  8 ++++----
 mm/page_isolation.c | 10 +++++++++-
 2 files changed, 13 insertions(+), 5 deletions(-)

-- 
2.13.6
