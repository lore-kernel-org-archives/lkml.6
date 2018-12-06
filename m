Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543C4C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 246BC20868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:13:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 246BC20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybernetics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbeLFQNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:13:19 -0500
Received: from mail.cybernetics.com ([173.71.130.66]:45172 "EHLO
        mail.cybernetics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbeLFQNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 11:13:19 -0500
X-ASG-Debug-ID: 1544112796-0fb3b01fb3c5b3f0001-xx1T2L
Received: from cybernetics.com ([10.157.1.126]) by mail.cybernetics.com with ESMTP id PGcOwVDYVPrI9Vwo (version=SSLv3 cipher=DES-CBC3-SHA bits=112 verify=NO); Thu, 06 Dec 2018 11:13:16 -0500 (EST)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-ASG-Whitelist: Client
Received: from [10.157.2.224] (account tonyb HELO [192.168.200.1])
  by cybernetics.com (CommuniGate Pro SMTP 5.1.14)
  with ESMTPSA id 8570034; Thu, 06 Dec 2018 11:13:16 -0500
Subject: Re: dmapool regression in next
To:     Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, tony@atomide.com,
        akpm@linux-foundation.org
X-ASG-Orig-Subj: Re: dmapool regression in next
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>, john.garry@huawei.com,
        linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
        andy.shevchenko@gmail.com, linux-omap@vger.kernel.org, hch@lst.de,
        linux-arm-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20181206013054.GI6707@atomide.com>
 <CAJKOXPcoK5SsXfXjdAWPHLX2KZRCqOv61HVf2DK9wm4_m+vJ0w@mail.gmail.com>
 <09e73d24-467a-52bb-0433-a9596d4d6f02@cybernetics.com>
 <451215b8-548a-eff7-9e96-0ff5f8cbb614@arm.com>
From:   Tony Battersby <tonyb@cybernetics.com>
Message-ID: <9187bbd9-3aaf-c1b3-16a3-4e1b3356c52e@cybernetics.com>
Date:   Thu, 6 Dec 2018 11:13:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <451215b8-548a-eff7-9e96-0ff5f8cbb614@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Barracuda-Connect: UNKNOWN[10.157.1.126]
X-Barracuda-Start-Time: 1544112796
X-Barracuda-Encrypted: DES-CBC3-SHA
X-Barracuda-URL: https://10.157.1.122:443/cgi-mod/mark.cgi
X-Barracuda-Scan-Msg-Size: 1890
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/18 10:51 AM, Robin Murphy wrote:
>> Here is the prototype:
>>
>> void dma_pool_free(struct dma_pool *pool, void *vaddr, dma_addr_t dma);
>>
>> With the old code, the 'dma' value had to be correct for use with
>> pool_find_page(), or else you would get an error.  If the 'vaddr' value
>> was incorrect, it would corrupt the dmapool freelist, but you wouldn't
>> get an error unless DMAPOOL_DEBUG was enabled.
>>
>> With my patch applied, 'vaddr' has to be correct for virt_to_page().  My
>> code also checks that 'dma' is consistent with 'vaddr' even if
>> DMAPOOL_DEBUG is disabled, since the check is fast and it will prevent
>> problems like this in the future.
> Unfortunately that logic has a fatal flaw - DMA pools are backed by 
> dma_alloc_coherent(), and there is absolutely no guarantee that the 
> memory dma_alloc_coherent() returns is backed by a struct page at all. 
> Even if it is, there is still absolutely no guarantee that the vaddr 
> value it returns is valid for virt_to_page() - on many systems it will 
> be in vmalloc or some architecture-specific region of address space.
>
> The problem is not that these drivers are buggy (they're not - the arch 
> code is returning a vmalloc()ed non-cacheable remap in the first place), 
> it's that 26abe88e830d is fundamentally unworkable and needs reverting. 
> Apparently the original patches managed not to catch my eye as something 
> I needed to review, sorry about that :(
>
> Robin.
>
Thanks for the info; the inner workings of the vm system are a bit out
of my area of expertise.  My first version of the patch series used a
different method that didn't rely on virt_to_page(); I will go back to
that version, clean it up, and resubmit when I have time.

Andrew, please revert all 9 patches.  I will resubmit the set when I
have a workable solution.

Tony Battersby

