Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722E7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 04:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EA04217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 04:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfBSEVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 23:21:10 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40144 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbfBSEVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 23:21:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93488EBD;
        Mon, 18 Feb 2019 20:21:07 -0800 (PST)
Received: from [10.162.40.139] (p8cg001049571a15.blr.arm.com [10.162.40.139])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B102B3F675;
        Mon, 18 Feb 2019 20:20:57 -0800 (PST)
Subject: Re: [PATCH v2 1/3] arm64: mm: use appropriate ctors for page tables
To:     Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Jun Yao <yaojun8558363@gmail.com>,
        Laura Abbott <labbott@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
References: <20190214211642.2200-1-yuzhao@google.com>
 <20190218231319.178224-1-yuzhao@google.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <863acc9a-53fb-86ad-4521-828ee8d9c222@arm.com>
Date:   Tue, 19 Feb 2019 09:51:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190218231319.178224-1-yuzhao@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/19/2019 04:43 AM, Yu Zhao wrote:
> For pte page, use pgtable_page_ctor(); for pmd page, use
> pgtable_pmd_page_ctor() if not folded; and for the rest (pud,
> p4d and pgd), don't use any.
pgtable_page_ctor()/dtor() is not optional for any level page table page
as it determines the struct page state and zone statistics. We should not
skip it for any page table page. As stated before pgtable_pmd_page_ctor()
is not a replacement for pgtable_page_ctor().
