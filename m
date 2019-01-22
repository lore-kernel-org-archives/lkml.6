Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0F5C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5301B21726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548174312;
	bh=NceVHhyfjnTlGz7ONfpAXNZ0OLqihlpu38df7G/595c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LE0mbEjNDrHin7hoR8D8n2tufNz31VEx8Tg1zaNrciYu5RRqSIW8j7VjynqqT9qNx
	 ql5/nZ64wf8TrsOzfbK4ZF+8POiyR/Ax6844OY5uVyLB1SrtLNrdB8UcuGi8No0gTC
	 GInyYegIQNeBzmxSG0a7j+b6F926yBbBmIU5RiWg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbfAVQZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 11:25:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:50876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728669AbfAVQZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 11:25:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B546D20870;
        Tue, 22 Jan 2019 16:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548174306;
        bh=NceVHhyfjnTlGz7ONfpAXNZ0OLqihlpu38df7G/595c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z4n0XIIgOZ92Pn3ns8HwzEd56+uRdWJJNzFOrZvbOSE7oC2OPQ9KeG0JkM8AuOWA2
         SvMkM38CzmCZMHnPfkJagJ9Pr1O4kXMwt86Jtpu5EyC8iq2zfOU7yvLNXLorHifpf+
         BjnEhWJsnRztAtQWcFGDjDsH2P1MeC0VRxIRu4hI=
Date:   Tue, 22 Jan 2019 17:25:03 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Michal Hocko <mhocko@suse.com>,
        linux-mm@kvack.org
Subject: Re: [PATCH] backing-dev: no need to check return value of
 debugfs_create functions
Message-ID: <20190122162503.GB22548@kroah.com>
References: <20190122152151.16139-8-gregkh@linuxfoundation.org>
 <20190122160759.mx3h7gjc23zmrvxc@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122160759.mx3h7gjc23zmrvxc@linutronix.de>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 05:07:59PM +0100, Sebastian Andrzej Siewior wrote:
> On 2019-01-22 16:21:07 [+0100], Greg Kroah-Hartman wrote:
> > diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> > index 8a8bb8796c6c..85ef344a9c67 100644
> > --- a/mm/backing-dev.c
> > +++ b/mm/backing-dev.c
> > @@ -102,39 +102,25 @@ static int bdi_debug_stats_show(struct seq_file *m, void *v)
> >  }
> >  DEFINE_SHOW_ATTRIBUTE(bdi_debug_stats);
> >  
> > -static int bdi_debug_register(struct backing_dev_info *bdi, const char *name)
> > +static void bdi_debug_register(struct backing_dev_info *bdi, const char *name)
> >  {
> > -	if (!bdi_debug_root)
> > -		return -ENOMEM;
> > -
> >  	bdi->debug_dir = debugfs_create_dir(name, bdi_debug_root);
> 
> If this fails then ->debug_dir is NULL 

Wonderful, who cares :)

> > -	if (!bdi->debug_dir)
> > -		return -ENOMEM;
> > -
> > -	bdi->debug_stats = debugfs_create_file("stats", 0444, bdi->debug_dir,
> > -					       bdi, &bdi_debug_stats_fops);
> > -	if (!bdi->debug_stats) {
> > -		debugfs_remove(bdi->debug_dir);
> > -		bdi->debug_dir = NULL;
> > -		return -ENOMEM;
> > -	}
> >  
> > -	return 0;
> > +	debugfs_create_file("stats", 0444, bdi->debug_dir, bdi,
> > +			    &bdi_debug_stats_fops);
> 
> then this creates the stats file in the root folder and

True.

> >  }
> >  
> >  static void bdi_debug_unregister(struct backing_dev_info *bdi)
> >  {
> > -	debugfs_remove(bdi->debug_stats);
> > -	debugfs_remove(bdi->debug_dir);
> > +	debugfs_remove_recursive(bdi->debug_dir);
> 
> this won't remove it.

Which is fine, you don't care.

But step back, how could that original call be NULL?  That only happens
if you pass it a bad parent dentry (which you didn't), or the system is
totally out of memory (in which case you don't care as everything else
is on fire).

> If you return for "debug_dir == NULL" then it is a nice cleanup.

No, that's not a valid thing to check for, you should not care as it
will not happen.  And if it does happen, it's ok, it's only debugfs, no
one can rely on it, it is only for debugging.

thanks,

greg k-h
