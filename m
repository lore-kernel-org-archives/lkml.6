Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E91BC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26E94206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545062636;
	bh=G9Xog0YEw6CvIMQ31u10PkHB8AhK6/zCFr0C53wQzrE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=akBPtNdiyttWKCN1A+p37vLQl46gAH4r3ArIMJB42C94yKvxipChb1D7I9C+WRlF7
	 THdxPWLouIJUSPmr9Kcu5isF19MiYyzRjqZDPeXYt3gf54eDRaru5vtZDk0nPASIxz
	 5WX7HqGzSoIzI4EkHtZszgfL5oYmIAGHwFXR/ikM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388036AbeLQQDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 11:03:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:39068 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727833AbeLQQDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 11:03:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 55AFDAF17;
        Mon, 17 Dec 2018 16:03:52 +0000 (UTC)
Date:   Mon, 17 Dec 2018 17:03:50 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [-next] lots of messages due to "mm, memory_hotplug: be more
 verbose for memory offline failures"
Message-ID: <20181217160350.GV30879@dhcp22.suse.cz>
References: <20181217155922.GC3560@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217155922.GC3560@osiris>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 17-12-18 16:59:22, Heiko Carstens wrote:
> Hi Michal,
> 
> with linux-next as of today on s390 I see tons of messages like
> 
> [   20.536664] page dumped because: has_unmovable_pages
> [   20.536792] page:000003d081ff4080 count:1 mapcount:0 mapping:000000008ff88600 index:0x0 compound_mapcount: 0
> [   20.536794] flags: 0x3fffe0000010200(slab|head)
> [   20.536795] raw: 03fffe0000010200 0000000000000100 0000000000000200 000000008ff88600
> [   20.536796] raw: 0000000000000000 0020004100000000 ffffffff00000001 0000000000000000
> [   20.536797] page dumped because: has_unmovable_pages
> [   20.536814] page:000003d0823b0000 count:1 mapcount:0 mapping:0000000000000000 index:0x0
> [   20.536815] flags: 0x7fffe0000000000()
> [   20.536817] raw: 07fffe0000000000 0000000000000100 0000000000000200 0000000000000000
> [   20.536818] raw: 0000000000000000 0000000000000000 ffffffff00000001 0000000000000000
> 
> bisect points to b323c049a999 ("mm, memory_hotplug: be more verbose for memory offline failures")
> which is the first commit with which the messages appear.

I would bet this is CMA allocator. How much is tons? Maybe we want a
rate limit or the other user is not really interested in them at all?
-- 
Michal Hocko
SUSE Labs
