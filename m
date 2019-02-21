Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7C9C00319
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3BB8214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550738729;
	bh=fn33i8okz9jBAD+8oha8iCLwWxNge4qxeAX2raJjtXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fMcdZ986Ab3mFIFS9ZHJ7X6qa3fjkW3TmRWFXzr4yd6BeUArOXTwZjGjsUCA9xZm1
	 rhr7YACMBO/Gt9WsR1iEHV6EIfc+HIEPHjyx6EXRsgLhxJvmszr9FTeET6FwJYIJjl
	 8z+Dg+SezBQ/L506O0FujgJWR2hqOMIeTm2by5Jc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfBUIp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 03:45:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:45024 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726354AbfBUIp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 03:45:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 77B87AEE8;
        Thu, 21 Feb 2019 08:45:26 +0000 (UTC)
Date:   Thu, 21 Feb 2019 09:45:25 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Yue Hu <zbestahu@gmail.com>, akpm@linux-foundation.org,
        rientjes@google.com, joe@perches.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, huyue2@yulong.com
Subject: Re: [PATCH] mm/cma_debug: Check for null tmp in cma_debugfs_add_one()
Message-ID: <20190221084525.GI4525@dhcp22.suse.cz>
References: <20190221040130.8940-1-zbestahu@gmail.com>
 <20190221040130.8940-2-zbestahu@gmail.com>
 <20190221082309.GG4525@dhcp22.suse.cz>
 <20190221083624.GD6397@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221083624.GD6397@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 21-02-19 09:36:24, Greg KH wrote:
> On Thu, Feb 21, 2019 at 09:23:09AM +0100, Michal Hocko wrote:
> > On Thu 21-02-19 12:01:30, Yue Hu wrote:
> > > From: Yue Hu <huyue2@yulong.com>
> > > 
> > > If debugfs_create_dir() failed, the following debugfs_create_file()
> > > will be meanless since it depends on non-NULL tmp dentry and it will
> > > only waste CPU resource.
> > 
> > The file will be created in the debugfs root. But, more importantly.
> > Greg (CCed now) is working on removing the failure paths because he
> > believes they do not really matter for debugfs and they make code more
> > ugly. More importantly a check for NULL is not correct because you
> > get ERR_PTR after recent changes IIRC.
> > 
> > > 
> > > Signed-off-by: Yue Hu <huyue2@yulong.com>
> > > ---
> > >  mm/cma_debug.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/mm/cma_debug.c b/mm/cma_debug.c
> > > index 2c2c869..3e9d984 100644
> > > --- a/mm/cma_debug.c
> > > +++ b/mm/cma_debug.c
> > > @@ -169,6 +169,8 @@ static void cma_debugfs_add_one(struct cma *cma, struct dentry *root_dentry)
> > >  	scnprintf(name, sizeof(name), "cma-%s", cma->name);
> > >  
> > >  	tmp = debugfs_create_dir(name, root_dentry);
> > > +	if (!tmp)
> > > +		return;
> 
> Ick, yes, this patch isn't ok, I've been doing lots of work to rip these
> checks out :)

Btw. I believe that it would help to clarify this stance in the
kerneldoc otherwise these checks will be returning back because the
general kernel development attitude is to check for errors. As I've said
previously debugfs being different is ugly but decision is yours.

-- 
Michal Hocko
SUSE Labs
