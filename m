Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5939C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BDEB206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:17:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BDEB206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=BitWizard.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbeIFNvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 09:51:51 -0400
Received: from cust-95-128-94-82.breedbanddelft.nl ([95.128.94.82]:50532 "EHLO
        cust-95-128-94-82.breedbanddelft.nl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728035AbeIFNvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 09:51:51 -0400
Received: by abra2.bitwizard.nl (Postfix, from userid 1000)
        id F408D13F75C; Thu,  6 Sep 2018 11:17:18 +0200 (CEST)
Date:   Thu, 6 Sep 2018 11:17:18 +0200
From:   Rogier Wolff <R.E.Wolff@BitWizard.nl>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jeff Layton <jlayton@redhat.com>,
        =?utf-8?B?54Sm5pmT5Yas?= <milestonejxd@gmail.com>,
        bfields@fieldses.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: POSIX violation by writeback error
Message-ID: <20180906091718.GL24519@BitWizard.nl>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906025709.GZ5631@dastard>
Organization: BitWizard B.V.
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 12:57:09PM +1000, Dave Chinner wrote:
> On Wed, Sep 05, 2018 at 02:07:46PM +0200, Rogier Wolff wrote:

> > And this has worked for years because
> > the kernel caches stuff from inodes and data-blocks. If you suddenly
> > write stuff to harddisk at 10ms for each seek between inode area and
> > data-area..
> 
> You're assuming an awful lot about filesystem implementation here.
> Neither ext4, btrfs or XFS issue physical IO like this when flushing
> data.

My thinking is: When fsync (implicit or explicit)  needs to know 
the result of the underlying IO, it needs to wait for it to have
happened. 

My thinking is: You can either log the data in the logfile or just the
metadata. By default/most people will chose the last. In the "make sure
it hits storage" case, you have three areas. 
* The logfile
* the inode area
* the data area. 

When you allow the application to continue pasta close, you can gather
up say a few megabytes of updates to each area and do say 50 seeks per
second. (achieving maybe about 50% of the throughput performance of
your drive)

If you don't store the /data/, you can stay in the inode or logfile
area and get a high throughput on your drive. But when a crash has the
filesystem in a defined state, what use is that if your application is
in a bad state because it is getting bad data?


Of course the application can be rewritten to have multiple threads so
that while one thread is waiting for a close to finish another one can
open/write/close another file. But there are existing applicaitons run
by users who do not have the knowledge or option to delve into the
source and rewrite the application to be multithreaded.

Your 100k files per second is closely similar to mine. In real life we
are not going to see such extreme numbers, but in some cases the
benchmark does predict a part of the performance of an application.
In practice, an application may spend 50% of the time on thinking
about the next file to make, and then 50k times per second actually
making the file.

	Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
**    Delftechpark 26 2628 XH  Delft, The Netherlands. KVK: 27239233    **
*-- BitWizard writes Linux device drivers for any device you may have! --*
The plan was simple, like my brother-in-law Phil. But unlike
Phil, this plan just might work.
