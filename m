Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF8EC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E82C5217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548173225;
	bh=yC8ED1P53BnbO3v5xu90tp3dY7+M8ycrISLjXbJfbe8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vPMrzEglAopvO45HKbLZQIToWBmiwweroQKZG5DAs1fprH00DVU9o1yzJeKegsG3j
	 ypItmQ0prKy2J2BlzrrYZtjeZDV756e/aa/8QTYcrUQsuxpIs2jWVFGtV8HmGSLg+M
	 8fJrBS3zXVFnznXZqguVsYIsGGi3RxT8dhSoemnE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbfAVQHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 11:07:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:40368 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728580AbfAVQHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 11:07:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E2126B06A;
        Tue, 22 Jan 2019 16:07:01 +0000 (UTC)
Date:   Tue, 22 Jan 2019 17:07:01 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Laura Abbott <labbott@redhat.com>, linux-mm@kvack.org
Subject: Re: [PATCH] mm: no need to check return value of debugfs_create
 functions
Message-ID: <20190122160701.GK4087@dhcp22.suse.cz>
References: <20190122152151.16139-14-gregkh@linuxfoundation.org>
 <20190122153102.GJ4087@dhcp22.suse.cz>
 <20190122155255.GA20142@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122155255.GA20142@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22-01-19 16:52:55, Greg KH wrote:
> On Tue, Jan 22, 2019 at 04:31:02PM +0100, Michal Hocko wrote:
> > On Tue 22-01-19 16:21:13, Greg KH wrote:
> > [...]
> > > diff --git a/mm/memblock.c b/mm/memblock.c
> > > index 022d4cbb3618..18ee657fb918 100644
> > > --- a/mm/memblock.c
> > > +++ b/mm/memblock.c
> > > @@ -1998,8 +1998,7 @@ DEFINE_SHOW_ATTRIBUTE(memblock_debug);
> > >  static int __init memblock_init_debugfs(void)
> > >  {
> > >  	struct dentry *root = debugfs_create_dir("memblock", NULL);
> > > -	if (!root)
> > > -		return -ENXIO;
> > > +
> > >  	debugfs_create_file("memory", 0444, root,
> > >  			    &memblock.memory, &memblock_debug_fops);
> > >  	debugfs_create_file("reserved", 0444, root,
> > 
> > I haven't really read the whole patch but this has just hit my eyes. Is
> > this a correct behavior?
> > 
> > Documentations says:
> >  * @parent: a pointer to the parent dentry for this file.  This should be a
> >  *          directory dentry if set.  If this parameter is NULL, then the
> >  *          file will be created in the root of the debugfs filesystem.
> > 
> > so in case of failure we would get those debugfs files outside of their
> > intended scope. I believe it is much more correct to simply not create
> > anything, no?
> 
> If debugfs_create_dir() returns NULL, then something is really wrong
> (you passed it an invalid pointer as the parent dentry, or free memory
> is gone), so there's nothing you can do except keep moving forward and
> take that result and pass it as any parent pointer you want to.  Your
> code logic should never care if a debugfs file is created or not, it is
> "fire and forget".

OK, but does it make any sense to continue creating files when you know
that the parent directory has failed to create? What kind of advantage
does this have?

> And any result of a debugfs call, like this one, that is to be passed
> into another debugfs call, will work just fine if the first one failed
> (the second one usually will also fail, which is fine.)
> 
> Also, and this is the biggest problem, everyone gets the return value
> check wrong thinking NULL will be an error, it is one type of error, but
> other ones are also returned and no one checks them properly.  So just
> don't check at all, that is the design goal here.

sounds like a poor design goal to me but not mine code to maintain so...
-- 
Michal Hocko
SUSE Labs
