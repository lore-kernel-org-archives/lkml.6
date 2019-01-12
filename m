Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB635C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 03:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1EF320870
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 03:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="aRkCkU+I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfALDGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 22:06:11 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:1256 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbfALDGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 22:06:11 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c3959870000>; Fri, 11 Jan 2019 19:05:43 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 11 Jan 2019 19:06:10 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 11 Jan 2019 19:06:10 -0800
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 12 Jan
 2019 03:06:09 +0000
Received: from [10.110.48.28] (172.20.13.39) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 12 Jan
 2019 03:06:09 +0000
Subject: Re: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
To:     Jerome Glisse <jglisse@redhat.com>
CC:     Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        "Dave Chinner" <david@fromorbit.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "John Hubbard" <john.hubbard@gmail.com>,
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
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20181219020723.GD4347@redhat.com>
 <20181219110856.GA18345@quack2.suse.cz> <20190103015533.GA15619@redhat.com>
 <20190103092654.GA31370@quack2.suse.cz> <20190103144405.GC3395@redhat.com>
 <a79b259b-3982-b271-025a-0656f70506f4@nvidia.com>
 <20190111165141.GB3190@redhat.com>
 <1b37061c-5598-1b02-2983-80003f1c71f2@nvidia.com>
 <20190112020228.GA5059@redhat.com>
 <294bdcfa-5bf9-9c09-9d43-875e8375e264@nvidia.com>
 <20190112024625.GB5059@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <b6f4ed36-fc8d-1f9b-8c74-b12f61d496ae@nvidia.com>
