Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38821C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 22:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE96A2089A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 22:53:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE96A2089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fromorbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbeJBFde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 01:33:34 -0400
Received: from ipmail01.adl6.internode.on.net ([150.101.137.136]:49681 "EHLO
        ipmail01.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725936AbeJBFde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 01:33:34 -0400
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail01.adl6.internode.on.net with ESMTP; 02 Oct 2018 08:23:25 +0930
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1g7749-0006hf-6g; Tue, 02 Oct 2018 08:53:25 +1000
Date:   Tue, 2 Oct 2018 08:53:25 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        TongZhang <ztong@vt.edu>, darrick.wong@oracle.com,
        linux-xfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        Wenbo Shen <shenwenbosmile@gmail.com>
Subject: Re: Leaking Path in XFS's ioctl interface(missing LSM check)
Message-ID: <20181001225325.GJ18567@dastard>
References: <5EF0D46A-C098-4B51-AD13-225FFCA35D4C@vt.edu>
 <20180926013329.GD31060@dastard>
 <20180926192426.472360ea@alans-desktop>
 <20180927013812.GF31060@dastard>
 <20180930151652.6975610c@alans-desktop>
 <20181001002521.GM31060@dastard>
 <20181001160442.47c798bc@alans-desktop>
 <20181001152529.GA2549@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181001152529.GA2549@thunk.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2018 at 11:25:29AM -0400, Theodore Y. Ts'o wrote:
> On Mon, Oct 01, 2018 at 04:04:42PM +0100, Alan Cox wrote:
> > > Systems restricted by LSMs to the point where CAP_SYS_ADMIN is not
> > > trusted have exactly the same issues. i.e. there's nobody trusted by
> > > the kernel to administer the storage stack, and nobody has defined a
> > > workable security model that can prevent untrusted users from
> > > violating the existing storage trust model....
> > 
> > With a proper set of LSM checks you can lock the filesystem management
> > and enforcement to a particular set of objects. You can build that model
> > where for example only an administrative login from a trusted console may
> > launch processes to do that management.
> > 
> > Or you could - if things were not going around the LSM hooks.
> 
> It would be useful if anyone actually *wants* to do this thing to
> define a formal security model, and detail *everything* that would
> need to be changed in order to accomplish it.  Just as we don't
> speculatively add code "just in case" someone might want to use it
> someday, I don't think we should be adding random LSM hooks just
> becausre someone *might* want do something.

Yeah, that's what I was implying we needed to do - taking the
current model and slapping LSM hooks around randomly will only make
things break and cause admins to curse us....

> Let's see the use case, and let's see how horrible the changes would
> need to be, and how credible we think it is that someone will actually
> want to *use* it.  I suspect the chagnes will be a really huge number
> of places, and not just in XFS....

So do I - the "in root we trust" model is pretty deeply ingrained up
and down the storage stack. I also suspect that most of our hardware
admin (not just storage) has similar assumptions about the security
model they operate in.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
