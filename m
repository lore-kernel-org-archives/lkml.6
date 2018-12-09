Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2896DC65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE6B420661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:22:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE6B420661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbeLIWW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:22:27 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35236 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726525AbeLIVzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:21 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72l-0002if-9X; Sun, 09 Dec 2018 21:55:19 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72i-0003ZW-07; Sun, 09 Dec 2018 21:55:16 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Bin Yang" <bin.yang@intel.com>,
        "Kees Cook" <keescook@chromium.org>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.962728629@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 239/328] pstore: Fix incorrect persistent ram buffer
 mapping
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Bin Yang <bin.yang@intel.com>

commit 831b624df1b420c8f9281ed1307a8db23afb72df upstream.

persistent_ram_vmap() returns the page start vaddr.
persistent_ram_iomap() supports non-page-aligned mapping.

persistent_ram_buffer_map() always adds offset-in-page to the vaddr
returned from these two functions, which causes incorrect mapping of
non-page-aligned persistent ram buffer.

By default ftrace_size is 4096 and max_ftrace_cnt is nr_cpu_ids. Without
this patch, the zone_sz in ramoops_init_przs() is 4096/nr_cpu_ids which
might not be page aligned. If the offset-in-page > 2048, the vaddr will be
in next page. If the next page is not mapped, it will cause kernel panic:

[    0.074231] BUG: unable to handle kernel paging request at ffffa19e0081b000
...
[    0.075000] RIP: 0010:persistent_ram_new+0x1f8/0x39f
...
[    0.075000] Call Trace:
[    0.075000]  ramoops_init_przs.part.10.constprop.15+0x105/0x260
[    0.075000]  ramoops_probe+0x232/0x3a0
[    0.075000]  platform_drv_probe+0x3e/0xa0
[    0.075000]  driver_probe_device+0x2cd/0x400
[    0.075000]  __driver_attach+0xe4/0x110
[    0.075000]  ? driver_probe_device+0x400/0x400
[    0.075000]  bus_for_each_dev+0x70/0xa0
[    0.075000]  driver_attach+0x1e/0x20
[    0.075000]  bus_add_driver+0x159/0x230
[    0.075000]  ? do_early_param+0x95/0x95
[    0.075000]  driver_register+0x70/0xc0
[    0.075000]  ? init_pstore_fs+0x4d/0x4d
[    0.075000]  __platform_driver_register+0x36/0x40
[    0.075000]  ramoops_init+0x12f/0x131
[    0.075000]  do_one_initcall+0x4d/0x12c
[    0.075000]  ? do_early_param+0x95/0x95
[    0.075000]  kernel_init_freeable+0x19b/0x222
[    0.075000]  ? rest_init+0xbb/0xbb
[    0.075000]  kernel_init+0xe/0xfc
[    0.075000]  ret_from_fork+0x3a/0x50

Signed-off-by: Bin Yang <bin.yang@intel.com>
[kees: add comments describing the mapping differences, updated commit log]
Fixes: 24c3d2f342ed ("staging: android: persistent_ram: Make it possible to use memory outside of bootmem")
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/pstore/ram_core.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

--- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -376,7 +376,12 @@ static void *persistent_ram_vmap(phys_ad
 	vaddr = vmap(pages, page_count, VM_MAP, prot);
 	kfree(pages);
 
-	return vaddr;
+	/*
+	 * Since vmap() uses page granularity, we must add the offset
+	 * into the page here, to get the byte granularity address
+	 * into the mapping to represent the actual "start" location.
+	 */
+	return vaddr + offset_in_page(start);
 }
 
 static void *persistent_ram_iomap(phys_addr_t start, size_t size,
@@ -395,6 +400,11 @@ static void *persistent_ram_iomap(phys_a
 	else
 		va = ioremap_wc(start, size);
 
+	/*
+	 * Since request_mem_region() and ioremap() are byte-granularity
+	 * there is no need handle anything special like we do when the
+	 * vmap() case in persistent_ram_vmap() above.
+	 */
 	return va;
 }
 
@@ -415,7 +425,7 @@ static int persistent_ram_buffer_map(phy
 		return -ENOMEM;
 	}
 
-	prz->buffer = prz->vaddr + offset_in_page(start);
+	prz->buffer = prz->vaddr;
 	prz->buffer_size = size - sizeof(struct persistent_ram_buffer);
 
 	return 0;
@@ -461,7 +471,8 @@ void persistent_ram_free(struct persiste
 
 	if (prz->vaddr) {
 		if (pfn_valid(prz->paddr >> PAGE_SHIFT)) {
-			vunmap(prz->vaddr);
+			/* We must vunmap() at page-granularity. */
+			vunmap(prz->vaddr - offset_in_page(prz->paddr));
 		} else {
 			iounmap(prz->vaddr);
 			release_mem_region(prz->paddr, prz->size);

