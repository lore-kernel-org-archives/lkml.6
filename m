Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C9CC43610
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 21:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2DB92245E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 21:45:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2DB92245E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fromorbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730579AbeKMHkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 02:40:22 -0500
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:11109 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725817AbeKMHkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 02:40:21 -0500
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail07.adl2.internode.on.net with ESMTP; 13 Nov 2018 08:15:17 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1gMK1D-0007Tx-S8; Tue, 13 Nov 2018 08:45:15 +1100
Date:   Tue, 13 Nov 2018 08:45:15 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     Joe Perches <joe@perches.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xfs: Remove noinline from #define STATIC
Message-ID: <20181112214515.GN19305@dastard>
References: <7302f4a13c1cbf62b07f636878ce25fcca84b6c4.camel@perches.com>
 <6420cf91-89c8-a876-7a0d-25ab8ba428b8@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6420cf91-89c8-a876-7a0d-25ab8ba428b8@sandeen.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 02:12:08PM -0600, Eric Sandeen wrote:
> On 11/10/18 7:21 PM, Joe Perches wrote:
> > Reduce total object size quite a bit (~32KB) and presumably
> > improve performance at the same time.
> > 
> > Total object size old vs new (x86-64 defconfig with xfs)
> > 
> >     text	   data	    bss	    dec	    hex	filename
> > - 959351	 165573	    632	1125556	 112cb4	(TOTALS) (old)
> > + 924683	 165669	    632	1090984	 10a5a8	(TOTALS) (new)
> 
> And what does it do to maximum stack excursions?

Better yet: what does it do to corruption stack traces and debugging
tools like profiling traces?

i.e. this noinline directive isn't about stack usage, this is about
being able to debug production code. Basically the compiler inliner
is so agressive on static functions that it makes it impossible to
decipher the stack traces. It flattens them way too much to
be able to tell how we got to a specific location in the code.

In reality, being able to find problems quickly and efficiently is
far more important to us than being able to run everything at
ludicrous speed....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
