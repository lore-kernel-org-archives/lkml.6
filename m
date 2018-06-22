Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC90C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D543241DC
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:30:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D543241DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751478AbeFVMaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 08:30:05 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:32930 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751342AbeFVMaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 08:30:04 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fWLCO-0008Bj-P8; Fri, 22 Jun 2018 12:29:56 +0000
Date:   Fri, 22 Jun 2018 13:29:56 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <xiaolong.ye@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LKP <lkp@01.org>
Subject: Re: [lkp-robot] [fs] 3deb642f0d: will-it-scale.per_process_ops -8.8%
 regression
Message-ID: <20180622122956.GX30522@ZenIV.linux.org.uk>
References: <20180622082752.GX11011@yexl-desktop>
 <CA+55aFw5ghByk_zCN25G6rPPSAQma3Mh0t4s18CtLg=h6U9+Zg@mail.gmail.com>
 <20180622095608.GA12263@lst.de>
 <20180622100014.GA12425@lst.de>
 <20180622110117.GU30522@ZenIV.linux.org.uk>
 <20180622115300.GA14654@lst.de>
 <20180622115613.GV30522@ZenIV.linux.org.uk>
 <20180622120739.GA15351@lst.de>
 <20180622121722.GW30522@ZenIV.linux.org.uk>
 <20180622123307.GA16699@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622123307.GA16699@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 02:33:07PM +0200, Christoph Hellwig wrote:
> On Fri, Jun 22, 2018 at 01:17:22PM +0100, Al Viro wrote:
> > > The problem is that call to sk_busy_loop(), which is going to be indirect
> > > no matter what.
> > 
> > 	if ->f_poll_head is NULL {
> > 		use ->poll
> > 	} else {
> > 		if can ll_poll (checked in ->f_mode)
> > 			call ->ll_poll(), if it returns what we want - we are done
> > 		add to ->f_poll_head
> > 		call ->poll_mask()
> 
> What I have for now is slightly different:
> 
> 	if ((events & POLL_BUSY_LOOP) && file->f_op->poll_busy_loop)
> 		file->f_op->poll_busy_loop(file, events);
> 
> 	if (file->f_op->poll) {
> 		return file->f_op->poll(file, pt);
> 	} else if (file_has_poll_mask(file)) {
> 		...
> 	}
> 
> returns whatever we want part is something I want to look into
> once the basics are done as it probably is non entirely trivial due to
> structure of polling in the low-level network protocol.

First of all, you'll get the same ->f_op for *all* sockets.  So you'll be
hitting that path regardless of sk_can_busy_loop(sock->sk).  What's more,
that way you get (on fast path) even more indirect calls, AFAICS.

And I don't see any point in separate file_has_poll_mask() - just check
->f_poll_head and that's it.
