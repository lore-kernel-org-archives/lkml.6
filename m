Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734CEC00319
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4071321734
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550738191;
	bh=BLC5WO9lZNuzlf6omeBaA0Qh70h77drVc5zvXoTJsuw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=R6sulhD52T0ExTO2LAQhu2RxO624Il+FaO/6GVpHUXPHCs2qXPSKVPe5p+YLsEpuM
	 KSZMN5QFtGsaBmEPpZdpwpTqknvV590FmSBaBcI1v7kjdlewAZlZajm+JRB9IytJJS
	 ARfjdwQx2DH9QI1pGUvshGFTZRvgEfZpwGBkmltE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfBUIg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 03:36:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:33826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbfBUIg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 03:36:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0D6B20842;
        Thu, 21 Feb 2019 08:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550738188;
        bh=BLC5WO9lZNuzlf6omeBaA0Qh70h77drVc5zvXoTJsuw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rEpnOzvYpgGQJzbfFxZIVbAc35BxXy/fA9cad4UXCo7lPMCUjuBdsNuUH7GsS+5aZ
         Me/ansqbIulB2fjysvYXwgnS1KdeohgMUdzQmmvg/Pf6mC7fzlUAHWMQDRKw9BKgje
         UkP9kfVNTcX1LqDvgqcu4qfLilepE5b8fwg07yRQ=
Date:   Thu, 21 Feb 2019 09:36:24 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Yue Hu <zbestahu@gmail.com>, akpm@linux-foundation.org,
        rientjes@google.com, joe@perches.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, huyue2@yulong.com
Subject: Re: [PATCH] mm/cma_debug: Check for null tmp in cma_debugfs_add_one()
Message-ID: <20190221083624.GD6397@kroah.com>
References: <20190221040130.8940-1-zbestahu@gmail.com>
 <20190221040130.8940-2-zbestahu@gmail.com>
 <20190221082309.GG4525@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221082309.GG4525@dhcp22.suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 09:23:09AM +0100, Michal Hocko wrote:
> On Thu 21-02-19 12:01:30, Yue Hu wrote:
> > From: Yue Hu <huyue2@yulong.com>
> > 
> > If debugfs_create_dir() failed, the following debugfs_create_file()
> > will be meanless since it depends on non-NULL tmp dentry and it will
> > only waste CPU resource.
> 
> The file will be created in the debugfs root. But, more importantly.
> Greg (CCed now) is working on removing the failure paths because he
> believes they do not really matter for debugfs and they make code more
> ugly. More importantly a check for NULL is not correct because you
> get ERR_PTR after recent changes IIRC.
> 
> > 
> > Signed-off-by: Yue Hu <huyue2@yulong.com>
> > ---
> >  mm/cma_debug.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/mm/cma_debug.c b/mm/cma_debug.c
> > index 2c2c869..3e9d984 100644
> > --- a/mm/cma_debug.c
> > +++ b/mm/cma_debug.c
> > @@ -169,6 +169,8 @@ static void cma_debugfs_add_one(struct cma *cma, struct dentry *root_dentry)
> >  	scnprintf(name, sizeof(name), "cma-%s", cma->name);
> >  
> >  	tmp = debugfs_create_dir(name, root_dentry);
> > +	if (!tmp)
> > +		return;

Ick, yes, this patch isn't ok, I've been doing lots of work to rip these
checks out :)

Thanks for catching this Michal.

greg k-h
