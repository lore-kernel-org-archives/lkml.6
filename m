Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E17C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 295392084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:08:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 295392084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbeJBCrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 22:47:49 -0400
Received: from namei.org ([65.99.196.166]:34604 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbeJBCrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 22:47:49 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id w91K8GDP015566;
        Mon, 1 Oct 2018 20:08:16 GMT
Date:   Tue, 2 Oct 2018 06:08:16 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
cc:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Dave Chinner <david@fromorbit.com>, TongZhang <ztong@vt.edu>,
        linux-xfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        Wenbo Shen <shenwenbosmile@gmail.com>
Subject: Re: Leaking Path in XFS's ioctl interface(missing LSM check)
In-Reply-To: <20181001154459.GB5872@magnolia>
Message-ID: <alpine.LRH.2.21.1810020608090.14406@namei.org>
References: <5EF0D46A-C098-4B51-AD13-225FFCA35D4C@vt.edu> <20180926013329.GD31060@dastard> <20180926192426.472360ea@alans-desktop> <20180927013812.GF31060@dastard> <20180930151652.6975610c@alans-desktop> <20181001002521.GM31060@dastard>
 <20181001160442.47c798bc@alans-desktop> <20181001154459.GB5872@magnolia>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Oct 2018, Darrick J. Wong wrote:

> If we /did/ replace CAP_SYS_ADMIN checking with a pile of LSM hooks,

Not sure we'd need a pile of hooks, what about just "read" and "write" 
storage admin?

Or even two new capabilities along these lines, which we convert existing 
CAP_SYS_ADMIN etc. to?

> how do we make sure that we (XFS) avoid breaking existing XFS tools?  I 
> guess the default compatibility handler for all of those new hooks would 
> be "return capable(CAP_SYS_ADMIN) ? 0 : -EPERM;" and then other LSMs 
> could restrict that further if so configured.
> 
> Seriously, I don't know that much about how LSMs actually perform
> security checks -- it looks like a number of them can be active
> simultaneously, and we just call each of them in a chain until one of
> them denies permission or we run out of LSMs and allow it?
> 

Correct.

> FWIW I didn't have a particular security or threat model in mind when I
> made the above list; all I did was break up the existing CAP_SYS_ADMIN
> into rough functional areas.  Maybe it makes sense, but maybe I'm
> rambling. :)
> 
> --D
> 
> > You can build that model where for example only an administrative
> > login from a trusted console may launch processes to do that
> > management.
> > 
> > Or you could - if things were not going around the LSM hooks.
> > 
> > Alan
> 

-- 
James Morris
<jmorris@namei.org>

