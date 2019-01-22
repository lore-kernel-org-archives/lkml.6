Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CCAC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 268B320870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfAVU2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 15:28:24 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:60665 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbfAVU2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 15:28:24 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gm2ei-0007Of-Mg; Tue, 22 Jan 2019 21:28:20 +0100
Date:   Tue, 22 Jan 2019 21:28:19 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Michal Hocko <mhocko@suse.com>,
        linux-mm@kvack.org
Subject: Re: [PATCH] backing-dev: no need to check return value of
 debugfs_create functions
Message-ID: <20190122202817.vypepopx4sd757c3@linutronix.de>
References: <20190122152151.16139-8-gregkh@linuxfoundation.org>
 <20190122160759.mx3h7gjc23zmrvxc@linutronix.de>
 <20190122162503.GB22548@kroah.com>
 <20190122171908.c7geuvluezkjp3s7@linutronix.de>
 <20190122183348.GA31271@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190122183348.GA31271@kroah.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-22 19:33:48 [+0100], Greg Kroah-Hartman wrote:
> On Tue, Jan 22, 2019 at 06:19:08PM +0100, Sebastian Andrzej Siewior wrote:
> > but if you cat the stats file then it will dereference the bdi struct
> > which has been free(), right?
> 
> Maybe, I don't know, your code is long gone, it doesn't matter :)

may point is that you may remain with a stats file in debugfs' root
folder which you can cat and then crash.

> > > But step back, how could that original call be NULL?  That only happens
> > > if you pass it a bad parent dentry (which you didn't), or the system is
> > > totally out of memory (in which case you don't care as everything else
> > > is on fire).
> > 
> > debugfs_get_inode() could do -ENOMEM and then the directory creation
> > fails with NULL.
> 
> And if that happens, your system has worse problems :)

So we care to properly handle -ENOMEM in driver's probe function. Those
change find their way to stable kernels.
This unhandled -ENOMEM in debugfs_get_inode() will let
debugfs_create_dir() reuturn NULL. Then debugfs_create_file() will
create the stats in debugfs' root folder. This is a changed behaviour
which is not expected. And then on rmmod the stats file is still present
and will participate in use-after-free if it is read.

> As it's been that way for over a decade, I think we will be fine :)
> If it changes in the future, in some way that actually matters, I'll go
> back and fix up all of the callers.

That is okay then :).
I don't mind if the stats file does not show up due to an error on
probe. It is debugfs after all. However I don't think that it is okay
that the stats file remains in the root folder even after the module has
been removed (and access memory that does not belong to it).

> thanks,
> 
> greg k-h

Sebastian