Date:   Fri, 11 Jan 2019 19:06:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190112024625.GB5059@redhat.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL102.nvidia.com (172.18.146.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1547262343; bh=R5a0O5J95KN3DTRarOwPo9CsjS/HpgzulQWk79iQGkk=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=aRkCkU+ITPsu/CfD2PjidubiKdZAyX9HvTTz4s3VTn6Xt1IdMSXDxs7wl2fwHDYAk
         bhEw98qhuqHuOEEtLLVHWd15BEENt3nH2ImAjcQz8gH9n9iQTPR2TIyrsW58CLNM12
         lC9IvZXRfZlbqGZNOoqxSnG7VvnRjzYZOw+SCMXVdop3JOoHHWyDHG7ymr2iLcAiIX
         ewOT0SBH8JEAYhBsdlWIfT+qFLgIesS8fN8jv+5q0qa2+acaZL1VOFbKsOB+PyYpWJ
         EC86GI4RIDvV7bJlsS7ESzsDpZVwNrmb6k4pMlq4fIo48DAsTaM3DIpwpiWZBOtyWi
         btGJc4b8NBQwA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/19 6:46 PM, Jerome Glisse wrote:
> On Fri, Jan 11, 2019 at 06:38:44PM -0800, John Hubbard wrote:
>> On 1/11/19 6:02 PM, Jerome Glisse wrote:
>>> On Fri, Jan 11, 2019 at 05:04:05PM -0800, John Hubbard wrote:
>>>> On 1/11/19 8:51 AM, Jerome Glisse wrote:
>>>>> On Thu, Jan 10, 2019 at 06:59:31PM -0800, John Hubbard wrote:
>>>>>> On 1/3/19 6:44 AM, Jerome Glisse wrote:
>>>>>>> On Thu, Jan 03, 2019 at 10:26:54AM +0100, Jan Kara wrote:
>>>>>>>> On Wed 02-01-19 20:55:33, Jerome Glisse wrote:
>>>>>>>>> On Wed, Dec 19, 2018 at 12:08:56PM +0100, Jan Kara wrote:
>>>>>>>>>> On Tue 18-12-18 21:07:24, Jerome Glisse wrote:
>>>>>>>>>>> On Tue, Dec 18, 2018 at 03:29:34PM -0800, John Hubbard wrote:
>>>>> [...]
>>>>
>>>> Hi Jerome,
>>>>
>>>> Looks good, in a conceptual sense. Let me do a brain dump of how I see it,
>>>> in case anyone spots a disastrous conceptual error (such as the lock_page
>>>> point), while I'm putting together the revised patchset.
>>>>
>>>> I've studied this carefully, and I agree that using mapcount in 
>>>> this way is viable, *as long* as we use a lock (or a construct that looks just 
>>>> like one: your "memory barrier, check, retry" is really just a lock) in
>>>> order to hold off gup() while page_mkclean() is in progress. In other words,
>>>> nothing that increments mapcount may proceed while page_mkclean() is running.
>>>
>>> No, increment to page->_mapcount are fine while page_mkclean() is running.
>>> The above solution do work no matter what happens thanks to the memory
>>> barrier. By clearing the pin flag first and reading the page->_mapcount
>>> after (and doing the reverse in GUP) we know that a racing GUP will either
>>> have its pin page clear but the incremented mapcount taken into account by
>>> page_mkclean() or page_mkclean() will miss the incremented mapcount but
>>> it will also no clear the pin flag set concurrently by any GUP.
>>>
>>> Here are all the possible time line:
>>> [T1]:
>>> GUP on CPU0                      | page_mkclean() on CPU1
>>>                                  |
>>> [G2] atomic_inc(&page->mapcount) |
>>> [G3] smp_wmb();                  |
>>> [G4] SetPagePin(page);           |
>>>                                 ...
>>>                                  | [C1] pined = TestClearPagePin(page);
>>
>> It appears that you're using the "page pin is clear" to indicate that
>> page_mkclean() is running. The problem is, that approach leads to toggling
>> the PagePin flag, and so an observer (other than gup or page_mkclean) will
>> see intervals during which the PagePin flag is clear, when conceptually it
>> should be set.
>>
>> Jan and other FS people, is it definitely the case that we only have to take
>> action (defer, wait, revoke, etc) for gup-pinned pages, in page_mkclean()?
>> Because I recall from earlier experiments that there were several places, not 
>> just page_mkclean().
> 
> Yes and it is fine to temporarily have the pin flag unstable. Anything
> that need stable page content will have to lock the page so will have
> to sync against any page_mkclean() and in the end the only thing were
> we want to check the pin flag is when doing write back ie after
> page_mkclean() while the page is still locked. If they are any other
> place that need to check the pin flag then they will need to lock the
> page. But i can not think of any other place right now.
> 
> 

OK. Yes, since the clearing and resetting happens under page lock, that will
suffice to synchronize it. That's a good point.

> [...]
> 
>>>> The other idea that you and Dan (and maybe others) pointed out was a debug
>>>> option, which we'll certainly need in order to safely convert all the call
>>>> sites. (Mirror the mappings at a different kernel offset, so that put_page()
>>>> and put_user_page() can verify that the right call was made.)  That will be
>>>> a separate patchset, as you recommended.
>>>>
>>>> I'll even go as far as recommending the page lock itself. I realize that this 
>>>> adds overhead to gup(), but we *must* hold off page_mkclean(), and I believe
>>>> that this (below) has similar overhead to the notes above--but is *much* easier
>>>> to verify correct. (If the page lock is unacceptable due to being so widely used,
>>>> then I'd recommend using another page bit to do the same thing.)
>>>
>>> Please page lock is pointless and it will not work for GUP fast. The above
>>> scheme do work and is fine. I spend the day again thinking about all memory
>>> ordering and i do not see any issues.
>>>
>>
>> Why is it that page lock cannot be used for gup fast, btw?
> 
> Well it can not happen within the preempt disable section. But after
> as a post pass before GUP_fast return and after reenabling preempt then
> it is fine like it would be for regular GUP. But locking page for GUP
> is also likely to slow down some workload (with direct-IO).
> 

Right, and so to crux of the matter: taking an uncontended page lock involves
pretty much the same set of operations that your approach does. (If gup ends up
contended with the page lock for other reasons than these paths, that seems
surprising.) I'd expect very similar performance.

But the page lock approach leads to really dramatically simpler code (and code
reviews, let's not forget). Any objection to my going that direction, and keeping
this idea as a Plan B? I think the next step will be, once again, to gather some
performance metrics, so maybe that will help us decide.


thanks,
-- 
John Hubbard
NVIDIA

