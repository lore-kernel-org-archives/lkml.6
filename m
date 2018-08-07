Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42902C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 22:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED901215A3
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 22:13:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED901215A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbeHHAaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 20:30:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50232 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726502AbeHHAaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 20:30:17 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 624F1402345E;
        Tue,  7 Aug 2018 22:13:47 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.215])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A52AD2023415;
        Tue,  7 Aug 2018 22:13:46 +0000 (UTC)
Date:   Tue, 7 Aug 2018 18:13:45 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Oscar Salvador <osalvador@techadventures.net>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        mhocko@suse.com, dan.j.williams@intel.com,
        pasha.tatashin@oracle.com, yasu.isimatu@gmail.com,
        logang@deltatee.com, dave.jiang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: Re: [RFC PATCH 2/3] mm/memory_hotplug: Create __shrink_pages and
 move it to offline_pages
Message-ID: <20180807221345.GD3301@redhat.com>
References: <20180807133757.18352-1-osalvador@techadventures.net>
 <20180807133757.18352-3-osalvador@techadventures.net>
 <20180807135221.GA3301@redhat.com>
 <a6e4e654-fc95-497f-16f3-8c1550cf03d6@redhat.com>
 <20180807204834.GA6844@techadventures.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180807204834.GA6844@techadventures.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 07 Aug 2018 22:13:47 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 07 Aug 2018 22:13:47 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jglisse@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 10:48:34PM +0200, Oscar Salvador wrote:
> On Tue, Aug 07, 2018 at 04:54:57PM +0200, David Hildenbrand wrote:
> > I wonder if we could instead forward from the callers whether we are
> > dealing with ZONE_DEVICE memory (is_device ...), at least that seems
> > feasible in hmm code. Not having looked at details yet.
> 
> Yes, this looks like the most straightforward way right now.
> We would have to pass it from arch_remove_memory to __remove_pages though.
> 
> It is not the most elegant way, but looking at the code of devm_memremap_pages_release
> and hmm_devmem_release I cannot really think of anything better.
> 
> In hmm_devmem_release is should be easy because AFAIK (unless I am missing something), hmm always works
> with ZONE_DEVICE.
> At least hmm_devmem_pages_create() moves the range to ZONE_DEVICE.
> 
> After looking at devm_memremap_pages(), I think it does the same:
> 
> ...
> move_pfn_range_to_zone(&NODE_DATA(nid)->node_zones[ZONE_DEVICE],
> 					align_start >> PAGE_SHIFT,
> 					align_size >> PAGE_SHIFT, altmap);
> ...
> 
> So I guess it is safe to assume that arch_remove_memory/__remove_pages are called
> from those functions while zone being ZONE_DEVICE.
> 
> Is that right, Jerome?

Correct, both HMM and devm always deal with ZONE_DEVICE page. So
any call to arch_remove_memory/__remove_pages in those context
can assume ZONE_DEVICE.

> 
> And since we know for sure that memhotplug-code cannot call it with ZONE_DEVICE,
> I think this can be done easily.

This might change down road but for now this is correct. They are
talks to enumerate device memory through standard platform mechanisms
and thus the kernel might see new types of resources down the road and
maybe we will want to hotplug them directly from regular hotplug path
as ZONE_DEVICE (lot of hypothetical at this point ;)).

Cheers,
Jérôme
