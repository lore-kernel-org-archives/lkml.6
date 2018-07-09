Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B5FC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D17A12089B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:50:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D17A12089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754559AbeGIOts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 10:49:48 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60546 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754516AbeGIOtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 10:49:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE47EED1;
        Mon,  9 Jul 2018 07:49:45 -0700 (PDT)
Received: from localhost (e105922-lin.cambridge.arm.com [10.1.206.33])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 92E283F589;
        Mon,  9 Jul 2018 07:49:45 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@arm.com>
To:     <kvmarm@lists.cs.columbia.edu>
Cc:     <linux-arm-kernel@lists.infradead.org>, <marc.zyngier@arm.com>,
        <christoffer.dall@arm.com>, <linux-kernel@vger.kernel.org>,
        <suzuki.poulose@arm.com>, <will.deacon@arm.com>
Subject: Re: [PATCH v5 0/7] KVM: Support PUD hugepages at stage 2
References: <20180709143835.28971-1-punit.agrawal@arm.com>
        <20180709143835.28971-2-punit.agrawal@arm.com>
Date:   Mon, 09 Jul 2018 15:49:44 +0100
In-Reply-To: <20180709143835.28971-2-punit.agrawal@arm.com> (Punit Agrawal's
        message of "Mon, 9 Jul 2018 15:38:28 +0100")
Message-ID: <871sccqx9z.fsf@e105922-lin.cambridge.arm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please ignore this cover letter.

Apologies for the duplicate cover-letter and a somewhat funky threading
(I blame emacs unsaved buffer).

The patches appear to be intact so don't let the threading get in the
way of review.

Punit Agrawal <punit.agrawal@arm.com> writes:

> This series is an update to the PUD hugepage support previously posted
> at [0]. This patchset adds support for PUD hugepages at stage
> 2. This feature is useful on cores that have support for large sized
> TLB mappings (e.g., 1GB for 4K granule).
>
> The biggest change in this version is to replace repeated instances of
> walking the page tables to get to a leaf-entry with a function to
> return the appropriate entry. This was suggested by Suzuki and should
> help reduce the amount of churn resulting from future changes. It also
> address other feedback on the previous version.
>
> Support is added to code that is shared between arm and arm64. Dummy
> helpers for arm are provided as the port does not support PUD hugepage
> sizes.
>
> The patches have been tested on an A57 based system. The patchset is
> based on v4.18-rc4. The are a few conflicts with the support for 52
> bit IPA[1] due to change in number of parameters for
> stage2_pmd_offset().
>
> Thanks,
> Punit
>
> v4 -> v5:
>
> * Patch 1 - Drop helper stage2_should_exec() and refactor the
>   condition to decide if a page table entry should be marked
>   executable
> * Patch 4-6 - Introduce stage2_get_leaf_entry() and use it in this and
>   latter patches
> * Patch 7 - Use stage 2 accessors instead of using the page table
>   helpers directly
> * Patch 7 - Add a note to update the PUD hugepage support when number
>   of levels of stage 2 tables differs from stage 1
>
>
> v3 -> v4:
> * Patch 1 and 7 - Don't put down hugepages pte if logging is enabled
> * Patch 4-5 - Add PUD hugepage support for exec and access faults
> * Patch 6 - PUD hugepage support for aging page table entries
>
> v2 -> v3:
> * Update vma_pagesize directly if THP [1/4]. Previsouly this was done
>   indirectly via hugetlb
> * Added review tag [4/4]
>
> v1 -> v2:
> * Create helper to check if the page should have exec permission [1/4]
> * Fix broken condition to detect THP hugepage [1/4]
> * Fix in-correct hunk resulting from a rebase [4/4]
>
> [0] https://www.spinics.net/lists/arm-kernel/msg663562.html
> [1] https://www.spinics.net/lists/kvm/msg171065.html
>
>
> Punit Agrawal (7):
>   KVM: arm/arm64: Share common code in user_mem_abort()
>   KVM: arm/arm64: Introduce helpers to manupulate page table entries
>   KVM: arm64: Support dirty page tracking for PUD hugepages
>   KVM: arm64: Support PUD hugepage in stage2_is_exec()
>   KVM: arm64: Support handling access faults for PUD hugepages
>   KVM: arm64: Update age handlers to support PUD hugepages
>   KVM: arm64: Add support for creating PUD hugepages at stage 2
>
>  arch/arm/include/asm/kvm_mmu.h         |  60 +++++
>  arch/arm64/include/asm/kvm_mmu.h       |  47 ++++
>  arch/arm64/include/asm/pgtable-hwdef.h |   4 +
>  arch/arm64/include/asm/pgtable.h       |   9 +
>  virt/kvm/arm/mmu.c                     | 289 ++++++++++++++++++-------
>  5 files changed, 330 insertions(+), 79 deletions(-)
