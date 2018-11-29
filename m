Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAC5C32789
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83A6B21019
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:51:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83A6B21019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731062AbeK3E5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:57:10 -0500
Received: from ale.deltatee.com ([207.54.116.67]:57236 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730594AbeK3E5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:57:10 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1gSQSf-000554-O9; Thu, 29 Nov 2018 10:50:50 -0700
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
 <14d6413c-b002-c152-5016-7ed659c08c24@deltatee.com>
 <CAPcyv4gZisOAE8VJPJChNXrWv0NhUevWuutsPdvNORBTOBXJfA@mail.gmail.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <43778343-6d43-eb43-0de0-3db6828902d0@deltatee.com>
Date:   Thu, 29 Nov 2018 10:50:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4gZisOAE8VJPJChNXrWv0NhUevWuutsPdvNORBTOBXJfA@mail.gmail.com>
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



On 2018-11-29 10:30 a.m., Dan Williams wrote:
> Oh! Yes, nice find. We need to wait for the percpu-ref to be dead and
> all outstanding references dropped before we can proceed to
> arch_remove_memory(), and I think this problem has been there since
> day one because the final exit was always after devm_memremap_pages()
> release which means arch_remove_memory() was always racing any final
> put_page(). I'll take a look, it seems the arch_remove_pages() call
> needs to be moved out-of-line to its own context and wait for the
> final exit of the percpu-ref.

Ok, well I thought moving the wait_for_completion() into the kill() call
was a pretty good solution to this. Though, if we move the
arch_remove_pages() into a different context, it *may* help with the
problem below...

>> Though, now that I look at it, the current change in question will be
>> wrong if there are two devm_memremap_pages_release()s to call. Both need
>> to drop their references before we can wait_for_completion() ;(. I guess
>> I need multiple percpu_refs or more complex changes to
>> devm_memremap_pages_release().
> 
> Can you just have a normal device-level kref for this case? On final
> device-level kref_put then kill the percpu_ref? I guess the problem is
> devm semantics where p2pdma only gets one callback on a driver
> ->remove() event. I'm not sure how to support multiple references of
> the same pages without creating a non-devm version of
> devm_memremap_pages(). I'm not opposed to that, but afaiu I don't
> think p2pdma is compatible with devm as long as it supports N>1:1
> mappings of the same range.

Hmm, no I think you misunderstood what I said. I'm saying I need to have
exactly one percpu_ref per call to devm_memremap_pages() and this is
doable, just slightly annoying. Right now I have one percpu_ref for
multiple calls to devm_memremap_pages() which doesn't work with the
above fix because there will always be a wait_for_completion() before
the last references are dropped in this way:

1) First devm_memremap_pages_release() is called which drops it's
reference and waits_for_completion().

2) The second devm_memremap_pages_release() needs to be called to drop
it's reference, but can't seeing the first is waiting, and therefore the
percpu_ref never goes to zero and the wait_for_completion() never returns.

Logan
