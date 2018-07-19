Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D73ECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 00:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E14872084E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 00:50:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E14872084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fromorbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730433AbeGSBad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 21:30:33 -0400
Received: from ipmail01.adl2.internode.on.net ([150.101.137.133]:51725 "EHLO
        ipmail01.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729861AbeGSBac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 21:30:32 -0400
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail01.adl2.internode.on.net with ESMTP; 19 Jul 2018 10:20:00 +0930
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1ffx8q-0004vC-9f; Thu, 19 Jul 2018 10:50:00 +1000
Date:   Thu, 19 Jul 2018 10:50:00 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Jann Horn <jannh@google.com>, Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        linux-fsdevel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: don't let getdents return bogus names
Message-ID: <20180719005000.GE19934@dastard>
References: <20180716194843.252772-1-jannh@google.com>
 <20180716195657.GO30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716195657.GO30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 08:56:57PM +0100, Al Viro wrote:
> On Mon, Jul 16, 2018 at 09:48:43PM +0200, Jann Horn wrote:
> > When you e.g. run `find` on a directory for which getdents returns
> > "filenames" that contain slashes, `find` passes those "filenames" back to
> > the kernel, which then interprets them as paths. That could conceivably
> > cause userspace to do something bad when accessing something like an
> > untrusted USB stick, but I'm not aware of any specific example.
> > 
> > Instead of returning bogus filenames to userspace, return -EUCLEAN.
> 
> Because there's such a lot of userland code that expect and handles that
> error value...

We've been using EUCLEAN ("structure needs cleaning") for indicating
filesystem corruption errors for many years now. e.g.

fs/ext2/ext2.h:#define  EFSCORRUPTED                    EUCLEAN /* Filesystem is corrupted */
fs/ext4/ext4.h:#define EFSCORRUPTED     EUCLEAN         /* Filesystem is corrupted */
fs/hpfs/hpfs_fn.h:#define EFSERROR  EUCLEAN
fs/xfs/xfs_linux.h:#define EFSCORRUPTED EUCLEAN         /* Filesystem is corrupted */
include/linux/jbd2.h:#define EFSCORRUPTED       EUCLEAN         /* Filesystem is corrupted */

There's hundreds of places in the filesystem code that this
specific error is returned to userspace - there's more than 500
individual places this error can be returned from just XFS....

To me it seems like the right error to return if a dirent is
corrupted, because that's exactly what XFS will return if any of the
directory structure around the dirent name itself is corrupt...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
