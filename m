Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D1FC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 14:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF6F2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 14:58:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDF6F2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403959AbeHPR5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 13:57:54 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:56232 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbeHPR5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 13:57:54 -0400
Received: by mail-wm0-f67.google.com with SMTP id f21-v6so4768699wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 07:58:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fI41CY9gpxX1U74eBVvDEDeEuWg5DUse5b/sAhmVZ9A=;
        b=Lsv0YKm6b3xLUXNK+dFIR8bEDXZF6rKiuSrYvmZMk5zVL4R3F1ZAYpohPQVIL/DfZj
         UqCHfGbWjns+CPq/7JoeHNIghdLFd6c3YY3K84yMWnFZpuOYqB6CUaezH3TWZcNbw/Ss
         BQDPPTbsFlbJ/DQLRt8AO3mgsCmNyWgo3T2kS0WjTSwH4UFNBSCYLAcvtedJe9Ik+KnR
         V1gyoSE/bP+UET9+0UpOZIvEkEkqxREYEBHeSs2FeE1OVstFoF98htEgTrWISdvJaFkL
         wbWSpLfcMALyZ+jH/2znfpx5/jhNsbgmLdw5qM9epwh8jh37NFb47pbeuLzuqthovi3K
         6i6g==
X-Gm-Message-State: AOUpUlFl38qZQN7gV63TNej9ljanKDWq/7VzwXuWELgtTVapDP/Wn/vk
        MQdqIf+1aDTjhc7qkblUgPPNIokAAyE=
X-Google-Smtp-Source: AA+uWPxgMFw65i3NRENhO36c864gwfPFKWBaoWG3dztzZyYMVoQs/P8gFgS2JnJKaFHbdX2IUbajaA==
X-Received: by 2002:a1c:ea17:: with SMTP id i23-v6mr16762341wmh.29.1534431531227;
        Thu, 16 Aug 2018 07:58:51 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id v14-v6sm770264wmh.41.2018.08.16.07.58.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Aug 2018 07:58:50 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 6FA2C1248F0; Thu, 16 Aug 2018 16:58:49 +0200 (CEST)
Date:   Thu, 16 Aug 2018 16:58:49 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Michal Hocko <mhocko@kernel.org>, akpm@linux-foundation.org,
        dan.j.williams@intel.com, Pavel.Tatashin@microsoft.com,
        david@redhat.com, yasu.isimatu@gmail.com, logang@deltatee.com,
        dave.jiang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: Re: [RFC PATCH 2/3] mm/memory_hotplug: Create __shrink_pages and
 move it to offline_pages
Message-ID: <20180816145849.GA17638@techadventures.net>
References: <20180807133757.18352-3-osalvador@techadventures.net>
 <20180807135221.GA3301@redhat.com>
 <20180807145900.GH10003@dhcp22.suse.cz>
 <20180807151810.GB3301@redhat.com>
 <20180808064758.GB27972@dhcp22.suse.cz>
 <20180808165814.GB3429@redhat.com>
 <20180809082415.GB24884@dhcp22.suse.cz>
 <20180809142709.GA3386@redhat.com>
 <20180809150950.GB15611@dhcp22.suse.cz>
 <20180809165821.GC3386@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180809165821.GC3386@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 12:58:21PM -0400, Jerome Glisse wrote:
> I agree, i never thought about that before. Looking at existing resource
> management i think the simplest solution would be to use a refcount on the
> resources instead of the IORESOURCE_BUSY flags.
> 
> So when you release resource as part of hotremove you would only dec the
> refcount and a resource is not busy only when refcount is zero.
> 
> Just the idea i had in mind. Right now i am working on other thing, Oscar
> is this something you would like to work on ? Feel free to come up with
> something better than my first idea :)

So, I thought a bit about this.
First I talked a bit with Jerome about the refcount idea.
The problem with reconverting this to refcount is that it is too intrusive,
and I think it is not really needed.

I then thought about defining a new flag, something like

#define IORESOURCE_NO_HOTREMOVE	xxx

but we ran out of bits for the flag field.

I then thought about doing something like:

struct resource {
        resource_size_t start;
        resource_size_t end;
        const char *name;
        unsigned long flags;
        unsigned long desc;
        struct resource *parent, *sibling, *child;
#ifdef CONFIG_MEMORY_HOTREMOVE
        bool device_managed;
#endif
};

but it is just too awful, not needed, and bytes consuming.

The only idea I had left is:

register_memory_resource(), which defines a new resource for the added memory-chunk
is only called from add_memory().
This function is only being hit when we add memory-chunks.

HMM/devm gets the resources their own way, calling devm_request_mem_region().

So resources that are requested from HMM/devm, have the following flags:

 (IORESOURCE_MEM|IORESOURCE_BUSY)

while resources that are requested via mem-hotplug have:

 (IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY)

IORESOURCE_SYSTEM_RAM = (IORESOURCE_MEM|IORESOURCE_SYSRAM)


release_mem_region_adjustable() is only being called from hot-remove path, so
unless I am mistaken, all resources hitting that path should match IORESOURCE_SYSTEM_RAM.

That leaves me with the idea that we could check for the resource->flags to contain IORESOURCE_SYSRAM,
as I think it is only being set for memory-chunks that are added via memory-hot-add path.

In case it is not, we know that that resource belongs to HMM/devm, so we can back off since
they take care of releasing the resource via devm_release_mem_region.

I am working on a RFC v2 containing this, but, Jerome, could you confirm above assumption, please?

Of course, ideas/suggestions are also welcome.

Thanks
-- 
Oscar Salvador
SUSE L3
