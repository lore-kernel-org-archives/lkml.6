Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD52CC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 11:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9686A23C2A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 11:43:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9686A23C2A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751478AbeFVLnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 07:43:37 -0400
Received: from verein.lst.de ([213.95.11.211]:56150 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751210AbeFVLnf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 07:43:35 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id BE90C68E45; Fri, 22 Jun 2018 13:53:00 +0200 (CEST)
Date:   Fri, 22 Jun 2018 13:53:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <xiaolong.ye@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LKP <lkp@01.org>
Subject: Re: [lkp-robot] [fs] 3deb642f0d: will-it-scale.per_process_ops
        -8.8% regression
Message-ID: <20180622115300.GA14654@lst.de>
References: <20180622082752.GX11011@yexl-desktop> <CA+55aFw5ghByk_zCN25G6rPPSAQma3Mh0t4s18CtLg=h6U9+Zg@mail.gmail.com> <20180622095608.GA12263@lst.de> <20180622100014.GA12425@lst.de> <20180622110117.GU30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622110117.GU30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 12:01:17PM +0100, Al Viro wrote:
> For fuck sake, if you want vfs_poll() inlined, *make* *it* *inlined*.

That is not going to help with de-virtualizing _qproc, which was
the whole idea of that change.  At least not without a compiler
way smarter than gcc.

But if you want it inline that is fine with me, it just seems little
large for inlining.

None that I plan to actually remove all calls except for poll and select
for vfs_poll in a pending series, at which point it would become static
anyway.

> Said that, you are not attacking the worst part of it - it's a static
> branch, not the considerably more costly indirect ones.  Remember when
> I asked you about the price of those?  Method calls are costly.

And back then it did not show up even in poll heavy workloads.  But
since then something new happened - spectre mitigations, which make
indirect calls exorbitantly more expensive.

> Now, ->sk_wq is modified only in sock_init_data() and sock_graft();
> the latter, IIRC, is ->accept() helper.  Do we ever call either of
> those on a sock of already opened file?  IOW, is there any real
> reason for socket ->get_poll_head() not to be constant, other
> than wanting to keep POLL_BUSY_LOOP handling out of ->poll_mask()?
> I agree that POLL_BUSY_LOOP is ugly as hell, but you *still* have
> sock_poll_mask() not free from it...

I'd have to defer to networking folks if busy looping after pollwait
is what they want, but I suspect the answer is no, by the time
we are already waiting for the queue busy waiting seems pointless.
