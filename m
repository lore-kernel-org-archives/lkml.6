Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3C2C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 10:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6800821783
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 10:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546252704;
	bh=oirEzEFtoFxAIjtDai0/NLU+z2b9loYhuu41HcALLFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SeC876on9qb43MHK50L+XWO3/bEtx+RuT0pk1XW9ITBagprDC2xbh1h5Xr7qhbv/p
	 nNoRekbUp4TXusb3RKCKVlTTYHoWu+x/rfX2YrwrLz2T+4mx+JLQAspv6+O+Stunqp
	 nRV21bv3bNne8flKQYdE12jo6My3Pio5M4+GG51c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbeLaKiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 05:38:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:42222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726988AbeLaKiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 05:38:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABBDE21019;
        Mon, 31 Dec 2018 10:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546252702;
        bh=oirEzEFtoFxAIjtDai0/NLU+z2b9loYhuu41HcALLFM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C/V/9Gr8iO1Sffx3EeJ133lP49TZrg7OeagaPoLsQcCi1Cabl/WH//YytSZzenfAm
         9FV/a3WvEjJSh85gU9qVtu5AXMY06KchDqGC+zgAZhFpoJcbcB3EJPZyXiVA3RAhsV
         Ra+4DYnIFCuYZXa2fssmgr020eBKRxN+zq8OdK1g=
Date:   Mon, 31 Dec 2018 11:38:20 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     joeyli <jlee@suse.com>
Cc:     "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Joe Perches <joe@perches.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Chen Yu <yu.c.chen@intel.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 0/2] [RFC] sysfs: Add hook for checking the file
 capability of opener
Message-ID: <20181231103820.GA27420@kroah.com>
References: <20181230132856.24095-1-jlee@suse.com>
 <20181230144506.GA18985@kroah.com>
 <20181231094105.GO3506@linux-l9pv.suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181231094105.GO3506@linux-l9pv.suse>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 31, 2018 at 05:41:05PM +0800, joeyli wrote:
> Hi Greg, 
> 
> Thanks for your review!
> 
> On Sun, Dec 30, 2018 at 03:45:06PM +0100, Greg Kroah-Hartman wrote:
> > On Sun, Dec 30, 2018 at 09:28:54PM +0800, Lee, Chun-Yi wrote:
> > > There have some discussion in the following mail loop about checking
> > > capability in sysfs write handler:
> > >     https://lkml.org/lkml/2018/9/13/978
> > 
> > A sysfs callback should not care about stuff like this.
> > 
> > Worst case, do a simple:
> > 	if (!capable(CAP_FOO))
> > 		return -EPERM
> > 
> > you don't care or need to worry about the file handle for that at all,
> > right?
> >
> 
> The capable() can be bypassed.

How?

> Unprivileged process may reads or writes those sysfs if file
> permission be relaxed by root for non-root user.

So if root says "I want a non-root user to be able to write to this
file" by changing its permissions, yes, a non-root user will be able to
write to them.  But the capable() check will catch this, right?

And why is the kernel trying to protect userspace from itself?  Root
explicitly asked for anyone to read/write this file, why do we think the
kernel knows better?

> > > Sometimes we check the capability in sysfs implementation by using
> > > capable function.
> > 
> > Which should be fine, right?
> >
> 
> If file permission is enough to restrict sysfs that can only be used
> by root. Why do some sysfs interfaces use capable()? It's not
> redundancy?

I don't know why some sysfs files use this, it was the choice of that
author it seems.  Perhaps it is to "check" that the root user really
does have that capability.  Some root users do not have all capabilities
if they were previously "dropped".

> > > But the checking can be bypassed by opening sysfs
> > > file within an unprivileged process then writing the file within a
> > > privileged process. The tricking way has been exposed by Andy Lutomirski
> > > for CVE-2013-1959.
> > 
> > And who does this for a sysfs file?  And why?
> 
> Just want to bypass the capable() checking. 

But why would you want to bypass this?  I don't understand.

What is the use case you are trying to solve for here.

> > > Because the sysfs_ops does not forward the file descriptor to the
> > > show/store callback, there doesn't have chance to check the capability
> > > of file's opener.
> > 
> > Which is by design.  If you care about open, you are using sysfs wrong.
> >
> 
> OK~ So the sysfs doesn't care opener's capability.

Exactly.

Except for the permission/mode that the file has on it.  The vfs checks
this at open time and either allows it or forbids it.

> > > This patch adds the hook to sysfs_ops that allows
> > > different implementation in object and attribute levels for checking
> > > file capable before accessing sysfs interfaces.
> > 
> > No, please no.
> >
> > > The callback function of kobject sysfs_ops is the first implementation
> > > of new hook. It casts attribute to kobj_attribute then calls the file
> > > capability callback function of attribute level. The same logic can
> > > be implemented in other sysfs file types, like: device, driver and
> > > bus type. 
> > > 
> > > The capability checking logic in wake_lock/wake_unlock sysfs interface
> > > is the first example for kobject. It will check the opener's capability.
> > 
> > Why doesn't the file permission of that sysfs file determine who can or
> > can not write to that file?
> >
> 
> I agree that the file permission can restrict the writer of sysfs. But,
> I still confused for why do some sysfs interface use capable()?

Go ask the individual authors who added those checks :)

thanks,

greg k-h
