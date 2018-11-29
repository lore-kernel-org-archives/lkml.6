Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2860AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDB7F213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:07:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDB7F213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730478AbeK3ENS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:13:18 -0500
Received: from ale.deltatee.com ([207.54.116.67]:56760 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729682AbeK3ENS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:13:18 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1gSPmJ-0004a6-3X; Thu, 29 Nov 2018 10:07:04 -0700
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stephen Bates <sbates@raithlin.com>
References: <154275556908.76910.8966087090637564219.stgit@dwillia2-desk3.amr.corp.intel.com>
 <154275558526.76910.7535251937849268605.stgit@dwillia2-desk3.amr.corp.intel.com>
 <6875ca04-a36a-89ae-825b-f629ab011d47@deltatee.com>
 <CAPcyv4i9QXsX9Rjz9E3gi643LQbSzaO_+iFLqLS+QO-GmrS0Eg@mail.gmail.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <14d6413c-b002-c152-5016-7ed659c08c24@deltatee.com>
Date:   Thu, 29 Nov 2018 10:06:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4i9QXsX9Rjz9E3gi643LQbSzaO_+iFLqLS+QO-GmrS0Eg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sbates@raithlin.com, bhelgaas@google.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, torvalds@linux-foundation.org, hch@lst.de, jglisse@redhat.com, stable@vger.kernel.org, akpm@linux-foundation.org, dan.j.williams@intel.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v8 3/7] mm, devm_memremap_pages: Fix shutdown handling
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018-11-28 8:10 p.m., Dan Williams wrote:
> Yes, please send a proper patch. 

Ok, I'll send one shortly.

> Although, I'm still not sure I see
> the problem with the order of the percpu-ref kill. It's likely more
> efficient to put the kill after the put_page() loop because the
> percpu-ref will still be in "fast" per-cpu mode, but the kernel panic
> should not be possible as long as their is a wait_for_completion()
> before the exit, unless something else is wrong.

The series of events looks something like this:

1) Some p2pdma user calls pci_alloc_p2pmem() to get some memory to DMA
to taking a reference to the pgmap.
2) Another process unbinds the underlying p2pdma driver and the devm
chain starts to unwind.
3) devm_memremap_pages_release() is called and it kills the reference
and drop's it's last reference.
4) arch_remove_memory() is called which will remove all the struct pages.
5) We eventually get to pci_p2pdma_release() where we wait for the
completion indicating all the pages have been freed.
6) The user in (1) tries to use the page that has been removed,
typically by calling pci_p2pdma_map_sg(), but the page doesn't exist so
the kernel panics.

So we really need the wait in (5) to occur before (4) but after (3) so
that the pages continue to exist until the last reference is dropped.

> Certainly you can't move the wait_for_completion() into your ->kill()
> callback without switching the ordering, but I'm not on board with
> that change until I understand a bit more about why you think
> device-dax might be broken?
> 
> I took a look at the p2pdma shutdown path and the:
> 
>         if (percpu_ref_is_dying(ref))
>                 return;
> ...looks fishy. If multiple agents can overlap their requests for the
> same range why not track that simply as additional refs? Could it be
> the crash that you are seeing is a result of mis-accounting when it is
> safe to assume the page allocation can be freed?

Yeah, someone else mentioned the same thing during review but if I
remove it, there can be a double kill() on a hypothetical driver that
might call pci_p2pdma_add_resource() twice. The issue is we only have
one percpu_ref per device not one per range/BAR.

Though, now that I look at it, the current change in question will be
wrong if there are two devm_memremap_pages_release()s to call. Both need
to drop their references before we can wait_for_completion() ;(. I guess
I need multiple percpu_refs or more complex changes to
devm_memremap_pages_release().

Thanks

Logan

