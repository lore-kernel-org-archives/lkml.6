Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D43C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF142080D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbeLRMTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 07:19:48 -0500
Received: from charlotte.tuxdriver.com ([70.61.120.58]:48953 "EHLO
        smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbeLRMTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 07:19:47 -0500
Received: from cpe-2606-a000-111b-405a-a193-cb97-58ba-1c15.dyn6.twc.com ([2606:a000:111b:405a:a193:cb97:58ba:1c15] helo=localhost)
        by smtp.tuxdriver.com with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.63)
        (envelope-from <nhorman@tuxdriver.com>)
        id 1gZELb-0005zt-8L; Tue, 18 Dec 2018 07:19:42 -0500
Date:   Tue, 18 Dec 2018 07:19:12 -0500
From:   Neil Horman <nhorman@tuxdriver.com>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Xin Long <lucien.xin@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, dave.hansen@intel.com,
        davem <davem@davemloft.net>, Oleg Babin <obabin@virtuozzo.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>
Subject: Re: [PATCH 6/6] Drop flex_arrays
Message-ID: <20181218121912.GA2078@hmswarspite.think-freely.org>
References: <20180907165635.8469-1-kent.overstreet@gmail.com>
 <20180907165635.8469-7-kent.overstreet@gmail.com>
 <CADvbK_ccPYY5jGRV+cLNc5Nzcfv0mq0eNMeU-ALvepax0ZSizQ@mail.gmail.com>
 <20181213144111.GO6830@bombadil.infradead.org>
 <20181213155149.GA4127@hmswarspite.think-freely.org>
 <20181213164533.GQ6830@bombadil.infradead.org>
 <20181213180917.GB4127@hmswarspite.think-freely.org>
 <20181217125011.GA28294@kmo-pixel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217125011.GA28294@kmo-pixel>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 07:50:11AM -0500, Kent Overstreet wrote:
> On Thu, Dec 13, 2018 at 01:09:17PM -0500, Neil Horman wrote:
> > On Thu, Dec 13, 2018 at 08:45:33AM -0800, Matthew Wilcox wrote:
> > > On Thu, Dec 13, 2018 at 10:51:49AM -0500, Neil Horman wrote:
> > > > On Thu, Dec 13, 2018 at 06:41:11AM -0800, Matthew Wilcox wrote:
> > > > > On Thu, Dec 13, 2018 at 09:30:47PM +0900, Xin Long wrote:
> > > > > > On Sat, Sep 8, 2018 at 1:57 AM Kent Overstreet
> > > > > > <kent.overstreet@gmail.com> wrote:
> > > > > > >
> > > > > > > All existing users have been converted to generic radix trees
> > > > > > NAK, SCTP is still using flex_arrays,
> > > > > > # grep flex_array net/sctp/*
> > > > > > 
> > > > > > This patch will break the build.
> > > > > 
> > > > > sctp added that user after this patch was sent.  Please stop adding
> > > > > flexarray users!
> > > > > 
> > > > > This particular user should probably have just used kvmalloc.
> > > > > 
> > > > 
> > > > No, I don't think thats right.
> > > > 
> > > > This appears to have been sent on September 7th.  Commit
> > > > 0d493b4d0be352b5e361e4fa0bc3efe952d8b10e, which added the use of flex_arrays to
> > > > sctp, seems to have been merged on August 10th, a month prior.
> > > 
> > > Are you seriously suggesting anybody sending cleanups needs to be
> > > monitoring every single email list to see if anybody has added a new user?
> > > Removing the flexarray has been advertised since May.
> > > https://lkml.org/lkml/2018/5/22/1142
> > > 
> > I don't see how thats any more egregious than everyone else having to monitor
> > for removals of code thats in the tree at some indeterminate future.  The long and the short of it
> > is that a new flex_array user was added in the intervening 7 months that this
> > patch has been waiting to go in, and it will now break if merged.  I'm sorry we
> > started using it during that time, but it got missed by everyone in the chain
> > that merged it, and hasn't been noticed in the 4 months since.  It is what it
> > is, and now it needs to be undone. 
> > 
> > > > regardless, however, sctp has a current in-tree use of flex_arrays, and merging
> > > > this patch will break the build without a respin.
> > > 
> > > Great.  I await your patch to replace the flexarray usage.
> > Sure, we'll get to it as soon as we can, or, if you are in a hurry, you can
> > replace the same usage, like you've done for all the other users in this series.
> 
> This is really my fault for slacking on getting generic-radix-trees in, and
> given that the sctp code has been merged I'll do the conversion.
> 
Thank you, I appreciate that.

> However.
> 
> Looking at the sctp code, honestly, wtf is going on here.
> 
> sctp_send_add_streams() calls sctp_stream_alloc_out() when it wants to make the
> out flex_array bigger - ok, this makes sense, you're using a flex_array because
> you want something resizable.
> 
> But wait, look what it actually does - it unconditionally frees the old flex
> array and preallocates a new one and copies the contents of the old one over.
> 
> Without, as far as I can tell, any locking whatsoever.
> 
> Was this code tested? Reviewed?
> 
Yup, both sides are protected by the socket lock for which the sctp connection
is associated.  Its locked in the sctp_setsockopt function, which is the path
through which we update/reallocate these flex arrays, and its also locked on
transmit in sctp_sendmsg, and on receive in sctp_rcv (via bh_lock_sock)

Neil

