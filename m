Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF24C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E37C20850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:57:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E37C20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbeLET5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:57:10 -0500
Received: from foss.arm.com ([217.140.101.70]:34456 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728269AbeLET5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:57:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57ADA80D;
        Wed,  5 Dec 2018 11:57:09 -0800 (PST)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 443013F614;
        Wed,  5 Dec 2018 11:57:07 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     hch@lst.de
Cc:     m.szyprowski@samsung.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, cai@gmx.us, salil.mehta@huawei.com,
        john.garry@huawei.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [PATCH v2 0/8] dma-debug cleanup and dynamic allocation
Date:   Wed,  5 Dec 2018 19:56:49 +0000
Message-Id: <cover.1544037783.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.19.1.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here's some assorted cleanup and improvements to dma-debug which grew
out of the problem that certain drivers use very large numbers of DMA
mappings, and knowing when to override "dma_debug_entries=..." and what
value to override it with can be a less-than-obvious task for users.

The main part is patches #3 and #4, wherein we make dma-debug clever
enough to allocate more entries dynamically if needed, such that the
preallocation value becomes more of a quality-of-life option than a
necessity. Patches #6 and #7 do some cruft-removal to allow patch #8
to make the allocation behaviour more efficient in general.

Patches #1, #2 and #5 are some other cleanup and handy features which
fell out of the discussion/development.

Robin.


Robin Murphy (8):
  dma-debug: Use pr_fmt()
  dma-debug: Expose nr_total_entries in debugfs
  dma-debug: Refactor dma_debug_entry allocation
  dma-debug: Dynamically expand the dma_debug_entry pool
  dma-debug: Make leak-like behaviour apparent
  x86/dma/amd-gart: Stop resizing dma_debug_entry pool
  dma/debug: Remove dma_debug_resize_entries()
  dma-debug: Batch dma_debug_entry allocation

 Documentation/DMA-API.txt                 |  20 +-
 Documentation/x86/x86_64/boot-options.txt |   5 +-
 arch/x86/kernel/amd_gart_64.c             |  23 ---
 include/linux/dma-debug.h                 |   7 -
 kernel/dma/debug.c                        | 211 ++++++++++------------
 5 files changed, 107 insertions(+), 159 deletions(-)

-- 
2.19.1.dirty

