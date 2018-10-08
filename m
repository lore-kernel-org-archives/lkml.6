Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593A5C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 09:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 294FB20878
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 09:39:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 294FB20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbeJHQuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 12:50:01 -0400
Received: from foss.arm.com ([217.140.101.70]:46532 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbeJHQuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 12:50:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F8C67A9;
        Mon,  8 Oct 2018 02:39:12 -0700 (PDT)
Received: from localhost (e105922-lin.cambridge.arm.com [10.1.197.25])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7DB03F5D3;
        Mon,  8 Oct 2018 02:39:11 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@arm.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, steve.capper@arm.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] Documentation/arm64: HugeTLB page implementation
References: <20181005143458.17875-1-punit.agrawal@arm.com>
        <97e4e5fb-24ed-0545-414a-6a0c0116e6b8@infradead.org>
Date:   Mon, 08 Oct 2018 10:39:10 +0100
In-Reply-To: <97e4e5fb-24ed-0545-414a-6a0c0116e6b8@infradead.org> (Randy
        Dunlap's message of "Sat, 6 Oct 2018 09:30:19 -0700")
Message-ID: <871s90u69t.fsf@e105922-lin.cambridge.arm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

Randy Dunlap <rdunlap@infradead.org> writes:

> Hi,
> Just some minor stuff (below).
>
> On 10/5/18 7:34 AM, Punit Agrawal wrote:
>> Arm v8 architecture supports multiple page sizes - 4k, 16k and
>> 64k. Based on the active page size, the Linux port supports
>> corresponding hugepage sizes at PMD and PUD(4k only) levels.
>> 
>> In addition, the architecture also supports caching larger sized
>> ranges (composed of multiple entries) at the PTE and PMD level in the
>> TLBs using the contiguous bit. The Linux port makes use of this
>> architectural support to enable additional hugepage sizes.
>> 
>> Describe the two different types of hugepages supported by the arm64
>> kernel and the hugepage sizes enabled by each.
>> 
>> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> ---
>>  Documentation/arm64/hugetlbpage.txt | 39 +++++++++++++++++++++++++++++
>>  1 file changed, 39 insertions(+)
>>  create mode 100644 Documentation/arm64/hugetlbpage.txt
>> 
>> diff --git a/Documentation/arm64/hugetlbpage.txt b/Documentation/arm64/hugetlbpage.txt
>> new file mode 100644
>> index 000000000000..64ee24b88d27
>> --- /dev/null
>> +++ b/Documentation/arm64/hugetlbpage.txt
>> @@ -0,0 +1,39 @@
>> +HugeTLBpage on ARM64
>> +====================
>> +
>> +Hugepage relies on making efficient use of TLBs to improve performance of
>> +address translations. The benefit depends on both -
>> +
>> +  - the size of hugepages
>> +  - size of entries supported by the TLBs
>> +
>> +The ARM64 port supports two flavours of hugepages.
>> +
>> +1) Block mappings at the pud/pmd level
>> +--------------------------------------
>> +
>> +These are regular hugepages where a pmd or a pud page table entry points to a
>> +block of memory. Regardless of the supported size of entries in TLB, block
>> +mappings reduces the depth of page table walk needed to translate hugepage
>
>             reduce
>
>> +addresses.
>> +
>> +2) Using the Contiguous bit
>> +---------------------------
>> +
>> +The architecture provides a contiguous bit in the translation table entries
>> +(D4.5.3, ARM DDI 0487C.a) that hints to the mmu to indicate that it is one of a
>
> preferably                                     MMU
>
>> +contiguous set of entries that can be cached in a single TLB entry.
>> +
>> +The contiguous bit is used in Linux to increase the mapping size at the pmd and
>> +pte (last) level. The number of supported contiguous entries vary by page size
>
>                                                                 varies
>
>> +and level of the page table.
>> +
>> +
>> +
>> +The following hugepage sizes are supported -
>> +
>> +         CONT PTE    PMD    CONT PMD    PUD
>> +         --------    ---    --------    ---
>> +  4K:         64K     2M         32M     1G
>> +  16K:         2M    32M          1G
>> +  64K:         2M   512M         16G
>> 

I've updated the patch with incorporating your feedback and will post an
update shortly.

Thanks a lot for taking a look.

Punit
