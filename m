Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189EDC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3D83205F4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:00:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3D83205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933809AbeGBKAY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 06:00:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:34430 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932105AbeGBKAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 06:00:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8B924AED7;
        Mon,  2 Jul 2018 10:00:21 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org
Cc:     boris.ostrovsky@oracle.com, hpa@zytor.com, tglx@linutronix.de,
        mingo@redhat.com, Juergen Gross <jgross@suse.com>,
        stable@vger.kernel.org
Subject: [PATCH] xen: remove global bit from __default_kernel_pte_mask for pv guests
Date:   Mon,  2 Jul 2018 12:00:18 +0200
Message-Id: <20180702100018.26279-1-jgross@suse.com>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When removing the global bit from __supported_pte_mask do the same for
__default_kernel_pte_mask in order to avoid the WARN_ONCE() in
check_pgprot() when setting a kernel pte before having called
init_mem_mapping().

Cc: <stable@vger.kernel.org> # 4.17
Reported-by: Michael Young <m.a.young@durham.ac.uk>
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/xen/enlighten_pv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 0f4cd9e5bed4..cf7b13d3e911 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1230,6 +1230,7 @@ asmlinkage __visible void __init xen_start_kernel(void)
 
 	/* Prevent unwanted bits from being set in PTEs. */
 	__supported_pte_mask &= ~_PAGE_GLOBAL;
+	__default_kernel_pte_mask &= ~_PAGE_GLOBAL;
 
 	/*
 	 * Prevent page tables from being allocated in highmem, even
-- 
2.13.7

