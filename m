Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DC0C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CEB92085B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="PuCLrKfI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CEB92085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbeJKGsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 02:48:02 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:9855 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeJKGsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 02:48:02 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bbe89fb0000>; Wed, 10 Oct 2018 16:23:39 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 10 Oct 2018 16:23:36 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 10 Oct 2018 16:23:36 -0700
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 10 Oct
 2018 23:23:36 +0000
Subject: Re: [PATCH v4 2/3] mm: introduce put_user_page*(), placeholder
 versions
To:     Jan Kara <jack@suse.cz>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        <john.hubbard@gmail.com>, Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Jerome Glisse <jglisse@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ralph Campbell <rcampbell@nvidia.com>
References: <20181008211623.30796-1-jhubbard@nvidia.com>
 <20181008211623.30796-3-jhubbard@nvidia.com>
 <20181008171442.d3b3a1ea07d56c26d813a11e@linux-foundation.org>
 <5198a797-fa34-c859-ff9d-568834a85a83@nvidia.com>
 <20181010085936.GC11507@quack2.suse.cz>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <f5fb98a8-a1dc-6f1d-bc9e-210be14e91b4@nvidia.com>
Date:   Wed, 10 Oct 2018 16:23:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181010085936.GC11507@quack2.suse.cz>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1539213819; bh=r/cMro//74qm0TVZvnk1VUgCyYhOP425szHScAcCu1I=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=PuCLrKfInwHq+B287fYUi421RMs4kf94/TPKrUzmWxzAuiCcu3ZndZvgx2uHJqcZj
         shRrEah7fYMwwowpMTes64L2lKobrKvGUJ5gMQAJoxS9PQpaWmibzKVjx6u8bf55IE
         cY9R8e+J2VlutZzT8bwBPfyEgp8ca0oPwvHs9Z9KUU/B6PV/jcWkRpSRSPNxI/h5xf
         D63svYjXuA/fQFmocH8rSCL2HV1tCmNrs3wkHXJZbpIyyap7pmgD55fpZAKkI7lKjO
         ykhcxPhM0wVBuzywTXjrAmAbQ6AkbyIHpP/EGh6xGjKXVvKW6DCQJRyDJKp8VPknFW
         RLHG8cq+lM9Rg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/18 1:59 AM, Jan Kara wrote:
> On Tue 09-10-18 17:42:09, John Hubbard wrote:
>> On 10/8/18 5:14 PM, Andrew Morton wrote:
>>> Also, maintainability.  What happens if someone now uses put_page() by
>>> mistake?  Kernel fails in some mysterious fashion?  How can we prevent
>>> this from occurring as code evolves?  Is there a cheap way of detecting
>>> this bug at runtime?
>>>
>>
>> It might be possible to do a few run-time checks, such as "does page that came 
>> back to put_user_page() have the correct flags?", but it's harder (without 
>> having a dedicated page flag) to detect the other direction: "did someone page 
>> in a get_user_pages page, to put_page?"
>>
>> As Jan said in his reply, converting get_user_pages (and put_user_page) to 
>> work with a new data type that wraps struct pages, would solve it, but that's
>> an awfully large change. Still...given how much of a mess this can turn into 
>> if it's wrong, I wonder if it's worth it--maybe? 
> 
> I'm certainly not opposed to looking into it. But after looking into this
> for a while it is not clear to me how to convert e.g. fs/direct-io.c or
> fs/iomap.c. They pass the reference from gup() via
> bio->bi_io_vec[]->bv_page and then release it after IO completion.
> Propagating the new type to ->bv_page is not good as lower layer do not
> really care how the page is pinned in memory. But we do need to somehow
> pass the information to the IO completion functions in a robust manner.
> 

You know, that problem has to be solved in either case: even if we do not
use a new data type for get_user_pages, we still need to clearly, accurately
match up the get/put pairs. And for the complicated systems (block IO, and
GPU DRM layer, especially) one of the things that has caused me concern is 
the way the pages all end up in a large, complicated pool, and put_page is
used to free all of them, indiscriminately.

So I'm glad you're looking at ways to disambiguate this for the bio system.

> Hmm, what about the following:
> 
> 1) Make gup() return new type - struct user_page *? In practice that would
> be just a struct page pointer with 0 bit set so that people are forced to
> use proper helpers and not just force types (and the setting of bit 0 and
> masking back would be hidden behind CONFIG_DEBUG_USER_PAGE_REFERENCES for
> performance reasons). Also the transition would have to be gradual so we'd
> have to name the function differently and use it from converted code.

Yes. That seems perfect: it just fades away if you're not debugging, but we
can catch lots of problems when CONFIG_DEBUG_USER_PAGE_REFERENCES is set. 

> 
> 2) Provide helper bio_add_user_page() that will take user_page, convert it
> to struct page, add it to the bio, and flag the bio as having pages with
> user references. That code would also make sure the bio is consistent in
> having only user-referenced pages in that case. IO completion (like
> bio_check_pages_dirty(), bio_release_pages() etc.) will check the flag and
> use approprite release function.

I'm very new to bio, so I have to ask: can we be sure that the same types of 
pages are always used, within each bio? Because otherwise, we'll have to plumb 
it all the way down to bio_vec's--or so it appears, based on my reading of 
bio_release_pages() and surrounding code.

> 
> 3) I have noticed fs/direct-io.c may submit zero page for IO when it needs
> to clear stuff so we'll probably need a helper function to acquire 'user pin'
> reference given a page pointer so that that code can be kept reasonably
> simple and pass user_page references all around.
>

This only works if we don't set page flags, because if we do set page flags 
on the single, global zero page, that will break the world. So I'm not sure
that the zero page usage in fs/directio.c is going to survive the conversion
to this new approach. :)
 
> So this way we could maintain reasonable confidence that refcounts didn't
> get mixed up. Thoughts?
> 

After thinking some more about the complicated situations in bio and DRM,
and looking into the future (bug reports...), I am leaning toward your 
struct user_page approach. 

I'm looking forward to hearing other opinions on whether it's worth it to go
and do this fairly intrusive change, in return for, probably, fewer bugs along
the way.


thanks,
-- 
John Hubbard
NVIDIA
