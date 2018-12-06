Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C812C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCC08208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:51:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCC08208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbeLFPvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:51:47 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53920 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbeLFPvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 10:51:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5FA880D;
        Thu,  6 Dec 2018 07:51:46 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE2253F59C;
        Thu,  6 Dec 2018 07:51:44 -0800 (PST)
Subject: Re: dmapool regression in next
To:     Tony Battersby <tonyb@cybernetics.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, tony@atomide.com
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>, john.garry@huawei.com,
        linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
        andy.shevchenko@gmail.com, akpm@linux-foundation.org,
        linux-omap@vger.kernel.org, hch@lst.de,
        linux-arm-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20181206013054.GI6707@atomide.com>
 <CAJKOXPcoK5SsXfXjdAWPHLX2KZRCqOv61HVf2DK9wm4_m+vJ0w@mail.gmail.com>
 <09e73d24-467a-52bb-0433-a9596d4d6f02@cybernetics.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <451215b8-548a-eff7-9e96-0ff5f8cbb614@arm.com>
Date:   Thu, 6 Dec 2018 15:51:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <09e73d24-467a-52bb-0433-a9596d4d6f02@cybernetics.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2018 15:11, Tony Battersby wrote:
> On 12/6/18 4:25 AM, Krzysztof Kozlowski wrote:
>> On Thu, 6 Dec 2018 at 02:31, Tony Lindgren <tony@atomide.com> wrote:
>>> Hi,
>>>
>>> Looks like with commit 26abe88e830d ("mm/dmapool.c: improve scalability
>>> of dma_pool_free()") I'm now getting spammed with lots of "(bad vaddr)"
>>> on at least omap4 pandaboard, see below.
>>>
>>> Any ideas what might be going wrong?
>>>
>>> Regards,
>>>
>>> Tony
>>>
>>> 8< ---------------------
>>> omap-dma-engine 4a056000.dma-controller: dma_pool_free 4a056000.dma-controller, (ptrval) (bad vaddr)/0xbe800000
>>> omap-dma-engine 4a056000.dma-controller: dma_pool_free 4a056000.dma-controller, (ptrval) (bad vaddr)/0xbe80001c
>>> omap-dma-engine 4a056000.dma-controller: dma_pool_free 4a056000.dma-controller, (ptrval) (bad vaddr)/0xbe800038
>>> ...
>> I see it as well on all my Exynos boards, since yesterday's next. In
>> my case it is the USB EHCI driver:
>> exynos-ehci 12110000.usb: dma_pool_free ehci_qtd, (ptrval) (bad
>> vaddr)/0xb8844180
>> Full log here:
>> https://krzk.eu/#/builders/1/builds/2937/steps/12/logs/serial0
>>
>> Best regards,
>> Krzysztof
>>
> Here is the prototype:
> 
> void dma_pool_free(struct dma_pool *pool, void *vaddr, dma_addr_t dma);
> 
> With the old code, the 'dma' value had to be correct for use with
> pool_find_page(), or else you would get an error.  If the 'vaddr' value
> was incorrect, it would corrupt the dmapool freelist, but you wouldn't
> get an error unless DMAPOOL_DEBUG was enabled.
> 
> With my patch applied, 'vaddr' has to be correct for virt_to_page().  My
> code also checks that 'dma' is consistent with 'vaddr' even if
> DMAPOOL_DEBUG is disabled, since the check is fast and it will prevent
> problems like this in the future.

Unfortunately that logic has a fatal flaw - DMA pools are backed by 
dma_alloc_coherent(), and there is absolutely no guarantee that the 
memory dma_alloc_coherent() returns is backed by a struct page at all. 
Even if it is, there is still absolutely no guarantee that the vaddr 
value it returns is valid for virt_to_page() - on many systems it will 
be in vmalloc or some architecture-specific region of address space.

The problem is not that these drivers are buggy (they're not - the arch 
code is returning a vmalloc()ed non-cacheable remap in the first place), 
it's that 26abe88e830d is fundamentally unworkable and needs reverting. 
Apparently the original patches managed not to catch my eye as something 
I needed to review, sorry about that :(

Robin.

> 
> So if a buggy driver passes in a good value for 'dma' but a bad value
> for 'vaddr', then it may have appeared to work previously (but with
> possible data corruption, depending on the circumstances), but my patch
> will expose the problem.  You can confirm by reverting my dmapool
> patches and enabling DMAPOOL_DEBUG, which is at the top of mm/dmapool.c:
> 
> #if defined(CONFIG_DEBUG_SLAB) || defined(CONFIG_SLUB_DEBUG_ON)
> #define DMAPOOL_DEBUG 1
> #endif
> 
> Tony Battersby
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
