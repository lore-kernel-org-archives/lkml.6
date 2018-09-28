Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD943C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3914120779
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:41:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3914120779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lxorguk.ukuu.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729527AbeI1WGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 18:06:04 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:34322 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728953AbeI1WGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 18:06:03 -0400
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id w8SFfgXA016685;
        Fri, 28 Sep 2018 16:41:43 +0100
Date:   Fri, 28 Sep 2018 16:41:42 +0100
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     Marcus Linsner <constantoverride@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Howto prevent kernel from evicting code pages ever? (to avoid
 disk thrashing when about to run out of RAM)
Message-ID: <20180928164142.715ea2a1@alans-desktop>
In-Reply-To: <CAKYFi-4a=H+vT+vo5s6mpKXAv+0W0pyTj1WtEr6xfjoFVFmtJQ@mail.gmail.com>
References: <CAKYFi-4a=H+vT+vo5s6mpKXAv+0W0pyTj1WtEr6xfjoFVFmtJQ@mail.gmail.com>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Aug 2018 11:25:35 +0200
Marcus Linsner <constantoverride@gmail.com> wrote:

> Hi. How to make the kernel keep(lock?) all code pages in RAM so that
> kswapd0 won't evict them when the system is under low memory
> conditions ?
> 
> The purpose of this is to prevent the kernel from causing lots of disk
> reads(effectively freezing the whole system) when about to run out of
> RAM, even when there is no swap enabled, but well before(in real time
> minutes) OOM-killer triggers to kill the offending process (eg. ld)!

Having no swap is not helping you at all.

In Linux you can do several things. Firstly add some swap - even a
swap file because if you have no swap you fill up memory with pages that
are not backed by disk and the kernel has to pick less and less optimal
things to swap out so begins to thrash. Even slowish swap is better than
no swap as it can dump out little used data pages.

You can tune the OOM killer to taste and you can even guide it on what to
shoot first.

You can use cgroups to constrain the resources some group of things are
allowed to use.

You can play with no overcommit mode, although that is much more about
'cannot fail' embedded applications usually. In that mode the kernel
tightly constrains the resource overcommit permissible. It's very
conservative and you end up needing a lot of 'just in case' wasted
resource, although you can tune the amount you leverage the real
resources.

To be fair Linux *is* really bad at handling this case. What other systems
did (being older and from the days where RAM wasn't reasonably assumed
infinite) was two fold.  The first was under high swap load to switch to
swapping out entire processes, which with all the shared resources and
fast I/O today isn't quite so relevant. The second was that it would
ensure a process got a certain amount of real CPU time before it's pages
could be booted out again (and would then boot out lots of them). That
turns the thrashing into forward progress but still feels unpleasant.
However you still need swap or you don't have anywhere to boot out all
the dirty non code pages in order to manage progress.

There is a reason swap exists. If you don't have enough RAM to run
smoothly without swap, add swap (or RAM). Even then some things usually
need swap - I've got things that make the compiler consume over 16GB
building one file. With swap it's fine even on a 4GB machine.

Alan
