Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7F4C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 06:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E1482172B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 06:24:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E1482172B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbeHCITG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 04:19:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:55210 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727419AbeHCITF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 04:19:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 33875AFC8;
        Fri,  3 Aug 2018 06:24:20 +0000 (UTC)
Date:   Fri, 3 Aug 2018 08:24:19 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-mm@kvack.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz, Punit.Agrawal@arm.com,
        Lorenzo.Pieralisi@arm.com, linux-arm-kernel@lists.infradead.org,
        bhelgaas@google.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC 2/2] mm: harden alloc_pages code paths against bogus nodes
Message-ID: <20180803062419.GE27245@dhcp22.suse.cz>
References: <20180801200418.1325826-1-jeremy.linton@arm.com>
 <20180801200418.1325826-3-jeremy.linton@arm.com>
 <20180802073147.GA10808@dhcp22.suse.cz>
 <5ed35dfa-5f02-55cb-9b84-b944394e1a5a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ed35dfa-5f02-55cb-9b84-b944394e1a5a@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 02-08-18 22:17:49, Jeremy Linton wrote:
> Hi,
> 
> On 08/02/2018 02:31 AM, Michal Hocko wrote:
> > On Wed 01-08-18 15:04:18, Jeremy Linton wrote:
> > > Its possible to crash __alloc_pages_nodemask by passing it
> > > bogus node ids. This is caused by NODE_DATA() returning null
> > > (hopefully) when the requested node is offline. We can
> > > harded against the basic case of a mostly valid node, that
> > > isn't online by checking for null and failing prepare_alloc_pages.
> > > 
> > > But this then suggests we should also harden NODE_DATA() like this
> > > 
> > > #define NODE_DATA(nid)         ( (nid) < MAX_NUMNODES ? node_data[(nid)] : NULL)
> > > 
> > > eventually this starts to add a bunch of generally uneeded checks
> > > in some code paths that are called quite frequently.
> > 
> > But the page allocator is really a hot path and people will not be happy
> > to have yet another branch there. No code should really use invalid numa
> > node ids in the first place.
> > 
> > If I remember those bugs correctly then it was the arch code which was
> > doing something wrong. I would prefer that code to be fixed instead.
> 
> Yes, I think the consensus is that 2/2 should be dropped.
> 
> The arch code is being fixed (both cases) this patch set is just an attempt
> to harden this code path against future failures like that so that we get
> some warnings/ugly messages rather than early boot failures.

Hmm, this is a completely different story. We do have VM_{BUG,WARN}_ON
which are noops for most configurations. It is primarily meant to be
enabled for developers or special debug kernels. If you have an example
when such an early splat in the log would safe a lot of head scratching
then this would sound like a reasonable justification to add
	VM_WARN_ON(!NODE_DATA(nid))
into the page allocator, me thinks. But considering that would should
get NULL ptr splat anyway then I am not really so sure. But maybe we are
in a context where warning would get into the log while a blow up would
just make the whole machine silent...
-- 
Michal Hocko
SUSE Labs
