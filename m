Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB30C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF652084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfBYTCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 14:02:55 -0500
Received: from mga03.intel.com ([134.134.136.65]:60203 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726625AbfBYTCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 14:02:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2019 11:02:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,412,1544515200"; 
   d="scan'208";a="118984325"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga006.jf.intel.com with ESMTP; 25 Feb 2019 11:02:42 -0800
Subject: [PATCH 4/5] mm/resource: let walk_system_ram_range() search child resources
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, keith.busch@intel.com,
        dan.j.williams@intel.com, dave.jiang@intel.com, zwisler@kernel.org,
        vishal.l.verma@intel.com, thomas.lendacky@amd.com,
        akpm@linux-foundation.org, mhocko@suse.com,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        ying.huang@intel.com, fengguang.wu@intel.com, bp@suse.de,
        bhelgaas@google.com, baiyaowei@cmss.chinamobile.com, tiwai@suse.de,
        jglisse@redhat.com
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Mon, 25 Feb 2019 10:57:38 -0800
References: <20190225185727.BCBD768C@viggo.jf.intel.com>
In-Reply-To: <20190225185727.BCBD768C@viggo.jf.intel.com>
Message-Id: <20190225185738.F6C24E62@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

In the process of onlining memory, we use walk_system_ram_range()
to find the actual RAM areas inside of the area being onlined.

However, it currently only finds memory resources which are
"top-level" iomem_resources.  Children are not currently
searched which causes it to skip System RAM in areas like this
(in the format of /proc/iomem):

a0000000-bfffffff : Persistent Memory (legacy)
  a0000000-afffffff : System RAM

Changing the true->false here allows children to be searched
as well.  We need this because we add a new "System RAM"
resource underneath the "persistent memory" resource when
we use persistent memory in a volatile mode.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Keith Busch <keith.busch@intel.com>
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

 b/kernel/resource.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff -puN kernel/resource.c~mm-walk_system_ram_range-search-child-resources kernel/resource.c
--- a/kernel/resource.c~mm-walk_system_ram_range-search-child-resources	2019-02-25 10:56:50.750908026 -0800
+++ b/kernel/resource.c	2019-02-25 10:56:50.754908026 -0800
@@ -454,6 +454,9 @@ int walk_mem_res(u64 start, u64 end, voi
  * This function calls the @func callback against all memory ranges of type
  * System RAM which are marked as IORESOURCE_SYSTEM_RAM and IORESOUCE_BUSY.
  * It is to be used only for System RAM.
+ *
+ * This will find System RAM ranges that are children of top-level resources
+ * in addition to top-level System RAM resources.
  */
 int walk_system_ram_range(unsigned long start_pfn, unsigned long nr_pages,
 			  void *arg, int (*func)(unsigned long, unsigned long, void *))
@@ -469,7 +472,7 @@ int walk_system_ram_range(unsigned long
 	flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
 	while (start < end &&
 	       !find_next_iomem_res(start, end, flags, IORES_DESC_NONE,
-				    true, &res)) {
+				    false, &res)) {
 		pfn = (res.start + PAGE_SIZE - 1) >> PAGE_SHIFT;
 		end_pfn = (res.end + 1) >> PAGE_SHIFT;
 		if (end_pfn > pfn)
_
