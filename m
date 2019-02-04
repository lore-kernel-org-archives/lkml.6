Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1F7C282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA98217FA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277415;
	bh=HwmZUhTAIqGpwxl6iOQm56gG2XgUC3F1fc1wUKtMYrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2Ewab4/epOMwOdy1ruTNPGtUnTqly4q+j0BDJ3vOyuJutWIldCDRpcYrgt3RAhxZ1
	 laU/x5mdxjKp36TzQQzAEApYZCorXkTQuK/wCAZyAHMKjr/dM91bmnDj6JsOrdOay5
	 HZclEMZQAu91NEfMb07EDnXP39Qk7qXXHkpVbVT8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731515AbfBDKuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:50:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:47934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732129AbfBDKuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:50:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C2952070C;
        Mon,  4 Feb 2019 10:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277407;
        bh=HwmZUhTAIqGpwxl6iOQm56gG2XgUC3F1fc1wUKtMYrU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V0GUEBcYCNChHxI7p+M/UoXHwuQEymHLvZqibecjouNgU3n49X6nyXqxUj8bt1WqH
         PRKL8y9zciVn+t309AVsskH2ZbO6QCXMYer5pL2OwsPoKVxxW1JBxKtLuyHIAvSiMx
         7Gnw2VsD1brG5dLlynrqUwiyEwVCj8C5bieBRU+g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oscar Salvador <osalvador@suse.de>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.19 64/74] mm,memory_hotplug: fix scan_movable_pages() for gigantic hugepages
Date:   Mon,  4 Feb 2019 11:37:17 +0100
Message-Id: <20190204103628.389081388@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103619.714714157@linuxfoundation.org>
References: <20190204103619.714714157@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oscar Salvador <osalvador@suse.de>

commit eeb0efd071d821a88da3fbd35f2d478f40d3b2ea upstream.

This is the same sort of error we saw in commit 17e2e7d7e1b8 ("mm,
page_alloc: fix has_unmovable_pages for HugePages").

Gigantic hugepages cross several memblocks, so it can be that the page
we get in scan_movable_pages() is a page-tail belonging to a
1G-hugepage.  If that happens, page_hstate()->size_to_hstate() will
return NULL, and we will blow up in hugepage_migration_supported().

The splat is as follows:

  BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
  #PF error: [normal kernel read fault]
  PGD 0 P4D 0
  Oops: 0000 [#1] SMP PTI
  CPU: 1 PID: 1350 Comm: bash Tainted: G            E     5.0.0-rc1-mm1-1-default+ #27
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.0.0-prebuilt.qemu-project.org 04/01/2014
  RIP: 0010:__offline_pages+0x6ae/0x900
  Call Trace:
   memory_subsys_offline+0x42/0x60
   device_offline+0x80/0xa0
   state_store+0xab/0xc0
   kernfs_fop_write+0x102/0x180
   __vfs_write+0x26/0x190
   vfs_write+0xad/0x1b0
   ksys_write+0x42/0x90
   do_syscall_64+0x5b/0x180
   entry_SYSCALL_64_after_hwframe+0x44/0xa9
  Modules linked in: af_packet(E) xt_tcpudp(E) ipt_REJECT(E) xt_conntrack(E) nf_conntrack(E) nf_defrag_ipv4(E) ip_set(E) nfnetlink(E) ebtable_nat(E) ebtable_broute(E) bridge(E) stp(E) llc(E) iptable_mangle(E) iptable_raw(E) iptable_security(E) ebtable_filter(E) ebtables(E) iptable_filter(E) ip_tables(E) x_tables(E) kvm_intel(E) kvm(E) irqbypass(E) crct10dif_pclmul(E) crc32_pclmul(E) ghash_clmulni_intel(E) bochs_drm(E) ttm(E) aesni_intel(E) drm_kms_helper(E) aes_x86_64(E) crypto_simd(E) cryptd(E) glue_helper(E) drm(E) virtio_net(E) syscopyarea(E) sysfillrect(E) net_failover(E) sysimgblt(E) pcspkr(E) failover(E) i2c_piix4(E) fb_sys_fops(E) parport_pc(E) parport(E) button(E) btrfs(E) libcrc32c(E) xor(E) zstd_decompress(E) zstd_compress(E) xxhash(E) raid6_pq(E) sd_mod(E) ata_generic(E) ata_piix(E) ahci(E) libahci(E) libata(E) crc32c_intel(E) serio_raw(E) virtio_pci(E) virtio_ring(E) virtio(E) sg(E) scsi_mod(E) autofs4(E)

[akpm@linux-foundation.org: fix brace layout, per David.  Reduce indentation]
Link: http://lkml.kernel.org/r/20190122154407.18417-1-osalvador@suse.de
Signed-off-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Anthony Yznaga <anthony.yznaga@oracle.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/memory_hotplug.c |   36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1326,23 +1326,27 @@ int test_pages_in_a_zone(unsigned long s
 static unsigned long scan_movable_pages(unsigned long start, unsigned long end)
 {
 	unsigned long pfn;
-	struct page *page;
+
 	for (pfn = start; pfn < end; pfn++) {
-		if (pfn_valid(pfn)) {
-			page = pfn_to_page(pfn);
-			if (PageLRU(page))
-				return pfn;
-			if (__PageMovable(page))
-				return pfn;
-			if (PageHuge(page)) {
-				if (hugepage_migration_supported(page_hstate(page)) &&
-				    page_huge_active(page))
-					return pfn;
-				else
-					pfn = round_up(pfn + 1,
-						1 << compound_order(page)) - 1;
-			}
-		}
+		struct page *page, *head;
+		unsigned long skip;
+
+		if (!pfn_valid(pfn))
+			continue;
+		page = pfn_to_page(pfn);
+		if (PageLRU(page))
+			return pfn;
+		if (__PageMovable(page))
+			return pfn;
+
+		if (!PageHuge(page))
+			continue;
+		head = compound_head(page);
+		if (hugepage_migration_supported(page_hstate(head)) &&
+		    page_huge_active(head))
+			return pfn;
+		skip = (1 << compound_order(head)) - (page - head);
+		pfn += skip - 1;
 	}
 	return 0;
 }


