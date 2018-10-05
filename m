Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03F1C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 23:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64106213A2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 23:37:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64106213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fromorbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729292AbeJFGiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 02:38:22 -0400
Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:51421 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726258AbeJFGiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 02:38:22 -0400
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail06.adl2.internode.on.net with ESMTP; 06 Oct 2018 09:07:21 +0930
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1g8Zer-0004L7-3P; Sat, 06 Oct 2018 09:37:21 +1000
Date:   Sat, 6 Oct 2018 09:37:21 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH] writeback: fix range_cyclic writeback vs writepages
 deadlock
Message-ID: <20181005233721.GI12041@dastard>
References: <20181005054526.21507-1-david@fromorbit.com>
 <20181005124640.3de2ba9dec8c713ee8cf286b@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005124640.3de2ba9dec8c713ee8cf286b@linux-foundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 12:46:40PM -0700, Andrew Morton wrote:
> On Fri,  5 Oct 2018 15:45:26 +1000 Dave Chinner <david@fromorbit.com> wrote:
> 
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > We've recently seen a workload on XFS filesystems with a repeatable
> > deadlock between background writeback and a multi-process
> > application doing concurrent writes and fsyncs to a small range of a
> > file.
> > 
> > ...
> > 
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > Reviewed-by: Jan Kara <jack@suse.de>
> 
> Not a serious enough problem for a -stable backport?

Don't have enough evidence to say one way or another. The reported
incident was from a RHEL 7 kernel, so the bug has been there for
years in one form or another, but it's only ever been triggered by
this one-off custom workload.

I haven't done any analysis on older kernels, nor have I looked to see
if there's any gotchas that a stable backport might encounter. And I
tend not to change stuff in a path that is critical to data integrity
without at least doing enough due diligence to suggest a stable
backport would be fine.

You can mark it for stable backports if you want, but I'm not
prepared to because I haven't done the work necessary to ensure it's
safe to do so.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
