Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4CCC67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 08:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57ED620779
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 08:33:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57ED620779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbeJVQu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 12:50:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:59646 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727509AbeJVQu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 12:50:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D09C1AF54;
        Mon, 22 Oct 2018 08:33:22 +0000 (UTC)
Date:   Mon, 22 Oct 2018 10:33:22 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Spock <dairinin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org
Subject: Re: Memory management issue in 4.18.15
Message-ID: <20181022083322.GE32333@dhcp22.suse.cz>
References: <CADa=ObrwYaoNFn0x06mvv5W1F9oVccT5qjGM8qFBGNPoNuMUNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADa=ObrwYaoNFn0x06mvv5W1F9oVccT5qjGM8qFBGNPoNuMUNw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc som more people.

I am wondering why 172b06c32b94 ("mm: slowly shrink slabs with a
relatively small number of objects") has been backported to the stable
tree when not marked that way. Put that aside it seems likely that the
upstream kernel will have the same issue I suspect. Roman, could you
have a look please?

On Sat 20-10-18 14:41:40, Spock wrote:
> Hello,
> 
> I have a workload, which creates lots of cache pages. Before 4.18.15,
> the behavior was very stable: pagecache is constantly growing until it
> consumes all the free memory, and then kswapd is balancing it around
> low watermark. After 4.18.15, once in a while khugepaged is waking up
> and reclaims almost all the pages from pagecache, so there is always
> around 2G of 8G unused. THP is enabled only for madvise case and are
> not used.
> 
> The exact change that leads to current behavior is
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-4.18.y&id=62aad93f09c1952ede86405894df1b22012fd5ab

-- 
Michal Hocko
SUSE Labs
