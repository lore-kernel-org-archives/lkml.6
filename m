Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF26FC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AE8A20675
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550956437;
	bh=H288oKZ7xm1LNXoh5JN36UfOyP8XY+Z8q8XgKvZYOTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H4Gowi0EzNB4qNnKSK37UW6S8zZ5VrB85zyt00yp2KN8HRdxdau+f9GhJCS9nyPXn
	 s460C2fd6YEOMsqett2Gw8UtGN27PsgwaZi7VFDyYFYE0dNWeUjSNDZPRHCnNn9X7j
	 G/HCz28zIZSgH2698S//4IgzijzuWg955g5fGilc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730075AbfBWVN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:13:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:47996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729991AbfBWVLa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:11:30 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC48520861;
        Sat, 23 Feb 2019 21:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550956289;
        bh=H288oKZ7xm1LNXoh5JN36UfOyP8XY+Z8q8XgKvZYOTY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u4Yz+TIX1fDftVHsdGT7QqA+PNpqq7ZW1UEJShWAfn0WLs7HHcdEXkQt6OrXEVBj+
         qT+C/Wx2/X3E31++SOxQX9rY53FJUUv4qsTzBQupkfEgkvVd5ypD/gkx80S3APPM7T
         ZOEyntEj4CiyYkvRh1dBVYmEqu+fg+SZzneP+QzU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org
Subject: [PATCH AUTOSEL 4.4 23/26] mm, memory_hotplug: test_pages_in_a_zone do not pass the end of zone
Date:   Sat, 23 Feb 2019 16:10:44 -0500
Message-Id: <20190223211047.202725-23-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223211047.202725-1-sashal@kernel.org>
References: <20190223211047.202725-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikhail Zaslonko <zaslonko@linux.ibm.com>

[ Upstream commit 24feb47c5fa5b825efb0151f28906dfdad027e61 ]

If memory end is not aligned with the sparse memory section boundary,
the mapping of such a section is only partly initialized.  This may lead
to VM_BUG_ON due to uninitialized struct pages access from
test_pages_in_a_zone() function triggered by memory_hotplug sysfs
handlers.

Here are the the panic examples:
 CONFIG_DEBUG_VM_PGFLAGS=y
 kernel parameter mem=2050M
 --------------------------
 page:000003d082008000 is uninitialized and poisoned
 page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
 Call Trace:
   test_pages_in_a_zone+0xde/0x160
   show_valid_zones+0x5c/0x190
   dev_attr_show+0x34/0x70
   sysfs_kf_seq_show+0xc8/0x148
   seq_read+0x204/0x480
   __vfs_read+0x32/0x178
   vfs_read+0x82/0x138
   ksys_read+0x5a/0xb0
   system_call+0xdc/0x2d8
 Last Breaking-Event-Address:
   test_pages_in_a_zone+0xde/0x160
 Kernel panic - not syncing: Fatal exception: panic_on_oops

Fix this by checking whether the pfn to check is within the zone.

[mhocko@suse.com: separated this change from http://lkml.kernel.org/r/20181105150401.97287-2-zaslonko@linux.ibm.com]
Link: http://lkml.kernel.org/r/20190128144506.15603-3-mhocko@kernel.org

[mhocko@suse.com: separated this change from
http://lkml.kernel.org/r/20181105150401.97287-2-zaslonko@linux.ibm.com]
Signed-off-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Tested-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/memory_hotplug.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 153acbf5f83db..804cbfe9132dd 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1399,6 +1399,9 @@ int test_pages_in_a_zone(unsigned long start_pfn, unsigned long end_pfn,
 				i++;
 			if (i == MAX_ORDER_NR_PAGES)
 				continue;
+			/* Check if we got outside of the zone */
+			if (zone && !zone_spans_pfn(zone, pfn + i))
+				return 0;
 			page = pfn_to_page(pfn + i);
 			if (zone && page_zone(page) != zone)
 				return 0;
-- 
2.19.1

