Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934453AbeCGWzr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 17:55:47 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:38556 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933533AbeCGWzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 17:55:46 -0500
Date: Wed, 7 Mar 2018 14:55:44 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Toshi Kani <toshi.kani@hpe.com>
Cc: mhocko@suse.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        bp@suse.de, catalin.marinas@arm.com, guohanjun@huawei.com,
        will.deacon@arm.com, wxf.wang@hisilicon.com, linux-mm@kvack.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/vmalloc: Add interfaces to free unused page
 table
Message-Id: <20180307145544.b4199a0d5631012a92d625e4@linux-foundation.org>
In-Reply-To: <20180307183227.17983-2-toshi.kani@hpe.com>
References: <20180307183227.17983-1-toshi.kani@hpe.com>
        <20180307183227.17983-2-toshi.kani@hpe.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  7 Mar 2018 11:32:26 -0700 Toshi Kani <toshi.kani@hpe.com> wrote:

> On architectures with CONFIG_HAVE_ARCH_HUGE_VMAP set, ioremap()
> may create pud/pmd mappings.  Kernel panic was observed on arm64
> systems with Cortex-A75 in the following steps as described by
> Hanjun Guo.
> 
> 1. ioremap a 4K size, valid page table will build,
> 2. iounmap it, pte0 will set to 0;
> 3. ioremap the same address with 2M size, pgd/pmd is unchanged,
>    then set the a new value for pmd;
> 4. pte0 is leaked;
> 5. CPU may meet exception because the old pmd is still in TLB,
>    which will lead to kernel panic.
> 
> This panic is not reproducible on x86.  INVLPG, called from iounmap,
> purges all levels of entries associated with purged address on x86.
> x86 still has memory leak.
> 
> Add two interfaces, pud_free_pmd_page() and pmd_free_pte_page(),
> which clear a given pud/pmd entry and free up a page for the lower
> level entries.
> 
> This patch implements their stub functions on x86 and arm64, which
> work as workaround.

Also, as this fixes an arm64 kernel panic, should we be using cc:stable?
