Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B22C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 13:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D940A21581
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 13:02:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D940A21581
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbeHTQRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 12:17:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:58582 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726748AbeHTQRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 12:17:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DF7E4AFC9;
        Mon, 20 Aug 2018 13:02:06 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org
Cc:     boris.ostrovsky@oracle.com, hpa@zytor.com, tglx@linutronix.de,
        mingo@redhat.com, Juergen Gross <jgross@suse.com>
Subject: [PATCH] x86/xen: remove unused function xen_auto_xlated_memory_setup()
Date:   Mon, 20 Aug 2018 15:02:03 +0200
Message-Id: <20180820130203.11501-1-jgross@suse.com>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xen_auto_xlated_memory_setup() is a leftover from PVH V1. Remove it.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/xen/setup.c   | 31 -------------------------------
 arch/x86/xen/xen-ops.h |  1 -
 2 files changed, 32 deletions(-)

diff --git a/arch/x86/xen/setup.c b/arch/x86/xen/setup.c
index 6e0d2086eacb..1163e33121fb 100644
--- a/arch/x86/xen/setup.c
+++ b/arch/x86/xen/setup.c
@@ -906,37 +906,6 @@ char * __init xen_memory_setup(void)
 }
 
 /*
- * Machine specific memory setup for auto-translated guests.
- */
-char * __init xen_auto_xlated_memory_setup(void)
-{
-	struct xen_memory_map memmap;
-	int i;
-	int rc;
-
-	memmap.nr_entries = ARRAY_SIZE(xen_e820_table.entries);
-	set_xen_guest_handle(memmap.buffer, xen_e820_table.entries);
-
-	rc = HYPERVISOR_memory_op(XENMEM_memory_map, &memmap);
-	if (rc < 0)
-		panic("No memory map (%d)\n", rc);
-
-	xen_e820_table.nr_entries = memmap.nr_entries;
-
-	e820__update_table(&xen_e820_table);
-
-	for (i = 0; i < xen_e820_table.nr_entries; i++)
-		e820__range_add(xen_e820_table.entries[i].addr, xen_e820_table.entries[i].size, xen_e820_table.entries[i].type);
-
-	/* Remove p2m info, it is not needed. */
-	xen_start_info->mfn_list = 0;
-	xen_start_info->first_p2m_pfn = 0;
-	xen_start_info->nr_p2m_frames = 0;
-
-	return "Xen";
-}
-
-/*
  * Set the bit indicating "nosegneg" library variants should be used.
  * We only need to bother in pure 32-bit mode; compat 32-bit processes
  * can have un-truncated segments, so wrapping around is allowed.
diff --git a/arch/x86/xen/xen-ops.h b/arch/x86/xen/xen-ops.h
index e78684597f57..0e60bd918695 100644
--- a/arch/x86/xen/xen-ops.h
+++ b/arch/x86/xen/xen-ops.h
@@ -50,7 +50,6 @@ void __init xen_inv_extra_mem(void);
 void __init xen_remap_memory(void);
 phys_addr_t __init xen_find_free_area(phys_addr_t size);
 char * __init xen_memory_setup(void);
-char * xen_auto_xlated_memory_setup(void);
 void __init xen_arch_setup(void);
 void xen_enable_sysenter(void);
 void xen_enable_syscall(void);
-- 
2.13.7

