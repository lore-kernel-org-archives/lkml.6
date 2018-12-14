Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF14C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C37B22148E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789243;
	bh=zBRLDU+LBgzmyriOaBWeIOMWZPC4UiL147KMvwDxPH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SPODWtTmP4cm3OQnT2WI//JO7ixR/veStACgQulrh+QmPogT4jxOL5B1yGoA5Sd2Q
	 hM+xiCof/H6OYADASHwlJp7xqEmzpurFUV/gztMpKGqFlH5urtAylRDXZrhAiamPeO
	 VxhJsJ6FUUXWU6KD2M3mNP5J7c/ewVXFCMfPlJg8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C37B22148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731103AbeLNMHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:07:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:52518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729873AbeLNMHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:07:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2135214AE;
        Fri, 14 Dec 2018 12:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789237;
        bh=zBRLDU+LBgzmyriOaBWeIOMWZPC4UiL147KMvwDxPH0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=axS3ol9CDWHeT7VkW+G1lkBujsZijynJc8l295dzPIYMTWt9XW+xJexZqKTG4WXHz
         duWYfx1o709uMKnWNCAapNW5l9BHdy4uNRsBLoybBQjjpAmYINhb/JFqYDWIeopz4d
         dCZn4tWqJSjkFczqEzNTWrKrXY8024B6IfUfO2wA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wei Yang <richard.weiyang@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 125/142] mm/page_alloc.c: fix calculation of pgdat->nr_zones
Date:   Fri, 14 Dec 2018 13:00:10 +0100
Message-Id: <20181214115752.035179121@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index b721631d78ab..6a62b2421cdf 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5733,8 +5733,10 @@ void __meminit init_currently_empty_zone(struct zone *zone,
 					unsigned long size)
 {
 	struct pglist_data *pgdat = zone->zone_pgdat;
+	int zone_idx = zone_idx(zone) + 1;
 
-	pgdat->nr_zones = zone_idx(zone) + 1;
+	if (zone_idx > pgdat->nr_zones)
+		pgdat->nr_zones = zone_idx;
 
 	zone->zone_start_pfn = zone_start_pfn;
 
-- 
2.19.1



