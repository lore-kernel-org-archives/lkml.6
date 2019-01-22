Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03732C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 17:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0785217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 17:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729494AbfAVRTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 12:19:11 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:60129 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728719AbfAVRTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 12:19:11 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1glzhc-0002mq-A4; Tue, 22 Jan 2019 18:19:08 +0100
Date:   Tue, 22 Jan 2019 18:19:08 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Michal Hocko <mhocko@suse.com>,
        linux-mm@kvack.org
Subject: Re: [PATCH] backing-dev: no need to check return value of
 debugfs_create functions
Message-ID: <20190122171908.c7geuvluezkjp3s7@linutronix.de>
References: <20190122152151.16139-8-gregkh@linuxfoundation.org>
 <20190122160759.mx3h7gjc23zmrvxc@linutronix.de>
 <20190122162503.GB22548@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190122162503.GB22548@kroah.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-22 17:25:03 [+0100], Greg Kroah-Hartman wrote:
> > >  }
> > >  
> > >  static void bdi_debug_unregister(struct backing_dev_info *bdi)
> > >  {
> > > -	debugfs_remove(bdi->debug_stats);
> > > -	debugfs_remove(bdi->debug_dir);
> > > +	debugfs_remove_recursive(bdi->debug_dir);
> > 
> > this won't remove it.
> 
> Which is fine, you don't care.

but if you cat the stats file then it will dereference the bdi struct
which has been free(), right?

> But step back, how could that original call be NULL?  That only happens
> if you pass it a bad parent dentry (which you didn't), or the system is
> totally out of memory (in which case you don't care as everything else
> is on fire).

debugfs_get_inode() could do -ENOMEM and then the directory creation
fails with NULL.

> > If you return for "debug_dir == NULL" then it is a nice cleanup.
> 
> No, that's not a valid thing to check for, you should not care as it
> will not happen.  And if it does happen, it's ok, it's only debugfs, no
> one can rely on it, it is only for debugging.

It might happen with ENOMEM as of now. It could happen for other reasons
in future if the code changes.

> thanks,
> 
> greg k-h

Sebastian
