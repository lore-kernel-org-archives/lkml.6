Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9B3C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5694F20657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="NmPuNZz/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390583AbfAOVjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 16:39:21 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:6624 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730500AbfAOVjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 16:39:20 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c3e52f10001>; Tue, 15 Jan 2019 13:38:58 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 15 Jan 2019 13:39:18 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 15 Jan 2019 13:39:18 -0800
Received: from [10.110.48.28] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 15 Jan
 2019 21:39:17 +0000
Subject: Re: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
To:     Jan Kara <jack@suse.cz>
CC:     Jerome Glisse <jglisse@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Dan Williams <dan.j.williams@intel.com>,
        John Hubbard <john.hubbard@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, <tom@talpey.com>,
        Al Viro <viro@zeniv.linux.org.uk>, <benve@cisco.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Michal Hocko <mhocko@kernel.org>, <mike.marciniszyn@intel.com>,
        <rcampbell@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <a79b259b-3982-b271-025a-0656f70506f4@nvidia.com>
 <20190111165141.GB3190@redhat.com>
 <1b37061c-5598-1b02-2983-80003f1c71f2@nvidia.com>
 <20190112020228.GA5059@redhat.com>
 <294bdcfa-5bf9-9c09-9d43-875e8375e264@nvidia.com>
 <20190112024625.GB5059@redhat.com>
 <b6f4ed36-fc8d-1f9b-8c74-b12f61d496ae@nvidia.com>
 <20190114145447.GJ13316@quack2.suse.cz> <20190114172124.GA3702@redhat.com>
 <fdece7f8-7e4f-f679-821f-1d05ed748c15@nvidia.com>
 <20190115083412.GD29524@quack2.suse.cz>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <9be3c203-6e44-6b9d-2331-afbcc269d0ff@nvidia.com>
Date:   Tue, 15 Jan 2019 13:39:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190115083412.GD29524@quack2.suse.cz>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1547588338; bh=PQJy2KoRlTDwuAHKEBF9mbcBgC8EwEXbZLfrRVfnbhE=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=NmPuNZz/AwQn5IGofNFU+LTwSUqYAwFl9sooH6S5IFHOEcYgT+ZlrFlsLW6nssika
         knPQW5sAfmGMK8Bt2X3XVo0RbeDFVxM1lzBDxbOEAo6ZnNED2UY1v7GiEzWoH93RRN
         rsEtZMOnhMmIDf5QlWFB5oPbmcaXlA2laapazQoQGs/QUzbwIkkGSqZv3whgL4uyAB
         tkpTZAXPvw57wYwnOeLIzgiTbpr57i0WPSgS0iZXAWVqFOIIiqSAmE/BDiTALxl/Y3
         06ebt8reuOlZM9t+Xm+1BMX+jIkJcJzh87shpFY0q0wEOL3pbhJj9GDDNLoFoV3LMI
         n54hPkmvaQNrA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/19 12:34 AM, Jan Kara wrote:
> On Mon 14-01-19 11:09:20, John Hubbard wrote:
>> On 1/14/19 9:21 AM, Jerome Glisse wrote:
>>>>
[...]
> 
>> For example, the following already survives a basic boot to graphics mode.
>> It requires a bunch of callsite conversions, and a page flag (neither of which
>> is shown here), and may also have "a few" gross conceptual errors, but take a 
>> peek:
> 
> Thanks for writing this down! Some comments inline.
> 

I appreciate your taking a look at this, Jan. I'm still pretty new to gup.c, 
so it's really good to get an early review.


>> +/*
>> + * Manages the PG_gup_pinned flag.
>> + *
>> + * Note that page->_mapcount counting part of managing that flag, because the
>> + * _mapcount is used to determine if PG_gup_pinned can be cleared, in
>> + * page_mkclean().
>> + */
>> +static void track_gup_page(struct page *page)
>> +{
>> +	page = compound_head(page);
>> +
>> +	lock_page(page);
>> +
>> +	wait_on_page_writeback(page);
> 
> ^^ I'd use wait_for_stable_page() here. That is the standard waiting
> mechanism to use before you allow page modification.

OK, will do. In fact, I initially wanted to use wait_for_stable_page(), but 
hesitated when I saw that it won't necessarily do wait_on_page_writeback(), 
and I then I also remembered Dave Chinner recently mentioned that the policy
decision needed some thought in the future (maybe something about block 
device vs. filesystem policy):

void wait_for_stable_page(struct page *page)
{
	if (bdi_cap_stable_pages_required(inode_to_bdi(page->mapping->host)))
		wait_on_page_writeback(page);
}

...but like you say, it's the standard way that fs does this, so we should
just use it.

> 
>> +
>> +	atomic_inc(&page->_mapcount);
>> +	SetPageGupPinned(page);
>> +
>> +	unlock_page(page);
>> +}
>> +
>> +/*
>> + * A variant of track_gup_page() that returns -EBUSY, instead of waiting.
>> + */
>> +static int track_gup_page_atomic(struct page *page)
>> +{
>> +	page = compound_head(page);
>> +
>> +	if (PageWriteback(page) || !trylock_page(page))
>> +		return -EBUSY;
>> +
>> +	if (PageWriteback(page)) {
>> +		unlock_page(page);
>> +		return -EBUSY;
>> +	}
> 
> Here you'd need some helper that would return whether
> wait_for_stable_page() is going to wait. Like would_wait_for_stable_page()
> but maybe you can come up with a better name.

Yes, in order to wait_for_stable_page(), that seems necessary, I agree.


thanks,
-- 
John Hubbard
NVIDIA
