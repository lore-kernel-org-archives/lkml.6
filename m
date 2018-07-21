Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D871CECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 23:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8686420863
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 23:45:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8686420863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fromorbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbeGVAk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 20:40:26 -0400
Received: from ipmail03.adl6.internode.on.net ([150.101.137.143]:10561 "EHLO
        ipmail03.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728189AbeGVAk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 20:40:26 -0400
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail03.adl6.internode.on.net with ESMTP; 22 Jul 2018 09:15:51 +0930
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1fh1ZO-0000T8-6V; Sun, 22 Jul 2018 09:45:50 +1000
Date:   Sun, 22 Jul 2018 09:45:50 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Ross Zwisler <ross.zwisler@linux.intel.com>,
        kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, linux-nvdimm@lists.01.org
Subject: Re: [PATCH 1/5] radix tree test suite: fix mapshift build target
Message-ID: <20180721234550.GB1691@dastard>
References: <20180503192430.7582-1-ross.zwisler@linux.intel.com>
 <20180503192430.7582-2-ross.zwisler@linux.intel.com>
 <20180715230052.GA6486@bombadil.infradead.org>
 <20180716160710.GA2287@linux.intel.com>
 <20180716195249.GA14380@bombadil.infradead.org>
 <20180716210820.GA17164@linux.intel.com>
 <20180717024132.GC7934@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717024132.GC7934@bombadil.infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 07:41:32PM -0700, Matthew Wilcox wrote:
> On Mon, Jul 16, 2018 at 03:08:20PM -0600, Ross Zwisler wrote:
> > On Mon, Jul 16, 2018 at 12:52:49PM -0700, Matthew Wilcox wrote:
> > > On Mon, Jul 16, 2018 at 10:07:10AM -0600, Ross Zwisler wrote:
> > <>
> > > OK ... what version of make are you using?  Because this works fine for me:
> > > 
> > > $ git clone linux clean
> > > $ cd clean
> > > $ git checkout v4.17
> > > $ cd tools/testing/radix-tree/ 
> > > $ git revert 8d9fa88edd5e360b71765feeadb915d4066c9684
> > > $ make
> > > 
> > > $ make --version
> > > GNU Make 4.1
> > > Built for x86_64-pc-linux-gnu
> > > 
> > > It's Debian's Version: 4.1-9.1
> > 
> > $ make --version
> > GNU Make 4.2.1
> > Built for x86_64-redhat-linux-gnu
> > 
> > The one from Fedora 27.
> 
> Huh.  I just tried 4.2.1-1.1 from Debian unstable and that doesn't
> produce the problem either.  I'm not sure how to proceed at this point.
> I'm really not a makefile expert.

This smells like a problem we just hit with make 4.2.1 in fedora 28
in fstests - the regex expanstion has been screwed up such that
things like [a-z] will match [A-Z] and other things as well. Debian
is unaffected, apparently fedora has a backport of stuff from the
as-yet-unreleased next version of make/glibc. See this thread:

https://www.spinics.net/lists/fstests/msg10200.html

Try setting LANG=C and seeing if the problem goes away....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
