Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51122C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C3A320659
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:16:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C3A320659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404016AbeHPSQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 14:16:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52694 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391877AbeHPSQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 14:16:00 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8DFD53EE;
        Thu, 16 Aug 2018 15:16:53 +0000 (UTC)
Date:   Thu, 16 Aug 2018 17:16:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     Takashi Iwai <tiwai@suse.de>, stable@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, Jiri Bohac <jbohac@suse.cz>
Subject: Re: [PATCH 4.4.y] tcp: Fix missing range_truesize enlargement in the
 backport
Message-ID: <20180816151646.GF10648@kroah.com>
References: <20180815095846.7734-1-tiwai@suse.de>
 <20180815111121.GA17583@kroah.com>
 <20180815200230.z6mywup7vfe3hmyo@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180815200230.z6mywup7vfe3hmyo@unicorn.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 10:02:30PM +0200, Michal Kubecek wrote:
> On Wed, Aug 15, 2018 at 01:11:21PM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Aug 15, 2018 at 11:58:46AM +0200, Takashi Iwai wrote:
> > > The 4.4.y stable backport dc6ae4dffd65 for the upstream commit
> > > 3d4bf93ac120 ("tcp: detect malicious patterns in
> > > tcp_collapse_ofo_queue()") missed a line that enlarges the
> > > range_truesize value, which broke the whole check.
> > > 
> > > Fixes: dc6ae4dffd65 ("tcp: detect malicious patterns in tcp_collapse_ofo_queue()")
> > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > > ---
> > > 
> > > Greg, this is a fix-up specific to 4.4.y stable backport that had a
> > > slightly different form from upstream fix.  I haven't looked at the
> > > older trees, but 4.9.y and later took the upstream fix as is, so this
> > > patch isn't needed for them.
> > > 
> > > The patch hasn't been tested with the real test case, though; let me
> > > know if the current code is intended.  Thanks!
> > 
> > Hm, I did the initial backport, and then Eric showed what I got wrong
> > and fixed that up, so being still wrong is not inconceivable at all :)
> 
> Takashi's follow-up patch is what makes the backport work the same way
> as the original mainline commit 3d4bf93ac120. Without it, range_truesize
> will be always equal to truesize of first packet in a contiguous range
> so that the condition
> 
>   range_truesize != head->truesize
> 
> will be always false (and there would be no point having range_truesize
> variable at all).

Thanks, I've now queued this up.

greg k-h
