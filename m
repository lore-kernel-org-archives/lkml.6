Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9F8C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BA9220C51
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="I7umh6V2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BA9220C51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389647AbeGKT1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 15:27:39 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:57302 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387848AbeGKT1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 15:27:39 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id E0B4E8EE409;
        Wed, 11 Jul 2018 12:21:54 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LAqvlV1V78k0; Wed, 11 Jul 2018 12:21:54 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id E30848EE0E4;
        Wed, 11 Jul 2018 12:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1531336914;
        bh=fzg/ZSvljtLnk0afJMLCTukW2IE7VYCFdKbcP6kXYFc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=I7umh6V2F4EMzoIvgmg+8vJkDMjtS/R7LYWiat1o/GHsrRl9Pe1pS/CVdUeJkxkoH
         ZfuL03xv2tMywEXguE7IHuv+ktA2Qr/7Ca7U8PglUc/hHIPibddjMAvBgSI+Tz3G3r
         B7yXh0fHqrIDh9qPJuMpzr/DFRFDkW6YGLrIBpnk=
Message-ID: <1531336913.3260.18.camel@HansenPartnership.com>
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
Date:   Wed, 11 Jul 2018 12:21:53 -0700
In-Reply-To: <18c5cbfe-403b-bb2b-1d11-19d324ec6234@redhat.com>
References: <1530905572-817-1-git-send-email-longman@redhat.com>
         <20180709081920.GD22049@dhcp22.suse.cz>
         <62275711-e01d-7dbe-06f1-bf094b618195@redhat.com>
         <20180710142740.GQ14284@dhcp22.suse.cz>
         <a2794bcc-9193-cbca-3a54-47420a2ab52c@redhat.com>
         <20180711102139.GG20050@dhcp22.suse.cz>
         <9f24c043-1fca-ee86-d609-873a7a8f7a64@redhat.com>
         <1531330947.3260.13.camel@HansenPartnership.com>
         <18c5cbfe-403b-bb2b-1d11-19d324ec6234@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-11 at 15:07 -0400, Waiman Long wrote:
> On 07/11/2018 01:42 PM, James Bottomley wrote:
> > On Wed, 2018-07-11 at 11:13 -0400, Waiman Long wrote:
> > > On 07/11/2018 06:21 AM, Michal Hocko wrote:
> > > > On Tue 10-07-18 12:09:17, Waiman Long wrote:
> > 
> > [...]
> > > > > I am going to reduce the granularity of each unit to 1/1000
> > > > > of the total system memory so that for large system with TB
> > > > > of memory, a smaller amount of memory can be specified.
> > > > 
> > > > It is just a matter of time for this to be too coarse as well.
> > > 
> > > The goal is to not have too much memory being consumed by
> > > negative
> > > dentries and also the limit won't be reached by regular daily
> > > activities. So a limit of 1/1000 of the total system memory will
> > > be good enough on large memory system even if the absolute number
> > > is really big.
> > 
> > OK, I think the reason we're going round and round here without
> > converging is that one of the goals of the mm subsystem is to
> > manage all of our cached objects and to it the negative (and
> > positive) dentries simply look like a clean cache of
> > objects.  Right at the moment mm manages them in the same way it
> > manages all the other caches, a lot of which suffer from the "you
> > can cause lots of allocations to artificially grow them"
> > problem.  So the main question is why doesn't the current mm
> > control of the caches work well enough for dentries? 
> > What are the problems you're seeing that mm should be catching?  If
> > you can answer this, then we could get on to whether a separate
> > shrinker, cache separation or some fix in mm itself is the right
> > answer.
> > 
> > What you say above is based on a conclusion: limiting dentries
> > improves the system performance.  What we're asking for is evidence
> > for that conclusion so we can explore whether the same would go for
> > any of our other system caches (so do we have a global cache
> > management problem or is it only the dentry cache?)
> > 
> > James
> > 
> 
> I am not saying that limiting dentries will improve performance. I am
> just saying that unlimited growth in the number of negative dentries
> will reduce the amount of memory available to other applications and
> hence will have an impact on performance. Normally the amount of
> memory consumed by dentries is a very small portion of the system
> memory.

OK, can we poke on only this point for a while?  Linux never really has
any "available memory": pretty much as soon as you boot up the system
will consume all your free memory for some type of cache (usually the
page cache which got filled during boot).  The expectation is that in a
steady, running, state the system is using almost all available memory
for caching something ... if it's not negative dentries it will be
something else.  The mm assumption is that clean cache is so cheap to
recover that it's almost equivalent to free memory and your patch is
saying this isn't so and we have a problem dumping the dentry cache.

So, why can't we treat the dentry cache as equivalent to free memory? 
What in your tests is making it harder to recover the memory in the
dentry cache?

James



