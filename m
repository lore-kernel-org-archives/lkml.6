Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5777DC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 20:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CEFD20659
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 20:21:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CEFD20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbeJLDuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 23:50:25 -0400
Received: from ale.deltatee.com ([207.54.116.67]:60680 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbeJLDuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 23:50:25 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1gAhSR-0004GP-Bp; Thu, 11 Oct 2018 14:21:20 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Rob Herring <robh@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Waterman <andrew@sifive.com>, linux-sh@vger.kernel.org,
        Palmer Dabbelt <palmer@sifive.com>,
        linux-kernel@vger.kernel.org, Stephen Bates <sbates@raithlin.com>,
        Zong Li <zong@andestech.com>, linux-mm@kvack.org,
        Olof Johansson <olof@lixom.net>,
        linux-riscv@lists.infradead.org,
        Michael Clark <michaeljclark@mac.com>,
        linux-arm-kernel@lists.infradead.org
References: <20181005161642.2462-1-logang@deltatee.com>
 <20181005161642.2462-6-logang@deltatee.com> <20181011133730.GB7276@lst.de>
 <8cea5ffa-5fbf-8ea2-b673-20e2d09a910d@deltatee.com>
 <83cfd2d7-b840-b0c6-594e-8b39be8177c1@deltatee.com>
Message-ID: <cfb2af87-7e47-539c-d149-2599f23b663a@deltatee.com>
Date:   Thu, 11 Oct 2018 14:21:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <83cfd2d7-b840-b0c6-594e-8b39be8177c1@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, michaeljclark@mac.com, linux-riscv@lists.infradead.org, olof@lixom.net, linux-mm@kvack.org, zong@andestech.com, sbates@raithlin.com, linux-kernel@vger.kernel.org, palmer@sifive.com, linux-sh@vger.kernel.org, andrew@sifive.com, aou@eecs.berkeley.edu, robh@kernel.org, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 5/5] RISC-V: Implement sparsemem
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018-10-11 12:45 p.m., Logan Gunthorpe wrote:
> Ok, I spoke too soon...
> 
> Having this define next to the struct page definition works great for
> riscv. However, making that happen in arm64 seems to be a nightmare. The
> include chain in arm64 is tangled up so much that including mm_types
> where this is needed seems to be extremely difficult.

Sorry for all the unnecessary churn but I've figured it out. Just had to
realize we only need mm_types.h to be included where
STRUCT_PAGE_MAX_SHIFT is finally expanded. Thus we only need it in one
more spot (fixmap.h). See below.

Thanks,

Logan

--


diff --git a/arch/arm64/include/asm/memory.h
b/arch/arm64/include/asm/memory.h
index b96442960aea..f0a5c9531e8b 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -34,15 +34,6 @@
  */
 #define PCI_IO_SIZE            SZ_16M

-/*
- * Log2 of the upper bound of the size of a struct page. Used for sizing
- * the vmemmap region only, does not affect actual memory footprint.
- * We don't use sizeof(struct page) directly since taking its size here
- * requires its definition to be available at this point in the inclusion
- * chain, and it may not be a power of 2 in the first place.
- */
-#define STRUCT_PAGE_MAX_SHIFT  6
-
 /*
  * VMEMMAP_SIZE - allows the whole linear region to be covered by
  *                a struct page array
diff --git a/include/asm-generic/fixmap.h b/include/asm-generic/fixmap.h
index 827e4d3bbc7a..8cc7b09c1bc7 100644
--- a/include/asm-generic/fixmap.h
+++ b/include/asm-generic/fixmap.h
@@ -16,6 +16,7 @@
 #define __ASM_GENERIC_FIXMAP_H

 #include <linux/bug.h>
+#include <linux/mm_types.h>

 #define __fix_to_virt(x)       (FIXADDR_TOP - ((x) << PAGE_SHIFT))
 #define __virt_to_fix(x)       ((FIXADDR_TOP - ((x)&PAGE_MASK)) >>
PAGE_SHIFT)
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5ed8f6292a53..d1c3cde8c201 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -206,6 +206,11 @@ struct page {
 #endif
 } _struct_page_alignment;

+/*
+ * Used for sizing the vmemmap region on some architectures.
+ */
+#define STRUCT_PAGE_MAX_SHIFT  ilog2(roundup_pow_of_two(sizeof(struct
page)))
+
 #define PAGE_FRAG_CACHE_MAX_SIZE       __ALIGN_MASK(32768, ~PAGE_MASK)
 #define PAGE_FRAG_CACHE_MAX_ORDER      get_order(PAGE_FRAG_CACHE_MAX_SIZE)
