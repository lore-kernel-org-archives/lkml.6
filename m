Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62E6C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A19820815
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729575AbfBCOAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:00:47 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53406 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728173AbfBCNtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:49:52 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9e-0003tg-8R; Sun, 03 Feb 2019 13:49:50 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9a-00072G-Gq; Sun, 03 Feb 2019 14:49:46 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Michal Hocko" <mhocko@suse.com>,
        "Dan Williams" <dan.j.williams@gmail.com>,
        "Johannes Thumshirn" <jthumshirn@suse.de>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.378464720@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 134/305] memory_hotplug: cond_resched in __remove_pages
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Hocko <mhocko@suse.com>

commit dd33ad7b251f900481701b2a82d25de583867708 upstream.

We have received a bug report that unbinding a large pmem (>1TB) can
result in a soft lockup:

  NMI watchdog: BUG: soft lockup - CPU#9 stuck for 23s! [ndctl:4365]
  [...]
  Supported: Yes
  CPU: 9 PID: 4365 Comm: ndctl Not tainted 4.12.14-94.40-default #1 SLE12-SP4
  Hardware name: Intel Corporation S2600WFD/S2600WFD, BIOS SE5C620.86B.01.00.0833.051120182255 05/11/2018
  task: ffff9cce7d4410c0 task.stack: ffffbe9eb1bc4000
  RIP: 0010:__put_page+0x62/0x80
  Call Trace:
   devm_memremap_pages_release+0x152/0x260
   release_nodes+0x18d/0x1d0
   device_release_driver_internal+0x160/0x210
   unbind_store+0xb3/0xe0
   kernfs_fop_write+0x102/0x180
   __vfs_write+0x26/0x150
   vfs_write+0xad/0x1a0
   SyS_write+0x42/0x90
   do_syscall_64+0x74/0x150
   entry_SYSCALL_64_after_hwframe+0x3d/0xa2
  RIP: 0033:0x7fd13166b3d0

It has been reported on an older (4.12) kernel but the current upstream
code doesn't cond_resched in the hot remove code at all and the given
range to remove might be really large.  Fix the issue by calling
cond_resched once per memory section.

Link: http://lkml.kernel.org/r/20181031125840.23982-1-mhocko@kernel.org
Signed-off-by: Michal Hocko <mhocko@suse.com>
Acked-by: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Dan Williams <dan.j.williams@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 mm/memory_hotplug.c | 1 +
 1 file changed, 1 insertion(+)

--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -780,6 +780,8 @@ int __remove_pages(struct zone *zone, un
 	sections_to_remove = nr_pages / PAGES_PER_SECTION;
 	for (i = 0; i < sections_to_remove; i++) {
 		unsigned long pfn = phys_start_pfn + i*PAGES_PER_SECTION;
+
+		cond_resched();
 		ret = __remove_section(zone, __pfn_to_section(pfn));
 		if (ret)
 			break;

