Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7A4C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B4C9217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548182033;
	bh=EAUgKB5MRBG268AYyy5GwVUX7cbp6D6CEq4cK/4bDos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qsHRxu/o3wYHofyuGJGmfdzQrscRvAtgmgjTIe9hl02wTOgdHsVtQP+gTAyhQwtqe
	 QEL2Bevnan5/W+h1OBvVvJ09PCQe/7HItU7GxEHq9wKvUKT6xEpHu984CP3ie8EZUk
	 cn40FYkUVl5hFpHmWBjstl1HRDzVNqadXBLDFBtw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfAVSdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 13:33:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:55570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbfAVSdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 13:33:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83C3D21726;
        Tue, 22 Jan 2019 18:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548182031;
        bh=EAUgKB5MRBG268AYyy5GwVUX7cbp6D6CEq4cK/4bDos=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DSi/QNpdgLa480rW0MPapR2CjpSbUm4sOGMYehry0sDvp9p1QOIp8M0/+dhHnE7mF
         OHDJBUwshgul7TVYJ25D4ADXbvu47z4IFODj6PL6VFzqvJO26K16InnVn1+CqpzhON
         7uLaVkrCYiFH5ZhXIlAnxG0HCF5dSN2wVEqYzQXE=
Date:   Tue, 22 Jan 2019 19:33:48 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Michal Hocko <mhocko@suse.com>,
        linux-mm@kvack.org
Subject: Re: [PATCH] backing-dev: no need to check return value of
 debugfs_create functions
Message-ID: <20190122183348.GA31271@kroah.com>
References: <20190122152151.16139-8-gregkh@linuxfoundation.org>
 <20190122160759.mx3h7gjc23zmrvxc@linutronix.de>
 <20190122162503.GB22548@kroah.com>
 <20190122171908.c7geuvluezkjp3s7@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122171908.c7geuvluezkjp3s7@linutronix.de>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 06:19:08PM +0100, Sebastian Andrzej Siewior wrote:
> On 2019-01-22 17:25:03 [+0100], Greg Kroah-Hartman wrote:
> > > >  }
> > > >  
> > > >  static void bdi_debug_unregister(struct backing_dev_info *bdi)
> > > >  {
> > > > -	debugfs_remove(bdi->debug_stats);
> > > > -	debugfs_remove(bdi->debug_dir);
> > > > +	debugfs_remove_recursive(bdi->debug_dir);
> > > 
> > > this won't remove it.
> > 
> > Which is fine, you don't care.
> 
> but if you cat the stats file then it will dereference the bdi struct
> which has been free(), right?

Maybe, I don't know, your code is long gone, it doesn't matter :)

> > But step back, how could that original call be NULL?  That only happens
> > if you pass it a bad parent dentry (which you didn't), or the system is
> > totally out of memory (in which case you don't care as everything else
> > is on fire).
> 
> debugfs_get_inode() could do -ENOMEM and then the directory creation
> fails with NULL.

And if that happens, your system has worse problems :)

> 
> > > If you return for "debug_dir == NULL" then it is a nice cleanup.
> > 
> > No, that's not a valid thing to check for, you should not care as it
> > will not happen.  And if it does happen, it's ok, it's only debugfs, no
> > one can rely on it, it is only for debugging.
> 
> It might happen with ENOMEM as of now. It could happen for other reasons
> in future if the code changes.

As it's been that way for over a decade, I think we will be fine :)
If it changes in the future, in some way that actually matters, I'll go
back and fix up all of the callers.

thanks,

greg k-h
