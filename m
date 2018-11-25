Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52547C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 08:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A2020855
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 08:10:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18A2020855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727396AbeKYTAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 14:00:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:39146 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726859AbeKYTAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 14:00:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D6CD5AD94;
        Sun, 25 Nov 2018 08:10:04 +0000 (UTC)
Date:   Sun, 25 Nov 2018 09:10:03 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, Oscar Salvador <OSalvador@suse.com>,
        Baoquan He <bhe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/5] mm: print more information about mapping in
 __dump_page
Message-ID: <20181125081003.GC12455@dhcp22.suse.cz>
References: <20181107101830.17405-1-mhocko@kernel.org>
 <20181107101830.17405-2-mhocko@kernel.org>
 <20181123160404.259413e56a8cc9a22112712a@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123160404.259413e56a8cc9a22112712a@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 23-11-18 16:04:04, Andrew Morton wrote:
> On Wed,  7 Nov 2018 11:18:26 +0100 Michal Hocko <mhocko@kernel.org> wrote:
> 
> > From: Michal Hocko <mhocko@suse.com>
> > 
> > __dump_page prints the mapping pointer but that is quite unhelpful
> > for many reports because the pointer itself only helps to distinguish
> > anon/ksm mappings from other ones (because of lowest bits
> > set). Sometimes it would be much more helpful to know what kind of
> > mapping that is actually and if we know this is a file mapping then also
> > try to resolve the dentry name.
> > 
> > ...
> >
> > --- a/mm/debug.c
> > +++ b/mm/debug.c
> >
> > ...
> >
> > @@ -70,6 +71,18 @@ void __dump_page(struct page *page, const char *reason)
> >  	if (PageCompound(page))
> >  		pr_cont(" compound_mapcount: %d", compound_mapcount(page));
> >  	pr_cont("\n");
> > +	if (PageAnon(page))
> > +		pr_emerg("anon ");
> > +	else if (PageKsm(page))
> > +		pr_emerg("ksm ");
> > +	else if (mapping) {
> > +		pr_emerg("%ps ", mapping->a_ops);
> > +		if (mapping->host->i_dentry.first) {
> > +			struct dentry *dentry;
> > +			dentry = container_of(mapping->host->i_dentry.first, struct dentry, d_u.d_alias);
> > +			pr_emerg("name:\"%*s\" ", dentry->d_name.len, dentry->d_name.name);
> > +		}
> > +	}
> 
> There has to be a better way of printing the filename.  It is so often
> needed.
> 
> The (poorly named and gleefully undocumented)
> take_dentry_name_snapshot() looks promising.  However it's unclear that
> __dump_page() is always called from contexts where
> take_dentry_name_snapshot() and release_dentry_name_snapshot() can be
> safely called.  Probably it's OK, but how to guarantee it?

http://lkml.kernel.org/r/20181125080834.GB12455@dhcp22.suse.cz as
suggested by Tetsuo?
-- 
Michal Hocko
SUSE Labs
