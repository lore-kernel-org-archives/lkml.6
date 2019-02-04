Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68795C282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 365A72081B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfBDXPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 18:15:01 -0500
Received: from ipmail02.adl2.internode.on.net ([150.101.137.139]:49151 "EHLO
        ipmail02.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726086AbfBDXPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 18:15:01 -0500
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail02.adl2.internode.on.net with ESMTP; 05 Feb 2019 09:43:46 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1gqnQw-0000Ul-Bx; Tue, 05 Feb 2019 10:13:46 +1100
Date:   Tue, 5 Feb 2019 10:13:46 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs: allow disabling xfs tracepoints via Kconfig
Message-ID: <20190204231346.GC14116@dastard>
References: <20190204212035.9919-1-linux@rasmusvillemoes.dk>
 <20190204215332.GB14116@dastard>
 <4d66f2c2-bf5c-be47-9ef1-e581c5901823@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d66f2c2-bf5c-be47-9ef1-e581c5901823@rasmusvillemoes.dk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 11:12:57PM +0100, Rasmus Villemoes wrote:
> On 04/02/2019 22.53, Dave Chinner wrote:
> > On Mon, Feb 04, 2019 at 10:20:35PM +0100, Rasmus Villemoes wrote:
> >> linux/tracepoints.h allows individual subsystems to disable their
> >> tracepoints. Add such a knob for xfs. Disabling XFS_TRACEPOINTS
> >> reduces the resident size of xfs.ko by about a third, or ~350 KiB.
> > 
> > Ok, now we can't debug typical problems on live production systems
> > if tracepoints are turned off on the user/distro kernels.  So under
> > what circumstances would we ever want to turn off tracepoints on
> > XFS?
> 
> I don't expect any mainstream distros to turn it off. But for embedded
> systems that use a hand-tuned .config, being able to shave off 100s of K
> of the kernel image is quite valuable.

However, small embedded systems don't use XFS because of it's size,
dependence on 64 bit capability (ie. 64BIT || LBDAF), its CPU and
memory overhead in comparison to other filesystems, etc. 

Increasing kconfig options increases the test matrix (even just the
"does this changeset compile" matrix) so these things don't come for
free.  XFS is firmly focussed on the other end of the scale (big,
lots, fast), so I'm not sure that increasing the kconfig combination
matrix to cater for really low end embedded systems is really that
worthwhile.

> Tracing _is_ useful,
> also/especially when doing embedded development, which is why "just turn
> off CONFIG_TRACING" isn't really an option.

Do you have a specific need for this, or is it just "I noticed this,
here's a patch"? If you need it and will use it, great, let's add
it. But config options that don't ever get used tend to rot....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
