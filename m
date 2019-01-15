Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E125C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 00:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 602C7206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 00:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbfAOABK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 19:01:10 -0500
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:3706 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727209AbfAOABJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 19:01:09 -0500
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail06.adl6.internode.on.net with ESMTP; 15 Jan 2019 10:30:47 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1gjC9u-0000IS-FO; Tue, 15 Jan 2019 11:00:46 +1100
Date:   Tue, 15 Jan 2019 11:00:46 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jann Horn <jannh@google.com>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v3 1/2] fs: don't let getdents return bogus names
Message-ID: <20190115000046.GR27534@dastard>
References: <20190114182318.110443-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114182318.110443-1-jannh@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 07:23:17PM +0100, Jann Horn wrote:
> When you e.g. run `find` on a directory for which getdents returns
> "filenames" that contain slashes, `find` passes those "filenames" back to
> the kernel, which then interprets them as paths. That could conceivably
> cause userspace to do something bad when accessing something like an
> untrusted USB stick, but I'm not aware of any specific example.
> 
> Instead of returning bogus filenames to userspace, return -EUCLEAN.

Please don't use EUCLEAN directly to indicate filesystem corruption
directly.  If we want to indicate that the filesystem is corrupted,
please hoist the multiple XFS/ext4 definitions of:

#define EFSCORRUPTED EUCLEAN

up into include/uapi/asm-generic/errno.h and then use EFSCORRUPTED
in all the places where we want to indicate to userspace that the
filesystem is corrupted. That tells both the code reader and the
userspace developers that it's a corruption error and puts context
to the "structure needs cleaning" text that goes along with it...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
