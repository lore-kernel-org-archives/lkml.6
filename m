Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38490C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBFBA23D50
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:15:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBFBA23D50
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755027AbeFYJPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 05:15:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:56455 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755008AbeFYJO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 05:14:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 24B59AB43;
        Mon, 25 Jun 2018 09:14:57 +0000 (UTC)
Date:   Mon, 25 Jun 2018 11:14:55 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     Nadav Amit <nadav.amit@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        ldufour@linux.vnet.ibm.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 PATCH 2/2] mm: mmap: zap pages with read mmap_sem for
 large mapping
Message-ID: <20180625091455.GH28965@dhcp22.suse.cz>
References: <1529364856-49589-1-git-send-email-yang.shi@linux.alibaba.com>
 <1529364856-49589-3-git-send-email-yang.shi@linux.alibaba.com>
 <3DDF2672-FCC4-4387-9624-92F33C309CAE@gmail.com>
 <158a4e4c-d290-77c4-a595-71332ede392b@linux.alibaba.com>
 <BFD6A249-B1D7-43D5-8D7C-9FAED4A168A1@gmail.com>
 <20180620071817.GJ13685@dhcp22.suse.cz>
 <c184031d-b1db-503e-1a32-7963b4bf3de0@linux.alibaba.com>
 <94bdfcf0-68ea-404c-a60f-362f677884b6@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94bdfcf0-68ea-404c-a60f-362f677884b6@linux.alibaba.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 22-06-18 18:01:08, Yang Shi wrote:
> Yes, this is true but I guess what Yang Shi meant was that an userspace
> > > access racing with munmap is not well defined. You never know whether
> > > you get your data, #PTF or SEGV because it depends on timing. The user
> > > visible change might be that you lose content and get zero page instead
> > > if you hit the race window while we are unmapping which was not possible
> > > before. But whouldn't such an access pattern be buggy anyway? You need
> > > some form of external synchronization AFAICS.
> > > 
> > > But maybe some userspace depends on "getting right data or get SEGV"
> > > semantic. If we have to preserve that then we can come up with a VM_DEAD
> > > flag set before we tear it down and force the SEGV on the #PF path.
> > > Something similar we already do for MMF_UNSTABLE.
> > 
> > Set VM_DEAD with read mmap_sem held? It should be ok since this is the
> > only place to set this flag for this unique special case.
> 
> BTW, it looks the vm flags have used up in 32 bit. If we really need
> VM_DEAD, it should be for both 32-bit and 64-bit.

Do we really need any special handling for 32b? Who is going to create
GB mappings for all this to be worth doing?

-- 
Michal Hocko
SUSE Labs
