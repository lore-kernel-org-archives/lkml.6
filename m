Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932C4C43382
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 23:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 162E920877
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 23:09:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 162E920877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lxorguk.ukuu.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbeIYFOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 01:14:15 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:41066 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbeIYFOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 01:14:15 -0400
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id w8ON9Vwb018026;
        Tue, 25 Sep 2018 00:09:31 +0100
Date:   Tue, 25 Sep 2018 00:09:30 +0100
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc:     Dave Chinner <david@fromorbit.com>,
        Jeff Layton <jlayton@redhat.com>,
        =?UTF-8?B?54Sm5pmT5Yas?= <milestonejxd@gmail.com>,
        bfields@fieldses.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: POSIX violation by writeback error
Message-ID: <20180925000930.3d4a93fd@alans-desktop>
In-Reply-To: <20180906091718.GL24519@BitWizard.nl>
References: <CAJDTihw7T8WLme09W8VHCRfiALq4fxg1ZsywcSjn6hXsAw5wRw@mail.gmail.com>
        <cd137e88c9e882200c08c7336aa7b5a1c84a7ba3.camel@redhat.com>
        <20180904161203.GD17478@fieldses.org>
        <20180904162348.GN17123@BitWizard.nl>
        <20180904185411.GA22166@fieldses.org>
        <a9d586a8c520e52bad2396b93f8d5cb8a9fd2071.camel@redhat.com>
        <CAJDTihxE07BuXMBmShXuj=TbJCK1mq3ZMFMxP1-T=xjhPF5ySw@mail.gmail.com>
        <09ba078797a1327713e5c2d3111641246451c06e.camel@redhat.com>
        <20180905120745.GP17123@BitWizard.nl>
        <20180906025709.GZ5631@dastard>
        <20180906091718.GL24519@BitWizard.nl>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Sep 2018 11:17:18 +0200
Rogier Wolff <R.E.Wolff@BitWizard.nl> wrote:

> On Thu, Sep 06, 2018 at 12:57:09PM +1000, Dave Chinner wrote:
> > On Wed, Sep 05, 2018 at 02:07:46PM +0200, Rogier Wolff wrote:  
> 
> > > And this has worked for years because
> > > the kernel caches stuff from inodes and data-blocks. If you suddenly
> > > write stuff to harddisk at 10ms for each seek between inode area and
> > > data-area..  
> > 
> > You're assuming an awful lot about filesystem implementation here.
> > Neither ext4, btrfs or XFS issue physical IO like this when flushing
> > data.  
> 
> My thinking is: When fsync (implicit or explicit)  needs to know 
> the result of the underlying IO, it needs to wait for it to have
> happened.

Worse than that. In many cases it needs to wait for the I/O command to
have been accepted and confirmed by the drive, then tell the disk to do a
commit to physical media, then see if that blows up. A confirmation the
disk got the data is not a confirmation that it's stable. Your disk can
also reply from its internal cache with data that will fail to hit the
media a few seconds later.

Given a cache flush on an ATA disk can take 7 seconds I'm not fond of it
8) Fortunately spinning rust is on the way out.

It's even uglier in truth. Spinning rust rewrites sectors under you
by magic without your knowledge and in freaky cases you can have data
turn error that you've not even touched this month. Flash has some
similar behaviour although it can at least use a supercap to do real work.

You can also issue things like a single 16K write and have only the last
8K succeed and the drive report an error, which freaks out some supposedly
robust techniques.

Alan
