Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4545C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88C23218A6
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545309866;
	bh=8KlNPwNV6AB/lDEFpXu6UH5N8C1TpcOhRftkTlAM7xo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KOlUpQqenz5RAiXEJlFbzP3ks9B3d6Y1xN72ywozYyumAXTi4zev7KE6ONTMDBJuD
	 e5pq5SPOrJOKE0b/F5TmujH0r5sA+xf3kv9HZ/nWDXFVaJTmPe5jwTBcIQPIdcd5sC
	 feu1VLQpUzOqGZ3nZbEcb9i8CsG72MN8ptwLxv2s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732561AbeLTMoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 07:44:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:59528 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728966AbeLTMoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 07:44:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5CCC7AE41;
        Thu, 20 Dec 2018 12:44:22 +0000 (UTC)
Date:   Thu, 20 Dec 2018 13:44:19 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCHv2 2/3] mm/numa: build zonelist when alloc for device on
 offline node
Message-ID: <20181220124419.GD9104@dhcp22.suse.cz>
References: <1545299439-31370-1-git-send-email-kernelfans@gmail.com>
 <1545299439-31370-3-git-send-email-kernelfans@gmail.com>
 <20181220113547.GC9104@dhcp22.suse.cz>
 <CAFgQCTvxNGTKD+DP_LxF86WoVnCHnPkWoSqdGeXQxXNVYD_orw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFgQCTvxNGTKD+DP_LxF86WoVnCHnPkWoSqdGeXQxXNVYD_orw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 20-12-18 20:26:28, Pingfan Liu wrote:
> On Thu, Dec 20, 2018 at 7:35 PM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Thu 20-12-18 17:50:38, Pingfan Liu wrote:
> > [...]
> > > @@ -453,7 +456,12 @@ static inline int gfp_zonelist(gfp_t flags)
> > >   */
> > >  static inline struct zonelist *node_zonelist(int nid, gfp_t flags)
> > >  {
> > > -     return NODE_DATA(nid)->node_zonelists + gfp_zonelist(flags);
> > > +     if (unlikely(!possible_zonelists[nid])) {
> > > +             WARN_ONCE(1, "alloc from offline node: %d\n", nid);
> > > +             if (unlikely(build_fallback_zonelists(nid)))
> > > +                     nid = first_online_node;
> > > +     }
> > > +     return possible_zonelists[nid] + gfp_zonelist(flags);
> > >  }
> >
> > No, please don't do this. We do not want to make things work magically
> 
> For magically, if you mean directly replies on zonelist instead of on
> pgdat struct, then it is easy to change

No, I mean that we _know_ which nodes are possible. Platform is supposed
to tell us. We should just do the intialization properly. What we do now
instead is a pile of hacks that fit magically together. And that should
be changed.

> > and we definitely do not want to put something like that into the hot
> 
> But  the cose of "unlikely" can be ignored, why can it not be placed
> in the path?

unlikely will simply put the code outside of the hot path. The condition
is still there. There are people desperately fighting to get every
single cycle out of the page allocator. Now you want them to pay a
branch which is relevant only for few obscure HW setups.

> > path. We definitely need zonelists to be build transparently for all
> > possible nodes during the init time.
> 
> That is the point, whether the all nodes should be instanced at boot
> time, or not be instanced until there is requirement.

And that should be done at init time. We have all the information
necessary at that time.
-- 
Michal Hocko
SUSE Labs
