Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89F5C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9604620880
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:05:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9604620880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730995AbeISOmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 10:42:09 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46079 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727770AbeISOmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 10:42:09 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4DE785ADFD14B;
        Wed, 19 Sep 2018 17:05:09 +0800 (CST)
Received: from localhost (10.202.226.46) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.399.0; Wed, 19 Sep 2018
 17:05:03 +0800
Date:   Wed, 19 Sep 2018 10:04:49 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
CC:     <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@suse.com>,
        Paul Burton <paul.burton@mips.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, <linux-ia64@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <linuxppc-dev@lists.ozlabs.org>,
        <sparclinux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: Re: [RFC PATCH 03/29] mm: remove CONFIG_HAVE_MEMBLOCK
Message-ID: <20180919100449.00006df9@huawei.com>
In-Reply-To: <1536163184-26356-4-git-send-email-rppt@linux.vnet.ibm.com>
References: <1536163184-26356-1-git-send-email-rppt@linux.vnet.ibm.com>
        <1536163184-26356-4-git-send-email-rppt@linux.vnet.ibm.com>
Organization: Huawei
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.46]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Sep 2018 18:59:18 +0300
Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:

> All architecures use memblock for early memory management. There is no need
> for the CONFIG_HAVE_MEMBLOCK configuration option.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>

Hi Mike,

A minor editing issue in here that is stopping boot on arm64 platforms with latest
version of the mm tree.

> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 76c83c1..bd841bb 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -1115,13 +1115,11 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
>  	return 1;
>  }
>  
> -#ifdef CONFIG_HAVE_MEMBLOCK
>  #ifndef MIN_MEMBLOCK_ADDR
>  #define MIN_MEMBLOCK_ADDR	__pa(PAGE_OFFSET)
>  #endif
>  #ifndef MAX_MEMBLOCK_ADDR
>  #define MAX_MEMBLOCK_ADDR	((phys_addr_t)~0)
> -#endif

This isn't the right #endif. It is matching with the #ifndef MAX_MEMBLOCK_ADDR
not the intented #ifdef CONFIG_HAVE_MEMBLOCK.

Now I haven't chased through the exact reason this is causing my acpi
arm64 system not to boot on the basis it is obviously miss-matched anyway
and I'm inherently lazy.  It's resulting in stubs replacing the following weak
functions.

early_init_dt_add_memory_arch
(this is defined elsewhere for some architectures but not arm)

early_init_dt_mark_hotplug_memory_arch
(there is only one definition of this in the kernel so it doesn't
 need to be weak or in the header etc).

early_init_dt_reserve_memory_arch
(defined on mips but nothing else)

Taking out the right endif also lets you drop an #else removing some stub
functions further down in here.

Nice cleanup in general btw.

Thanks,

Jonathan
>  
>  void __init __weak early_init_dt_add_memory_arch(u64 base, u64 size)
>  {

