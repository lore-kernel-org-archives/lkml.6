Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CB4C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F327F26E75
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="y9mlVq4s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F327F26E75
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934272AbeFZSze (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 14:55:34 -0400
Received: from gum.cmpxchg.org ([85.214.110.215]:49338 "EHLO gum.cmpxchg.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933897AbeFZSzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 14:55:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cmpxchg.org
        ; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=6RXfo9Kz4LSycVlaA8XOUYuoUVPIG7oEWJvgtAmRMVA=; b=y9mlVq4sr/GfrJF40qjMR6tfmx
        614mC32Bb3mMUn/UsCE9qvs5K3XoRsgQzYS0eoAtj2kjwxmRgpRKP0dLSg0tswdRmFLHv2Mhc+N9k
        WCccwZGi3UYNCWDqeGLZShOxV7ww1QXm2UWQ4kk0264mmo4FB1PyE04OZSodzoYT3nNY=;
Date:   Tue, 26 Jun 2018 14:57:24 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Jan Kara <jack@suse.com>, Greg Thelen <gthelen@google.com>,
        Roman Gushchin <guro@fb.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 1/2] fs: fsnotify: account fsnotify metadata to kmemcg
Message-ID: <20180626185724.GA3958@cmpxchg.org>
References: <20180625230659.139822-1-shakeelb@google.com>
 <20180625230659.139822-2-shakeelb@google.com>
 <CAOQ4uxiV75+X3dMLS93iXqwmSU6eKPOUocdkXiR7MQZhEjotQg@mail.gmail.com>
 <CALvZod5ARMZL+eD8-mrxeBvxJcuVPXaCwWEgUyQw85xXWxHauA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod5ARMZL+eD8-mrxeBvxJcuVPXaCwWEgUyQw85xXWxHauA@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 11:00:53AM -0700, Shakeel Butt wrote:
> On Mon, Jun 25, 2018 at 10:49 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> ...
> >
> > The verb 'unuse' takes an argument memcg and 'uses' it - too weird.
> > You can use 'override'/'revert' verbs like override_creds or just call
> > memalloc_use_memcg(old_memcg) since there is no reference taken
> > anyway in use_memcg and no reference released in unuse_memcg.
> >
> > Otherwise looks good to me.
> >
> 
> Thanks for your feedback. Just using memalloc_use_memcg(old_memcg) and
> ignoring the return seems more simple. I will wait for feedback from
> other before changing anything.

We're not nesting calls to memalloc_use_memcg(), right? So we don't
have to return old_memcg and don't have to pass anything to unuse, it
can always set current->active_memcg to NULL.
