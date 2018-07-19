Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB47ECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 20:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37AC42084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 20:52:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37AC42084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730432AbeGSVh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 17:37:27 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46049 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727609AbeGSVh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 17:37:26 -0400
Received: by mail-wr1-f68.google.com with SMTP id c4-v6so9308727wrs.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 13:52:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RuRQobfna1gFuE+SiuGl+tZbbFsIbAQ3ocQMrEiC49A=;
        b=CLmiPp6ahmEhieIF06m5R+WcBT/y3EZ8jP8WWVRTyRGJPbeAtfEeDuB99YYufvjB1n
         cFcDlS3tUHx9EKOXelEWr4tH9SwSy6dAuvG/61xSXFGu4PamWQVopCIZGgtA5+Z3QiVY
         MfcF3jLLb+yAcpTDL1VwcWF5MqWv4AlKcK/zf8afx6QPX/VmYHKbVlk3+3Ob9XbQmPjE
         QHKugdOhdAHP0Fbb3nc2YYVDt3vTWhE2co1436869zj4Xf6OFnUXVHOibe7nU0Lfw2yH
         RNAhzkKM2ye5lj7YHchqj8ZIMdiVTIVmcvYIm/IE+dtpRVFovwiDWACDvb8L+eRq4ieq
         GR3Q==
X-Gm-Message-State: AOUpUlGuO96YczwxeihucYR1QUGhMH7jzD6k9e4Yo9C+4Ex48yCHiSRW
        JzvdTdVFaMgPlR3ZUpylqpi683s2N7o=
X-Google-Smtp-Source: AAOMgpdDvGNa2fqzTr4KV5nDgMZCBUdxTUX0RL3YaHTzhhTztCw2TpGFhfSLUoa3xGa/SH57aULcdQ==
X-Received: by 2002:a5d:4210:: with SMTP id n16-v6mr8088100wrq.55.1532033556651;
        Thu, 19 Jul 2018 13:52:36 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id h1-v6sm80631wri.90.2018.07.19.13.52.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 13:52:35 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 615141241AE; Thu, 19 Jul 2018 22:52:35 +0200 (CEST)
Date:   Thu, 19 Jul 2018 22:52:35 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, pasha.tatashin@oracle.com,
        vbabka@suse.cz, aaron.lu@intel.com, iamjoonsoo.kim@lge.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v2 3/5] mm/page_alloc: Optimize free_area_init_core
Message-ID: <20180719205235.GA14010@techadventures.net>
References: <20180719132740.32743-1-osalvador@techadventures.net>
 <20180719132740.32743-4-osalvador@techadventures.net>
 <20180719134417.GC7193@dhcp22.suse.cz>
 <20180719140327.GB10988@techadventures.net>
 <20180719151555.GH7193@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180719151555.GH7193@dhcp22.suse.cz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 05:15:55PM +0200, Michal Hocko wrote:
> Your changelog doesn't really explain the motivation. Does the change
> help performance? Is this a pure cleanup?

Hi Michal,

Sorry to not have explained this better from the very beginning.

It should help a bit in performance terms as we would be skipping those
condition checks and assignations for zones that do not have any pages.
It is not a huge win, but I think that skipping code we do not really need to run
is worh to have.

> The function is certainly not an example of beauty. It is more an
> example of changes done on top of older ones without much thinking. But
> I do not see your change would make it so much better. I would consider
> it a much nicer cleanup if it was split into logical units each doing
> one specific thing.

About the cleanup, I thought that moving that block of code to a separate function
would make the code easier to follow.
If you think that this is still not enough, I can try to split it and see the outcome.

> Btw. are you sure this change is correct? E.g.
> 		/*
> 		 * Set an approximate value for lowmem here, it will be adjusted
> 		 * when the bootmem allocator frees pages into the buddy system.
> 		 * And all highmem pages will be managed by the buddy system.
> 		 */
> 		zone->managed_pages = is_highmem_idx(j) ? realsize : freesize;
> 
> expects freesize to be calculated properly and just from quick reading
> the code I do not see why skipping other adjustments is ok for size > 0.
> Maybe this is OK, I dunno and my brain is already heading few days off
> but a real cleanup wouldn't even make me think what the heck is going on
> here.

This changed in commit e69438596bb3e97809e76be315e54a4a444f4797.
Current code does not have "realsize" anymore.

Thanks
-- 
Oscar Salvador
SUSE L3
