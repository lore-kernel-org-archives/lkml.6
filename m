Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8113BC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 19:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 389322086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 19:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="OTc8G58j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 389322086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbeLLTNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 14:13:30 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:13762 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbeLLTN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 14:13:29 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c115dd40001>; Wed, 12 Dec 2018 11:13:25 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 12 Dec 2018 11:13:27 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 12 Dec 2018 11:13:27 -0800
Received: from [10.2.165.33] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 12 Dec
 2018 19:13:27 +0000
Subject: Re: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
To:     Matthew Wilcox <willy@infradead.org>
CC:     Jerome Glisse <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        John Hubbard <john.hubbard@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, Jan Kara <jack@suse.cz>,
        <tom@talpey.com>, Al Viro <viro@zeniv.linux.org.uk>,
        <benve@cisco.com>, Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Michal Hocko <mhocko@kernel.org>, <mike.marciniszyn@intel.com>,
        <rcampbell@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <CAPcyv4h99JVHAS7Q7k3iPPUq+oc1NxHdyBHMjpgyesF1EjVfWA@mail.gmail.com>
 <a0adcf7c-5592-f003-abc5-a2645eb1d5df@nvidia.com>
 <CAPcyv4iNtamDAY9raab=iXhSZByecedBpnGybjLM+PuDMwq7SQ@mail.gmail.com>
 <3c91d335-921c-4704-d159-2975ff3a5f20@nvidia.com>
 <20181205011519.GV10377@bombadil.infradead.org>
 <20181205014441.GA3045@redhat.com>
 <59ca5c4b-fd5b-1fc6-f891-c7986d91908e@nvidia.com>
 <7b4733be-13d3-c790-ff1b-ac51b505e9a6@nvidia.com>
 <20181207191620.GD3293@redhat.com>
 <3c4d46c0-aced-f96f-1bf3-725d02f11b60@nvidia.com>
 <20181208051810.GA24118@bombadil.infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <7491557a-4fe9-71fd-e329-e84e9e830929@nvidia.com>
Date:   Wed, 12 Dec 2018 11:13:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181208051810.GA24118@bombadil.infradead.org>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1544642005; bh=YN0jTaiJ1Jod/SEAVEWZJPkpexuJCrezKX4+9wNyVGs=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=OTc8G58jBaRtBUPsZxPLk5QC5CHYJw8ezPmaZAEQT5QwH1pPQoCx2Ueft3Q4iO0CW
         e8bACNhwhtP7WJcTsVhonK/jXnxeZnpdlLkjOpEca1Hn1tbd+0dmuaUdOPGR2jYtKB
         cKrG0y7VekSDcomrZDr/2yHz/G+4nT3EU5Jcb0Gp0SrDNw1K1LNy490BEMWYi4aBV+
         pEH6A7NLvojjwU9Vga3Me+9nDpQ5LbEQf/rzOpFTue8ETO0zGSwiIbnJ4881h21PHi
         8uiPYBl1EFGMQF0gOtIKtvu/yHvkre07jG4+Uj3TslVpfanOOwkrkmRpiXkasX4TPH
         oukDglEW+G0rg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/18 9:18 PM, Matthew Wilcox wrote:
> On Fri, Dec 07, 2018 at 04:52:42PM -0800, John Hubbard wrote:
>> I see. OK, HMM has done an efficient job of mopping up unused fields, and now we are
>> completely out of space. At this point, after thinking about it carefully, it seems clear
>> that it's time for a single, new field:
> 
> Sorry for not replying earlier; I'm travelling and have had trouble
> keeping on top of my mail.

Hi Matthew,

> 
> Adding this field will grow struct page by 4-8 bytes, so it will no
> longer be 64 bytes.  This isn't an acceptable answer.

I had to ask, though, just in case the historical rules might no longer
be ask pressing. But OK.

> 
> We have a few options for bits.  One is that we have (iirc) two
> bits available in page->flags on 32-bit.  That'll force a few more
> configurations into using _last_cpupid and/or page_ext.  I'm not a huge
> fan of this approach.
> 
> The second is to use page->lru.next bit 1.  This requires some care
> because m68k allows misaligned pointers.  If the list_head that it's
> joined to is misaligned, we'll be in trouble.  This can get tricky because
> some pages are attached to list_heads which are on the stack ... and I
> don't think gcc guarantees __aligned attributes work for stack variables.
> 
> The third is to use page->lru.prev bit 0.  We'd want to switch pgmap
> and hmm_data around to make this work, and we'd want to record this
> in mm_types.h so nobody tries to use a field which aliases with
> page->lru.prev and has bit 0 set on a page which can be mapped to
> userspace (which I currently believe to be true).
> 
> The fourth is to use a bit in page->flags for 64-bit and a bit in
> page_ext->flags for 32-bit.  Or we could get rid of page_ext and grow
> struct page with a ->flags2 on 32-bit.
> 
> Fifth, it isn't clear to me how many bits might be left in ->_last_cpupid
> at this point, and perhaps there's scope for using a bit in there.
> 

Thanks for taking the time to collect and explain all of this, I'm stashing
it away as I'm sure it will come up again.

The latest approach to the gup/dma problem here might, or might not, actually
need a single page bit. I'll know in a day or two.

-- 
thanks,
John Hubbard
NVIDIA 
