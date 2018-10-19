Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174ADECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 05:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D89A421470
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 05:55:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D89A421470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbeJSN7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 09:59:33 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50435 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbeJSN7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 09:59:33 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9J5so3J1121917
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 18 Oct 2018 22:54:50 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9J5snYS1121914;
        Thu, 18 Oct 2018 22:54:49 -0700
Date:   Thu, 18 Oct 2018 22:54:49 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Christoph Hellwig <tipbot@zytor.com>
Message-ID: <tip-485734f3fc77c1eb77ffe138c027b9a4bf0178f3@git.kernel.org>
Cc:     hch@lst.de, mingo@kernel.org, tedheadster@gmail.com, hpa@zytor.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
          mingo@kernel.org, hch@lst.de, tedheadster@gmail.com
In-Reply-To: <20181014075208.2715-1-hch@lst.de>
References: <20181014075208.2715-1-hch@lst.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/swiotlb: Enable swiotlb for > 4GiG RAM on
 32-bit kernels
Git-Commit-ID: 485734f3fc77c1eb77ffe138c027b9a4bf0178f3
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

Commit-ID:  485734f3fc77c1eb77ffe138c027b9a4bf0178f3
Gitweb:     https://git.kernel.org/tip/485734f3fc77c1eb77ffe138c027b9a4bf0178f3
Author:     Christoph Hellwig <hch@lst.de>
AuthorDate: Sun, 14 Oct 2018 09:52:08 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 19 Oct 2018 07:49:32 +0200

x86/swiotlb: Enable swiotlb for > 4GiG RAM on 32-bit kernels

We already build the swiotlb code for 32-bit kernels with PAE support,
but the code to actually use swiotlb has only been enabled for 64-bit
kernels for an unknown reason.

Before Linux v4.18 we paper over this fact because the networking code,
the SCSI layer and some random block drivers implemented their own
bounce buffering scheme.

[ mingo: Changelog fixes. ]

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
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
