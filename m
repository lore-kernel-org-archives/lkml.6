Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5762CC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 05:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E848E2086E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 05:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="UlxnlU9Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E848E2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbeIZLLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 07:11:49 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:1728 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbeIZLLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 07:11:49 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bab125c0000>; Tue, 25 Sep 2018 22:00:12 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 25 Sep 2018 22:00:46 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 25 Sep 2018 22:00:46 -0700
Received: from [10.110.48.28] (10.110.48.28) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 26 Sep
 2018 05:00:45 +0000
Subject: Re: [BUG] mm: direct I/O (using GUP) can write to COW anonymous pages
To:     Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>
CC:     Hugh Dickins <hughd@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        <sqazi@google.com>, "Michael S. Tsirkin" <mst@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Miklos Szeredi <miklos@szeredi.hu>, <john.hubbard@gmail.com>
References: <CAG48ez17Of=dnymzm8GAN_CNG1okMg1KTeMtBQhXGP2dyB5uJw@mail.gmail.com>
 <alpine.LSU.2.11.1809171628190.2225@eggly.anvils>
 <CAG48ez1hk5evqQpyvticPzLFOcESfo2NoWnqrLZk6N4PXwdsOw@mail.gmail.com>
 <20180918095822.GH10257@quack2.suse.cz>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <4a17705b-5ca9-296b-b24e-d2d9f10b4c06@nvidia.com>
Date:   Tue, 25 Sep 2018 22:00:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180918095822.GH10257@quack2.suse.cz>
X-Originating-IP: [10.110.48.28]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1537938012; bh=wqDsxABzUE8c/7q35edv8o0o9cYz8e4VO0t3mC1yF5k=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=UlxnlU9Q1GNa8tY16EcHXLPdirfKofK0NeDcpgzQFSw5ti9Cf+EMUNKe+HMEx9HEA
         3zopg+Q8iISYSOkZyCYY1MYwuxm3HL+YA8ClS52moTEmQKJRsYuKmYgUQ5Mhyx4Ef1
         h2qPxEMruQ3ow7DMKjJ2kIElm+//3zrkiEjrMJDN0z9mrMAhJnd2mkZRlzo4/Ua82g
         CjA40dHKnj+qvSMJNxOBY05lB2X/SKJb5D8vWpEAzFc6QCq9WX2i+lPabYcIJf83Wb
         oqGdOjqROVn1lbY5jFcIqWBhuBdMAmcJjKEh1jxsH5+0HoSCAb8BLptSSjUIlC8lyP
         Lzs7EeaHJZVoA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/18 2:58 AM, Jan Kara wrote:
> On Tue 18-09-18 02:35:43, Jann Horn wrote:
>> On Tue, Sep 18, 2018 at 2:05 AM Hugh Dickins <hughd@google.com> wrote:
> 
> Thanks for CC Hugh.
> 
>>> On Mon, 17 Sep 2018, Jann Horn wrote:
>>>
>>
>> Makes sense, I guess.
>>
>> I wonder whether there's a concise way to express this in the fork.2
>> manpage, or something like that. Maybe I'll take a stab at writing
>> something. The biggest issue I see with documenting this edgecase is
>> that, as an application developer, if you don't know whether some file
>> might be coming from a FUSE filesystem that has opted out of using the
>> disk cache, the "don't do that" essentially becomes "don't read() into
>> heap buffers while fork()ing in another thread", since with FUSE,
>> direct I/O can happen even if you don't open files as O_DIRECT as long
>> as the filesystem requests direct I/O, and get_user_pages_fast() will
>> AFAIU be used for non-page-aligned buffers, meaning that an adjacent
>> heap memory access could trigger CoW page duplication. But then, FUSE
>> filesystems that opt out of the disk cache are probably so rare that
>> it's not a concern in practice...
> 
> So at least for shared file mappings we do need to fix this issue as it's
> currently userspace triggerable Oops if you try hard enough. And with RDMA
> you don't even have to try that hard. Properly dealing with private
> mappings should not be that hard once the infrastructure is there I hope
> but I didn't seriously look into that. I've added Miklos and John to CC as
> they are interested as well. John was working on fixing this problem -
> https://lkml.org/lkml/2018/7/9/158 - but I didn't hear from him for quite a
> while so I'm not sure whether it died off or what's the current situation.
> 

Hi,

Sorry for missing this even though I was CC'd, I only just now noticed it, while
trying to get caught up again.

Anyway, I've been sidetracked for a...while (since July!), but am jumping back 
in and working on this now. And I've got time allocated for it. So here goes.

thanks,
-- 
John Hubbard
NVIDIA
