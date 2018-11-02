Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652BDC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 16:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 367052082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 16:13:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 367052082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbeKCBUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 21:20:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:53120 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726085AbeKCBUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 21:20:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 39667ACB8;
        Fri,  2 Nov 2018 16:13:16 +0000 (UTC)
Date:   Fri, 2 Nov 2018 17:13:14 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Dexuan Cui <decui@microsoft.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Rik van Riel <riel@surriel.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Stable@vger.kernel.org" <Stable@vger.kernel.org>
Subject: Re: Will the recent memory leak fixes be backported to longterm
 kernels?
Message-ID: <20181102161314.GF28039@dhcp22.suse.cz>
References: <PU1P153MB0169CB6382E0F047579D111DBFCF0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20181102005816.GA10297@tower.DHCP.thefacebook.com>
 <PU1P153MB0169FE681EF81BCE81B005A1BFCF0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20181102073009.GP23921@dhcp22.suse.cz>
 <20181102154844.GA17619@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102154844.GA17619@tower.DHCP.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 02-11-18 15:48:57, Roman Gushchin wrote:
> On Fri, Nov 02, 2018 at 09:03:55AM +0100, Michal Hocko wrote:
> > On Fri 02-11-18 02:45:42, Dexuan Cui wrote:
> > [...]
> > > I totally agree. I'm now just wondering if there is any temporary workaround,
> > > even if that means we have to run the kernel with some features disabled or
> > > with a suboptimal performance?
> > 
> > One way would be to disable kmem accounting (cgroup.memory=nokmem kernel
> > option). That would reduce the memory isolation because quite a lot of
> > memory will not be accounted for but the primary source of in-flight and
> > hard to reclaim memory will be gone.
> 
> In my experience disabling the kmem accounting doesn't really solve the issue
> (without patches), but can lower the rate of the leak.

This is unexpected. 90cbc2508827e was introduced to address offline
memcgs to be reclaim even when they are small. But maybe you mean that
we still leak in an absence of the memory pressure. Or what does prevent
memcg from going down?

> > Another workaround could be to use force_empty knob we have in v1 and
> > use it when removing a cgroup. We do not have it in cgroup v2 though.
> > The file hasn't been added to v2 because we didn't really have any
> > proper usecase. Working around a bug doesn't sound like a _proper_
> > usecase but I can imagine workloads that bring a lot of metadata objects
> > that are not really interesting for later use so something like a
> > targeted drop_caches...
> 
> This can help a bit too, but even using the system-wide drop_caches knob
> unfortunately doesn't return all the memory back.

Could you be more specific please?

-- 
Michal Hocko
SUSE Labs
