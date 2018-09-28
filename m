Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DE7C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 19:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86CA6206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 19:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="E6sC6kVT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86CA6206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbeI2BbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 21:31:24 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:6025 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbeI2BbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 21:31:23 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bae7b750000>; Fri, 28 Sep 2018 12:05:26 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 28 Sep 2018 12:06:13 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 28 Sep 2018 12:06:13 -0700
Received: from [10.110.48.28] (10.110.48.28) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 28 Sep
 2018 19:06:12 +0000
Subject: Re: [PATCH 0/4] get_user_pages*() and RDMA: first steps
To:     Jerome Glisse <jglisse@redhat.com>, <john.hubbard@gmail.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>,
        Christian Benvenuti <benve@cisco.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>
References: <20180928053949.5381-1-jhubbard@nvidia.com>
 <20180928152958.GA3321@redhat.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <4c884529-e2ff-3808-9763-eb0e71f5a616@nvidia.com>
Date:   Fri, 28 Sep 2018 12:06:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180928152958.GA3321@redhat.com>
X-Originating-IP: [10.110.48.28]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1538161526; bh=cZtqCVfexqOsIXuxuL9ZrXL5pBrPhmX5KWUoyuRcWzQ=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=E6sC6kVTffKtlcE1z4VXI0DuuHPFuOwVrJ+rO4zYKM66H40ctegDN+xyfGj8Eb7m9
         aLQT4FCfK9TBGQNGFsUwzTt+F5d2VGYaWyvJov3Jn42WznzQVo7Bv3rjaEbvagHdlW
         OkXBt98ay81mdSwSYN1KsuEbYAeNQJ8Qdo6PPlnaDO9Wz7JVpz2p8JbUmZ0S3ySNXq
         B+cAO1MO4lv0T8qNaCgQTuWW+O67IYR8/n6IRYcTB72rmnlpxlhKeM8bzPxgsGfYz3
         u51Y93cMBBy2nGIBPB+W+2OO4Z3dl7MbWG9L/IsvbblzAZwKGLUfCPxCMAZkNDvxzv
         kRzc937Az/7Yg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/18 8:29 AM, Jerome Glisse wrote:
> On Thu, Sep 27, 2018 at 10:39:45PM -0700, john.hubbard@gmail.com wrote:
>> From: John Hubbard <jhubbard@nvidia.com>
>>
>> Hi,
>>
>> This short series prepares for eventually fixing the problem described
>> in [1], and is following a plan listed in [2].
>>
>> I'd like to get the first two patches into the -mm tree.
>>
>> Patch 1, although not technically critical to do now, is still nice to have,
>> because it's already been reviewed by Jan, and it's just one more thing on the
>> long TODO list here, that is ready to be checked off.
>>
>> Patch 2 is required in order to allow me (and others, if I'm lucky) to start
>> submitting changes to convert all of the callsites of get_user_pages*() and
>> put_page().  I think this will work a lot better than trying to maintain a
>> massive patchset and submitting all at once.
>>
>> Patch 3 converts infiniband drivers: put_page() --> put_user_page(). I picked
>> a fairly small and easy example.
>>
>> Patch 4 converts a small driver from put_page() --> release_user_pages(). This
>> could just as easily have been done as a change from put_page() to
>> put_user_page(). The reason I did it this way is that this provides a small and
>> simple caller of the new release_user_pages() routine. I wanted both of the
>> new routines, even though just placeholders, to have callers.
>>
>> Once these are all in, then the floodgates can open up to convert the large
>> number of get_user_pages*() callsites.
>>
>> [1] https://lwn.net/Articles/753027/ : "The Trouble with get_user_pages()"
>>
>> [2] https://lkml.kernel.org/r/20180709080554.21931-1-jhubbard@nvidia.com
>>     Proposed steps for fixing get_user_pages() + DMA problems.
>>
> 
> So the solution is to wait (possibly for days, months, years) that the
> RDMA or GPU which did GUP and do not have mmu notifier, release the page
> (or put_user_page()) ?
> 
> This sounds bads. Like i said during LSF/MM there is no way to properly
> fix hardware that can not be preempted/invalidated ... most GPU are fine.
> Few RDMA are fine, most can not ...
> 

Hi Jerome,

Personally, I'm think that this particular design is the best one I've seen
so far, but if other, better designs show up, than let's do those instead, sure.

I guess your main concern is that this might take longer than other approaches.

As for time frame, perhaps I made it sound worse than it really is. I have patches
staged already for all of the simpler call sites, and for about half of the more
complicated ones. The core solution in mm is not large, and we've gone through a 
few discussion threads about it back in July or so, so it shouldn't take too long
to perfect it.

So it may be a few months to get it all reviewed and submitted, but I don't
see "years" by any stretch.


> If it is just about fixing the set_page_dirty() bug then just looking at
> refcount versus mapcount should already tell you if you can remove the
> buffer head from the page or not. Which would fix the bug without complex
> changes (i still like the put_user_page just for symetry with GUP).
> 

It's about more than that. The goal is to make it safe and correct to
use a non-CPU device to read and write to "pinned" memory, especially when
that memory is backed by a file system.

I recall there were objections to just narrowly fixing the set_page_dirty()
bug, because the underlying problem is large and serious. So here we are.

thanks,
-- 
John Hubbard
NVIDIA

