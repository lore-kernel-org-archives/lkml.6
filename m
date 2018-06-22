Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1902CC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 11:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C013E24187
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 11:56:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C013E24187
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751313AbeFVL4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 07:56:20 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:60394 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751005AbeFVL4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 07:56:19 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fWKfl-0007RD-I1; Fri, 22 Jun 2018 11:56:13 +0000
Date:   Fri, 22 Jun 2018 12:56:13 +0100
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
Message-ID: <20180622115613.GV30522@ZenIV.linux.org.uk>
References: <20180622082752.GX11011@yexl-desktop>
 <CA+55aFw5ghByk_zCN25G6rPPSAQma3Mh0t4s18CtLg=h6U9+Zg@mail.gmail.com>
 <20180622095608.GA12263@lst.de>
 <20180622100014.GA12425@lst.de>
 <20180622110117.GU30522@ZenIV.linux.org.uk>
 <20180622115300.GA14654@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622115300.GA14654@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 01:53:00PM +0200, Christoph Hellwig wrote:

> > Now, ->sk_wq is modified only in sock_init_data() and sock_graft();
> > the latter, IIRC, is ->accept() helper.  Do we ever call either of
> > those on a sock of already opened file?  IOW, is there any real
> > reason for socket ->get_poll_head() not to be constant, other
> > than wanting to keep POLL_BUSY_LOOP handling out of ->poll_mask()?
> > I agree that POLL_BUSY_LOOP is ugly as hell, but you *still* have
> > sock_poll_mask() not free from it...
> 
> I'd have to defer to networking folks if busy looping after pollwait
> is what they want, but I suspect the answer is no, by the time
> we are already waiting for the queue busy waiting seems pointless.

	So mark that in ->f_mode - I strongly suspect that
sk_can_busy_loop(sock->sk) can't change while an opened file is there.
And lift that (conditional on new FMODE_BUSY_LOOP) into do_poll()
and do_select() - we *already* have bits of pieces of that logics in
there and that way they'd at least be gathered in one place.

	Then replace ->get_poll_head() with file->f_poll_head and
see what it gives.
