Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA62C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF18120835
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:02:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF18120835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbeJIRSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 13:18:12 -0400
Received: from foss.arm.com ([217.140.101.70]:35002 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbeJIRSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 13:18:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B17CED1;
        Tue,  9 Oct 2018 03:02:03 -0700 (PDT)
Received: from localhost (e105922-lin.cambridge.arm.com [10.1.197.25])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF5163F5D3;
        Tue,  9 Oct 2018 03:02:02 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@arm.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, steve.capper@arm.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2] Documentation/arm64: HugeTLB page implementation
References: <97e4e5fb-24ed-0545-414a-6a0c0116e6b8@infradead.org>
        <20181008100355.31820-1-punit.agrawal@arm.com>
        <67f4ceb7-d41c-ab7a-4d5e-c147dadf6860@infradead.org>
Date:   Tue, 09 Oct 2018 11:02:01 +0100
In-Reply-To: <67f4ceb7-d41c-ab7a-4d5e-c147dadf6860@infradead.org> (Randy
        Dunlap's message of "Mon, 8 Oct 2018 12:49:13 -0700")
Message-ID: <87ftxf7812.fsf@e105922-lin.cambridge.arm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:

> On 10/8/18 3:03 AM, Punit Agrawal wrote:
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
>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks!

Catalin, Will - I assume you'll pick this up at some point? Or do arm64
documentation patches get routed by another tree?

>
> Thanks.
>
>> ---
>> Hi,
>> 
>> This version incorporates the feedback on v1.
>> 
>> Thanks,
>> Punit
>> 
>>  Documentation/arm64/hugetlbpage.txt | 38 +++++++++++++++++++++++++++++
>>  1 file changed, 38 insertions(+)
>>  create mode 100644 Documentation/arm64/hugetlbpage.txt
>> 
>> diff --git a/Documentation/arm64/hugetlbpage.txt b/Documentation/arm64/hugetlbpage.txt
>> new file mode 100644
>> index 000000000000..cfae87dc653b
>> --- /dev/null
>> +++ b/Documentation/arm64/hugetlbpage.txt
>> @@ -0,0 +1,38 @@
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
>> +mappings reduce the depth of page table walk needed to translate hugepage
>> +addresses.
>> +
>> +2) Using the Contiguous bit
>> +---------------------------
>> +
>> +The architecture provides a contiguous bit in the translation table entries
>> +(D4.5.3, ARM DDI 0487C.a) that hints to the MMU to indicate that it is one of a
>> +contiguous set of entries that can be cached in a single TLB entry.
>> +
>> +The contiguous bit is used in Linux to increase the mapping size at the pmd and
>> +pte (last) level. The number of supported contiguous entries varies by page size
>> +and level of the page table.
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
