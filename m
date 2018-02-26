Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753059AbeBZNwt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 08:52:49 -0500
Received: from mga04.intel.com ([192.55.52.120]:54609 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752771AbeBZNws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 08:52:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,396,1515484800";
   d="scan'208";a="29836352"
From: Aaron Lu <aaron.lu@intel.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>, Dave Hansen <dave.hansen@intel.com>,
        Kemi Wang <kemi.wang@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v3 0/3] mm: improve zone->lock scalability
Date: Mon, 26 Feb 2018 21:53:43 +0800
Message-Id: <20180226135346.7208-1-aaron.lu@intel.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1/3 is a small cleanup suggested by Matthew Wilcox which doesn't
affect scalability or performance;
Patch 2/3 moves some code in free_pcppages_bulk() outside of zone->lock
and has Mel Gorman's ack;
Patch 3/3 uses prefetch in free_pcppages_bulk() outside of zone->lock to
speedup page merging under zone->lock but Mel Gorman has some concerns.

For details, please see their changelogs.

Changes from v2:
Patch 1/3 is newly added;
Patch 2/3 is patch 1/2 in v2 and doesn't have any change except resolving
conflicts due to the newly added patch 1/3;
Patch 3/3 is patch 2/2 in v2 and only has some changelog updates on
concerns part.

v1 and v2 was here:
https://lkml.org/lkml/2018/1/23/879

Aaron Lu (3):
  mm/free_pcppages_bulk: update pcp->count inside
  mm/free_pcppages_bulk: do not hold lock when picking pages to free
  mm/free_pcppages_bulk: prefetch buddy while not holding lock

 mm/page_alloc.c | 56 +++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 21 deletions(-)

-- 
2.14.3
