Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC1DC67879
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 23:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D5A220858
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 23:34:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D5A220858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbeJIGsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 02:48:42 -0400
Received: from mga14.intel.com ([192.55.52.115]:46544 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725759AbeJIGsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 02:48:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2018 16:34:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,358,1534834800"; 
   d="scan'208";a="97639761"
Received: from ahduyck-mobl.amr.corp.intel.com (HELO localhost.localdomain) ([10.7.198.166])
  by orsmga001.jf.intel.com with ESMTP; 08 Oct 2018 16:34:34 -0700
Subject: [mm PATCH] memremap: Fix reference count for pgmap in
 devm_memremap_pages
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org,
        dan.j.williams@intel.com
Cc:     pavel.tatashin@microsoft.com, mhocko@suse.com,
        dave.jiang@intel.com, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org, dave.hansen@intel.com,
        jglisse@redhat.com, alexander.h.duyck@linux.intel.com,
        logang@deltatee.com, mingo@kernel.org,
        kirill.shutemov@linux.intel.com
Date:   Mon, 08 Oct 2018 16:34:33 -0700
Message-ID: <20181008233404.1909.37302.stgit@localhost.localdomain>
In-Reply-To: <CAPcyv4jX5WYmMYzGCBrnaqT7tqHGSVPwm7Dpi-XpuM9ns84+0w@mail.gmail.com>
References: <CAPcyv4jX5WYmMYzGCBrnaqT7tqHGSVPwm7Dpi-XpuM9ns84+0w@mail.gmail.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the earlier patch "mm: defer ZONE_DEVICE page initialization to the
point where we init pgmap" I had overlooked the reference count that was
being held per page on the pgmap. As a result on running the ndctl test
"create.sh" we would call into devm_memremap_pages_release and encounter
the following percpu reference count error and hang:
  WARNING: CPU: 30 PID: 0 at lib/percpu-refcount.c:155
  percpu_ref_switch_to_atomic_rcu+0xf3/0x120

This patch addresses that by performing an update for all of the device
PFNs in a single call. In my testing this seems to resolve the issue while
still allowing us to retain the improvements seen in memory initialization.

Reported-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 kernel/memremap.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/memremap.c b/kernel/memremap.c
index 6ec81e0d7a33..9eced2cc9f94 100644
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -218,6 +218,7 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
 	memmap_init_zone_device(&NODE_DATA(nid)->node_zones[ZONE_DEVICE],
 				align_start >> PAGE_SHIFT,
 				align_size >> PAGE_SHIFT, pgmap);
+	percpu_ref_get_many(pgmap->ref, pfn_end(pgmap) - pfn_first(pgmap));
 
 	devm_add_action(dev, devm_memremap_pages_release, pgmap);
 

