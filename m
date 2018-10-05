Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF29C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 987DE20652
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="UuNE0X42"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 987DE20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbeJFDs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 23:48:56 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:19680 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbeJFDs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 23:48:56 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bb7ce1a0000>; Fri, 05 Oct 2018 13:48:28 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 05 Oct 2018 13:48:31 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 05 Oct 2018 13:48:31 -0700
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 5 Oct
 2018 20:48:29 +0000
Subject: Re: [PATCH v2 3/3] infiniband/mm: convert to the new
 put_user_page[s]() calls
To:     Jason Gunthorpe <jgg@ziepe.ca>, <john.hubbard@gmail.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Christian Benvenuti <benve@cisco.com>
References: <20181005040225.14292-1-jhubbard@nvidia.com>
 <20181005040225.14292-4-jhubbard@nvidia.com>
 <20181005152055.GB20776@ziepe.ca>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <a4402c75-8b6d-a09e-07be-864c678ccc4f@nvidia.com>
Date:   Fri, 5 Oct 2018 13:48:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181005152055.GB20776@ziepe.ca>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1538772508; bh=JnnVtmc5/fXbNCSz1vf/olr5sqGydkl8QGd+bUL9RTk=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=UuNE0X42HgQdo2oIxe2f5shUCkffgh/pFd/EhlnyLxPXXhtlRzCZQN+7XX22IbwfA
         UsQqGaHcA0WOG66ujvhnjdf++xRHnv8vZ916Fun1nLirzeGR2Y3fgZSTA6emVO+6vk
         uMoERqc5JSTKlCYphEP/C62cKsvcYT1pQ5stMnmHGjQ2wmLCpeWTaDrmBFA7KJiqPF
         AuKo3xtX176SN4PHq6XgmaPX79pLCyYM8rqjjVfQMzn+7XozLysoxNxAvpCPAly4ej
         Ada2XnTg9/NN04x3Qzfy71zfsZtLL6hWxFArNYobwEx370GNSkgZXTdrWutrv9d7gP
         y0KcCw5GYgZoQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/18 8:20 AM, Jason Gunthorpe wrote:
> On Thu, Oct 04, 2018 at 09:02:25PM -0700, john.hubbard@gmail.com wrote:
>> From: John Hubbard <jhubbard@nvidia.com>
>>
>> For code that retains pages via get_user_pages*(),
>> release those pages via the new put_user_page(),
>> instead of put_page().
>>
>> This prepares for eventually fixing the problem described
>> in [1], and is following a plan listed in [2], [3], [4].
>>
>> [1] https://lwn.net/Articles/753027/ : "The Trouble with get_user_pages()"
>>
>> [2] https://lkml.kernel.org/r/20180709080554.21931-1-jhubbard@nvidia.com
>>     Proposed steps for fixing get_user_pages() + DMA problems.
>>
>> [3]https://lkml.kernel.org/r/20180710082100.mkdwngdv5kkrcz6n@quack2.suse.cz
>>     Bounce buffers (otherwise [2] is not really viable).
>>
>> [4] https://lkml.kernel.org/r/20181003162115.GG24030@quack2.suse.cz
>>     Follow-up discussions.
>>
>> CC: Doug Ledford <dledford@redhat.com>
>> CC: Jason Gunthorpe <jgg@ziepe.ca>
>> CC: Mike Marciniszyn <mike.marciniszyn@intel.com>
>> CC: Dennis Dalessandro <dennis.dalessandro@intel.com>
>> CC: Christian Benvenuti <benve@cisco.com>
>>
>> CC: linux-rdma@vger.kernel.org
>> CC: linux-kernel@vger.kernel.org
>> CC: linux-mm@kvack.org
>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
>>  drivers/infiniband/core/umem.c              |  2 +-
>>  drivers/infiniband/core/umem_odp.c          |  2 +-
>>  drivers/infiniband/hw/hfi1/user_pages.c     | 11 ++++-------
>>  drivers/infiniband/hw/mthca/mthca_memfree.c |  6 +++---
>>  drivers/infiniband/hw/qib/qib_user_pages.c  | 11 ++++-------
>>  drivers/infiniband/hw/qib/qib_user_sdma.c   |  8 ++++----
>>  drivers/infiniband/hw/usnic/usnic_uiom.c    |  2 +-
>>  7 files changed, 18 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
>> index a41792dbae1f..9430d697cb9f 100644
>> +++ b/drivers/infiniband/core/umem.c
>> @@ -60,7 +60,7 @@ static void __ib_umem_release(struct ib_device *dev, struct ib_umem *umem, int d
>>  		page = sg_page(sg);
>>  		if (!PageDirty(page) && umem->writable && dirty)
>>  			set_page_dirty_lock(page);
>> -		put_page(page);
>> +		put_user_page(page);
>>  	}
> 
> How about ?
> 
> if (umem->writable && dirty)
>      put_user_pages_dirty_lock(&page, 1);
> else
>      put_user_page(page);
> 
> ?

OK, I'll make that change.

> 
>> diff --git a/drivers/infiniband/hw/hfi1/user_pages.c b/drivers/infiniband/hw/hfi1/user_pages.c
>> index e341e6dcc388..99ccc0483711 100644
>> +++ b/drivers/infiniband/hw/hfi1/user_pages.c
>> @@ -121,13 +121,10 @@ int hfi1_acquire_user_pages(struct mm_struct *mm, unsigned long vaddr, size_t np
>>  void hfi1_release_user_pages(struct mm_struct *mm, struct page **p,
>>  			     size_t npages, bool dirty)
>>  {
>> -	size_t i;
>> -
>> -	for (i = 0; i < npages; i++) {
>> -		if (dirty)
>> -			set_page_dirty_lock(p[i]);
>> -		put_page(p[i]);
>> -	}
>> +	if (dirty)
>> +		put_user_pages_dirty_lock(p, npages);
>> +	else
>> +		put_user_pages(p, npages);
> 
> And I know Jan gave the feedback to remove the bool argument, but just
> pointing out that quite possibly evey caller will wrapper it in an if
> like this..
> 

Yes, that attracted me, too. It's nice to write the "if" code once, instead of 
many times. But doing it efficiently requires using a bool argument (otherwise,
you end up with another "if" branch, to convert from bool to an enum or flag arg),
and that's generally avoided because no one wants to see code of the form:

   do_this(0, 1, 0, 1);
   do_this(1, 0, 0, 1);

, which, although hilarious, is still evil. haha. Anyway, maybe I'll leave it as-is
for now, to inject some hysteresis into this aspect of the review?


thanks,
-- 
John Hubbard
NVIDIA
