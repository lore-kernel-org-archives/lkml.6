Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F483C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 19:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BE2A2150F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 19:21:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BE2A2150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbeHWWwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 18:52:31 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:60798 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbeHWWwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 18:52:31 -0400
Received: from relay7-d.mail.gandi.net (unknown [217.70.183.200])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 54B4B3A702F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 21:12:48 +0200 (CEST)
X-Originating-IP: 134.134.139.72
Received: from localhost (jfdmzpr03-ext.jf.intel.com [134.134.139.72])
        (Authenticated sender: josh@joshtriplett.org)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 8A57120004;
        Thu, 23 Aug 2018 19:12:45 +0000 (UTC)
Date:   Thu, 23 Aug 2018 12:12:35 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     nicolas.pitre@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: Kernel-only deployments?
Message-ID: <20180823191235.GA3243@localhost>
References: <20180823174359.GA13033@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180823174359.GA13033@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 10:43:59AM -0700, Paul E. McKenney wrote:
> Hello!
> 
> Does anyone do kernel-only deployments, for example, setting up an
> embedded device having a Linux kernel and absolutely no userspace
> whatsoever?

I would very much *like* to do this. One day I'd like to have a
CONFIG_USERSPACE that I can disable, and then just have the kernel call
an in-kernel main() where it would normally start init.

> Those who know me will not be at all surprised to learn that I went
> overboard making the resulting initrd as small as possible.  I started
> by throwing out everything not absolutely needed by the dash and sleep
> binaries, which got me down to about 2.5MB, 1.8MB of which was libc.
> This situation of course prompted me to create an initrd containing
> a statically linked binary named "init" and absolutely nothing else
> (not even /dev or /tmp directories), which weighs in at not quite 800KB.
> This is a great improvement over 10MB, to say nothing of 40MB, but 800KB
> for a C-language "for" loop containing nothing more than a single call to
> sleep()?  Much of the code is there for things that I might do (dl_open(),
> for example), but don't.  All I can say is that there clearly aren't many
> of us left who made heavy use of systems with naked-eye-visible bits!
> (Or naked-finger-feelable, for that matter.)

I have definitely built initramfs images containing nothing but a single
statically linked /init before.

If you want to make it even smaller, you could avoid linking in libc at
all, and just write a short assembly stub, but I don't know any way to
do that *portably* without writing raw assembly for each target
platform. That would get you down to a few kB though.

> This further prompted the idea of modifying kernel_init() to just loop
> forever, perhaps not even reaping orphaned zombies [*], given an appropriate
> Kconfig option and/or kernel boot parameter.  I obviously cannot justify
> this to save a sub-one-megabyte initrd for rcutorture, no matter how much
> a wasted 800K might have offended my 30-years-ago self.  If I take this
> next step, there have to be quite a few others benefiting significantly
> from it.

I would *love* to have support for omitting userspace entirely. And once
we have that, we can start ripping out so many other things...

One thought, though: that won't necessarily give you a representative
rcutorture experience, given that you need to test things like the
nohz-on-non-idle support, which interacts with "am I in userspace".
