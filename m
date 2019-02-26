Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D40C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFE46217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551182965;
	bh=phjMlhQFpn3LuE/36mFjR9doP93UxX1cvoVhII/S3uQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ilUcIw/CbwwuGa7hLR0NdjKbXU7lWRKWqXMYu7VQcq4n8csYoftfI6E5DQbTa98Mj
	 XyC0LphqVO+uJwwM5Dgw0gW4sL8G5c5onjpz3v9k2/Y1kSm4pr4oDuAN1vzMcwX6gX
	 63ONqRZkmZApYE8wA+vFx6pNsyFoQk1AnXsRQh4Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbfBZMJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 07:09:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:34610 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726567AbfBZMJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 07:09:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2C35BB611;
        Tue, 26 Feb 2019 12:09:21 +0000 (UTC)
Date:   Tue, 26 Feb 2019 13:09:19 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     x86@kernel.org, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Jonathan Corbet <corbet@lwn.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        Daniel Vacek <neelx@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/6] make memblock allocator utilize the node's fallback
 info
Message-ID: <20190226120919.GY10588@dhcp22.suse.cz>
References: <1551011649-30103-1-git-send-email-kernelfans@gmail.com>
 <20190225160358.GW10588@dhcp22.suse.cz>
 <CAFgQCTuD9MMdXRjyu1w5s3QSupWWtdcCOR6LhdSEP=1xGONWjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFgQCTuD9MMdXRjyu1w5s3QSupWWtdcCOR6LhdSEP=1xGONWjQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 26-02-19 13:47:37, Pingfan Liu wrote:
> On Tue, Feb 26, 2019 at 12:04 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Sun 24-02-19 20:34:03, Pingfan Liu wrote:
> > > There are NUMA machines with memory-less node. At present page allocator builds the
> > > full fallback info by build_zonelists(). But memblock allocator does not utilize
> > > this info. And for memory-less node, memblock allocator just falls back "node 0",
> > > without utilizing the nearest node. Unfortunately, the percpu section is allocated
> > > by memblock, which is accessed frequently after bootup.
> > >
> > > This series aims to improve the performance of per cpu section on memory-less node
> > > by feeding node's fallback info to memblock allocator on x86, like we do for page
> > > allocator. On other archs, it requires independent effort to setup node to cpumask
> > > map ahead.
> >
> > Do you have any numbers to tell us how much does this improve the
> > situation?
> 
> Not yet. At present just based on the fact that we prefer to allocate
> per cpu area on local node.

Yes, we _usually_ do. But the additional complexity should be worth it.
And if we find out that the final improvement is not all that great and
considering that memory-less setups are crippled anyway then it might
turn out we just do not care all that much.
-- 
Michal Hocko
SUSE Labs
