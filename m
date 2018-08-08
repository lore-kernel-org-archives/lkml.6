Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7ECC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 07:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C7E216F3
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 07:56:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0C7E216F3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbeHHKOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 06:14:47 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36076 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbeHHKOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 06:14:46 -0400
Received: by mail-wr1-f66.google.com with SMTP id h9-v6so1144506wro.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 00:56:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=erRqCe77Zf/w1weN4opA903ZI2qAxXY4n+C/DtE09nY=;
        b=tODHoua0QiTd17sfxj8zHd+PmvzFgWsmwY4uZ2bWA7eOcKjcjqx1d5QUQ0N1BaPdZh
         eHaFnTBsw4Qxv7/0PVs/Ez3/xn9IlX8Pgo+ibAqge8SPFW22t7Do+Dk7MyiTTjgVWjl1
         geIAfJ7NgUYoYPiSI5Gqz1sRG+l1legXS0A7rVKlT7fQFAcfiexeJyYubEXUZnTtjtAS
         XZCG71itndHUsj9UIHdq7tM3Ixwo+ih1m+hD+Nqv7QxXUIZwmXhxYWJ0Q+iVll65p0aW
         vVa1k9iVCyAS/AVycUiRSame2Uf5dCQa5Kc5pgD//4OHbrCBZ/PyWlJQS5CjcqEfNnP9
         TKNQ==
X-Gm-Message-State: AOUpUlEO/U2x0p2gYaF8f+Z6q0t7aJ6qnDB+pywHrVaP00pgkd4CBk7m
        Lj+EsWf0/LK0c5ZcTiUBdh4=
X-Google-Smtp-Source: AA+uWPwOTVom9iPejkcrDOhFPs/t822A/jtCWCqvF2ffvErodlsM0tPJPhsN/mCBwmbGU56y1FDbEQ==
X-Received: by 2002:a5d:4e92:: with SMTP id e18-v6mr1181696wru.32.1533714975651;
        Wed, 08 Aug 2018 00:56:15 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id m2-v6sm4082119wrw.76.2018.08.08.00.56.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 00:56:15 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 690E312476D; Wed,  8 Aug 2018 09:56:14 +0200 (CEST)
Date:   Wed, 8 Aug 2018 09:56:14 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     David Hildenbrand <david@redhat.com>
Cc:     Jerome Glisse <jglisse@redhat.com>, akpm@linux-foundation.org,
        mhocko@suse.com, dan.j.williams@intel.com, yasu.isimatu@gmail.com,
        logang@deltatee.com, dave.jiang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: Re: [RFC PATCH 2/3] mm/memory_hotplug: Create __shrink_pages and
 move it to offline_pages
Message-ID: <20180808075614.GB9568@techadventures.net>
References: <20180807133757.18352-1-osalvador@techadventures.net>
 <20180807133757.18352-3-osalvador@techadventures.net>
 <20180807135221.GA3301@redhat.com>
 <a6e4e654-fc95-497f-16f3-8c1550cf03d6@redhat.com>
 <20180807204834.GA6844@techadventures.net>
 <20180807221345.GD3301@redhat.com>
 <20180808073835.GA9568@techadventures.net>
 <44f74b58-aae0-a44c-3b98-7b1aac186f8e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44f74b58-aae0-a44c-3b98-7b1aac186f8e@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 09:45:37AM +0200, David Hildenbrand wrote:
> On 08.08.2018 09:38, Oscar Salvador wrote:
> > On Tue, Aug 07, 2018 at 06:13:45PM -0400, Jerome Glisse wrote:
> >>> And since we know for sure that memhotplug-code cannot call it with ZONE_DEVICE,
> >>> I think this can be done easily.
> >>
> >> This might change down road but for now this is correct. They are
> >> talks to enumerate device memory through standard platform mechanisms
> >> and thus the kernel might see new types of resources down the road and
> >> maybe we will want to hotplug them directly from regular hotplug path
> >> as ZONE_DEVICE (lot of hypothetical at this point ;)).
> > 
> > Well, I think that if that happens this whole thing will become
> > much easier, since we will not have several paths for doing the same thing.
> > 
> > Another thing that I realized is that while we want to move all operation-pages
> > from remove_memory() path to offline_pages(), this can get tricky.
> > 
> > Unless I am missing something, the devices from HMM and devm are not being registered
> > against "memory_subsys" struct, and so, they never get to call memory_subsys_offline()
> > and so offline_pages().
> > 
> > Which means that we would have to call __remove_zone() from those paths.
> > But this alone will not work.
> 
> I mean, they move it to the zone ("replacing online/offlining code"), so
> they should take of removing it again.

Yeah, I guess so.

I mean, of course we can make this work by placing __remove_zone in devm_memremap_pages_release
and hmm_devmem_release functions and make sure to call offline_mem_sections first.
But sounds a bit "hacky"..

Thanks
-- 
Oscar Salvador
SUSE L3
