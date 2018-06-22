Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A2EC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08BCD2251A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:23:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08BCD2251A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751931AbeFVMXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 08:23:44 -0400
Received: from verein.lst.de ([213.95.11.211]:56321 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751209AbeFVMXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 08:23:42 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 8EDBD68E45; Fri, 22 Jun 2018 14:33:07 +0200 (CEST)
Date:   Fri, 22 Jun 2018 14:33:07 +0200
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
Message-ID: <20180622123307.GA16699@lst.de>
References: <20180622082752.GX11011@yexl-desktop> <CA+55aFw5ghByk_zCN25G6rPPSAQma3Mh0t4s18CtLg=h6U9+Zg@mail.gmail.com> <20180622095608.GA12263@lst.de> <20180622100014.GA12425@lst.de> <20180622110117.GU30522@ZenIV.linux.org.uk> <20180622115300.GA14654@lst.de> <20180622115613.GV30522@ZenIV.linux.org.uk> <20180622120739.GA15351@lst.de> <20180622121722.GW30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622121722.GW30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 01:17:22PM +0100, Al Viro wrote:
> > The problem is that call to sk_busy_loop(), which is going to be indirect
> > no matter what.
> 
> 	if ->f_poll_head is NULL {
> 		use ->poll
> 	} else {
> 		if can ll_poll (checked in ->f_mode)
> 			call ->ll_poll(), if it returns what we want - we are done
> 		add to ->f_poll_head
> 		call ->poll_mask()

What I have for now is slightly different:

	if ((events & POLL_BUSY_LOOP) && file->f_op->poll_busy_loop)
		file->f_op->poll_busy_loop(file, events);

	if (file->f_op->poll) {
		return file->f_op->poll(file, pt);
	} else if (file_has_poll_mask(file)) {
		...
	}

returns whatever we want part is something I want to look into
once the basics are done as it probably is non entirely trivial due to
structure of polling in the low-level network protocol.
