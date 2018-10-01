Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF90C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 911912145D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:35:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 911912145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbeJAVN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 17:13:27 -0400
Received: from mga01.intel.com ([192.55.52.88]:19224 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729378AbeJAVN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 17:13:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2018 07:35:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,328,1534834800"; 
   d="scan'208";a="261908429"
Received: from ddalessa-mobl2.amr.corp.intel.com (HELO [10.254.201.54]) ([10.254.201.54])
  by orsmga005.jf.intel.com with ESMTP; 01 Oct 2018 07:35:04 -0700
Subject: Re: [PATCH 3/4] infiniband/mm: convert to the new put_user_page()
 call
To:     John Hubbard <jhubbard@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        john.hubbard@gmail.com
Cc:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Christian Benvenuti <benve@cisco.com>
References: <20180928053949.5381-1-jhubbard@nvidia.com>
 <20180928053949.5381-3-jhubbard@nvidia.com> <20180928153922.GA17076@ziepe.ca>
 <36bc65a3-8c2a-87df-44fc-89a1891b86db@nvidia.com>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <ed9cbf0a-acc9-1b26-a7fc-e8f89f577ce9@intel.com>
Date:   Mon, 1 Oct 2018 10:35:02 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <36bc65a3-8c2a-87df-44fc-89a1891b86db@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/2018 11:12 PM, John Hubbard wrote:
> On 9/28/18 8:39 AM, Jason Gunthorpe wrote:
>> On Thu, Sep 27, 2018 at 10:39:47PM -0700, john.hubbard@gmail.com wrote:
>>> From: John Hubbard <jhubbard@nvidia.com>
> [...]
>>>
>>> diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
>>> index a41792dbae1f..9430d697cb9f 100644
>>> +++ b/drivers/infiniband/core/umem.c
>>> @@ -60,7 +60,7 @@ static void __ib_umem_release(struct ib_device *dev, struct ib_umem *umem, int d
>>>   		page = sg_page(sg);
>>>   		if (!PageDirty(page) && umem->writable && dirty)
>>>   			set_page_dirty_lock(page);
>>> -		put_page(page);
>>> +		put_user_page(page);
>>
>> Would it make sense to have a release/put_user_pages_dirtied to absorb
>> the set_page_dity pattern too? I notice in this patch there is some
>> variety here, I wonder what is the right way?
>>
>> Also, I'm told this code here is a big performance bottleneck when the
>> number of pages becomes very long (think >> GB of memory), so having a
>> future path to use some kind of batching/threading sound great.
>>
> 
> Yes. And you asked for this the first time, too. Consistent! :) Sorry for
> being slow to pick it up. It looks like there are several patterns, and
> we have to support both set_page_dirty() and set_page_dirty_lock(). So
> the best combination looks to be adding a few variations of
> release_user_pages*(), but leaving put_user_page() alone, because it's
> the "do it yourself" basic one. Scatter-gather will be stuck with that.
> 
> Here's a differential patch with that, that shows a nice little cleanup in
> a couple of IB places, and as you point out, it also provides the hooks for
> performance upgrades (via batching) in the future.
> 
> Does this API look about right?

I'm on board with that and the changes to hfi1 and qib.

Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>

