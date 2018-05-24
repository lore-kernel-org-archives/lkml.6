Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032391AbeEXKol (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 06:44:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35242 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S968277AbeEXJ55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 05:57:57 -0400
From: Li Wang <liwang@redhat.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Huang Ying <huang.ying.caritas@gmail.com>, Yu Zhao <yuzhao@google.com>
Subject: [PATCH RFC] zswap: reject to compress/store page if zswap_max_pool_percent is 0
Date: Thu, 24 May 2018 17:57:51 +0800
Message-Id: <20180524095752.17770-1-liwang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The '/sys/../zswap/stored_pages:' keep raising in zswap test with
"zswap.max_pool_percent=0" parameter. But theoretically, it should
not compress or store pages any more since there is no space for
compressed pool.

Reproduce steps:

  1. Boot kernel with "zswap.enabled=1 zswap.max_pool_percent=17"
  2. Set the max_pool_percent to 0
      # echo 0 > /sys/module/zswap/parameters/max_pool_percent
     Confirm this parameter works fine
      # cat /sys/kernel/debug/zswap/pool_total_size
      0
  3. Do memory stress test to see if some pages have been compressed
      # stress --vm 1 --vm-bytes $mem_available"M" --timeout 60s
     Watching the 'stored_pages' numbers increasing or not

The root cause is:

  When the zswap_max_pool_percent is set to 0 via kernel parameter, the zswap_is_full()
  will always return true to shrink the pool size by zswap_shrink(). If the pool size
  has been shrinked a little success, zswap will do compress/store pages again. Then we
  get fails on that as above.

Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Seth Jennings <sjenning@redhat.com>
Cc: Dan Streetman <ddstreet@ieee.org>
Cc: Huang Ying <huang.ying.caritas@gmail.com>
Cc: Yu Zhao <yuzhao@google.com>
---
 mm/zswap.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/zswap.c b/mm/zswap.c
index 61a5c41..2b537bb 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1007,6 +1007,11 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 	u8 *src, *dst;
 	struct zswap_header zhdr = { .swpentry = swp_entry(type, offset) };
 
+	if (!zswap_max_pool_percent) {
+		ret = -ENOMEM;
+		goto reject;
+	}
+
 	/* THP isn't supported */
 	if (PageTransHuge(page)) {
 		ret = -EINVAL;
-- 
2.9.5
