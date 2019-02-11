Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C75C282D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 512C6217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfBKU7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 15:59:42 -0500
Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:54605 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726080AbfBKU7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 15:59:41 -0500
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail06.adl2.internode.on.net with ESMTP; 12 Feb 2019 07:29:40 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1gtIfy-0002Bw-Dx; Tue, 12 Feb 2019 07:59:38 +1100
Date:   Tue, 12 Feb 2019 07:59:38 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Tavian Barnes <tavianator@tavianator.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: d_type and bind mounts
Message-ID: <20190211205938.GE20493@dastard>
References: <CABg4E-mbCk-jeRjETEtXk+ZHVub00_G5QaOnxbf5fgKd5MpD+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABg4E-mbCk-jeRjETEtXk+ZHVub00_G5QaOnxbf5fgKd5MpD+A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 02:59:29PM -0500, Tavian Barnes wrote:
> It seems that readdir()/getdents() fill d_type from the underlying
> filesystem, not respecting bind mounts of non-directories:
> 
> $ touch mount_point
> $ sudo mount --bind /dev/null mount_point
> $ find -name mount_point -type c
> $ find -name mount_point -type f
> ./mount_point
> 
> (Requires a fairly recent GNU findutils to reproduce, older ones
> always call stat().)  I've seen similar discussions about d_ino being
> for the underlying file, not the mount point, which people have said

Find is using readdir to look up the directory entry, so what it
finds is the underlying filesystem dirent that is completely unaware
that the dentry cache has an overlayed mountpoint above the
filesystem.  d_type is stored in the underlying directory, so it is
reported from the on-disk information in the underlying filesystem,
not the dentry cache that is aware of the mount point at that
location.

> is technically a POSIX violation but also unlikely to be fixed.  Is
> the same true of d_type?  And is there some workaround a program could
> use to get the actual type without the overhead of a whole stat()
> call? For example, a way to tell whether a directory entry is a mount
> point?

Not that I know of, but that doesn't mean there isn't one. In
general, though, if you are looking for something overlaid on the
underlying dirent (like a mount point) then you have to trigger a
path walk to find whatever is overlaid on that location.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
