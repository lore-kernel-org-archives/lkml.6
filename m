Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24074C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCA9420C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:16:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCA9420C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732242AbeIXSSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:18:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55784 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730180AbeIXSST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:18:19 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 485CB10A5;
        Mon, 24 Sep 2018 12:16:28 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bin Yang <bin.yang@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 4.14 076/173] pstore: Fix incorrect persistent ram buffer mapping
Date:   Mon, 24 Sep 2018 13:51:50 +0200
Message-Id: <20180924113121.627149584@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113114.334025954@linuxfoundation.org>
References: <20180924113114.334025954@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/pstore/ram_core.c |   17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

--- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -421,7 +421,12 @@ static void *persistent_ram_vmap(phys_ad
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
@@ -440,6 +445,11 @@ static void *persistent_ram_iomap(phys_a
 	else
 		va = ioremap_wc(start, size);
 
+	/*
+	 * Since request_mem_region() and ioremap() are byte-granularity
+	 * there is no need handle anything special like we do when the
+	 * vmap() case in persistent_ram_vmap() above.
+	 */
 	return va;
 }
 
@@ -460,7 +470,7 @@ static int persistent_ram_buffer_map(phy
 		return -ENOMEM;
 	}
 
-	prz->buffer = prz->vaddr + offset_in_page(start);
+	prz->buffer = prz->vaddr;
 	prz->buffer_size = size - sizeof(struct persistent_ram_buffer);
 
 	return 0;
@@ -507,7 +517,8 @@ void persistent_ram_free(struct persiste
 
 	if (prz->vaddr) {
 		if (pfn_valid(prz->paddr >> PAGE_SHIFT)) {
-			vunmap(prz->vaddr);
+			/* We must vunmap() at page-granularity. */
+			vunmap(prz->vaddr - offset_in_page(prz->paddr));
 		} else {
 			iounmap(prz->vaddr);
 			release_mem_region(prz->paddr, prz->size);


