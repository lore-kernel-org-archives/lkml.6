Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C03C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 06:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A7AD2086B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 06:45:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A7AD2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732407AbeGLGxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 02:53:30 -0400
Received: from smtprelay0194.hostedemail.com ([216.40.44.194]:41231 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727113AbeGLGxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 02:53:30 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 2BB4A1264;
        Thu, 12 Jul 2018 06:45:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: thing30_859cf6bf52d0e
X-Filterd-Recvd-Size: 3501
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Thu, 12 Jul 2018 06:45:18 +0000 (UTC)
Message-ID: <2296606a890a1f3543c5db825ed172f7d295a504.camel@perches.com>
Subject: Re: [PATCH 02/12] blk: use for_each_if
From:   Joe Perches <joe@perches.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Shaohua Li <shli@fb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 11 Jul 2018 23:45:16 -0700
In-Reply-To: <CAKMK7uE5aJq-1wd0ZOhwFaTy3iKMAZsfdAf=Tw+eGxtCmfcVQg@mail.gmail.com>
References: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
         <20180709083650.23549-2-daniel.vetter@ffwll.ch>
         <20180711164058.GC72677@devbig577.frc2.facebook.com>
         <20180711164536.GD72677@devbig577.frc2.facebook.com>
         <965184f9-e5ed-3c8b-bfd7-a033a252371b@kernel.dk>
         <CAKMK7uE5aJq-1wd0ZOhwFaTy3iKMAZsfdAf=Tw+eGxtCmfcVQg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-11 at 20:50 +0200, Daniel Vetter wrote:
> On Wed, Jul 11, 2018 at 8:30 PM, Jens Axboe <axboe@kernel.dk> wrote:
> > On 7/11/18 10:45 AM, Tejun Heo wrote:
> > > On Wed, Jul 11, 2018 at 09:40:58AM -0700, Tejun Heo wrote:
> > > > On Mon, Jul 09, 2018 at 10:36:40AM +0200, Daniel Vetter wrote:
> > > > > Makes the macros resilient against if {} else {} blocks right
> > > > > afterwards.
> > > > > 
> > > > > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > > > > Cc: Tejun Heo <tj@kernel.org>
> > > > > Cc: Jens Axboe <axboe@kernel.dk>
> > > > > Cc: Shaohua Li <shli@fb.com>
> > > > > Cc: Kate Stewart <kstewart@linuxfoundation.org>
> > > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
> > > > > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > > > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > > 
> > > > Acked-by: Tejun Heo <tj@kernel.org>
> > > > 
> > > > Jens, it'd probably be best to route this through block tree.
> > > 
> > > Oops, this requires an earlier patch to move the for_each_if def to a
> > > common header and should be routed together.
> > 
> > Yeah, this is a problem with the submission.
> > 
> > Always (ALWAYS) CC folks on at least the cover letter and generic
> > earlier patches. Getting just one patch sent like this is mostly
> > useless, and causes more harm than good.
> 
> Ime sending a patch with more than 20 or so recipients means it gets
> stuck everywhere in moderation queues. Or outright spam filters. I
> thought the correct way to do this is to cc: mailing lists (lkml has
> them all), but apparently that's not how it's done. Despite that all
> the patch series I get never have the cover letter addressed to me
> either.
> 
> So what's the magic way to make this possible?

Jens' advice is crap.

There is no generic way to make this possible.

BCC's don't work, series that touch multiple subsystems
get rejected when the recipient list is too large.

I think you did it correctly.
