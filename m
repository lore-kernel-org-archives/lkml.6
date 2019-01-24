Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8705BC282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 23:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E7BC218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 23:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbfAXXVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 18:21:55 -0500
Received: from mga05.intel.com ([192.55.52.43]:15138 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725991AbfAXXVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 18:21:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jan 2019 15:21:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,518,1539673200"; 
   d="scan'208";a="121111369"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga003.jf.intel.com with ESMTP; 24 Jan 2019 15:21:52 -0800
Subject: [PATCH 1/5] mm/resource: return real error codes from walk failures
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        dan.j.williams@intel.com, dave.jiang@intel.com, zwisler@kernel.org,
        vishal.l.verma@intel.com, thomas.lendacky@amd.com,
        akpm@linux-foundation.org, mhocko@suse.com,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        ying.huang@intel.com, fengguang.wu@intel.com, bp@suse.de,
        bhelgaas@google.com, baiyaowei@cmss.chinamobile.com, tiwai@suse.de,
        jglisse@redhat.com
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Thu, 24 Jan 2019 15:14:42 -0800
References: <20190124231441.37A4A305@viggo.jf.intel.com>
In-Reply-To: <20190124231441.37A4A305@viggo.jf.intel.com>
Message-Id: <20190124231442.EFD29EE0@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

walk_system_ram_range() can return an error code either becuase *it*
failed, or because the 'func' that it calls returned an error.  The
memory hotplug does the following:

        ret = walk_system_ram_range(..., func);
        if (ret)
		return ret;

and 'ret' makes it out to userspace, eventually.  The problem is,
walk_system_ram_range() failues that result from *it* failing (as
opposed to 'func') return -1.  That leads to a very odd -EPERM (-1)
return code out to userspace.

Make walk_system_ram_range() return -EINVAL for internal failures to
keep userspace less confused.

This return code is compatible with all the callers that I audited.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ross Zwisler <zwisler@kernel.org>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: linux-nvdimm@lists.01.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: Huang Ying <ying.huang@intel.com>
Cc: Fengguang Wu <fengguang.wu@intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Jerome Glisse <jglisse@redhat.com>
---

 b/kernel/resource.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -puN kernel/resource.c~memory-hotplug-walk_system_ram_range-returns-neg-1 kernel/resource.c
--- a/kernel/resource.c~memory-hotplug-walk_system_ram_range-returns-neg-1	2019-01-24 15:13:13.950199540 -0800
+++ b/kernel/resource.c	2019-01-24 15:13:13.954199540 -0800
@@ -375,7 +375,7 @@ static int __walk_iomem_res_desc(resourc
 				 int (*func)(struct resource *, void *))
 {
 	struct resource res;
-	int ret = -1;
+	int ret = -EINVAL;
 
 	while (start < end &&
 	       !find_next_iomem_res(start, end, flags, desc, first_lvl, &res)) {
@@ -453,7 +453,7 @@ int walk_system_ram_range(unsigned long
 	unsigned long flags;
 	struct resource res;
 	unsigned long pfn, end_pfn;
-	int ret = -1;
+	int ret = -EINVAL;
 
 	start = (u64) start_pfn << PAGE_SHIFT;
 	end = ((u64)(start_pfn + nr_pages) << PAGE_SHIFT) - 1;
_
