Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4B2C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FCEE20866
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545999335;
	bh=ZkBy9mYLZRTnnv4W+GrK5w14fDnCrMXybu3WxRp1YnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tdfhSXHv07ybxHJsARVT8S7V/wJDdRtttxGT5Kn1IdRsx6QEF2ODvH0gzumXL/Pp7
	 MdSzEPmwVRO5R+d1uP6FLf1cWqfO+PZqpD49SYsdOZDekG7q+ggLcCYUrzqEv8k27l
	 6bFL48HBPHUvoXZkw1AXNFw4FdVdO2P8T3BC7L/Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732473AbeL1MPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:15:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:34574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732455AbeL1MPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:15:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C830F2087F;
        Fri, 28 Dec 2018 12:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545999331;
        bh=ZkBy9mYLZRTnnv4W+GrK5w14fDnCrMXybu3WxRp1YnY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=od8jC1LqMDCHkz8k41vyS74N/z3VmJbxhpl28PZtJdK3Qy6OgqF3gd19jyEouJmDz
         ZbKkcH075OeTsPEUkk1hYFmy6x4ZqwxxGI9ujvgLy9NAiDyj0oZbVXvUDQft/RRFo/
         FlCHRdiTnbJEswWPSgnQw6EZBM+vjMR7WYUOPrvU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Pasha Tatashin <Pavel.Tatashin@microsoft.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.19 40/46] mm, memory_hotplug: initialize struct pages for the full memory section
Date:   Fri, 28 Dec 2018 12:52:34 +0100
Message-Id: <20181228113127.244829208@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181228113124.971620049@linuxfoundation.org>
References: <20181228113124.971620049@linuxfoundation.org>
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

From: Mikhail Zaslonko <zaslonko@linux.ibm.com>

commit 2830bf6f05fb3e05bc4743274b806c821807a684 upstream.

If memory end is not aligned with the sparse memory section boundary,
the mapping of such a section is only partly initialized.  This may lead
to VM_BUG_ON due to uninitialized struct page access from
is_mem_section_removable() or test_pages_in_a_zone() function triggered
by memory_hotplug sysfs handlers:

Here are the the panic examples:
 CONFIG_DEBUG_VM=y
 CONFIG_DEBUG_VM_PGFLAGS=y

 kernel parameter mem=2050M
 --------------------------
 page:000003d082008000 is uninitialized and poisoned
 page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
 Call Trace:
 ( test_pages_in_a_zone+0xde/0x160)
   show_valid_zones+0x5c/0x190
   dev_attr_show+0x34/0x70
   sysfs_kf_seq_show+0xc8/0x148
   seq_read+0x204/0x480
   __vfs_read+0x32/0x178
   vfs_read+0x82/0x138
   ksys_read+0x5a/0xb0
   system_call+0xdc/0x2d8
 Last Breaking-Event-Address:
   test_pages_in_a_zone+0xde/0x160
 Kernel panic - not syncing: Fatal exception: panic_on_oops

 kernel parameter mem=3075M
 --------------------------
 page:000003d08300c000 is uninitialized and poisoned
 page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
 Call Trace:
 ( is_mem_section_removable+0xb4/0x190)
   show_mem_removable+0x9a/0xd8
   dev_attr_show+0x34/0x70
   sysfs_kf_seq_show+0xc8/0x148
   seq_read+0x204/0x480
   __vfs_read+0x32/0x178
   vfs_read+0x82/0x138
   ksys_read+0x5a/0xb0
   system_call+0xdc/0x2d8
 Last Breaking-Event-Address:
   is_mem_section_removable+0xb4/0x190
 Kernel panic - not syncing: Fatal exception: panic_on_oops

Fix the problem by initializing the last memory section of each zone in
memmap_init_zone() till the very end, even if it goes beyond the zone end.

Michal said:

: This has alwways been problem AFAIU.  It just went unnoticed because we
: have zeroed memmaps during allocation before f7f99100d8d9 ("mm: stop
: zeroing memory during allocation in vmemmap") and so the above test
: would simply skip these ranges as belonging to zone 0 or provided a
: garbage.
:
: So I guess we do care for post f7f99100d8d9 kernels mostly and
: therefore Fixes: f7f99100d8d9 ("mm: stop zeroing memory during
: allocation in vmemmap")

Link: http://lkml.kernel.org/r/20181212172712.34019-2-zaslonko@linux.ibm.com
Fixes: f7f99100d8d9 ("mm: stop zeroing memory during allocation in vmemmap")
Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
Reviewed-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Suggested-by: Michal Hocko <mhocko@kernel.org>
Acked-by: Michal Hocko <mhocko@suse.com>
Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: Pasha Tatashin <Pavel.Tatashin@microsoft.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/page_alloc.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5538,6 +5538,18 @@ not_early:
 			cond_resched();
 		}
 	}
+#ifdef CONFIG_SPARSEMEM
+	/*
+	 * If the zone does not span the rest of the section then
+	 * we should at least initialize those pages. Otherwise we
+	 * could blow up on a poisoned page in some paths which depend
+	 * on full sections being initialized (e.g. memory hotplug).
+	 */
+	while (end_pfn % PAGES_PER_SECTION) {
+		__init_single_page(pfn_to_page(end_pfn), end_pfn, zone, nid);
+		end_pfn++;
+	}
+#endif
 }
 
 static void __meminit zone_init_free_lists(struct zone *zone)


