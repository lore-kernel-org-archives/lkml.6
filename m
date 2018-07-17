Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04AAFECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B514A20C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:23:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B514A20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731551AbeGQMz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 08:55:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:50076 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731417AbeGQMz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 08:55:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A7801ACEF;
        Tue, 17 Jul 2018 12:23:31 +0000 (UTC)
Date:   Tue, 17 Jul 2018 14:23:27 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Daniel Drake <drake@endlessm.com>
Cc:     hannes@cmpxchg.org, Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        Linux Upstreaming Team <linux@endlessm.com>,
        linux-block@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Mike Galbraith <efault@gmx.de>,
        Oliver Yang <yangoliver@me.com>,
        Shakeel Butt <shakeelb@google.com>,
        xxx xxx <x.qendo@gmail.com>,
        Taras Kondratiuk <takondra@cisco.com>,
        Daniel Walker <danielwa@cisco.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Ruslan Ruslichenko <rruslich@cisco.com>, kernel-team@fb.com
Subject: Re: [PATCH 0/10] psi: pressure stall information for CPU, memory,
 and IO v2
Message-ID: <20180717122327.GG7193@dhcp22.suse.cz>
References: <20180712172942.10094-1-hannes@cmpxchg.org>
 <20180716155745.10368-1-drake@endlessm.com>
 <20180717112515.GE7193@dhcp22.suse.cz>
 <CAD8Lp45W00ga-P-nb6iytgSGW4xwSzmaTHA87DOvSotN0S2edw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD8Lp45W00ga-P-nb6iytgSGW4xwSzmaTHA87DOvSotN0S2edw@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 17-07-18 07:13:52, Daniel Drake wrote:
> On Tue, Jul 17, 2018 at 6:25 AM, Michal Hocko <mhocko@kernel.org> wrote:
> > Yes this is really unfortunate. One thing that could help would be to
> > consider a trashing level during the reclaim (get_scan_count) to simply
> > forget about LRUs which are constantly refaulting pages back. We already
> > have the infrastructure for that. We just need to plumb it in.
> 
> Can you go into a bit more detail about that infrastructure and how we
> might detect which pages are being constantly refaulted? I'm
> interested in spending a few hours on this topic to see if I can come
> up with anything.

mm/workingset.c allows for tracking when an actual page got evicted.
workingset_refault tells us whether a give filemap fault is a recent
refault and activates the page if that is the case. So what you need is
to note how many refaulted pages we have on the active LRU list. If that
is a large part of the list and if the inactive list is really small
then we know we are trashing. This all sounds much easier than it will
eventually turn out to be of course but I didn't really get to play with
this much.

HTH even though it is not really thought through well.
-- 
Michal Hocko
SUSE Labs
