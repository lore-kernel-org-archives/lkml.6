Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01F8C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 00:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A58D2218DE
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 00:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbfAEAWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 19:22:10 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:56080 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726249AbfAEAWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 19:22:10 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01406;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0THYi1he_1546647563;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0THYi1he_1546647563)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 05 Jan 2019 08:19:30 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     mhocko@suse.com, hannes@cmpxchg.org, shakeelb@google.com,
        akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v2 PATCH 2/5] mm: memcontrol: do not try to do swap when force empty
Date:   Sat,  5 Jan 2019 08:19:17 +0800
Message-Id: <1546647560-40026-3-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1546647560-40026-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1546647560-40026-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The typical usecase of force empty is to try to reclaim as much as
possible memory before offlining a memcg.  Since there should be no
attached tasks to offlining memcg, the tasks anonymous pages would have
already been freed or uncharged.  Even though anonymous pages get
swapped out, but they still get charged to swap space.  So, it sounds
pointless to do swap for force empty.

I tried to dig into the history of this, it was introduced by
commit 8c7c6e34a125 ("memcg: mem+swap controller core"), but there is
not any clue about why it was done so at the first place.

The below simple test script shows slight file cache reclaim improvement
when swap is on.

echo 3 > /proc/sys/vm/drop_caches
mkdir /sys/fs/cgroup/memory/test
echo 30 > /sys/fs/cgroup/memory/test/memory.swappiness
echo $$ >/sys/fs/cgroup/memory/test/cgroup.procs
cat /proc/meminfo | grep ^Cached|awk -F" " '{print $2}'
dd if=/dev/zero of=/mnt/test bs=1M count=1024
ping localhost > /dev/null &
echo 1 > /sys/fs/cgroup/memory/test/memory.force_empty
killall ping
echo $$ >/sys/fs/cgroup/memory/cgroup.procs
cat /proc/meminfo | grep ^Cached|awk -F" " '{print $2}'
rmdir /sys/fs/cgroup/memory/test
cat /proc/meminfo | grep ^Cached|awk -F" " '{print $2}'

The number of page cache is:
			w/o		w/
before force empty    1088792        1088784
after force empty     41492          39428
reclaimed	      1047300        1049356

Without doing swap, force empty can reclaim 2MB more memory in 1GB page
cache.

Cc: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index af7f18b..75208a2 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2895,7 +2895,7 @@ static int mem_cgroup_force_empty(struct mem_cgroup *memcg)
 			return -EINTR;
 
 		progress = try_to_free_mem_cgroup_pages(memcg, 1,
-							GFP_KERNEL, true);
+							GFP_KERNEL, false);
 		if (!progress) {
 			nr_retries--;
 			/* maybe some writeback is necessary */
-- 
1.8.3.1

