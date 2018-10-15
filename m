Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F16C28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 09:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FA9120853
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 09:10:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FA9120853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbeJOQyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 12:54:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52023 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbeJOQyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 12:54:24 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9F99oDY3561559
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 15 Oct 2018 02:09:50 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9F99opm3561556;
        Mon, 15 Oct 2018 02:09:50 -0700
Date:   Mon, 15 Oct 2018 02:09:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Christoph Hellwig <tipbot@zytor.com>
Message-ID: <tip-6f3bc8028570e4c326030e8795dbcd57c561b723@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, hch@lst.de, mingo@kernel.org,
        tglx@linutronix.de, tedheadster@gmail.com, hpa@zytor.com
Reply-To: tglx@linutronix.de, hpa@zytor.com, tedheadster@gmail.com,
          hch@lst.de, linux-kernel@vger.kernel.org, mingo@kernel.org
In-Reply-To: <20181014075208.2715-1-hch@lst.de>
References: <20181014075208.2715-1-hch@lst.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/swiotlb: Enable swiotlb for > 4GiG ram on
 32-bit kernels
Git-Commit-ID: 6f3bc8028570e4c326030e8795dbcd57c561b723
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  6f3bc8028570e4c326030e8795dbcd57c561b723
Gitweb:     https://git.kernel.org/tip/6f3bc8028570e4c326030e8795dbcd57c561b723
Author:     Christoph Hellwig <hch@lst.de>
AuthorDate: Sun, 14 Oct 2018 09:52:08 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 15 Oct 2018 10:55:03 +0200

x86/swiotlb: Enable swiotlb for > 4GiG ram on 32-bit kernels

We already build the swiotlb code for 32b-t kernels with PAE support,
but the code to actually use swiotlb has only been enabled for 64-bit
kernel for an unknown reason.

Before Linux 4.18 we paper over this fact because the networking code,
the scsi layer and some random block drivers implemented their own
bounce buffering scheme.

Fixes: 21e07dba9fb1 ("scsi: reduce use of block bounce buffers")
Fixes: ab74cfebafa3 ("net: remove the PCI_DMA_BUS_IS_PHYS check in illegal_highdma")
Reported-by: Matthew Whitehead <tedheadster@gmail.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Matthew Whitehead <tedheadster@gmail.com>
Cc: konrad.wilk@oracle.com
Cc: iommu@lists.linux-foundation.org
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20181014075208.2715-1-hch@lst.de
---
 arch/x86/kernel/pci-swiotlb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/kernel/pci-swiotlb.c b/arch/x86/kernel/pci-swiotlb.c
index 661583662430..71c0b01d93b1 100644
--- a/arch/x86/kernel/pci-swiotlb.c
+++ b/arch/x86/kernel/pci-swiotlb.c
@@ -42,10 +42,8 @@ IOMMU_INIT_FINISH(pci_swiotlb_detect_override,
 int __init pci_swiotlb_detect_4gb(void)
 {
 	/* don't initialize swiotlb if iommu=off (no_iommu=1) */
-#ifdef CONFIG_X86_64
 	if (!no_iommu && max_possible_pfn > MAX_DMA32_PFN)
 		swiotlb = 1;
-#endif
 
 	/*
 	 * If SME is active then swiotlb will be set to 1 so that bounce
