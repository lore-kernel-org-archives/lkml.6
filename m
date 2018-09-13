Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123A7C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 11:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB9FD2133F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 11:59:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB9FD2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbeIMRJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 13:09:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42606 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbeIMRJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 13:09:03 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0CF1AC9B;
        Thu, 13 Sep 2018 11:59:53 +0000 (UTC)
Date:   Thu, 13 Sep 2018 13:59:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCHES] tty ioctls cleanups, compat and not only
Message-ID: <20180913115951.GB2268@kroah.com>
References: <20180913023119.GQ19965@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913023119.GQ19965@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 03:31:19AM +0100, Al Viro wrote:
> 	See vfs.git#work.tty-ioctl.  Completely untested, should seriously
> clean the things up wrt compat.  Remaining problems (aside of the bugs
> introduced in it, of course):
> 	* TIOCSERGSTRUCT must die; it's present only in amiserial and it's
> _vile_; look at what it copies out and weep.
> 	* synclink_gt has proper compat handling for its private ioctls;
> other synclink drivers (with the same ioctls) do not.
> 	* dgnc definitely has buggered ioctls - structs full of longs are
> bloody bad idea for passing around.  It's in staging, and I'd say that it
> needs the userland ABI fixed.
> 	* cyclades, rocket, moxa and mxser probably have non-trivial
> problems with their private ioctls; I hadn't looked into those.
> 	* n_gsm needs ->compat_ioctl(); easy to do, I just hadn't done it
> yet.
> 	* ipwireless might or might not need compat_ioctl (PPP stuff in it);
> not sure.
> 	* ldisc private ioctls need more work.  Hadn't gone there yet.
> Generic ioctls should be fine - they never reach ->compat_ioctl() with this
> series.
> 
> 	There's some overlap with patches posted earlier - e.g. I'm fairly
> sure that keyboard ioctl "remove from fs/compat_ioctl.c" part duplicates
> one of yours; I'll be glad to drop and replace such duplicates with already
> posted variants.
> 
> 	Basic idea is to shunt generic ioctls that are reachable only
> via tty_ioctl() very early in tty_compat_ioctl(), separately for those
> that do and do not need compat_ptr().  That already simplifies the hell
> out of ->compat_ioctl() situation - its instances won't ever see those,
> so they can e.g. ignore the behaviour of n_tty_ioctl_helper(); whatever
> they get in cmd won't be accepted by that one.
> 
> 	Next we separate TIOC[SG]SERIAL into a couple of new methods,
> leaving the copyin/copyout to callers.  That allows to take care of
> compat for those in tty_compat_ioctl() *and* actually kills some of
> ->ioctl() instances.
> 
> 	And then there's dead code of all kinds all over the place ;-/
> The oldest one has been alive from Aug 1 1992 to Oct 18 1992 and had
> shambled around ever since (FIONBIO), but there are other examples.
> 10 years dead is better than 26, but still...
> 
> 	Shortlog and diffstat follow, patches in followups...

Thanks a lot for this work.  If you and Arnd want to figure out whose
tree to take it through, I have no objection.

All of these can be marked as:

	Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

if you want to.

greg k-h
