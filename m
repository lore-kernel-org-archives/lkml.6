Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755341AbeE3E7c (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 00:59:32 -0400
Received: from 8bytes.org ([81.169.241.247]:41352 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754955AbeE3E73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 00:59:29 -0400
Date: Wed, 30 May 2018 06:59:27 +0200
From: "joro@8bytes.org" <joro@8bytes.org>
To: "Kani, Toshi" <toshi.kani@hpe.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "cpandya@codeaurora.org" <cpandya@codeaurora.org>,
        "Hocko, Michal" <MHocko@suse.com>
Subject: Re: [PATCH v3 3/3] x86/mm: add TLB purge to free pmd/pte page
 interfaces
Message-ID: <20180530045927.GP18595@8bytes.org>
References: <20180516233207.1580-1-toshi.kani@hpe.com>
 <20180516233207.1580-4-toshi.kani@hpe.com>
 <20180529144438.GM18595@8bytes.org>
 <1527610139.14039.58.camel@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527610139.14039.58.camel@hpe.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 04:10:24PM +0000, Kani, Toshi wrote:
> Can you explain why you think allocating a page here is a major problem?

Because a larger allocation is more likely to fail. And if you fail the
allocation, you also fail to free more pages, which _is_ a problem. So
better avoid any allocations in code paths that are about freeing
memory.

> If we just revert, please apply patch 1/3 first.  This patch address the
> BUG_ON issue on PAE.  This is a real issue that needs a fix ASAP.

It does not address the problem of dirty page-walk caches on x86-64.

> The page-directory cache issue on x64, which is addressed by patch 3/3,
> is a theoretical issue that I could not hit by putting ioremap() calls
> into a loop for a whole day.  Nobody hit this issue, either.

How do you know you didn't hit that issue? It might cause silent data
corruption, which might not be easily detected.

> The simple revert patch Joerg posted a while ago causes
> pmd_free_pte_page() to fail on x64.  This causes multiple pmd mappings
> to fall into pte mappings on my test systems.  This can be seen as a
> degradation, and I am afraid that it is more harmful than good.

The plain revert just removes all the issues with the dirty TLB that the
original patch introduced and prevents huge mappings from being
established when there have been smaller mappings before. This is not
ideal, but at least its is consistent and does not leak pages and leaves
no dirty TLBs. So this is the easiest and most reliable fix for this
stage in the release process.


Regards,

	Joerg
