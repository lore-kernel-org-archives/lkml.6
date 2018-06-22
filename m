Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9044C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 11:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC1A2418B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 11:58:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DC1A2418B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751341AbeFVL6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 07:58:19 -0400
Received: from verein.lst.de ([213.95.11.211]:56210 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751005AbeFVL6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 07:58:17 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id E57E868E45; Fri, 22 Jun 2018 14:07:39 +0200 (CEST)
Date:   Fri, 22 Jun 2018 14:07:39 +0200
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
Message-ID: <20180622120739.GA15351@lst.de>
References: <20180622082752.GX11011@yexl-desktop> <CA+55aFw5ghByk_zCN25G6rPPSAQma3Mh0t4s18CtLg=h6U9+Zg@mail.gmail.com> <20180622095608.GA12263@lst.de> <20180622100014.GA12425@lst.de> <20180622110117.GU30522@ZenIV.linux.org.uk> <20180622115300.GA14654@lst.de> <20180622115613.GV30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622115613.GV30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 12:56:13PM +0100, Al Viro wrote:
> 	So mark that in ->f_mode - I strongly suspect that
> sk_can_busy_loop(sock->sk) can't change while an opened file is there.
> And lift that (conditional on new FMODE_BUSY_LOOP) into do_poll()
> and do_select() - we *already* have bits of pieces of that logics in
> there and that way they'd at least be gathered in one place.

The problem is that call to sk_busy_loop(), which is going to be indirect
no matter what.

> 
> 	Then replace ->get_poll_head() with file->f_poll_head and
> see what it gives.

Working on it right now.  Works so far except for the busy loop case.
I'm looking into a separate methods just for that as a first idea.
