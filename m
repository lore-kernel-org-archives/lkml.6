Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A257C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC22E2089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qcTdmJno"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC22E2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbeJIDCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 23:02:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33456 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeJIDCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 23:02:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9+hibdFJ7f+QzvvL8Y657U7dz0koWuYGCzJ6Awvw590=; b=qcTdmJnojkMpi+YOOsp/yTxyZ
        w4SqVOpTxeV8UCe07T4RjzQyn1UUslnU9wplLB74oAOZzxffXFurGknbMAuw8nb2jI+7BJtU7yutv
        FrmtBaWlBwDA/AXopenIx0KdoaqDSEveyAfW5AwKvosXMT+mdKiy8FgPV6TL3axw9ZCZv+QK8g80e
        EL/U5vIP38RWQzuWLxGZD/R8N3Kwng7qBr3q1xswAjdXbm5ZiKkCN13+Gk2hHFVCpHeykPIvLu5bp
        pdAh0YKVHeDgXVCUh68GJ7pfuhQXKaITFLq8WwHIjn3mRxnJ877W/qxPUy4aWxSmvOkE40p6NZIfa
        G1kOcoVhg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g9bWl-0006nu-Js; Mon, 08 Oct 2018 19:49:15 +0000
Subject: Re: [PATCH v2] Documentation/arm64: HugeTLB page implementation
To:     Punit Agrawal <punit.agrawal@arm.com>, linux-doc@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        steve.capper@arm.com, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Jonathan Corbet <corbet@lwn.net>
References: <97e4e5fb-24ed-0545-414a-6a0c0116e6b8@infradead.org>
 <20181008100355.31820-1-punit.agrawal@arm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <67f4ceb7-d41c-ab7a-4d5e-c147dadf6860@infradead.org>
Date:   Mon, 8 Oct 2018 12:49:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181008100355.31820-1-punit.agrawal@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/18 3:03 AM, Punit Agrawal wrote:
> Arm v8 architecture supports multiple page sizes - 4k, 16k and
> 64k. Based on the active page size, the Linux port supports
> corresponding hugepage sizes at PMD and PUD(4k only) levels.
> 
> In addition, the architecture also supports caching larger sized
> ranges (composed of multiple entries) at the PTE and PMD level in the
> TLBs using the contiguous bit. The Linux port makes use of this
> architectural support to enable additional hugepage sizes.
> 
> Describe the two different types of hugepages supported by the arm64
> kernel and the hugepage sizes enabled by each.
> 
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Jonathan Corbet <corbet@lwn.net>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> Hi,
> 
> This version incorporates the feedback on v1.
> 
> Thanks,
> Punit
> 
>  Documentation/arm64/hugetlbpage.txt | 38 +++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/arm64/hugetlbpage.txt
> 
> diff --git a/Documentation/arm64/hugetlbpage.txt b/Documentation/arm64/hugetlbpage.txt
> new file mode 100644
> index 000000000000..cfae87dc653b
> --- /dev/null
> +++ b/Documentation/arm64/hugetlbpage.txt
> @@ -0,0 +1,38 @@
> +HugeTLBpage on ARM64
> +====================
> +
> +Hugepage relies on making efficient use of TLBs to improve performance of
> +address translations. The benefit depends on both -
> +
> +  - the size of hugepages
> +  - size of entries supported by the TLBs
> +
> +The ARM64 port supports two flavours of hugepages.
> +
> +1) Block mappings at the pud/pmd level
> +--------------------------------------
> +
> +These are regular hugepages where a pmd or a pud page table entry points to a
> +block of memory. Regardless of the supported size of entries in TLB, block
> +mappings reduce the depth of page table walk needed to translate hugepage
> +addresses.
> +
> +2) Using the Contiguous bit
> +---------------------------
> +
> +The architecture provides a contiguous bit in the translation table entries
> +(D4.5.3, ARM DDI 0487C.a) that hints to the MMU to indicate that it is one of a
> +contiguous set of entries that can be cached in a single TLB entry.
> +
> +The contiguous bit is used in Linux to increase the mapping size at the pmd and
> +pte (last) level. The number of supported contiguous entries varies by page size
> +and level of the page table.
> +
> +
> +The following hugepage sizes are supported -
> +
> +         CONT PTE    PMD    CONT PMD    PUD
> +         --------    ---    --------    ---
> +  4K:         64K     2M         32M     1G
> +  16K:         2M    32M          1G
> +  64K:         2M   512M         16G
> 


-- 
~Randy
