Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC2CC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A2AB208A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:33:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A2AB208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932863AbeFUIdC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 04:33:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:39416 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932687AbeFUIdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 04:33:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 30A0CAF9A;
        Thu, 21 Jun 2018 08:32:59 +0000 (UTC)
Date:   Thu, 21 Jun 2018 10:32:58 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     osalvador@techadventures.net
Cc:     akpm@linux-foundation.org, vbabka@suse.cz,
        pasha.tatashin@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>,
        Reza Arbab <arbab@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/4] Small cleanup for memoryhotplug
Message-ID: <20180621083258.GF10465@dhcp22.suse.cz>
References: <20180601125321.30652-1-osalvador@techadventures.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601125321.30652-1-osalvador@techadventures.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc Reza Arbab - I remember he was able to hit some bugs in memblock
registration code when I was reworking that area previously]

On Fri 01-06-18 14:53:17, osalvador@techadventures.net wrote:
> From: Oscar Salvador <osalvador@suse.de>
> 
> 
> Hi,
> 
> I wanted to give it a try and do a small cleanup in the memhotplug's code.
> A lot more could be done, but I wanted to start somewhere.
> I tried to unify/remove duplicated code.
> 
> The following is what this patchset does:
> 
> 1) add_memory_resource() has code to allocate a node in case it was offline.
>    Since try_online_node has some code for that as well, I just made add_memory_resource() to
>    use that so we can remove duplicated code..
>    This is better explained in patch 1/4.
> 
> 2) register_mem_sect_under_node() will be called only from link_mem_sections()
> 
> 3) Get rid of link_mem_sections() in favour of walk_memory_range() with a callback to
>    register_mem_sect_under_node()
> 
> 4) Drop unnecessary checks from register_mem_sect_under_node()
> 
> 
> I have done some tests and I could not see anything broken because of 
> this patchset.
> 
> Oscar Salvador (4):
>   mm/memory_hotplug: Make add_memory_resource use __try_online_node
>   mm/memory_hotplug: Call register_mem_sect_under_node
>   mm/memory_hotplug: Get rid of link_mem_sections
>   mm/memory_hotplug: Drop unnecessary checks from
>     register_mem_sect_under_node
> 
>  drivers/base/memory.c |   2 -
>  drivers/base/node.c   |  52 +++++---------------------
>  include/linux/node.h  |  21 +++++------
>  mm/memory_hotplug.c   | 101 ++++++++++++++++++++++++++------------------------
>  4 files changed, 71 insertions(+), 105 deletions(-)
> 
> -- 
> 2.13.6
> 

-- 
Michal Hocko
SUSE Labs
