Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DB2C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 375C820862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHon4cov"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 375C820862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390194AbeHASJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 14:09:09 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38232 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390005AbeHASJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 14:09:08 -0400
Received: by mail-lf1-f65.google.com with SMTP id a4-v6so13732024lff.5;
        Wed, 01 Aug 2018 09:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=93x5y2Dc/rNkiXHdRkllzhsmzl11TBcLrZdlz8BmOfQ=;
        b=jHon4covejtcXQIL+Rz/NKzNGofkC0fXLXQEZ1hkeSCFg/qSztBC7s2BBwatTV4wo0
         R3uTxNQuq6ZuSnKZLMHCqYeqBl+jzWsBPsKsRm1ZqA0fgt1ILcBkbIcnioGNCp82aoc4
         SkYAs9ZIjA3PWEUK1cdlCyaFmb0REcUSaPJDdKd1P4aIr/90QGv5Hf09VxJzga12IOs2
         soxOt1MwaByi9Ka+doroH6K9bMJPyjHue7Dtb1ip39QJ0ndnsfLx23N4+Jj4VcYJ9+Ql
         IzkmNv3Q6V6x6veXO025iAgXnOBH+r1m9TkMkc2aR8uDXskn+YYxGAgewnX3JKgxpG04
         Xh/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=93x5y2Dc/rNkiXHdRkllzhsmzl11TBcLrZdlz8BmOfQ=;
        b=KuSFTWd/6m4fDdNrwZtJyFgc4FnAz96/FNgML9gvb47H9XwgxziaBDzROjD3QKI4Q2
         XYXJXKcZmn8aQKPLgyXZxXnNRRSBYS3tExTxLCi3JiqkV43ZIliNru4ODYQJS2gL+2m3
         NJRtiV7/qfuf9K4TmLIF8Bw1gBftpQeA8Zha6/pYAVpPMx/K/yPyufVeZ3E8oBGvVHez
         o0LWMGTwhuk6CKAIvn+5aYavoBFm+/T3LlV4inLWcaa/jPMYXFAI9MgzcQUmOU3xolhQ
         QukDyF6nz9++T+85I/5YIjIRK6jKGoZK+Jc1KLkENa2yaFTo+j/6QWkl3B/iCvkgje/Y
         JpUg==
X-Gm-Message-State: AOUpUlELbVV0HSosMmxGw++w1OQUsYL3scOvDIovWcsMI9XUq0cWvxZo
        nfaAwJatK4DT6Y371Bb/Um0=
X-Google-Smtp-Source: AAOMgpciH86XmquICRiQMCcRz6r8FxIm6d452fZaIfpHGrvPgmCa2I2IeggwmYL6jj2AlpT6ibgknQ==
X-Received: by 2002:a19:dd81:: with SMTP id w1-v6mr15889239lfi.114.1533140558026;
        Wed, 01 Aug 2018 09:22:38 -0700 (PDT)
Received: from esperanza ([185.6.245.156])
        by smtp.gmail.com with ESMTPSA id q85-v6sm2487185lfg.20.2018.08.01.09.22.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 09:22:37 -0700 (PDT)
Date:   Wed, 1 Aug 2018 19:22:35 +0300
From:   Vladimir Davydov <vdavydov.dev@gmail.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memcg: Remove memcg_cgroup::id from IDR on
 mem_cgroup_css_alloc() failure
Message-ID: <20180801162235.j3v7xipyw5afnj4x@esperanza>
References: <20180413115454.GL17484@dhcp22.suse.cz>
 <abfd4903-c455-fac2-7ed6-73707cda64d1@virtuozzo.com>
 <20180413121433.GM17484@dhcp22.suse.cz>
 <20180413125101.GO17484@dhcp22.suse.cz>
 <20180726162512.6056b5d7c1d2a5fbff6ce214@linux-foundation.org>
 <20180727193134.GA10996@cmpxchg.org>
 <20180729192621.py4znecoinw5mqcp@esperanza>
 <20180730153113.GB4567@cmpxchg.org>
 <20180731163908.603d7a27c6534341e1afa724@linux-foundation.org>
 <20180801155552.GA8600@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180801155552.GA8600@cmpxchg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 11:55:52AM -0400, Johannes Weiner wrote:
> On Tue, Jul 31, 2018 at 04:39:08PM -0700, Andrew Morton wrote:
> > On Mon, 30 Jul 2018 11:31:13 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:
> > 
> > > Subject: [PATCH] mm: memcontrol: simplify memcg idr allocation and error
> > >  unwinding
> > > 
> > > The memcg ID is allocated early in the multi-step memcg creation
> > > process, which needs 2-step ID allocation and IDR publishing, as well
> > > as two separate IDR cleanup/unwind sites on error.
> > > 
> > > Defer the IDR allocation until the last second during onlining to
> > > eliminate all this complexity. There is no requirement to have the ID
> > > and IDR entry earlier than that. And the root reference to the ID is
> > > put in the offline path, so this matches nicely.
> > 
> > This patch isn't aware of Kirill's later "mm, memcg: assign memcg-aware
> > shrinkers bitmap to memcg", which altered mem_cgroup_css_online():
> > 
> > @@ -4356,6 +4470,11 @@ static int mem_cgroup_css_online(struct
> >  {
> >  	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
> >  
> > +	if (memcg_alloc_shrinker_maps(memcg)) {
> > +		mem_cgroup_id_remove(memcg);
> > +		return -ENOMEM;
> > +	}
> > +
> >  	/* Online state pins memcg ID, memcg ID pins CSS */
> >  	atomic_set(&memcg->id.ref, 1);
> >  	css_get(css);
> > 
> 
> Hm, that looks out of place too. The bitmaps are allocated for the
> entire lifetime of the css, not just while it's online.
> 
> Any objections to the following fixup to that patch?

That would be incorrect. Memory cgroups that haven't been put online
are invisible to for_each_mem_cgroup(), which is used for expanding
shrinker maps of all cgroups - see memcg_expand_shrinker_maps(). So if
memcg_expand_shrinker_maps() is called between css_alloc and css_online,
it will miss this cgroup and its shrinker_map won't be reallocated to
fit the new id. Allocating the shrinker map in css_online guarantees
that it won't happen. Looks like this code lacks a comment...
