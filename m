Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9536C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7296921729
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:45:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7296921729
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbeHHMD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 08:03:59 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34796 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbeHHMD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 08:03:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id c13-v6so1449889wrt.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 02:45:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mX/hQwsfBkULlSp0ufj2CAyHlVO5e8bD6UOLyT42ER8=;
        b=KgbMTpXZLsttdYDI/srjBlAc4dyKY+Vivu3mG+bbYIlMufvpJPhQSDVtm/YTGTTJzY
         rMegKnzpZu020h/76FsfxgHA3y9ZlE7WhYNN33HKG4IWIBwNXEs1f3qVcGjZjhNaf0xX
         1yV+1ou7cAAYX8GD9G+ydryTVsoEbSEqPaHM253EWA2DOo+6aS+66DdtYR3BQe9JQ+st
         aSyk9rRjN6O0DdXjozgG+z2epw+zCzbM7UQaTqFiR5A74Rhn3TjPStfIc9TrQ4E2BE61
         s64QivKYdBug6u6zCBx8Go/2nQ9RupKmpSbTL+wJzeTT7pkJF591JeyYjP5NWdqZRQ+w
         sDbA==
X-Gm-Message-State: AOUpUlEwpNzp1Cf5nXBpsQSV2EBullX6q+jLXgibW/CbMQKqGgT9Szl7
        FeaUskNi6HZQJlWaDccu7zM=
X-Google-Smtp-Source: AA+uWPzPKjEvRfknUhgA4Y5py7iF8UrgaQkbuPD3doOODTWu/Z/uHrEZwlwXlPj7fLar4w0Y8Qvbqg==
X-Received: by 2002:adf:9d46:: with SMTP id o6-v6mr1392503wre.51.1533721503515;
        Wed, 08 Aug 2018 02:45:03 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id p3-v6sm4229523wrg.47.2018.08.08.02.45.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 02:45:02 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 13F69124779; Wed,  8 Aug 2018 11:45:02 +0200 (CEST)
Date:   Wed, 8 Aug 2018 11:45:02 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Michal Hocko <mhocko@kernel.org>, akpm@linux-foundation.org,
        dan.j.williams@intel.com, david@redhat.com, yasu.isimatu@gmail.com,
        logang@deltatee.com, dave.jiang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: Re: [RFC PATCH 2/3] mm/memory_hotplug: Create __shrink_pages and
 move it to offline_pages
Message-ID: <20180808094502.GA10068@techadventures.net>
References: <20180807133757.18352-1-osalvador@techadventures.net>
 <20180807133757.18352-3-osalvador@techadventures.net>
 <20180807135221.GA3301@redhat.com>
 <20180807145900.GH10003@dhcp22.suse.cz>
 <20180807151810.GB3301@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807151810.GB3301@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 11:18:10AM -0400, Jerome Glisse wrote:
> Correct, you should not call release_mem_region_adjustable() the device
> region is not part of regular iomem resource as it might not necessarily
> be enumerated through known ways to the kernel (ie only the device driver
> can discover the region and core kernel do not know about it).
> 
> One of the issue to adding this region to iomem resource is that they
> really need to be ignored by core kernel because you can not assume that
> CPU can actually access them. Moreover, if CPU can access them it is
> likely that CPU can not do atomic operation on them (ie what happens on
> a CPU atomic instruction is undefined). So they are _special_ and only
> make sense to be use in conjunction with a device driver.
> 
> 
> Also in the case they do exist in iomem resource it is as PCIE BAR so
> as IORESOURCE_IO (iirc) and thus release_mem_region_adjustable() would
> return -EINVAL. Thought nothing bad happens because of that, only a
> warning message that might confuse the user.

Just to see if I understand this correctly.
I guess that these regions are being registered via devm_request_mem_region() calls.
Among other callers, devm_request_mem_region() is being called from:

dax_pmem_probe
hmm_devmem_add

AFAICS from the code, those regions will inherit the flags from the parent, which is iomem_resource:

#define devm_request_mem_region(dev,start,n,name) \
	__devm_request_region(dev, &iomem_resource, (start), (n), (name))

struct resource iomem_resource = {
	.name	= "PCI mem",
	.start	= 0,
	.end	= -1,
	.flags	= IORESOURCE_MEM,
};


struct resource * __request_region()
{
	...
	...
	res->flags = resource_type(parent) | resource_ext_type(parent);
	res->flags |= IORESOURCE_BUSY | flags;
	res->desc = parent->desc;
	...
	...
}

So the regions will not be tagged as IORESOURCE_IO but IORESOURCE_MEM.
From the first glance release_mem_region_adjustable() looks like it does
more things than __release_region(), and I did not check it deeply
but maybe we can make it work.

Thanks
-- 
Oscar Salvador
SUSE L3
