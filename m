Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD83C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 20:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28B10208B6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 20:48:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28B10208B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbeHGXEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 19:04:50 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35136 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeHGXEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 19:04:50 -0400
Received: by mail-wr1-f66.google.com with SMTP id g1-v6so28592wru.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 13:48:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9/PQg3vyzDMNzwKAoNuBf6PJv8UKMGxUfCo+EXMJ12w=;
        b=MUDIN4Z88mhRnxMN1bDXVQROyAjJTtaFDzJ6BpiKpVsvtv9LRy7ZnCbhf46jvHaNGo
         uGTGFq+asmJnUhJKc7OdKmP25RQ7tCQypDE4xdlwIlJ4C+3g+98nI6fmABeOrE9eq71W
         Y6bwhxvvGHyV6Frvt4623AeSF5geHWPmF0cmpmgfP0ZHcGkCkSDlZwtsoTxNCl3I1Zza
         2lyiAu59W5vE6jj18wBoHHsjSrjOxtUvk1JFxl22EfFyj/zrpzWuos6H37whSb2VOwUm
         DB9z1P5nKS1ERDBGiFKPiqcgFulJV+mfa51u+cmEJAfbH8h3bIgdBlkKuoXcIbKyQfrA
         gPTg==
X-Gm-Message-State: AOUpUlFJHrUuAp7mBQvO/ZCZMzdhP/kzCDEnty3l4t9eT7/kSRT4zH1Y
        f5X0RvUTrQBOEe4hRTQD2k4=
X-Google-Smtp-Source: AAOMgpcKTj44W4vOEGYKmt09t1p14Hu2tv4U7cP3AO5nFTKKWqh8ftZx9w4JJuutjQntlLBSSv4vyA==
X-Received: by 2002:adf:bbd4:: with SMTP id z20-v6mr14110306wrg.183.1533674916146;
        Tue, 07 Aug 2018 13:48:36 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id f17-v6sm1540301wrs.1.2018.08.07.13.48.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 13:48:35 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id AD8E212474C; Tue,  7 Aug 2018 22:48:34 +0200 (CEST)
Date:   Tue, 7 Aug 2018 22:48:34 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     David Hildenbrand <david@redhat.com>
Cc:     Jerome Glisse <jglisse@redhat.com>, akpm@linux-foundation.org,
        mhocko@suse.com, dan.j.williams@intel.com,
        pasha.tatashin@oracle.com, yasu.isimatu@gmail.com,
        logang@deltatee.com, dave.jiang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: Re: [RFC PATCH 2/3] mm/memory_hotplug: Create __shrink_pages and
 move it to offline_pages
Message-ID: <20180807204834.GA6844@techadventures.net>
References: <20180807133757.18352-1-osalvador@techadventures.net>
 <20180807133757.18352-3-osalvador@techadventures.net>
 <20180807135221.GA3301@redhat.com>
 <a6e4e654-fc95-497f-16f3-8c1550cf03d6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6e4e654-fc95-497f-16f3-8c1550cf03d6@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 04:54:57PM +0200, David Hildenbrand wrote:
> I wonder if we could instead forward from the callers whether we are
> dealing with ZONE_DEVICE memory (is_device ...), at least that seems
> feasible in hmm code. Not having looked at details yet.

Yes, this looks like the most straightforward way right now.
We would have to pass it from arch_remove_memory to __remove_pages though.

It is not the most elegant way, but looking at the code of devm_memremap_pages_release
and hmm_devmem_release I cannot really think of anything better.

In hmm_devmem_release is should be easy because AFAIK (unless I am missing something), hmm always works
with ZONE_DEVICE.
At least hmm_devmem_pages_create() moves the range to ZONE_DEVICE.

After looking at devm_memremap_pages(), I think it does the same:

...
move_pfn_range_to_zone(&NODE_DATA(nid)->node_zones[ZONE_DEVICE],
					align_start >> PAGE_SHIFT,
					align_size >> PAGE_SHIFT, altmap);
...

So I guess it is safe to assume that arch_remove_memory/__remove_pages are called
from those functions while zone being ZONE_DEVICE.

Is that right, Jerome?

And since we know for sure that memhotplug-code cannot call it with ZONE_DEVICE,
I think this can be done easily.

Thanks
-- 
Oscar Salvador
SUSE L3
