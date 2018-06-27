Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F213C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53442253D6
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:56:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53442253D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934946AbeF0Pz6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 11:55:58 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33660 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934746AbeF0Pz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 11:55:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F60018A;
        Wed, 27 Jun 2018 08:55:55 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 603133F318;
        Wed, 27 Jun 2018 08:55:55 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 45FC71AE3692; Wed, 27 Jun 2018 16:56:33 +0100 (BST)
Date:   Wed, 27 Jun 2018 16:56:33 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Toshi Kani <toshi.kani@hpe.com>
Cc:     mhocko@suse.com, akpm@linux-foundation.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, cpandya@codeaurora.org,
        linux-mm@kvack.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>, stable@vger.kernel.org
Subject: Re: [PATCH v4 2/3] ioremap: Update pgtable free interfaces with addr
Message-ID: <20180627155632.GH30631@arm.com>
References: <20180627141348.21777-1-toshi.kani@hpe.com>
 <20180627141348.21777-3-toshi.kani@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627141348.21777-3-toshi.kani@hpe.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Toshi,

On Wed, Jun 27, 2018 at 08:13:47AM -0600, Toshi Kani wrote:
> From: Chintan Pandya <cpandya@codeaurora.org>
> 
> The following kernel panic was observed on ARM64 platform due to a stale
> TLB entry.
> 
>  1. ioremap with 4K size, a valid pte page table is set.
>  2. iounmap it, its pte entry is set to 0.
>  3. ioremap the same address with 2M size, update its pmd entry with
>     a new value.
>  4. CPU may hit an exception because the old pmd entry is still in TLB,
>     which leads to a kernel panic.
> 
> Commit b6bdb7517c3d ("mm/vmalloc: add interfaces to free unmapped page
> table") has addressed this panic by falling to pte mappings in the above
> case on ARM64.
> 
> To support pmd mappings in all cases, TLB purge needs to be performed
> in this case on ARM64.
> 
> Add a new arg, 'addr', to pud_free_pmd_page() and pmd_free_pte_page()
> so that TLB purge can be added later in seprate patches.

So I acked v13 of Chintan's series posted here:

http://lists.infradead.org/pipermail/linux-arm-kernel/2018-June/582953.html

any chance this lot could all be merged together, please?

Will
