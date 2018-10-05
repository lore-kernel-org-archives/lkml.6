Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17528C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 19:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3393213A2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 19:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Hc52I6T4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3393213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbeJFCtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 22:49:21 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:16508 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728061AbeJFCtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 22:49:21 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bb7c00f0000>; Fri, 05 Oct 2018 12:48:31 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 05 Oct 2018 12:49:07 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 05 Oct 2018 12:49:07 -0700
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 5 Oct
 2018 19:49:06 +0000
Subject: Re: [PATCH v2 2/3] mm: introduce put_user_page[s](), placeholder
 versions
To:     Jason Gunthorpe <jgg@ziepe.ca>, <john.hubbard@gmail.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Jerome Glisse <jglisse@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
References: <20181005040225.14292-1-jhubbard@nvidia.com>
 <20181005040225.14292-3-jhubbard@nvidia.com>
 <20181005151726.GA20776@ziepe.ca>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <c6f31004-3a67-880b-47bb-b560dfd85343@nvidia.com>
Date:   Fri, 5 Oct 2018 12:49:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181005151726.GA20776@ziepe.ca>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1538768911; bh=A44HVFpuTyXFHxDlpQtKpZC5RyVPcULm1rkwlmyrEdw=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Hc52I6T4bTE+nh7vWtchnbb6xb64C7nm7UnFkOa0fXkALf+gVTtFuLjbe7VxP9FiG
         tpK97sfm4EtvpLtXihP/MteVE7V2ik1ar2dnOKX4TOHZVcAA5pc1aZ1yrUeavneXnl
         /PIY3yWLPFsLV/4FkXqR55PeXV3Vm3mjmAb2+p74q1wUKcnx57zLlX7nFiR9+/etdr
         GDaMNofEQ9Lv69guUJhqH/qir8ukXqiLtOLn+tOa9Ss3BB6xpQqh3PtB99ZHpTsCbO
         VeH7hGKLdTmBGbYpA2Z15CXvZqcDQQhsLSEQ3TPWz/CRI35bKraDFI8tjlMWW3CIW/
         vh1t/KIhzZyQw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/18 8:17 AM, Jason Gunthorpe wrote:
> On Thu, Oct 04, 2018 at 09:02:24PM -0700, john.hubbard@gmail.com wrote:
>> From: John Hubbard <jhubbard@nvidia.com>
>>
>> Introduces put_user_page(), which simply calls put_page().
>> This provides a way to update all get_user_pages*() callers,
>> so that they call put_user_page(), instead of put_page().
>>
>> Also introduces put_user_pages(), and a few dirty/locked variations,
>> as a replacement for release_pages(), for the same reasons.
>> These may be used for subsequent performance improvements,
>> via batching of pages to be released.
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
[...]
>>  
>> +/* Placeholder version, until all get_user_pages*() callers are updated. */
>> +static inline void put_user_page(struct page *page)
>> +{
>> +	put_page(page);
>> +}
>> +
>> +/* For get_user_pages*()-pinned pages, use these variants instead of
>> + * release_pages():
>> + */
>> +static inline void put_user_pages_dirty(struct page **pages,
>> +					unsigned long npages)
>> +{
>> +	while (npages) {
>> +		set_page_dirty(pages[npages]);
>> +		put_user_page(pages[npages]);
>> +		--npages;
>> +	}
>> +}
> 
> Shouldn't these do the !PageDirty(page) thing?
> 

Well, not yet. This is the "placeholder" patch, in which I planned to keep
the behavior the same, while I go to all the get_user_pages call sites and change 
put_page() and release_pages() over to use these new routines.

After the call sites are changed, then these routines will be updated to do more.
[2], above has slightly more detail about that.


thanks,
-- 
John Hubbard
NVIDIA
