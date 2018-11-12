Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F107FC43610
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 22:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC130223DD
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 22:30:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC130223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730657AbeKMIZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 03:25:17 -0500
Received: from smtprelay0164.hostedemail.com ([216.40.44.164]:43755 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728030AbeKMIZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 03:25:17 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 0579D100E86D4;
        Mon, 12 Nov 2018 22:30:06 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: beast30_74ed5e0c58a5f
X-Filterd-Recvd-Size: 2375
Received: from XPS-9350 (unknown [172.58.27.5])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Mon, 12 Nov 2018 22:30:03 +0000 (UTC)
Message-ID: <bd3806ccc911989c7ef1fed9e8d26a4a5ad347a9.camel@perches.com>
Subject: Re: [PATCH] xfs: Remove noinline from #define STATIC
From:   Joe Perches <joe@perches.com>
To:     Dave Chinner <david@fromorbit.com>,
        Eric Sandeen <sandeen@sandeen.net>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 12 Nov 2018 14:30:01 -0800
In-Reply-To: <20181112214515.GN19305@dastard>
References: <7302f4a13c1cbf62b07f636878ce25fcca84b6c4.camel@perches.com>
         <6420cf91-89c8-a876-7a0d-25ab8ba428b8@sandeen.net>
         <20181112214515.GN19305@dastard>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-11-13 at 08:45 +1100, Dave Chinner wrote:
> On Mon, Nov 12, 2018 at 02:12:08PM -0600, Eric Sandeen wrote:
> > On 11/10/18 7:21 PM, Joe Perches wrote:
> > > Reduce total object size quite a bit (~32KB) and presumably
> > > improve performance at the same time.
> > > 
> > > Total object size old vs new (x86-64 defconfig with xfs)
> > > 
> > >     text	   data	    bss	    dec	    hex	filename
> > > - 959351	 165573	    632	1125556	 112cb4	(TOTALS) (old)
> > > + 924683	 165669	    632	1090984	 10a5a8	(TOTALS) (new)
> > 
> > And what does it do to maximum stack excursions?
> 
> Better yet: what does it do to corruption stack traces and debugging
> tools like profiling traces?
> 
> i.e. this noinline directive isn't about stack usage, this is about
> being able to debug production code. Basically the compiler inliner
> is so agressive on static functions that it makes it impossible to
> decipher the stack traces. It flattens them way too much to
> be able to tell how we got to a specific location in the code.
> 
> In reality, being able to find problems quickly and efficiently is
> far more important to us than being able to run everything at
> ludicrous speed....

Is that really a compelling argument given thw ~50:50
split of static/STATIC uses in xfs?

$ git grep -w STATIC fs/xfs/ | wc -l
1064
$ git grep -w static fs/xfs/ | wc -l
942


