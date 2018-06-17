Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173DAC433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 22:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C05682083D
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 22:23:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C05682083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754136AbeFQWXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 18:23:37 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:13069 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752698AbeFQWXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 18:23:36 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b26df540000>; Sun, 17 Jun 2018 15:23:16 -0700
Received: from HQMAIL107.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sun, 17 Jun 2018 15:23:40 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sun, 17 Jun 2018 15:23:40 -0700
Received: from [10.2.175.123] (10.2.175.123) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Sun, 17 Jun
 2018 22:23:35 +0000
Subject: Re: [PATCH 0/2] mm: gup: don't unmap or drop filesystem buffers
To:     Christopher Lameter <cl@linux.com>, <john.hubbard@gmail.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
References: <20180617012510.20139-1-jhubbard@nvidia.com>
 <010001640fbe0dd8-f999e7f6-7b6e-4deb-b073-0c572006727d-000000@email.amazonses.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <4708f5be-1829-3a20-8fad-5a445d18aa84@nvidia.com>
Date:   Sun, 17 Jun 2018 15:23:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <010001640fbe0dd8-f999e7f6-7b6e-4deb-b073-0c572006727d-000000@email.amazonses.com>
X-Originating-IP: [10.2.175.123]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/17/2018 02:54 PM, Christopher Lameter wrote:
> On Sat, 16 Jun 2018, john.hubbard@gmail.com wrote:
> 
>> I've come up with what I claim is a simple, robust fix, but...I'm
>> presuming to burn a struct page flag, and limit it to 64-bit arches, in
>> order to get there. Given that the problem is old (Jason Gunthorpe noted
>> that RDMA has been living with this problem since 2005), I think it's
>> worth it.
>>
>> Leaving the new page flag set "nearly forever" is not great, but on the
>> other hand, once the page is actually freed, the flag does get cleared.
>> It seems like an acceptable tradeoff, given that we only get one bit
>> (and are lucky to even have that).
> 
> This is not robust. Multiple processes may register a page with the RDMA
> subsystem. How do you decide when to clear the flag? I think you would
> need an additional refcount for the number of times the page was
> registered.

Effectively, page->_refcount is what does that here. It would be a nice, but 
not strictly required optimization to have a separate reference count. That's
because the new page flag gets cleared when the page is fully freed. So unless
we're dealing with pages that don't get freed, it's functional, right?

Each of those multiple processes also wants protection from the ravages
of try_to_unmap() and drop_buffers(), anyway. Having said that, it would
be nice to have that refcount, but seems hard to get one.

> 
> I still think the cleanest solution here is to require mmu notifier
> callbacks and to not pin the page in the first place. If a NIC does not
> support a hardware mmu then it can still simulate it in software by
> holding off the ummapping the mmu notifier callback until any pending
> operation is complete and then invalidate the mapping so that future
> operations require a remapping (or refaulting).
> 

Interesting. I didn't want a solution that only supported the few devices
that can support their own replayable page faulting, so I was sort of putting
the mmu notifier idea on the back burner. But somehow I missed the
idea of just holding off the invalidation, in MMU notifier callback, to 
work for non-page-faultable hardware. On one hand, it's wild to hold off
the invalidation perhaps for a long time, but on the other hand--you get
behavior that the hardware cannot otherwise do: access to non-pinned memory.

I know this was brought up before. Definitely would like to hear more 
opinions and brainstorming here.

thanks,
-- 
John Hubbard
NVIDIA
