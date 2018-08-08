Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48EC3C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 13:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08E2A21762
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 13:42:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08E2A21762
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbeHHQCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 12:02:21 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38279 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbeHHQCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 12:02:21 -0400
Received: by mail-wm0-f68.google.com with SMTP id t25-v6so2803101wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 06:42:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ycZJOXh6UzuMWXvw1624x0vmupDIPzGFYr5dyjWPP9I=;
        b=VFBAVIjjNtWkuHNFzK8n5X/+O0Gy/IT8ivRj58TYxTFRdTPzskrzZDgEU550XVUurv
         HQZFvzFdHvZ++D56yuMQEQVSKBIMx4oB3rSJSDQGn2BNZLnCcPilcA9jNZij+JjxL20X
         9fkrwpAqVH3TVP0qVpXhb2LDma9CCFP5qAK+Z0v/IXZk8eJYgkF4tzAFEifs8SMzwJ/F
         RK2QZ+3tgNu46du1HvBkNcSVEzp8Oz8zLjlrqyUtWGnSkZpya1OZm8Ip1xrFkWdpnxWv
         wM7UYd9wACQL99if/2vfyh+H1zsDVYpSHf6UeJFOxe6XlgdguZBHIokjVk/ohNaTGRpX
         82/A==
X-Gm-Message-State: AOUpUlGGsCbDEieQ65okQqKEpHNaahkIalseBvsHCQv8E/q48WypsWze
        TGPrPqhU0+nFCSQArmT5s1w=
X-Google-Smtp-Source: AA+uWPyGFsHP8EaCEWChymdtv7Zh886WXZVTdQh3loZSYNLyYIg6BIHdoEc2JgkmavcwiyOqcRQbEA==
X-Received: by 2002:a1c:6f44:: with SMTP id k65-v6mr1845252wmc.19.1533735755994;
        Wed, 08 Aug 2018 06:42:35 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id 185-v6sm8025100wmy.38.2018.08.08.06.42.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 06:42:35 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id F1FB4124790; Wed,  8 Aug 2018 15:42:33 +0200 (CEST)
Date:   Wed, 8 Aug 2018 15:42:33 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     David Hildenbrand <david@redhat.com>
Cc:     Jerome Glisse <jglisse@redhat.com>, akpm@linux-foundation.org,
        mhocko@suse.com, dan.j.williams@intel.com, yasu.isimatu@gmail.com,
        logang@deltatee.com, dave.jiang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: Re: [RFC PATCH 2/3] mm/memory_hotplug: Create __shrink_pages and
 move it to offline_pages
Message-ID: <20180808134233.GA10946@techadventures.net>
References: <20180807133757.18352-1-osalvador@techadventures.net>
 <20180807133757.18352-3-osalvador@techadventures.net>
 <20180807135221.GA3301@redhat.com>
 <a6e4e654-fc95-497f-16f3-8c1550cf03d6@redhat.com>
 <20180807204834.GA6844@techadventures.net>
 <20180807221345.GD3301@redhat.com>
 <20180808073835.GA9568@techadventures.net>
 <44f74b58-aae0-a44c-3b98-7b1aac186f8e@redhat.com>
 <20180808075614.GB9568@techadventures.net>
 <7a64e67d-1df9-04ab-cc49-99a39aa90798@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a64e67d-1df9-04ab-cc49-99a39aa90798@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 10:08:41AM +0200, David Hildenbrand wrote:
> Then it is maybe time to cleary distinguish both types of memory, as
> they are fundamentally different when it comes to online/offline behavior.
> 
> Ordinary ram:
>  add_memory ...
>  online_pages ...
>  offline_pages
>  remove_memory
> 
> Device memory
>  add_device_memory ...
>  remove_device_memory
> 
> So adding/removing from the zone and stuff can be handled there.

Uhm, I have been thinking about this.
Maybe we could do something like (completely untested):


== memory_hotplug code ==

int add_device_memory(int nid, unsigned long start, unsigned long size,
                                struct vmem_altmap *altmap, bool mapping)
{
        int ret;
        unsigned long start_pfn = PHYS_PFN(start);
        unsigned long nr_pages = size >> PAGE_SHIFT;

        mem_hotplug_begin();
        if (mapping)
                ret = arch_add_memory(nid, start, size, altmap, false)
        else
                ret = add_pages(nid, start_pfn, nr_pages, altmap, false):

        if (!ret) {
                pgdata_t *pgdata = NODE_DATA(nid);
                struct zone *zone = pgdata->node_zones[ZONE_DEVICE];

                online_mem_sections(start_pfn, start_pfn + nr_pages);
                move_pfn_range_to_zone(zone, start_pfn, nr_pages, altmap);
        }
        mem_hotplug_done();

        return ret;
}

int del_device_memory(int nid, unsigned long start, unsigned long size,
                                struct vmem_altmap *altmap, bool mapping)
{
        int ret;
        unsigned long start_pfn = PHYS_PFN(start);
        unsigned long nr_pages = size >> PAGE_SHIFT;
        pgdata_t *pgdata = NODE_DATA(nid);
        struct zone *zone = pgdata->node_zones[ZONE_DEVICE];

        mem_hotplug_begin();

        offline_mem_sections(start_pfn, start_pfn + nr_pages);
        __shrink_pages(zone, start_pfn, start_pfn + nr_pages, nr_pages);

        if (mapping)
                ret = arch_remove_memory(nid, start, size, altmap)
        else
                ret = __remove_pages(nid, start_pfn, nr_pages, altmap)

        mem_hotplug_done();

        return ret;
}

===

And then, HMM/devm code could use it.

For example:

hmm_devmem_pages_create():

...
...
if (devmem->pagemap.type == MEMORY_DEVICE_PUBLIC)
	linear_mapping = true;
else
	linear_mapping = false;

ret = add_device_memory(nid, align_start, align_size, NULL, linear_mapping);
if (ret)
	goto error_add_memory;
...
...


hmm_devmem_release:

...
...
if (resource->desc == IORES_DESC_DEVICE_PRIVATE_MEMORY)
	mapping = false;
else
	mapping = true;

del_device_memory(nid, start_pfn << PAGE_SHIFT, npages << PAGE_SHIFT,
								NULL,
								mapping);
...
...


In this way, we do not need to play tricks in HMM/devm code, we just need to
call those functions when adding/removing memory.

We would still have to figure out a way to go for the release_mem_region_adjustable() stuff though.

Thanks
-- 
Oscar Salvador
SUSE L3
