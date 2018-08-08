Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28914C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 07:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6C1F205C9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 07:38:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6C1F205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbeHHJ5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 05:57:03 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37117 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbeHHJ5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 05:57:03 -0400
Received: by mail-wr1-f65.google.com with SMTP id u12-v6so1094608wrr.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 00:38:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QSUkCzv0KmOT0y96k9iexRlheO+mhe9fWp3mCh/VAO8=;
        b=nsQvDmLKVg5qbDgPz4h2bYJuYDOBaZI7r5jQeMlIOvD1epKj7hejvlvvj1Fp8wu8oS
         cSRGnZai7BhfB/0pujER59Im5i8WabJw1pyWc2sgdoMQronP0ypc3tsevX4F5HNake+g
         KWPNe+d6n7gLrgnI4CXOaj7brBAe/OP/vmbucTeQxQD+1XEVkuuN7rGZNeUd/GJWEZ3x
         mzgYqphwRT4ZH7Z0IQKrA6DhqITSxzh+pjJJHjYk9tNtOYXykIhen5So3noglj89JCFG
         Ulvbis5KGpF8cayJgWQT5GSbyEyUOe61MJBNqvJWKaJ7dvU6E//2SU7lUob9KBhQZNGq
         fsqg==
X-Gm-Message-State: AOUpUlFOk1ybBaVN2S05Pw5ah2yhMveqSHSoKrtZ82dLhOXmeerslJJw
        hD1WfHWZklTWaizkw0iX1Rg=
X-Google-Smtp-Source: AA+uWPz8W0yaK9TrkIAp0eIWHAlhor5METjXqT+/F3kzaYVFgwTJUQiHu/zjcfPwZLfHPdzvLG4x+w==
X-Received: by 2002:adf:84e5:: with SMTP id 92-v6mr1134511wrg.56.1533713916810;
        Wed, 08 Aug 2018 00:38:36 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id v65-v6sm4478465wme.22.2018.08.08.00.38.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 00:38:36 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 42F25124766; Wed,  8 Aug 2018 09:38:35 +0200 (CEST)
Date:   Wed, 8 Aug 2018 09:38:35 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        mhocko@suse.com, dan.j.williams@intel.com,
        pasha.tatashin@oracle.com, yasu.isimatu@gmail.com,
        logang@deltatee.com, dave.jiang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: Re: [RFC PATCH 2/3] mm/memory_hotplug: Create __shrink_pages and
 move it to offline_pages
Message-ID: <20180808073835.GA9568@techadventures.net>
References: <20180807133757.18352-1-osalvador@techadventures.net>
 <20180807133757.18352-3-osalvador@techadventures.net>
 <20180807135221.GA3301@redhat.com>
 <a6e4e654-fc95-497f-16f3-8c1550cf03d6@redhat.com>
 <20180807204834.GA6844@techadventures.net>
 <20180807221345.GD3301@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807221345.GD3301@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 06:13:45PM -0400, Jerome Glisse wrote:
> > And since we know for sure that memhotplug-code cannot call it with ZONE_DEVICE,
> > I think this can be done easily.
> 
> This might change down road but for now this is correct. They are
> talks to enumerate device memory through standard platform mechanisms
> and thus the kernel might see new types of resources down the road and
> maybe we will want to hotplug them directly from regular hotplug path
> as ZONE_DEVICE (lot of hypothetical at this point ;)).

Well, I think that if that happens this whole thing will become
much easier, since we will not have several paths for doing the same thing.

Another thing that I realized is that while we want to move all operation-pages
from remove_memory() path to offline_pages(), this can get tricky.

Unless I am missing something, the devices from HMM and devm are not being registered
against "memory_subsys" struct, and so, they never get to call memory_subsys_offline()
and so offline_pages().

Which means that we would have to call __remove_zone() from those paths.
But this alone will not work.

find_smallest/biggest_section_pfn are two functions that are being called from

shrink_pgdat_span
and
shrink_zone_span

to adjust zone_first_pfn/node_first_pfn and the spanned pages.

Currently, find_smallest/biggest_section_pfn checks for the secion to be valid,
and this is fine since we are removing those sections from the remove_memory path.

But if we want to move __remove_zone() to offline_pages(), we have to use
online_section() instead of valid_section().

This is all fine from offline_pages because the sections get offlined in:

__offline_pages
 offline_isolated_pages
  offline_isolated_pages_cb
   __offline_isolated_pages
    offline_mem_sections


But this does not happen in HMM/devm path.

I am pretty sure this is a dumb question, but why HMM/devm path
do not call online_pages/offline_pages?

Thanks
-- 
Oscar Salvador
SUSE L3
