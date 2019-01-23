Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A40C282C5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 06:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 568C421841
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 06:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548226011;
	bh=5QXH7AbOaOo5SJKtG5CEPSl1xutl/m0veyOLAaw5S5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GNXCAVlOwQk6H1Pq1M8bzaV3jbeTwigzg0HtsG9PnbRujXcEeUFlRontjR/7A9+/b
	 eesIv1AfKW7UX9kIZSs38NeNPYyeJJDVNMEKOXcuU2KpLzdXrdt6HkfWmGwsHHU7wJ
	 umpOagRODEpT/o+jXq7CCFaBpjS0qlYpqSXbPJ8Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbfAWGqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 01:46:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:53920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbfAWGqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 01:46:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1046B21726;
        Wed, 23 Jan 2019 06:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548226008;
        bh=5QXH7AbOaOo5SJKtG5CEPSl1xutl/m0veyOLAaw5S5E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f9PCRIhh9EZz/Aq3A3u8EzexW/9Oy+0Ppd7792PVNya1Z+1E5jCYbPXtyWJRH+rI1
         QyaEWSoGd7UEBLJvAgvuDQ5X8W4MDyddY2V9kCOVGgWT3MNgtOfeb2s6AuaIMqxCFe
         tJ9GTxaVmBw2ml0wD8ALyviHinM6uP+Rcb9Lgbas=
Date:   Wed, 23 Jan 2019 07:46:46 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Michal Hocko <mhocko@suse.com>,
        linux-mm@kvack.org
Subject: Re: [PATCH] backing-dev: no need to check return value of
 debugfs_create functions
Message-ID: <20190123064646.GA26885@kroah.com>
References: <20190122152151.16139-8-gregkh@linuxfoundation.org>
 <20190122160759.mx3h7gjc23zmrvxc@linutronix.de>
 <20190122162503.GB22548@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122162503.GB22548@kroah.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 05:25:03PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Jan 22, 2019 at 05:07:59PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2019-01-22 16:21:07 [+0100], Greg Kroah-Hartman wrote:
> > > diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> > > index 8a8bb8796c6c..85ef344a9c67 100644
> > > --- a/mm/backing-dev.c
> > > +++ b/mm/backing-dev.c
> > > @@ -102,39 +102,25 @@ static int bdi_debug_stats_show(struct seq_file *m, void *v)
> > >  }
> > >  DEFINE_SHOW_ATTRIBUTE(bdi_debug_stats);
> > >  
> > > -static int bdi_debug_register(struct backing_dev_info *bdi, const char *name)
> > > +static void bdi_debug_register(struct backing_dev_info *bdi, const char *name)
> > >  {
> > > -	if (!bdi_debug_root)
> > > -		return -ENOMEM;
> > > -
> > >  	bdi->debug_dir = debugfs_create_dir(name, bdi_debug_root);
> > 
> > If this fails then ->debug_dir is NULL 
> 
> Wonderful, who cares :)

Ok, after sleeping on it, I'll change this function to return an error
if we are out of memory, that way you will not be creating any files in
any other location if you use the return value like this.  That should
solve this issue.

thanks,

greg k-h
