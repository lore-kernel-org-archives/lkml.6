Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43805C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 02:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA24E2073F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 02:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="TEiOKq/6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA24E2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbeI2Iyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 04:54:53 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:8598 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbeI2Iyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 04:54:53 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5baee3410000>; Fri, 28 Sep 2018 19:28:17 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 28 Sep 2018 19:28:17 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 28 Sep 2018 19:28:17 -0700
Received: from [10.110.48.28] (10.110.48.28) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 29 Sep
 2018 02:28:17 +0000
Subject: Re: [PATCH 0/4] get_user_pages*() and RDMA: first steps
To:     Jerome Glisse <jglisse@redhat.com>
CC:     <john.hubbard@gmail.com>, Matthew Wilcox <willy@infradead.org>,
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
 <4c884529-e2ff-3808-9763-eb0e71f5a616@nvidia.com>
 <20180928214934.GA3265@redhat.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <dfa6aaef-b97e-ebd4-6cc8-c907a7b3f9bb@nvidia.com>
Date:   Fri, 28 Sep 2018 19:28:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180928214934.GA3265@redhat.com>
X-Originating-IP: [10.110.48.28]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1538188097; bh=t+MQ6YuetpCFQopdhlrtuzedivNpAF672qcSMiwsNWM=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=TEiOKq/6iHLplxizoaBW9TrcL7ZhJTWVxiNfnuBUXz2A/NscYYOfx9kSsshZjMX8Z
         v4P5CegwHi1Xfiioyi1ixE0l79chH2/6k4IyTh8mSxv122af25bN2RwBR8nQoTSxao
         d5Obew8VrKiI4970tQhjMMZQgUSrIMnFrF8e04X82lgf/Gmt/eAt35/U4+yIPJ9z1G
         ZMAvY4u+VdFxe4lfc/1jKHzkVu1/iLLIVepSxNDsS4awkK/ZauJBFRpAkY9sYljc42
         kAaN2rtCsfV9IVLOtN9LYPFXQUXXQWKhJwHvvYvSCMCpVxcmMp0M2s83nr4PDNPtfj
         4mIbwFWOdHCpQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/18 2:49 PM, Jerome Glisse wrote:
> On Fri, Sep 28, 2018 at 12:06:12PM -0700, John Hubbard wrote:
>> On 9/28/18 8:29 AM, Jerome Glisse wrote:
>>> On Thu, Sep 27, 2018 at 10:39:45PM -0700, john.hubbard@gmail.com wrote:
>>>> From: John Hubbard <jhubbard@nvidia.com>
[...]
>>> So the solution is to wait (possibly for days, months, years) that the
>>> RDMA or GPU which did GUP and do not have mmu notifier, release the page
>>> (or put_user_page()) ?
>>>
>>> This sounds bads. Like i said during LSF/MM there is no way to properly
>>> fix hardware that can not be preempted/invalidated ... most GPU are fine.
>>> Few RDMA are fine, most can not ...
>>>
>>
>> Hi Jerome,
>>
>> Personally, I'm think that this particular design is the best one I've seen
>> so far, but if other, better designs show up, than let's do those instead, sure.
>>
>> I guess your main concern is that this might take longer than other approaches.
>>
>> As for time frame, perhaps I made it sound worse than it really is. I have patches
>> staged already for all of the simpler call sites, and for about half of the more
>> complicated ones. The core solution in mm is not large, and we've gone through a 
>> few discussion threads about it back in July or so, so it shouldn't take too long
>> to perfect it.
>>
>> So it may be a few months to get it all reviewed and submitted, but I don't
>> see "years" by any stretch.
> 
> Bit of miss-comprehention there :) By month, years, i am talking about
> the time it will take for some user to release the pin they have on the
> page. Not the time to push something upstream.
> 
> AFAICT RDMA driver do not have any upper bound on how long they can hold
> a page reference and thus your solution can leave one CPU core stuck for
> as long as the pin is active. Worst case might lead to all CPU core waiting
> for something that might never happen.
> 

Actually, the latest direction on that discussion was toward periodically
writing back, even while under RDMA, via bounce buffers:

  https://lkml.kernel.org/r/20180710082100.mkdwngdv5kkrcz6n@quack2.suse.cz

I still think that's viable. Of course, there are other things besides 
writeback (see below) that might also lead to waiting.

>>> If it is just about fixing the set_page_dirty() bug then just looking at
>>> refcount versus mapcount should already tell you if you can remove the
>>> buffer head from the page or not. Which would fix the bug without complex
>>> changes (i still like the put_user_page just for symetry with GUP).
>>>
>>
>> It's about more than that. The goal is to make it safe and correct to
>> use a non-CPU device to read and write to "pinned" memory, especially when
>> that memory is backed by a file system.
>>
>> I recall there were objections to just narrowly fixing the set_page_dirty()
>> bug, because the underlying problem is large and serious. So here we are.
> 
> Except that you can not solve that issue without proper hardware. GPU are
> fine. RDMA are broken except the mellanox5 hardware which can invalidate
> at anytime its page table thus allowing to write protect the page at any
> time.

Today, people are out there using RDMA without page-fault-capable hardware.
And they are hitting problems, as we've seen. From the discussions so far,
I don't think it's impossible to solve the problems, even for "lesser", 
non-fault-capable hardware. Especially once we decide on what is reasonable
and supported.  Certainly the existing situation needs *something* to 
change, even if it's (I don't recommend this) "go forth and tell the world
to stop using RDMA with their current hardware".

> 
> With the solution put forward here you can potentialy wait _forever_ for
> the driver that holds a pin to drop it. This was the point i was trying to
> get accross during LSF/MM. 

I agree that just blocking indefinitely is generally unacceptable for kernel
code, but we can probably avoid it for many cases (bounce buffers), and
if we think it is really appropriate (file system unmounting, maybe?) then
maybe tolerate it in some rare cases.  

>You can not fix broken hardware that decided to
> use GUP to do a feature they can't reliably do because their hardware is
> not capable to behave.
> 
> Because code is easier here is what i was meaning:
> 
> https://cgit.freedesktop.org/~glisse/linux/commit/?h=gup&id=a5dbc0fe7e71d347067579f13579df372ec48389
> https://cgit.freedesktop.org/~glisse/linux/commit/?h=gup&id=01677bc039c791a16d5f82b3ef84917d62fac826
> 

While that may work sometimes, I don't think it is reliable enough to trust for
identifying pages that have been gup-pinned. There's just too much overloading of
other mechanisms going on there, and if we pile on top with this constraint of "if you
have +3 refcounts, and this particular combination of page counts and mapcounts, then
you're definitely a long-term pinned page", I think users will find a lot of corner
cases for us that break that assumption. 

So I think we agree that the put_user_page() approach, to complement the
get_user_pages*() call sites, is worth doing regardless of the details of the core
solution. btw, now that I'm refreshing my memory of our earlier discussions: Jan had an
interesting point that "long-term pinned" is a property of the call site, rather than
of the page:

  https://lkml.kernel.org/r/20180704104318.f5pnqtnn3unkwauw@quack2.suse.cz

...which really sounded like a useful way to think about this.

Here's what I think would help:

1) I'll send out a freshened-up RFC for the core implementation (it's hard to talk about
here without that, although your code above helps), and we can hammer out some answers
there.

2) I'll work through remaining comments (Jason had some) on this and respin this patchset.

Basically, I'm hearing "Jerome is totally going to ACK this, but maybe disagree about
some or all of the upcoming RFC". But then again, I hear what I want to hear! :)


thanks,
-- 
John Hubbard
NVIDIA
