Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B595AC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81981206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:20:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81981206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbeJCCFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 22:05:34 -0400
Received: from namei.org ([65.99.196.166]:35070 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726946AbeJCCFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 22:05:33 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id w92JKVAN019036;
        Tue, 2 Oct 2018 19:20:31 GMT
Date:   Wed, 3 Oct 2018 05:20:31 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Dave Chinner <david@fromorbit.com>
cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        TongZhang <ztong@vt.edu>, linux-xfs@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        Wenbo Shen <shenwenbosmile@gmail.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>
Subject: Re: Leaking Path in XFS's ioctl interface(missing LSM check)
In-Reply-To: <20181001224528.GI18567@dastard>
Message-ID: <alpine.LRH.2.21.1810030518240.17817@namei.org>
References: <5EF0D46A-C098-4B51-AD13-225FFCA35D4C@vt.edu> <20180926013329.GD31060@dastard> <20180926192426.472360ea@alans-desktop> <20180927013812.GF31060@dastard> <20180930151652.6975610c@alans-desktop> <20181001002521.GM31060@dastard>
 <20181001160442.47c798bc@alans-desktop> <20181001154459.GB5872@magnolia> <alpine.LRH.2.21.1810020608090.14406@namei.org> <20181001224528.GI18567@dastard>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Oct 2018, Dave Chinner wrote:

> On Tue, Oct 02, 2018 at 06:08:16AM +1000, James Morris wrote:
> > On Mon, 1 Oct 2018, Darrick J. Wong wrote:
> > 
> > > If we /did/ replace CAP_SYS_ADMIN checking with a pile of LSM hooks,
> > 
> > Not sure we'd need a pile of hooks, what about just "read" and "write" 
> > storage admin?
> > 
> > Or even two new capabilities along these lines, which we convert existing 
> > CAP_SYS_ADMIN etc. to?
> 
> So instead of having hundreds of management ioctls under
> CAP_SYS_ADMIN, we'd now have hundreds of non-storage ioctls under
> CAP_SYS_ADMIN and hundreds of storage ioctls under
> CAP_SYS_STORAGE_ADMIN?
> 
> Maybe I'm missing something, but I don't see how that improves the
> situation w.r.t. locked down LSM configurations?

I'm not sure about capabilities, but having two specific LSM hooks for 
storage admin would allow SELinux et al to explicitly control privileged 
access to these interfaces.  Storage admin seems to be a special case of 
its own which we want to be able to mediate as such.



-- 
James Morris
<jmorris@namei.org>

