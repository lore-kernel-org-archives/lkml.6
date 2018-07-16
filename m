Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E9DECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFAF920864
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:38:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFAF920864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732199AbeGPIEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:04:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46892 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729883AbeGPIEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:04:21 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 610E5CA1;
        Mon, 16 Jul 2018 07:38:20 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Tatashin <pasha.tatashin@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.17 32/67] mm: zero unavailable pages before memmap init
Date:   Mon, 16 Jul 2018 09:35:01 +0200
Message-Id: <20180716073448.234284402@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716073443.294323458@linuxfoundation.org>
References: <20180716073443.294323458@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pavel Tatashin <pasha.tatashin@oracle.com>

commit e181ae0c5db9544de9c53239eb22bc012ce75033 upstream.

We must zero struct pages for memory that is not backed by physical
memory, or kernel does not have access to.

Recently, there was a change which zeroed all memmap for all holes in
e820.  Unfortunately, it introduced a bug that is discussed here:

  https://www.spinics.net/lists/linux-mm/msg156764.html

Linus, also saw this bug on his machine, and confirmed that reverting
commit 124049decbb1 ("x86/e820: put !E820_TYPE_RAM regions into
memblock.reserved") fixes the issue.

The problem is that we incorrectly zero some struct pages after they
were setup.

The fix is to zero unavailable struct pages prior to initializing of
struct pages.

A more detailed fix should come later that would avoid double zeroing
cases: one in __init_single_page(), the other one in
zero_resv_unavail().

Fixes: 124049decbb1 ("x86/e820: put !E820_TYPE_RAM regions into memblock.reserved")
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/page_alloc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6841,6 +6841,7 @@ void __init free_area_init_nodes(unsigne
 	/* Initialise every node */
 	mminit_verify_pageflags_layout();
 	setup_nr_node_ids();
+	zero_resv_unavail();
 	for_each_online_node(nid) {
 		pg_data_t *pgdat = NODE_DATA(nid);
 		free_area_init_node(nid, NULL,
@@ -6851,7 +6852,6 @@ void __init free_area_init_nodes(unsigne
 			node_set_state(nid, N_MEMORY);
 		check_for_memory(pgdat, nid);
 	}
-	zero_resv_unavail();
 }
 
 static int __init cmdline_parse_core(char *p, unsigned long *core,
@@ -7027,9 +7027,9 @@ void __init set_dma_reserve(unsigned lon
 
 void __init free_area_init(unsigned long *zones_size)
 {
+	zero_resv_unavail();
 	free_area_init_node(0, zones_size,
 			__pa(PAGE_OFFSET) >> PAGE_SHIFT, NULL);
-	zero_resv_unavail();
 }
 
 static int page_alloc_cpu_dead(unsigned int cpu)


