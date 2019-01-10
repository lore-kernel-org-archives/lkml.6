Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C332AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9312E2177B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547144659;
	bh=j1wp5+YMGTH2746OHEwtJPq8N3Yy60136mAzN+h5OXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NH+tAwschdZRlHwf0fH2tZwL5cA2Sr3DGA4tssQhqavihuFGCuAuG0WKRZY2TwVCf
	 Y66rELxtg3MQ8aymWh+YhX3oJvbDkTeScASozbKivZXfDBY41oV4czor9uT0ZKDnoi
	 IkHgxY6C2hSlE2IlDZgohZ0Skc691WSrv0pHQq2A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731131AbfAJSYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 13:24:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:43408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729986AbfAJSYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 13:24:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D76C9214DA;
        Thu, 10 Jan 2019 18:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547144656;
        bh=j1wp5+YMGTH2746OHEwtJPq8N3Yy60136mAzN+h5OXI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LIG4gaX/1hBkVCh705mA0A0dCeQDkgti6f1Fw9Kj2ptJeIvjOmAhLVrXkxZB4rCZw
         L43MDPcQukCjvL/+H+aWkEa9u4vCazJHbfLZyI4Ad6QOTn6VSxUY7NMvqZ2hHrfIpQ
         tJlgXmH3rUWzYfu2yTwv8w7fpL6x5lEWQRRbk4/0=
Date:   Thu, 10 Jan 2019 19:24:13 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     "Hutter, Tony" <hutter2@llnl.gov>,
        Marc Dionne <marc.c.dionne@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: x86/fpu: Don't export __kernel_fpu_{begin,end}()
Message-ID: <20190110182413.GA6932@kroah.com>
References: <git-mailbomb-linux-master-12209993e98c5fa1855c467f22a24e3d5b8be205@kernel.org>
 <CAB9dFdsZb-sZixeOzrt8F50h1pnUK2W2Cxx8+xjhgd0=6xs7iw@mail.gmail.com>
 <20190109111951.5zvnj7ls6jv56p2u@linutronix.de>
 <20190109165235.GA8151@kroah.com>
 <20190109170935.e6b6rwzpk6dlruu4@linutronix.de>
 <20190110131132.GC20217@kroah.com>
 <ba74ed88-06d0-5063-799f-c9c6ddbc7da0@llnl.gov>
 <20190110180752.f4cnunadzzkev24m@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190110180752.f4cnunadzzkev24m@linutronix.de>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 07:07:52PM +0100, Sebastian Andrzej Siewior wrote:
> On 2019-01-10 17:32:58 [+0000], Hutter, Tony wrote:
> > > But since when did out-of-tree modules use __kernel_fpu_begin?  It's an
> > > x86-only thing, and shouldn't really be used by anyone, right?
> > 
> > ZFS on Linux uses it for checksums.  Its removal is currently breaking ZFS builds against 5.0:
> 
> So btrfs uses crc32c() / kernel's crypto API for that and ZFS can't?
> Well the crypto API is GPL only exported so that won't work. crc32c() is
> EXPORT_SYMBOL() so it would work.
> On the other hand it does not look right to provide a EXPORT_SYMBOL
> wrapper around a GPL only interface…

Yes, the "GPL condom" attempt doesn't work at all.  It's been shot down
a long time ago in the courts.

My tolerance for ZFS is pretty non-existant.  Sun explicitly did not
want their code to work on Linux, so why would we do extra work to get
their code to work properly?

greg k-h
