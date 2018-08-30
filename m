Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9A9C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 07:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95C432082C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 07:21:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95C432082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbeH3LVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 07:21:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:55876 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727278AbeH3LVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 07:21:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 97C7BAEE6;
        Thu, 30 Aug 2018 07:20:57 +0000 (UTC)
Date:   Thu, 30 Aug 2018 09:20:56 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Larry Woodman <lwoodman@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Wangkai (Kevin C)" <wangkai86@huawei.com>
Subject: Re: [PATCH 2/2] fs/dcache: Make negative dentries easier to be
 reclaimed
Message-ID: <20180830072056.GC2656@dhcp22.suse.cz>
References: <1535476780-5773-1-git-send-email-longman@redhat.com>
 <1535476780-5773-3-git-send-email-longman@redhat.com>
 <20180829075129.GU10223@dhcp22.suse.cz>
 <374c2c5c-cc9b-af03-a800-32f2cf8a3055@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <374c2c5c-cc9b-af03-a800-32f2cf8a3055@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 29-08-18 15:58:52, Waiman Long wrote:
> On 08/29/2018 03:51 AM, Michal Hocko wrote:
> > On Tue 28-08-18 13:19:40, Waiman Long wrote:
> >> For negative dentries that are accessed once and never used again, they
> >> should be removed first before other dentries when shrinker is running.
> >> This is done by putting negative dentries at the head of the LRU list
> >> instead at the tail.
> >>
> >> A new DCACHE_NEW_NEGATIVE flag is now added to a negative dentry when it
> >> is initially created. When such a dentry is added to the LRU, it will be
> >> added to the head so that it will be the first to go when a shrinker is
> >> running if it is never accessed again (DCACHE_REFERENCED bit not set).
> >> The flag is cleared after the LRU list addition.
> > Placing object to the head of the LRU list can be really tricky as Dave
> > pointed out. I am not familiar with the dentry cache reclaim so my
> > comparison below might not apply. Let me try anyway.
> >
> > Negative dentries sound very similar to MADV_FREE pages from the reclaim
> > POV. They are primary candidate for reclaim, yet you want to preserve
> > aging to other easily reclaimable objects (including other MADV_FREE
> > pages). What we do for those pages is to move them from the anonymous
> > LRU list to the inactive file LRU list. Now you obviously do not have
> > anon/file LRUs but something similar to active/inactive LRU lists might
> > be a reasonably good match. Have easily reclaimable dentries on the
> > inactive list including negative dentries. If negative entries are
> > heavily used then they can promote to the active list because there is
> > no reason to reclaim them soon.
> >
> > Just my 2c
> 
> As mentioned in my reply to Dave, I did considered using a 2 LRU list
> solution. However, that will add more complexity to the dcache LRU
> management code than my current approach and probably more potential for
> slowdown.

I completely agree with Dave here. This is not easy but trying to sneak
in something that works for an _artificial_ workload is simply a no go.
So if it takes to come with a more complex solution to cover more
general workloads then be it. Someone has to bite a bullet and explore
that direction. It won't be a simple project but well, if negative
dentries really matter then it is worth making the reclaim design robust
and comprehensible rather than adhoc and unpredictable.
-- 
Michal Hocko
SUSE Labs
