Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91B7C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B9592084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="hgkaOWuA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B9592084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbeLLWRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 17:17:36 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:10092 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728337AbeLLWRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 17:17:33 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c1188f40000>; Wed, 12 Dec 2018 14:17:24 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 12 Dec 2018 14:17:28 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 12 Dec 2018 14:17:28 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 12 Dec
 2018 22:17:28 +0000
Subject: Re: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
To:     Jerome Glisse <jglisse@redhat.com>
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
        Jason Gunthorpe <jgg@ziepe.ca>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        <rcampbell@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20181207191620.GD3293@redhat.com>
 <3c4d46c0-aced-f96f-1bf3-725d02f11b60@nvidia.com>
 <20181208022445.GA7024@redhat.com> <20181210102846.GC29289@quack2.suse.cz>
 <20181212150319.GA3432@redhat.com>
 <CAPcyv4go0Xzhz8rXdfscWuXDu83BO9v8WD4upDUJWb7gKzX5OQ@mail.gmail.com>
 <20181212213005.GE5037@redhat.com>
 <514cc9e1-dc4d-b979-c6bc-88ac503c098d@nvidia.com>
 <20181212220418.GH5037@redhat.com>
 <311cd7a7-6727-a298-964e-ad238a30bdef@nvidia.com>
 <20181212221446.GI5037@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <2483bf1b-944e-ad3b-74f6-773a0aa8813c@nvidia.com>
Date:   Wed, 12 Dec 2018 14:17:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181212221446.GI5037@redhat.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1544653044; bh=WSBF5BoWMhSw1y8bxFCZvm4e+XFb5iL3/hlj9E+wdtQ=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=hgkaOWuAPiGd1hMtFupnP2yJu/+oR7hIw4buwpSVnaI7SnZWcGnX/VtEMAN66Qe0z
         oydhxFrwW7RSk4iSd/CcDffotKNrtiRhVPp7IkQ/3wa2eyyy2PFhqD8LoI7dVfLWEL
         JvgNUfPkjaQPg3ZXSt9JDsA/fwK4UN9Kd9Nw6KZhd1zeTZxjGjFR0skG/djqDc+IE6
         /JoXvpIuph5l03Aw0igMJNS7o7rxbGW742FWltKUa4Z4PER1oamfRZ0PYUMGmbTZVX
         vlvxjBT1rz6uq+y9gpp/pTDW9yN4Up0girGsYNPUa1jJNQUtaGg3xajfIMm8FRvNbK
         3qa2CzeoB1GAw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/18 2:14 PM, Jerome Glisse wrote:
> On Wed, Dec 12, 2018 at 02:11:58PM -0800, John Hubbard wrote:
>> On 12/12/18 2:04 PM, Jerome Glisse wrote:
>>> On Wed, Dec 12, 2018 at 01:56:00PM -0800, John Hubbard wrote:
>>>> On 12/12/18 1:30 PM, Jerome Glisse wrote:
>>>>> On Wed, Dec 12, 2018 at 08:27:35AM -0800, Dan Williams wrote:
>>>>>> On Wed, Dec 12, 2018 at 7:03 AM Jerome Glisse <jglisse@redhat.com> wrote:
>>>>>>>
>>>>>>> On Mon, Dec 10, 2018 at 11:28:46AM +0100, Jan Kara wrote:
>>>>>>>> On Fri 07-12-18 21:24:46, Jerome Glisse wrote:
[...]
>>>
>>>>>     Patch 1: register mmu notifier
>>>>>     Patch 2: listen to MMU_NOTIFY_TRUNCATE and MMU_NOTIFY_UNMAP
>>>>>              when that happens update the device page table or
>>>>>              usage to point to a crappy page and do put_user_page
>>>>>              on all previously held page
>>>>
>>>> Minor point, this sequence should be done within a wrapper around existing 
>>>> get_user_pages(), such as get_user_pages_revokable() or something.
>>>
>>> No we want to teach everyone to abide by the rules, if we add yet another
>>> GUP function prototype people will use the one where they don;t have to
>>> say they abide by the rules. It is time we advertise the fact that GUP
>>> should not be use willy nilly for anything without worrying about the
>>> implication it has :)
>>
>> Well, the best way to do that is to provide a named function call that 
>> implements the rules. That also makes it easy to grep around and see which
>> call sites still need upgrades, and which don't.
>>
>>>
>>> So i would rather see a consolidation in the number of GUP prototype we
>>> have than yet another one.
>>
>> We could eventually get rid of the older GUP prototypes, once we're done
>> converting. Having a new, named function call will *without question* make
>> the call site conversion go much easier, and the end result is also better:
>> the common code is in a central function, rather than being at all the call
>> sites.
>>
> 
> Then last patch in the patchset must remove all GUP prototype except
> ones with the right API :)
> 

Yes, exactly.


thanks,
-- 
John Hubbard
NVIDIA
