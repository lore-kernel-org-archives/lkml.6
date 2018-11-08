Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACFD9ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 671382147A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXUTmTUD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 671382147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733048AbeKIHsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:48:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:42076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730929AbeKIHsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:48:01 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBA132147D;
        Thu,  8 Nov 2018 22:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541715030;
        bh=DAKxtlLfhicPPRa1cqw0vFEjY6al64YV1NcrjXwZruY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VXUTmTUD21+ee0U4/g4fGbtO+RF4WPox0fuGi29d74m+GFiIU2iIqoPsjOtQ4CBLy
         LBtZGRh3kVAnS1yJ4HjI/r43/7Ti2RORi8dx7ZkNmkcaG0IhgkbEgRMYODCSPsLjOa
         LO9cwoj6RkFEnrJrtESvydUTzTHrqqnXAitD0gxA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthew Whitehead <tedheadster@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>, konrad.wilk@oracle.com,
        iommu@lists.linux-foundation.org, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.18 33/34] x86/swiotlb: Enable swiotlb for > 4GiG RAM on 32-bit kernels
Date:   Thu,  8 Nov 2018 13:53:02 -0800
Message-Id: <20181108215140.924758534@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215138.892971755@linuxfoundation.org>
References: <20181108215138.892971755@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christoph Hellwig <hch@lst.de>

commit 485734f3fc77c1eb77ffe138c027b9a4bf0178f3 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/pci-swiotlb.c |    2 --
 1 file changed, 2 deletions(-)

--- a/arch/x86/kernel/pci-swiotlb.c
+++ b/arch/x86/kernel/pci-swiotlb.c
@@ -42,10 +42,8 @@ IOMMU_INIT_FINISH(pci_swiotlb_detect_ove
 int __init pci_swiotlb_detect_4gb(void)
 {
 	/* don't initialize swiotlb if iommu=off (no_iommu=1) */
-#ifdef CONFIG_X86_64
 	if (!no_iommu && max_possible_pfn > MAX_DMA32_PFN)
 		swiotlb = 1;
-#endif
 
 	/*
 	 * If SME is active then swiotlb will be set to 1 so that bounce


