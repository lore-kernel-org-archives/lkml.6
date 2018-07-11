Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027A9C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A977D20B6F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:09:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A977D20B6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732570AbeGKLNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 07:13:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:51460 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726641AbeGKLNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 07:13:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BBB00AD9E;
        Wed, 11 Jul 2018 11:09:51 +0000 (UTC)
Date:   Wed, 11 Jul 2018 13:09:49 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        virtio-dev@lists.oasis-open.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        KVM list <kvm@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        liliang.opensource@gmail.com, yang.zhang.wz@gmail.com,
        quan.xu0@gmail.com, nilal@redhat.com,
        Rik van Riel <riel@redhat.com>, peterx@redhat.com
Subject: Re: [PATCH v35 1/5] mm: support to get hints of free page blocks
Message-ID: <20180711110949.GJ20050@dhcp22.suse.cz>
References: <1531215067-35472-1-git-send-email-wei.w.wang@intel.com>
 <1531215067-35472-2-git-send-email-wei.w.wang@intel.com>
 <CA+55aFz9a=D-kquM=sG5uhV_HrBAw+VAhcJmtPNz+howy4j9ow@mail.gmail.com>
 <5B455D50.90902@intel.com>
 <CA+55aFzqj8wxXnHAdUTiOomipgFONVbqKMjL_tfk7e5ar1FziQ@mail.gmail.com>
 <20180711092152.GE20050@dhcp22.suse.cz>
 <5B45E17D.2090205@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B45E17D.2090205@intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 11-07-18 18:52:45, Wei Wang wrote:
> On 07/11/2018 05:21 PM, Michal Hocko wrote:
> > On Tue 10-07-18 18:44:34, Linus Torvalds wrote:
> > [...]
> > > That was what I tried to encourage with actually removing the pages
> > > form the page list. That would be an _incremental_ interface. You can
> > > remove MAX_ORDER-1 pages one by one (or a hundred at a time), and mark
> > > them free for ballooning that way. And if you still feel you have tons
> > > of free memory, just continue removing more pages from the free list.
> > We already have an interface for that. alloc_pages(GFP_NOWAIT, MAX_ORDER -1).
> > So why do we need any array based interface?
> 
> Yes, I'm trying to get free pages directly via alloc_pages, so there will be
> no new mm APIs.

OK. The above was just a rough example. In fact you would need a more
complex gfp mask. I assume you only want to balloon only memory directly
usable by the kernel so it will be
	(GFP_KERNEL | __GFP_NOWARN) & ~__GFP_RECLAIM

> I plan to let free page allocation stop when the remaining system free
> memory becomes close to min_free_kbytes (prevent swapping).

~__GFP_RECLAIM will make sure you are allocate as long as there is any
memory without reclaim. It will not even poke the kswapd to do the
background work. So I do not think you would need much more than that.

But let me note that I am not really convinced how this (or previous)
approach will really work in most workloads. We tend to cache heavily so
there is rarely any memory free.

-- 
Michal Hocko
SUSE Labs
