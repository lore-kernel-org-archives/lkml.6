Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DADC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 073282085A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548174476;
	bh=xUE8u4vQ0lmQz4BihaXFwsAVlh+oSHMOU9iHN6A/Q4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DIoVokvbACvYW9q4WuuEoh9sf33FkEjdkgGAaMm3reOb29QdiqdlGFA8CJfOEnhsc
	 HIxhfqRipuf3PkfkftAEWCgo/6R2zB3VmLMkyjCGbdIDoza59gaVuCFGTFf+Yf7uk5
	 lOQ13bovgVuUgvLQ25bKZl/i3pZaK2O0P/Pc49bc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbfAVQ1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 11:27:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:52434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728580AbfAVQ1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 11:27:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D00602085A;
        Tue, 22 Jan 2019 16:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548174472;
        bh=xUE8u4vQ0lmQz4BihaXFwsAVlh+oSHMOU9iHN6A/Q4A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2uMbOUF2KUYIGHpQHcWgVpKUY37ULvUNj2LtAotHo3yUxccvLBCkRzoUwsF7Ai43Q
         aGnZqT5HWERV0E5xVylg+kUAbrgSGnlScjd6mFnA4vr3IP5q3O12qGRYtFy7QOBGoJ
         ZNF1o1wwMO/tEnQh+XFuUOtJqWcDaPkmpCzGl3C8=
Date:   Tue, 22 Jan 2019 17:27:49 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Laura Abbott <labbott@redhat.com>, linux-mm@kvack.org
Subject: Re: [PATCH] mm: no need to check return value of debugfs_create
 functions
Message-ID: <20190122162749.GA22841@kroah.com>
References: <20190122152151.16139-14-gregkh@linuxfoundation.org>
 <20190122153102.GJ4087@dhcp22.suse.cz>
 <20190122155255.GA20142@kroah.com>
 <20190122160701.GK4087@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122160701.GK4087@dhcp22.suse.cz>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 05:07:01PM +0100, Michal Hocko wrote:
> On Tue 22-01-19 16:52:55, Greg KH wrote:
> > On Tue, Jan 22, 2019 at 04:31:02PM +0100, Michal Hocko wrote:
> > > On Tue 22-01-19 16:21:13, Greg KH wrote:
> > > [...]
> > > > diff --git a/mm/memblock.c b/mm/memblock.c
> > > > index 022d4cbb3618..18ee657fb918 100644
> > > > --- a/mm/memblock.c
> > > > +++ b/mm/memblock.c
> > > > @@ -1998,8 +1998,7 @@ DEFINE_SHOW_ATTRIBUTE(memblock_debug);
> > > >  static int __init memblock_init_debugfs(void)
> > > >  {
> > > >  	struct dentry *root = debugfs_create_dir("memblock", NULL);
> > > > -	if (!root)
> > > > -		return -ENXIO;
> > > > +
> > > >  	debugfs_create_file("memory", 0444, root,
> > > >  			    &memblock.memory, &memblock_debug_fops);
> > > >  	debugfs_create_file("reserved", 0444, root,
> > > 
> > > I haven't really read the whole patch but this has just hit my eyes. Is
> > > this a correct behavior?
> > > 
> > > Documentations says:
> > >  * @parent: a pointer to the parent dentry for this file.  This should be a
> > >  *          directory dentry if set.  If this parameter is NULL, then the
> > >  *          file will be created in the root of the debugfs filesystem.
> > > 
> > > so in case of failure we would get those debugfs files outside of their
> > > intended scope. I believe it is much more correct to simply not create
> > > anything, no?
> > 
> > If debugfs_create_dir() returns NULL, then something is really wrong
> > (you passed it an invalid pointer as the parent dentry, or free memory
> > is gone), so there's nothing you can do except keep moving forward and
> > take that result and pass it as any parent pointer you want to.  Your
> > code logic should never care if a debugfs file is created or not, it is
> > "fire and forget".
> 
> OK, but does it make any sense to continue creating files when you know
> that the parent directory has failed to create? What kind of advantage
> does this have?

It has no advantage or disadvantage.  And again, it can't really happen
unless the system is out of memory and in that case, everything else
just crashed anyway.

> > And any result of a debugfs call, like this one, that is to be passed
> > into another debugfs call, will work just fine if the first one failed
> > (the second one usually will also fail, which is fine.)
> > 
> > Also, and this is the biggest problem, everyone gets the return value
> > check wrong thinking NULL will be an error, it is one type of error, but
> > other ones are also returned and no one checks them properly.  So just
> > don't check at all, that is the design goal here.
> 
> sounds like a poor design goal to me but not mine code to maintain so...

The design goal was to make it as simple as possible to use, and that
includes "you do not care about the return value".  Now we do have to
return a value because some people need that for when they want to make
a subdirectory, or remove the file later on, otherwise I would have just
had everything be a void return function :)

thanks,

greg k-h
