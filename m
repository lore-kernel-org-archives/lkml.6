Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD6E3C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B52528017
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:55:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B52528017
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755248AbeF2OzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 10:55:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:42610 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751234AbeF2OzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 10:55:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 509D6AEB9;
        Fri, 29 Jun 2018 14:55:15 +0000 (UTC)
Date:   Fri, 29 Jun 2018 16:55:13 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Greg Thelen <gthelen@google.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Peter Feiner <pfeiner@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] kvm, mm: account shadow page tables to kmemcg
Message-ID: <20180629145513.GG5963@dhcp22.suse.cz>
References: <20180629140224.205849-1-shakeelb@google.com>
 <20180629143044.GF5963@dhcp22.suse.cz>
 <efdb8e40-742e-d120-6589-96b4fdf83cb9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efdb8e40-742e-d120-6589-96b4fdf83cb9@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 29-06-18 16:40:23, Paolo Bonzini wrote:
> On 29/06/2018 16:30, Michal Hocko wrote:
> > I am not familiar wtih kvm to judge but if we are going to account this
> > memory we will probably want to let oom_badness know how much memory
> > to account to a specific process. Is this something that we can do?
> > We will probably need a new MM_KERNEL rss_stat stat for that purpose.
> > 
> > Just to make it clear. I am not opposing to this patch but considering
> > that shadow page tables might consume a lot of memory it would be good
> > to know who is responsible for it from the OOM perspective. Something to
> > solve on top of this.
> 
> The amount of memory is generally proportional to the size of the
> virtual machine memory, which is reflected directly into RSS.  Because
> KVM processes are usually huge, and will probably dwarf everything else
> in the system (except firefox and chromium of course :)), the general
> order of magnitude of the oom_badness should be okay.

I think we will need MM_KERNEL longterm anyway. As I've said this is not
a must for this patch to go. But it is better to have a fair comparision
and kill larger processes if at all possible. It seems this should be
the case here.
 
> > I would also love to see a note how this memory is bound to the owner
> > life time in the changelog. That would make the review much more easier.
> 
> --verbose for people that aren't well versed in linux mm, please...

Well, if the memory accounted to the memcg hits the hard limit and there
is no way to reclaim anything to reduce the charged memory then we have
to kill something. Hopefully the memory hog. If that one dies it would
be great it releases its charges along the way. My remark was just to
explain how that would happen for this specific type of memory. Bound to
a file, has its own tear down etc. Basically make life of reviewers
easier to understand the lifetime of charged objects without digging
deep into the specific subsystem.
-- 
Michal Hocko
SUSE Labs
