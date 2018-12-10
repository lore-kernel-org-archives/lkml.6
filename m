Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F15EC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 334222086D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:00:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 334222086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbeLJOAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 09:00:42 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54570 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727062AbeLJOAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 09:00:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 112D61596;
        Mon, 10 Dec 2018 06:00:41 -0800 (PST)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EE37A3F575;
        Mon, 10 Dec 2018 06:00:38 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     hch@lst.de
Cc:     m.szyprowski@samsung.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, cai@gmx.us, salil.mehta@huawei.com,
        john.garry@huawei.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [PATCH v3 0/7] dma-debug cleanup and dynamic allocation
Date:   Mon, 10 Dec 2018 14:00:26 +0000
Message-Id: <cover.1544447601.git.robin.murphy@arm.com>
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

The main part is patch #4, wherein we make dma-debug clever enough
to allocate more entries dynamically if needed, such that the
preallocation value becomes more of a quality-of-life option than a
necessity. Patches #5 and #6 do some cruft-removal to allow patch #7
to make the allocation behaviour more efficient in general.

Patches #1, #2 and #4 are some other cleanup and handy features which
fell out of the discussion/development.

Robin.


Robin Murphy (7):
  dma-debug: Use pr_fmt()
  dma-debug: Expose nr_total_entries in debugfs
  dma-debug: Dynamically expand the dma_debug_entry pool
  dma-debug: Make leak-like behaviour apparent
  x86/dma/amd-gart: Stop resizing dma_debug_entry pool
  dma/debug: Remove dma_debug_resize_entries()
  dma-debug: Batch dma_debug_entry allocation

 Documentation/DMA-API.txt                 |  20 +-
 Documentation/x86/x86_64/boot-options.txt |   5 +-
 arch/x86/kernel/amd_gart_64.c             |  23 ---
 include/linux/dma-debug.h                 |   7 -
 kernel/dma/debug.c                        | 217 ++++++++++------------
 5 files changed, 109 insertions(+), 163 deletions(-)

-- 
2.19.1.dirty

