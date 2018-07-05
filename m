Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44AB8C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 22:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB9A62407F
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 22:10:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB9A62407F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753510AbeGEWKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 18:10:43 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38472 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753345AbeGEWKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 18:10:42 -0400
Received: from localhost.localdomain (c-24-4-125-7.hsd1.ca.comcast.net [24.4.125.7])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id ABD7DE71;
        Thu,  5 Jul 2018 22:10:31 +0000 (UTC)
Date:   Thu, 5 Jul 2018 15:10:30 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     vdavydov.dev@gmail.com, shakeelb@google.com,
        viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
        tglx@linutronix.de, pombredanne@nexb.com, stummala@codeaurora.org,
        gregkh@linuxfoundation.org, sfr@canb.auug.org.au, guro@fb.com,
        mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
        chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
        ying.huang@intel.com, mgorman@techsingularity.net, jbacik@fb.com,
        linux@roeck-us.net, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, willy@infradead.org, lirongqing@baidu.com,
        aryabinin@virtuozzo.com
Subject: Re: [PATCH v8 05/17] mm: Assign memcg-aware shrinkers bitmap to
 memcg
Message-Id: <20180705151030.c67eb9a989c5f0023a53d415@linux-foundation.org>
In-Reply-To: <aaa98988-29e9-fb81-1d36-6b8bd7a371be@virtuozzo.com>
References: <153063036670.1818.16010062622751502.stgit@localhost.localdomain>
        <153063056619.1818.12550500883688681076.stgit@localhost.localdomain>
        <20180703135000.b2322ae0e514f028e7941d3c@linux-foundation.org>
        <aaa98988-29e9-fb81-1d36-6b8bd7a371be@virtuozzo.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jul 2018 18:51:12 +0300 Kirill Tkhai <ktkhai@virtuozzo.com> wrote:

> > - why aren't we decreasing shrinker_nr_max in
> >   unregister_memcg_shrinker()?  That's easy to do, avoids pointless
> >   work in shrink_slab_memcg() and avoids memory waste in future
> >   prealloc_memcg_shrinker() calls.
> 
> You sure, but there are some things. Initially I went in the same way
> as memcg_nr_cache_ids is made and just took the same x2 arithmetic.
> It never decreases, so it looked good to make shrinker maps like it.
> It's the only reason, so, it should not be a problem to rework.
> 
> The only moment is Vladimir strongly recommends modularity, i.e.
> to have memcg_shrinker_map_size and shrinker_nr_max as different variables.

For what reasons?

> After the rework we won't be able to have this anymore, since memcontrol.c
> will have to know actual shrinker_nr_max value and it will have to be exported.
>
> Could this be a problem?

Vladimir?
