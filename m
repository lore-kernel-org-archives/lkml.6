Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544D9C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1895D20851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 23:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="VnEPQtpC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1895D20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbeLLXqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 18:46:18 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:9013 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbeLLXqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 18:46:17 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c119dc40000>; Wed, 12 Dec 2018 15:46:12 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 12 Dec 2018 15:46:15 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 12 Dec 2018 15:46:15 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 12 Dec
 2018 23:46:15 +0000
Subject: Re: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
To:     Jason Gunthorpe <jgg@ziepe.ca>, Jerome Glisse <jglisse@redhat.com>
CC:     Dan Williams <dan.j.williams@intel.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <john.hubbard@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, <tom@talpey.com>,
        Al Viro <viro@zeniv.linux.org.uk>, <benve@cisco.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        <rcampbell@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Weiny, Ira" <ira.weiny@intel.com>
References: <7b4733be-13d3-c790-ff1b-ac51b505e9a6@nvidia.com>
 <20181207191620.GD3293@redhat.com>
 <3c4d46c0-aced-f96f-1bf3-725d02f11b60@nvidia.com>
 <20181208022445.GA7024@redhat.com> <20181210102846.GC29289@quack2.suse.cz>
 <20181212150319.GA3432@redhat.com>
 <CAPcyv4go0Xzhz8rXdfscWuXDu83BO9v8WD4upDUJWb7gKzX5OQ@mail.gmail.com>
 <20181212213005.GE5037@redhat.com>
 <CAPcyv4gJHeFjEgna1S-2uE4KxkSUgkc=e=2E5oqfoirec84C-w@mail.gmail.com>
 <20181212215348.GF5037@redhat.com> <20181212233703.GB2947@ziepe.ca>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <63a551ce-c314-db75-f6d3-c92e39655f79@nvidia.com>
Date:   Wed, 12 Dec 2018 15:46:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181212233703.GB2947@ziepe.ca>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1544658372; bh=uX8Gpj8vVhSuC8ABhWrngWoL/y4B3pb0WpnakWUJ464=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=VnEPQtpCXrSakkMWU86ldsqjhUzaytvRAep1ilR7O7c0YhaTwH+QfBv6Ze/XyPO+F
         SEVMBPN2fZ9YmgX3LVdvS6DSyoNmPfOWWlTxJnP6bgXAq7thk2AvbZj4MZJgLjejSr
         rNVY1TSrHAmBNhJVPlSfFYywkXzZNejV/BkfSj6dhr6H71ckJrxtn+t9CDkr5qb2Iv
         LoYs+koN5a7tNTi4OZZCWcoFXKcl8YzTRx88WOB0fTqtsTcNzcSUKdMk6nvCifQOy5
         /A3qt78ZfY0E6o0SgnnBPi3QPlsDBXgYr0XS6jl34nqzWPWH3u6OHXpCb2/46NNaDl
         +xpMYLbTKNycQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/18 3:37 PM, Jason Gunthorpe wrote:
> On Wed, Dec 12, 2018 at 04:53:49PM -0500, Jerome Glisse wrote:
>>> Almost, we need some safety around assuming that DMA is complete the
>>> page, so the notification would need to go all to way to userspace
>>> with something like a file lease notification. It would also need to
>>> be backstopped by an IOMMU in the case where the hardware does not /
>>> can not stop in-flight DMA.
>>
>> You can always reprogram the hardware right away it will redirect
>> any dma to the crappy page.
> 
> That causes silent data corruption for RDMA users - we can't do that.
> 
> The only way out for current hardware is to forcibly terminate the
> RDMA activity somehow (and I'm not even sure this is possible, at
> least it would be driver specific)
> 
> Even the IOMMU idea probably doesn't work, I doubt all current
> hardware can handle a PCI-E error TLP properly. 

Very true.

> 
> On some hardware it probably just protects DAX by causing data
> corruption for RDMA - I fail to see how that is a win for system
> stability if the user obviously wants to use DAX and RDMA together...
> 
> I think your approach with ODP only is the only one that meets your
> requirements, the only other data-integrity-preserving approach is to
> block/fail ftruncate/etc.
> 
>> From my point of view driver should listen to ftruncate before the
>> mmu notifier kicks in and send event to userspace and maybe wait
>> and block ftruncate (or move it to a worker thread).
> 
> We can do this, but we can't guarantee forward progress in userspace
> and the best way we have to cancel that is portable to all RDMA
> hardware is to kill the process(es)..
> 
> So if that is acceptable then we could use user notifiers and allow
> non-ODP users...
> 

That is exactly the conclusion that some of us in the GPU world reached as
well, when chatting about how this would have to work, even on modern GPU 
hardware that can replay page faults, in many cases. 

I think as long as we specify that the acceptable consequence of doing, say,
umount on a filesystem that has active DMA happening is that the associated
processes get killed, then we're going to be OK.

What would worry me is if there was an expectation that processes could
continue working properly after such a scenario.


thanks,
-- 
John Hubbard
NVIDIA
