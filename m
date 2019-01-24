Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF5AC282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 23:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A7A8218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 23:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbfAXXV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 18:21:57 -0500
Received: from mga07.intel.com ([134.134.136.100]:24343 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727616AbfAXXVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 18:21:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jan 2019 15:21:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,518,1539673200"; 
   d="scan'208";a="294207413"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga005.jf.intel.com with ESMTP; 24 Jan 2019 15:21:53 -0800
Subject: [PATCH 2/5] mm/resource: move HMM pr_debug() deeper into resource code
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        dan.j.williams@intel.com, dave.jiang@intel.com, zwisler@kernel.org,
        vishal.l.verma@intel.com, thomas.lendacky@amd.com,
        akpm@linux-foundation.org, mhocko@suse.com,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        ying.huang@intel.com, fengguang.wu@intel.com, jglisse@redhat.com
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Thu, 24 Jan 2019 15:14:44 -0800
References: <20190124231441.37A4A305@viggo.jf.intel.com>
In-Reply-To: <20190124231441.37A4A305@viggo.jf.intel.com>
Message-Id: <20190124231444.38182DD8@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

HMM consumes physical address space for its own use, even
though nothing is mapped or accessible there.  It uses a
special resource description (IORES_DESC_DEVICE_PRIVATE_MEMORY)
to uniquely identify these areas.

When HMM consumes address space, it makes a best guess about
what to consume.  However, it is possible that a future memory
or device hotplug can collide with the reserved area.  In the
case of these conflicts, there is an error message in
register_memory_resource().

Later patches in this series move register_memory_resource()
from using request_resource_conflict() to __request_region().
Unfortunately, __request_region() does not return the conflict
like the previous function did, which makes it impossible to
check for IORES_DESC_DEVICE_PRIVATE_MEMORY in a conflicting
resource.

Instead of warning in register_memory_resource(), move the
check into the core resource code itself (__request_region())
where the conflicting resource _is_ available.  This has the
added bonus of producing a warning in case of HMM conflicts
with devices *or* RAM address space, as opposed to the RAM-
only warnings that were there previously.

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
Cc: Jerome Glisse <jglisse@redhat.com>
---

 b/kernel/resource.c   |   10 ++++++++++
 b/mm/memory_hotplug.c |    5 -----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff -puN kernel/resource.c~move-request_region-check kernel/resource.c
--- a/kernel/resource.c~move-request_region-check	2019-01-24 15:13:14.453199539 -0800
+++ b/kernel/resource.c	2019-01-24 15:13:14.458199539 -0800
@@ -1123,6 +1123,16 @@ struct resource * __request_region(struc
 		conflict = __request_resource(parent, res);
 		if (!conflict)
 			break;
+		/*
+		 * mm/hmm.c reserves physical addresses which then
+		 * become unavailable to other users.  Conflicts are
+		 * not expected.  Be verbose if one is encountered.
+		 */
+		if (conflict->desc == IORES_DESC_DEVICE_PRIVATE_MEMORY) {
+			pr_debug("Resource conflict with unaddressable "
+				 "device memory at %#010llx !\n",
+				 (unsigned long long)start);
+		}
 		if (conflict != parent) {
 			if (!(conflict->flags & IORESOURCE_BUSY)) {
 				parent = conflict;
diff -puN mm/memory_hotplug.c~move-request_region-check mm/memory_hotplug.c
--- a/mm/memory_hotplug.c~move-request_region-check	2019-01-24 15:13:14.455199539 -0800
+++ b/mm/memory_hotplug.c	2019-01-24 15:13:14.459199539 -0800
@@ -109,11 +109,6 @@ static struct resource *register_memory_
 	res->flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
 	conflict =  request_resource_conflict(&iomem_resource, res);
 	if (conflict) {
-		if (conflict->desc == IORES_DESC_DEVICE_PRIVATE_MEMORY) {
-			pr_debug("Device unaddressable memory block "
-				 "memory hotplug at %#010llx !\n",
-				 (unsigned long long)start);
-		}
 		pr_debug("System RAM resource %pR cannot be added\n", res);
 		kfree(res);
 		return ERR_PTR(-EEXIST);
_
