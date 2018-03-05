Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932594AbeCEUsk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 15:48:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:55845 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932531AbeCEUsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 15:48:38 -0500
Date: Mon, 5 Mar 2018 21:48:36 +0100
From: Jan Kara <jack@suse.cz>
To: Dexuan Cui <decui@microsoft.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        Jork Loeser <Jork.Loeser@microsoft.com>
Subject: Re: Any known soft lockup issue with vfs_write()->fsnotify()?
Message-ID: <20180305204836.qznlcm6uwurfs2n4@quack2.suse.cz>
References: <KL1P15301MB000645A10FE2B20421A7F3DBBFC50@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <KL1P15301MB000645A10FE2B20421A7F3DBBFC50@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Fri 02-03-18 22:28:50, Dexuan Cui wrote:
> Recently people are getting a soft lock issue with vfs_write()->fsnotify(). 
> The detailed calltrace is available at:
> https://github.com/coreos/bugs/issues/2356
> https://github.com/coreos/bugs/issues/2364

I didn't see them yet.

> The kernel versions showing up the issue are:
> 4.14.11-coreos 
> 4.14.19-coreos
> 4.13.0-1009 -- this is the kernel with which I'm personally seeing the lockup.
> 
> I have not got a chance to try the latest mainline kernel yet.

It would be good to try 4.15 kernel to see whether recent fixes from Miklos
didn't fix your problem. They should be present in 4.14.11/19 kernels as
well but one never knows...

> Before the lockup error message suddenly appears, Linux has been running
> fine for many hours.  I have NOT found a consistent way to reproduce the
> lockup yet.
> 
> Looks the kernel is stuck in fsnotify(), when it tries to get the
> fsnotify_mark_srcu lock.

It is not possible that we would 'hang' in srcu_read_lock() - that is
just a read of one variable and increment of another. We'd have to be
looping somewhere and watchdog would have to happen to hit us always at
that place. Weird. Are you sure RIP points to srcu_read_lock?

> "git log fs/notify/fsnotify.c" on the latest mainline shows that some
> recent patches might help.
> 
> I'd like to check if this is a known issue.

As I've mentioned above, so far I didn't see reports like this...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
