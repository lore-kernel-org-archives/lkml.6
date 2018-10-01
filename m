Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E91FC004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08C892089D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:25:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08C892089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fromorbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbeJAHAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:00:30 -0400
Received: from ipmail01.adl6.internode.on.net ([150.101.137.136]:32715 "EHLO
        ipmail01.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726245AbeJAHA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:00:29 -0400
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail01.adl6.internode.on.net with ESMTP; 01 Oct 2018 09:55:21 +0930
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1g6m1Z-0005G7-7g; Mon, 01 Oct 2018 10:25:21 +1000
Date:   Mon, 1 Oct 2018 10:25:21 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc:     TongZhang <ztong@vt.edu>, darrick.wong@oracle.com,
        linux-xfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        Wenbo Shen <shenwenbosmile@gmail.com>
Subject: Re: Leaking Path in XFS's ioctl interface(missing LSM check)
Message-ID: <20181001002521.GM31060@dastard>
References: <5EF0D46A-C098-4B51-AD13-225FFCA35D4C@vt.edu>
 <20180926013329.GD31060@dastard>
 <20180926192426.472360ea@alans-desktop>
 <20180927013812.GF31060@dastard>
 <20180930151652.6975610c@alans-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180930151652.6975610c@alans-desktop>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 30, 2018 at 03:16:52PM +0100, Alan Cox wrote:
> > > CAP_SYS_ADMIN is also a bit weird because low level access usually
> > > implies you can bypass access controls so you should also check
> > > CAP_SYS_DAC ?  
> > 
> > Do you mean CAP_DAC_READ_SEARCH as per the newer handle syscalls?
> > But that only allows bypassing directory search operations, so maybe
> > you mean CAP_DAC_OVERRIDE?
> 
> It depends what the ioctl allows you to do. If it allows me to bypass
> DAC and manipulate the file system to move objects around then it's a
> serious issue.

These interfaces have always been allowed to do that. You can't do
transparent online background defragmentation without bypassing DAC
and moving objects around. You can't scrub metadata and data without
bypassing DAC. You can't do dedupe without bypassing /some level/ of
DAC to get access to the filesystem used space map and the raw block
device to hash the data. But the really important access control for
dedupe - avoiding deduping data across files at different security
levels - isn't controlled at all.

> The underlying problem is if CAP_SYS_ADMIN is able to move objects around
> then I can move modules around.

Yup, anything with direct access to block devices can do that. Many
filesystem and storage utilities are given direct access to the
block device, because that's what they need to work.

e.g. in DM land, the control ioctls (ctl_ioctl()) are protected by:

        /* only root can play with this */
        if (!capable(CAP_SYS_ADMIN))
                return -EACCES;

Think about it - if DM control ioctls only require CAP_SYS_ADMIN,
then if have that cap you can use DM to remap any block in a block
device to any other block. You don't need to the filesystem to move
stuff around, it can be moved around without the filesystem knowing
anything about it.

> We already have a problem with
> CAP_DAC_OVERRIDE giving you CAP_SYS_RAWIO (ie totally owning the machine)
> unless the modules are signed, if xfs allows ADMIN as well then
> CAP_SYS_ADMIN is much easier to obtain and you'd get total system
> ownership from it.

Always been the case, and it's not isolated to XFS.

$ git grep CAP_SYS_ADMIN fs/ |wc -l
139
$ git grep CAP_SYS_ADMIN block/ |wc -l
16
$ git grep CAP_SYS_ADMIN drivers/block/ drivers/scsi |wc -l
88

The "CAP_SYS_ADMIN for ioctls" trust model in the storage stack
extends both above and below the filesystem. If you don't trust
CAP_SYS_ADMIN, then you are basically saying that you cannot trust
your storage management and maintenance utilities at any level.


> Not good.
> 
> > Regardless, this horse bolted long before those syscalls were
> > introduced.  The time to address this issue was when XFS was merged
> > into linux all those years ago, back when the apps that run in
> > highly secure restricted environments that use these interfaces were
> > being ported to linux. We can't change this now without breaking
> > userspace....
> 
> That's what people said about setuid shell scripts.

Completely different. setuid shell scripts got abused as a hack for
the lazy to avoid setting up permissions properly and hence were
easily exploited.

The storage stack is completely dependent on a simplisitic layered
trust model and that root (CAP_SYS_ADMIN) is god. The storage trust
model falls completely apart if we don't have a trusted root user to
administer all layers of the storage stack.

This isn't the first time I've raised this issue - I raised it
back when the user namespace stuff was ram-roaded into the kernel,
and was essentially ignored by the userns people. As a result, we
end up with all the storage management ioctls restricted to the
initns where we have trusted CAP_SYS_ADMIN users.

I've also raised it more recently in the unprivileged mount
discussions (so untrusted root in containers can mount filesystems)
- no solution to the underlying trust model deficiencies was found
in those discussions, either. Instead, filesystems that can
be mounted by untrusted users (i.e. FUSE) have a special flag in
their fstype definition to say this is allowed.

Systems restricted by LSMs to the point where CAP_SYS_ADMIN is not
trusted have exactly the same issues. i.e. there's nobody trusted by
the kernel to administer the storage stack, and nobody has defined a
workable security model that can prevent untrusted users from
violating the existing storage trust model....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
