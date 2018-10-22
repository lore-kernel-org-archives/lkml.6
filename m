Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24ACDC67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88C5420652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:18:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88C5420652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbeJWEip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 00:38:45 -0400
Received: from mga07.intel.com ([134.134.136.100]:37690 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbeJWEio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 00:38:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2018 13:18:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,413,1534834800"; 
   d="scan'208";a="99739367"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by fmsmga004.fm.intel.com with ESMTP; 22 Oct 2018 13:18:45 -0700
Subject: [PATCH 6/9] mm/memory-hotplug: allow memory resources to be children
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        dan.j.williams@intel.com, dave.jiang@intel.com, zwisler@kernel.org,
        vishal.l.verma@intel.com, thomas.lendacky@amd.com,
        akpm@linux-foundation.org, mhocko@suse.com,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        ying.huang@intel.com, fengguang.wu@intel.com
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Mon, 22 Oct 2018 13:13:27 -0700
References: <20181022201317.8558C1D8@viggo.jf.intel.com>
In-Reply-To: <20181022201317.8558C1D8@viggo.jf.intel.com>
Message-Id: <20181022201327.F1642450@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The mm/resource.c code is used to manage the physical address
space.  We can view the current resource configuration in
/proc/iomem.  An example of this is at the bottom of this
description.

The nvdimm subsystem "owns" the physical address resources which
map to persistent memory and has resources inserted for them as
"Persistent Memory".  We want to use this persistent memory, but
as volatile memory, just like RAM.  The best way to do this is
to leave the existing resource in place, but add a "System RAM"
resource underneath it. This clearly communicates the ownership
relationship of this memory.

The request_resource_conflict() API only deals with the
top-level resources.  Replace it with __request_region() which
will search for !IORESOURCE_BUSY areas lower in the resource
tree than the top level.

We also rework the old error message a bit since we do not get
the conflicting entry back: only an indication that we *had* a
conflict.

We *could* also simply truncate the existing top-level
"Persistent Memory" resource and take over the released address
space.  But, this means that if we ever decide to hot-unplug the
"RAM" and give it back, we need to recreate the original setup,
which may mean going back to the BIOS tables.

This should have no real effect on the existing collision
detection because the areas that truly conflict should be marked
IORESOURCE_BUSY.

00000000-00000fff : Reserved
00001000-0009fbff : System RAM
0009fc00-0009ffff : Reserved
000a0000-000bffff : PCI Bus 0000:00
000c0000-000c97ff : Video ROM
000c9800-000ca5ff : Adapter ROM
000f0000-000fffff : Reserved
  000f0000-000fffff : System ROM
00100000-9fffffff : System RAM
  01000000-01e071d0 : Kernel code
  01e071d1-027dfdff : Kernel data
  02dc6000-0305dfff : Kernel bss
a0000000-afffffff : Persistent Memory (legacy)
  a0000000-a7ffffff : System RAM
b0000000-bffdffff : System RAM
bffe0000-bfffffff : Reserved
c0000000-febfffff : PCI Bus 0000:00

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

---

 b/mm/memory_hotplug.c |   31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff -puN mm/memory_hotplug.c~mm-memory-hotplug-allow-memory-resource-to-be-child mm/memory_hotplug.c
--- a/mm/memory_hotplug.c~mm-memory-hotplug-allow-memory-resource-to-be-child	2018-10-22 13:12:23.570930388 -0700
+++ b/mm/memory_hotplug.c	2018-10-22 13:12:23.573930388 -0700
@@ -99,24 +99,21 @@ void mem_hotplug_done(void)
 /* add this memory to iomem resource */
 static struct resource *register_memory_resource(u64 start, u64 size)
 {
-	struct resource *res, *conflict;
-	res = kzalloc(sizeof(struct resource), GFP_KERNEL);
-	if (!res)
-		return ERR_PTR(-ENOMEM);
+	struct resource *res;
+	unsigned long flags =  IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
+	char resource_name[] = "System RAM";
 
-	res->name = "System RAM";
-	res->start = start;
-	res->end = start + size - 1;
-	res->flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
-	conflict =  request_resource_conflict(&iomem_resource, res);
-	if (conflict) {
-		if (conflict->desc == IORES_DESC_DEVICE_PRIVATE_MEMORY) {
-			pr_debug("Device unaddressable memory block "
-				 "memory hotplug at %#010llx !\n",
-				 (unsigned long long)start);
-		}
-		pr_debug("System RAM resource %pR cannot be added\n", res);
-		kfree(res);
+	/*
+	 * Request ownership of the new memory range.  This might be
+	 * a child of an existing resource that was present but
+	 * not marked as busy.
+	 */
+	res = __request_region(&iomem_resource, start, size,
+			       resource_name, flags);
+
+	if (!res) {
+		pr_debug("Unable to reserve System RAM region: %016llx->%016llx\n",
+				start, start + size);
 		return ERR_PTR(-EEXIST);
 	}
 	return res;
_
