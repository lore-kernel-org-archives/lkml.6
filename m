Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2921C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 07:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 890DE21486
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 07:50:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 890DE21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbeHVLOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 07:14:07 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:56133 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727396AbeHVLOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 07:14:07 -0400
Received: by mail-wm0-f44.google.com with SMTP id f21-v6so1105057wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 00:50:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RXFsFv+lBt8R9Z8QH6feWWIWVr7wGHh+bMm98XVSHBY=;
        b=fGGXx7pyYCLt+RGoA9B93Bxcxx+aRxHKCbl8ynhO3t0+cztrn2RG2Wu9X3SWj6pMNl
         6gNn/dSKG2eaMGt4DzQE2MWVaNNVQwlKAcH/hh4Fd4mFzourC/px7LPDkGk0me/koaZj
         L7GKgEmWNkq1A3y9QWZUAVNUJUBS9hZNr8vPQL1mMnjIj1nQz6OsBOvaLCsMbMoWb+hm
         8kJ5xbtpbs4PuVpk8EHKfKYppINirCfvDTKX5gvGYdwvpiNtO2fgPfui6p79sbB10pWJ
         6uhcZcQeSxU5c/q3eJ11vBg7zeuQ7jhgGtJsds0EgMeiyRk35MW1zaac3PSEDCNNoOjr
         57kQ==
X-Gm-Message-State: APzg51CDYr6WnIoky4t1+RN7o8/ZLy446MUBqMZY8ed8PLTxBqqdngez
        z5z8mLT7W9mUQeZQlf5yY3M=
X-Google-Smtp-Source: ANB0VdZXFoiTr3anRBcnkq1gIp+2A/W8vnEmZ1Tpj9OBIfASZH6nNFSspVmLW6fbzqaZiSY2JkCvjw==
X-Received: by 2002:a1c:8e04:: with SMTP id q4-v6mr1635127wmd.150.1534924222227;
        Wed, 22 Aug 2018 00:50:22 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id o81-v6sm1120594wmo.28.2018.08.22.00.50.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 00:50:21 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 7F118124A09; Wed, 22 Aug 2018 09:50:20 +0200 (CEST)
Date:   Wed, 22 Aug 2018 09:50:20 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com,
        dan.j.williams@intel.com, jglisse@redhat.com,
        jonathan.cameron@huawei.com, Pavel.Tatashin@microsoft.com,
        yasu.isimatu@gmail.com, logang@deltatee.com, dave.jiang@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [RFC v2 2/2] mm/memory_hotplug: Shrink spanned pages when
 offlining memory
Message-ID: <20180822075020.GA14550@techadventures.net>
References: <20180817154127.28602-1-osalvador@techadventures.net>
 <20180817154127.28602-3-osalvador@techadventures.net>
 <a18525a5-ea5f-5e7a-8765-a6c0e38ddd21@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a18525a5-ea5f-5e7a-8765-a6c0e38ddd21@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 03:17:10PM +0200, David Hildenbrand wrote:
> > add_device_memory is in charge of
> 
> I wouldn't use the terminology of onlining/offlining here. That applies
> rather to memory that is exposed to the rest of the system (e.g. buddy
> allocator, has underlying memory block devices). I guess it is rather a
> pure setup/teardown of that device memory.

Hi David,

I am not sure if you are referring to:

"
a) calling either arch_add_memory() or add_pages(), depending on whether
   we want a linear mapping
b) online the memory sections that correspond to the pfn range
c) calling move_pfn_range_to_zone() being zone ZONE_DEVICE to
   expand zone/pgdat spanned pages and initialize its pages
"

Well, that is partialy true.
I mean, in order to make this work, we need to offline/online the memory
sections, because shrink_pages will rely on that from now on.
Is what we do when online/offline pages, but since device memory
does not go through the "official" channels, we need to do it there
as well.

Sure I can use another terminology, but since that is what
offline/online_mem_sections do, I just came up with that.

> I would really like to see the mem_hotplug_begin/end also getting moved
> inside add_device_memory()/del_device_memory(). (just like for
> add/remove_memory)
> 
> I wonder if kasan_ stuff actually requires this lock, or if it could
> also be somehow moved inside add_device_memory/del_device_memory.

Yes, that was my first approach, but then I saw that the kasan stuff is being
handled whithin those locks, so I was not sure and I backed off leaving the
mem_hotplug_begin/end where they were.

Maybe Jerome can shed some light and, and we can just handle the kasan stuff
out of the locks.

> Maybe shorten that a bit
> 
> "HMM/devm memory does not have IORESOURCE_SYSTEM_RAM set. They use
>  devm_request_mem_region/devm_release_mem_region to add/release a
>  resource. Just back off here."

Uhm, fair enough.

> Any reason for these indirections?

I wanted to hide the internals in the memory_hotplug code.
I thought about removing them, but I finally left them.
If people think that we are better off without them, I can just
remove them.

> I guess for readability, this patch could be split up into several
> patches. E.g. factoring out of add_device_memory/del_device_memory,
> release_mem_region_adjustable change ...

Yes, really true.
But I wanted first to gather feedback mainly from HMM/devm people to see
if they saw an outright bug within the series because I am not so
familiar with that part of the code.

Feedback from Jerome/Dan will be appreciate as well to see if this is a good
direction.

But you are right, in the end, this will have to be slipt up into several
parts to ease the review.

Thanks for reviewing this David!
I will try to address your concerns.

Thanks 
-- 
Oscar Salvador
SUSE L3
