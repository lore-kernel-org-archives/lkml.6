Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D656EC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BFB82087F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bUEDsJjL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BFB82087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbeLEJqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:46:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:53024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728571AbeLEJqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:46:49 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6459C20878;
        Wed,  5 Dec 2018 09:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544003208;
        bh=MytifBFqhD8qxDtP+VB5UAGzmhyxcO+ZcXBnjD/NR6s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bUEDsJjLGCvVUPgKI+9Alqb2pLXb2OecXjKMmhhE305o1cQBV0qSIP9VR4KohSwKB
         Lp7M8OgsYpVgws7MXmr7MLauG22VqbHPkY1kHtpeaL6whjpBPjPSTB1BuUb2PUS4F+
         7aCNk6Jr7h6RHewHqnTbzDFi4i2+/OLaANxnBKKQ=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org
Subject: [PATCH AUTOSEL 4.14 65/69] mm/page_alloc.c: fix calculation of pgdat->nr_zones
Date:   Wed,  5 Dec 2018 04:42:43 -0500
Message-Id: <20181205094247.6556-65-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205094247.6556-1-sashal@kernel.org>
References: <20181205094247.6556-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yang <richard.weiyang@gmail.com>

[ Upstream commit 8f416836c0d50b198cad1225132e5abebf8980dc ]

init_currently_empty_zone() will adjust pgdat->nr_zones and set it to
'zone_idx(zone) + 1' unconditionally.  This is correct in the normal
case, while not exact in hot-plug situation.

This function is used in two places:

  * free_area_init_core()
  * move_pfn_range_to_zone()

In the first case, we are sure zone index increase monotonically.  While
in the second one, this is under users control.

One way to reproduce this is:
----------------------------

1. create a virtual machine with empty node1

   -m 4G,slots=32,maxmem=32G \
   -smp 4,maxcpus=8          \
   -numa node,nodeid=0,mem=4G,cpus=0-3 \
   -numa node,nodeid=1,mem=0G,cpus=4-7

2. hot-add cpu 3-7

   cpu-add [3-7]

2. hot-add memory to nod1

   object_add memory-backend-ram,id=ram0,size=1G
   device_add pc-dimm,id=dimm0,memdev=ram0,node=1

3. online memory with following order

   echo online_movable > memory47/state
   echo online > memory40/state

After this, node1 will have its nr_zones equals to (ZONE_NORMAL + 1)
instead of (ZONE_MOVABLE + 1).

Michal said:
 "Having an incorrect nr_zones might result in all sorts of problems
  which would be quite hard to debug (e.g. reclaim not considering the
  movable zone). I do not expect many users would suffer from this it
  but still this is trivial and obviously right thing to do so
  backporting to the stable tree shouldn't be harmful (last famous
  words)"

Link: http://lkml.kernel.org/r/20181117022022.9956-1-richard.weiyang@gmail.com
Fixes: f1dd2cd13c4b ("mm, memory_hotplug: do not associate hotadded memory to zones until online")
Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page_alloc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2074f424dabf..86a5cab8b5dc 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5554,8 +5554,10 @@ void __meminit init_currently_empty_zone(struct zone *zone,
 					unsigned long size)
 {
 	struct pglist_data *pgdat = zone->zone_pgdat;
+	int zone_idx = zone_idx(zone) + 1;
 
-	pgdat->nr_zones = zone_idx(zone) + 1;
+	if (zone_idx > pgdat->nr_zones)
+		pgdat->nr_zones = zone_idx;
 
 	zone->zone_start_pfn = zone_start_pfn;
 
-- 
2.17.1

