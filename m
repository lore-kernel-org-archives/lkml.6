Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB50C476E8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3072A21471
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Wl/722EK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3072A21471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732455AbeGLQPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 12:15:09 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:37204 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726800AbeGLQPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 12:15:09 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 1AB6C8EE409;
        Thu, 12 Jul 2018 09:04:57 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Hm6Dt1cNkSz9; Thu, 12 Jul 2018 09:04:55 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id D4BD98EE02B;
        Thu, 12 Jul 2018 09:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1531411495;
        bh=tRah15F2C3Av3WsOHu99zG9/PG5/T0837j/vqfOMUoo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Wl/722EKmGW4ckJRRXJ+UFdB3ojprSjVhVk3QO8XMobXChwojlaNG8BswvpnIPHp1
         dYlVTA4jQHlGc+pBt7dxyedu1sTMC0uuLcrik/6EjkOJ/a/xH7tLQukXqAm3IkGOHp
         WRC5zrc4X57Ds+U4ZISSXueO/hDqoaMMIDfmVaew=
Message-ID: <1531411494.18255.6.camel@HansenPartnership.com>
Subject: Re: [PATCH v6 0/7] fs/dcache: Track & limit # of negative dentries
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Waiman Long <longman@redhat.com>, Michal Hocko <mhocko@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Larry Woodman <lwoodman@redhat.com>,
        "Wangkai (Kevin C)" <wangkai86@huawei.com>
Date:   Thu, 12 Jul 2018 09:04:54 -0700
In-Reply-To: <4d49a270-23c9-529f-f544-65508b6b53cc@redhat.com>
References: <1530905572-817-1-git-send-email-longman@redhat.com>
         <20180709081920.GD22049@dhcp22.suse.cz>
         <62275711-e01d-7dbe-06f1-bf094b618195@redhat.com>
         <20180710142740.GQ14284@dhcp22.suse.cz>
         <a2794bcc-9193-cbca-3a54-47420a2ab52c@redhat.com>
         <20180711102139.GG20050@dhcp22.suse.cz>
         <9f24c043-1fca-ee86-d609-873a7a8f7a64@redhat.com>
         <1531330947.3260.13.camel@HansenPartnership.com>
         <18c5cbfe-403b-bb2b-1d11-19d324ec6234@redhat.com>
         <1531336913.3260.18.camel@HansenPartnership.com>
         <4d49a270-23c9-529f-f544-65508b6b53cc@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-07-12 at 11:54 -0400, Waiman Long wrote:
> On 07/11/2018 03:21 PM, James Bottomley wrote:
> > On Wed, 2018-07-11 at 15:07 -0400, Waiman Long wrote:
> > > On 07/11/2018 01:42 PM, James Bottomley wrote:
> > > > On Wed, 2018-07-11 at 11:13 -0400, Waiman Long wrote:
> > > > > On 07/11/2018 06:21 AM, Michal Hocko wrote:
> > > > > > On Tue 10-07-18 12:09:17, Waiman Long wrote:
> > > > 
> > > > [...]
> > > > > > > I am going to reduce the granularity of each unit to
> > > > > > > 1/1000
> > > > > > > of the total system memory so that for large system with
> > > > > > > TB
> > > > > > > of memory, a smaller amount of memory can be specified.
> > > > > > 
> > > > > > It is just a matter of time for this to be too coarse as
> > > > > > well.
> > > > > 
> > > > > The goal is to not have too much memory being consumed by
> > > > > negative
> > > > > dentries and also the limit won't be reached by regular daily
> > > > > activities. So a limit of 1/1000 of the total system memory
> > > > > will
> > > > > be good enough on large memory system even if the absolute
> > > > > number
> > > > > is really big.
> > > > 
> > > > OK, I think the reason we're going round and round here without
> > > > converging is that one of the goals of the mm subsystem is to
> > > > manage all of our cached objects and to it the negative (and
> > > > positive) dentries simply look like a clean cache of
> > > > objects.  Right at the moment mm manages them in the same way
> > > > it
> > > > manages all the other caches, a lot of which suffer from the
> > > > "you
> > > > can cause lots of allocations to artificially grow them"
> > > > problem.  So the main question is why doesn't the current mm
> > > > control of the caches work well enough for dentries? 
> > > > What are the problems you're seeing that mm should be
> > > > catching?  If
> > > > you can answer this, then we could get on to whether a separate
> > > > shrinker, cache separation or some fix in mm itself is the
> > > > right
> > > > answer.
> > > > 
> > > > What you say above is based on a conclusion: limiting dentries
> > > > improves the system performance.  What we're asking for is
> > > > evidence
> > > > for that conclusion so we can explore whether the same would go
> > > > for
> > > > any of our other system caches (so do we have a global cache
> > > > management problem or is it only the dentry cache?)
> > > > 
> > > > James
> > > > 
> > > 
> > > I am not saying that limiting dentries will improve performance.
> > > I am
> > > just saying that unlimited growth in the number of negative
> > > dentries
> > > will reduce the amount of memory available to other applications
> > > and
> > > hence will have an impact on performance. Normally the amount of
> > > memory consumed by dentries is a very small portion of the system
> > > memory.
> > 
> > OK, can we poke on only this point for a while?  Linux never really
> > has
> > any "available memory": pretty much as soon as you boot up the
> > system
> > will consume all your free memory for some type of cache (usually
> > the
> > page cache which got filled during boot).  The expectation is that
> > in a
> > steady, running, state the system is using almost all available
> > memory
> > for caching something ... if it's not negative dentries it will be
> > something else.  The mm assumption is that clean cache is so cheap
> > to
> > recover that it's almost equivalent to free memory and your patch
> > is
> > saying this isn't so and we have a problem dumping the dentry
> > cache.
> > 
> > So, why can't we treat the dentry cache as equivalent to free
> > memory? 
> > What in your tests is making it harder to recover the memory in the
> > dentry cache?
> > 
> > James
> 
> It is not that dentry cache is harder to get rid of than the other
> memory. It is that the ability of generate unlimited number of
> negative dentries that will displace other useful memory from the
> system. What the patch is trying to do is to have a warning or
> notification system in place to spot unusual activities in regard to
> the number of negative dentries in the system. The system
> administrators can then decide on what to do next.

But every cache has this property: I can cause the same effect by doing
a streaming read on a multi gigabyte file: the page cache will fill
with the clean pages belonging to the file until I run out of memory
and it has to start evicting older cache entries.  Once we hit the
steady state of minimal free memory, the mm subsytem tries to balance
the cache requests (like my streaming read) against the existing pool
of cached objects.

The question I'm trying to get an answer to is why does the dentry
cache need special limits when the mm handling of the page cache (and
other mm caches) just works?

James


> For many user activities, there are ways to audit what the users are
> doing and what resources they are consuming. I don't think that is
> the case for negative dentries. The closest I can think of is the use
> of memory controller to limit the amount of kernel memory use. This
> patchset will provide more visibility about the memory consumption of
> negative dentries for the system as a whole, though it won't go into
> the per-user level. We just don't want a disproportionate amount of
> memory to be used up by negative dentries.
> 
> Cheers,
> Longman
> 
> Cheers,
> Longman
> 

