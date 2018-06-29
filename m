Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8837FC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 04:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37BBC249D1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 04:44:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37BBC249D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fromorbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932516AbeF2Eop (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 00:44:45 -0400
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:2036 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932408AbeF2Eoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 00:44:44 -0400
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail06.adl6.internode.on.net with ESMTP; 29 Jun 2018 14:14:42 +0930
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1fYlGy-0002RK-B4; Fri, 29 Jun 2018 14:44:40 +1000
Date:   Fri, 29 Jun 2018 14:44:40 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Steve French <smfrench@gmail.com>
Cc:     ronnie sahlberg <ronniesahlberg@gmail.com>,
        Theodore Tso <tytso@mit.edu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        CIFS <linux-cifs@vger.kernel.org>
Subject: Re: config files and how to have persistent Linux kernel Driver/File
 System configuration info saved
Message-ID: <20180629044440.GK19934@dastard>
References: <CAH2r5msV1hBAGgqtMFh6P=OGPV3RKjVAER=5bg-6Y+vW5BEJwQ@mail.gmail.com>
 <20180628225857.GB1231@thunk.org>
 <CAN05THStuq+RLzb_oNiD2TvN6MjMMnTdCxNiHuYWHRueQ46=_A@mail.gmail.com>
 <CAH2r5mui9WLBC6ne+iqVeYDGKEMKTabHPTf57STM9_aPGfM0sA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2r5mui9WLBC6ne+iqVeYDGKEMKTabHPTf57STM9_aPGfM0sA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 06:24:59PM -0500, Steve French wrote:
> On Thu, Jun 28, 2018 at 6:21 PM ronnie sahlberg
> <ronniesahlberg@gmail.com> wrote:
> >
> > On Fri, Jun 29, 2018 at 8:58 AM, Theodore Y. Ts'o via samba-technical
> > <samba-technical@lists.samba.org> wrote:
> > > On Thu, Jun 28, 2018 at 05:37:15PM -0500, Steve French wrote:
> > >> Ronnie brought up an interesting point about the problems consistently
> > >> configuring file systems (or any Linux module for that matter) so that
> > >> reboot doesn't wipe away security or performance tuning changes.
> > >
> > > In general it's considered best practice to make the file system
> > > auto-tune itself as much as possible, because the sad fact is that
> > > 99.9999% of the customers aren't going to bother to add any tuning
> > > parameters.  So there hasn't been a push to try to create something
> > > more complex, because it's generally not needed.
> >
> > True, but in these cases I think we are more looking at server or
> > mountpoint specific options than
> > actual fs tuning.
> >
> > For example nfsmount.conf can be used to say "only use NFSv4 when
> > accessing server abc" etc.
> > For the case of CIFS I could imagine that an administrator might want
> > to set "disable smb1 protocol globally"
> 
> Or perhaps
>   "disable smb1 on " ... various public networks but allow it on
> private networks

The way the policy is configured depends on the mechanism used to
configure the policy. If it's a sysctl or a mount option, then we've
already got everything we need. If it's something dynamic in sysfs,
then I think you're on your own.

FYI, I have been looking at making sysctl be able to work on /sys
rather than just /proc/sys (I have a 10 line hack to enable it) so
we could re-use it with custom per-mount error config files in
/etc/xfs/ for XFS that we inject based on a uevent delivered to
udev. It works, but the fact is modifying sysctl in this way exposes
it to a whole bunch of stuff sysctl doesn't understand, shouldn't be
accessing and/or trying modify. i.e. sysctl is disturbingly dumb,
and it gets away with it because of it's restricted scope and API
presented by /proc/sys.

So, really, I'm probably just going roll our own sysfs config file
mechanism into xfs_spaceman (probably based on the new config file
parser we have for mkfs.xfs) and hide the mess with a nice, simple
xfs_admin interface for udev to call. i.e. roll our own :)

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
