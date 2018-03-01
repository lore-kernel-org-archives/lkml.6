Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966346AbeCAG1v (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 01:27:51 -0500
Received: from mga03.intel.com ([134.134.136.65]:12103 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966268AbeCAG1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 01:27:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,407,1515484800";
   d="scan'208";a="33761273"
From: Aaron Lu <aaron.lu@intel.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>, Dave Hansen <dave.hansen@intel.com>,
        Kemi Wang <kemi.wang@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>
Subject: [PATCH v4 0/3] mm: improve zone->lock scalability
Date: Thu,  1 Mar 2018 14:28:42 +0800
Message-Id: <20180301062845.26038-1-aaron.lu@intel.com>
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

v4:
Address David Rientjes' comments to not update pcp->count in front of
free_pcppages_bulk() in patch 1/3.
Reword code comments in patch 2/3 as suggested by David Rientjes.

v3:
Added patch 1/3 to update pcp->count inside of free_pcppages_bulk();
Rebase to v4.16-rc2.

v2 & v1:
https://lkml.org/lkml/2018/1/23/879

Aaron Lu (3):
  mm/free_pcppages_bulk: update pcp->count inside
  mm/free_pcppages_bulk: do not hold lock when picking pages to free
  mm/free_pcppages_bulk: prefetch buddy while not holding lock

 mm/page_alloc.c | 62 +++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 22 deletions(-)

-- 
2.14.3
