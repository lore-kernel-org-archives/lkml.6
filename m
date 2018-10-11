Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE6BC28CF8
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 22:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73664213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 22:17:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73664213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbeJLFqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 01:46:15 -0400
Received: from mga17.intel.com ([192.55.52.151]:13924 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbeJLFqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 01:46:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2018 15:16:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,370,1534834800"; 
   d="scan'208";a="80765705"
Received: from ahduyck-mobl.amr.corp.intel.com (HELO localhost.localdomain) ([10.7.198.157])
  by orsmga008.jf.intel.com with ESMTP; 11 Oct 2018 15:13:51 -0700
Subject: [mm PATCH v2 4/6] mm: Do not set reserved flag for hotplug memory
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     pavel.tatashin@microsoft.com, mhocko@suse.com,
        dave.jiang@intel.com, alexander.h.duyck@linux.intel.com,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        davem@davemloft.net, yi.z.zhang@linux.intel.com,
        khalid.aziz@oracle.com, rppt@linux.vnet.ibm.com, vbabka@suse.cz,
        sparclinux@vger.kernel.org, dan.j.williams@intel.com,
        ldufour@linux.vnet.ibm.com, mgorman@techsingularity.net,
        mingo@kernel.org, kirill.shutemov@linux.intel.com
Date:   Thu, 11 Oct 2018 15:13:51 -0700
Message-ID: <20181011221351.1925.67694.stgit@localhost.localdomain>
In-Reply-To: <20181011221237.1925.85591.stgit@localhost.localdomain>
References: <20181011221237.1925.85591.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The general suspicion at this point is that the setting of the reserved bit
is not really needed for hotplug memory. In addition the setting of this
bit results in issues for DAX in that it is not possible to assign the
region to KVM if the reserved bit is set in each page.

For now we can try just not setting the bit since we suspect it isn't
adding value in setting it. If at a later time we find that it is needed we
can come back through and re-add it for the hotplug paths.

Suggested-by: Michael Hocko <mhocko@suse.com>
Reported-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 mm/page_alloc.c |   11 -----------
 1 file changed, 11 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3603d5444865..e435223e2ddb 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5571,8 +5571,6 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 
 		page = pfn_to_page(pfn);
 		__init_single_page(page, pfn, zone, nid);
-		if (context == MEMMAP_HOTPLUG)
-			__SetPageReserved(page);
 
 		/*
 		 * Mark the block movable so that blocks are reserved for
@@ -5626,15 +5624,6 @@ void __ref memmap_init_zone_device(struct zone *zone,
 		__init_single_page(page, pfn, zone_idx, nid);
 
 		/*
-		 * Mark page reserved as it will need to wait for onlining
-		 * phase for it to be fully associated with a zone.
-		 *
-		 * We can use the non-atomic __set_bit operation for setting
-		 * the flag as we are still initializing the pages.
-		 */
-		__SetPageReserved(page);
-
-		/*
 		 * ZONE_DEVICE pages union ->lru with a ->pgmap back
 		 * pointer and hmm_data.  It is a bug if a ZONE_DEVICE
 		 * page is ever freed or placed on a driver-private list.

