Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A0FC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D02292077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:08:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D02292077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=BitWizard.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbeIELhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 07:37:34 -0400
Received: from cust-95-128-94-82.breedbanddelft.nl ([95.128.94.82]:44548 "EHLO
        cust-95-128-94-82.breedbanddelft.nl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726242AbeIELhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 07:37:34 -0400
Received: by abra2.bitwizard.nl (Postfix, from userid 1000)
        id 36EF913F782; Wed,  5 Sep 2018 09:08:47 +0200 (CEST)
Date:   Wed, 5 Sep 2018 09:08:47 +0200
From:   Rogier Wolff <R.E.Wolff@BitWizard.nl>
To:     Jeff Layton <jlayton@redhat.com>
Cc:     =?utf-8?B?54Sm5pmT5Yas?= <milestonejxd@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: POSIX violation by writeback error
Message-ID: <20180905070847.GC24519@BitWizard.nl>
References: <CAJDTihz-rFb2SGaxZsQnXGnee_2qW_ynhPe=tZ4yzQBSV_KQ1g@mail.gmail.com>
 <20180904075347.GH11854@BitWizard.nl>
 <CAJDTihzqn3whQ47uUOxGYk4Je4S10ehNEQCtfb=j--iCsdDqgQ@mail.gmail.com>
 <82ffc434137c2ca47a8edefbe7007f5cbecd1cca.camel@redhat.com>
 <CAJDTihw7T8WLme09W8VHCRfiALq4fxg1ZsywcSjn6hXsAw5wRw@mail.gmail.com>
 <cd137e88c9e882200c08c7336aa7b5a1c84a7ba3.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cd137e88c9e882200c08c7336aa7b5a1c84a7ba3.camel@redhat.com>
Organization: BitWizard B.V.
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 11:44:20AM -0400, Jeff Layton wrote:
> On Tue, 2018-09-04 at 22:56 +0800, 焦晓冬 wrote:
> > On Tue, Sep 4, 2018 at 7:09 PM Jeff Layton <jlayton@redhat.com> wrote:
> > > 
> > > On Tue, 2018-09-04 at 16:58 +0800, Trol wrote:
> > > > That is certainly not possible to be done. But at least, shall we report
> > > > error on read()? Silently returning wrong data may cause further damage,
> > > > such as removing wrong files since it was marked as garbage in the old file.
> > > > 
> > > 
> > > Is the data wrong though? You tried to write and then that failed.
> > > Eventually we want to be able to get at the data that's actually in the
> > > file -- what is that point?
> > 
> > The point is silently data corruption is dangerous. I would prefer getting an
> > error back to receive wrong data.
> > 
> 
> Well, _you_ might like that, but there are whole piles of applications
> that may fall over completely in this situation. Legacy usage matters
> here.

Can I make a suggestion here?

First imagine a spherical cow in a vacuum..... 

What I mean is: In the absence of boundary conditions (the real world)
what would ideally happen?

I'd say: 

* When you've written data to a file, you would want to read that
  written data back. Even in the presence of errors on the backing
  media.

But already this is controversial: I've seen time-and-time again that
people with raid-5 setups continue to work untill the second drive
fails: They ignored the signals the system was giving: "Please replace
a drive".

So when a mail queuer puts mail the mailq files and the mail processor
can get them out of there intact, nobody is going to notice.  (I know
mail queuers should call fsync and report errors when that fails, but
there are bound to be applications where calling fsync is not
appropriate (*))

So maybe when the write fails, the reads on that file should fail?

Then it means the data required to keep in memory is much reduced: you
only have to keep the metadata.

In both cases, semantics change when a reboot happens before the
read. Should we care? If we can't fix it when a reboot has happened,
does it make sense to do something different when a reboot has NOT
happened?

	Roger. 



(*) I have 800Gb of data I need to give to a client. The
truck-of-tapes solution of today is a 1Tb USB-3 drive. Writing that
data onto the drive runs at 30Mb/sec (USB2 speed: USB3 didn't work for
some reason) for 5-10 seconds and then slows down to 200k/sec for
minutes at a time. One of the reasons might be that fuse-ntfs is
calling fsync on the MFT and directory files to keep stuff consistent
just in case things crash. Well... In this case this means that
copying the data took 3 full days instead of 3 hours. Too much calling
fsync is not good either.

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
**    Delftechpark 26 2628 XH  Delft, The Netherlands. KVK: 27239233    **
*-- BitWizard writes Linux device drivers for any device you may have! --*
The plan was simple, like my brother-in-law Phil. But unlike
Phil, this plan just might work.
