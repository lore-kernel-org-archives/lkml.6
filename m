Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB644ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84ACF21523
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:01:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84ACF21523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732789AbeITTpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 15:45:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54454 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727633AbeITTpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 15:45:22 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EDFBE30C57F7;
        Thu, 20 Sep 2018 14:01:44 +0000 (UTC)
Received: from redhat.com (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A8C9981E20;
        Thu, 20 Sep 2018 14:01:29 +0000 (UTC)
Date:   Thu, 20 Sep 2018 10:01:27 -0400
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Whitcroft <robobotbotbot@gmail.com>,
        Brian Belleville <bbellevi@uci.edu>,
        Jiri Kosina <jikos@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] floppy: Do not copy a kernel pointer to user memory in
 FDGETPRM ioctl
Message-ID: <20180920140127.72w35olyd4ivnxjp@redhat.com>
References: <1520467365-7194-1-git-send-email-bbellevi@uci.edu>
 <20180529132722.GH7445@brain>
 <CAGXu5jLXm8mJuwtDEO_+dDJk5tRA+2mkEv5S9NaPP87J42B7KQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jLXm8mJuwtDEO_+dDJk5tRA+2mkEv5S9NaPP87J42B7KQ@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Thu, 20 Sep 2018 14:01:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 12:45:25AM -0700, Kees Cook wrote:
> On Tue, May 29, 2018 at 6:27 AM, Andy Whitcroft <robobotbotbot@gmail.com> wrote:
> > On Wed, Mar 07, 2018 at 04:02:45PM -0800, Brian Belleville wrote:
> >> The final field of a floppy_struct is the field "name", which is a
> >> pointer to a string in kernel memory. The kernel pointer should not be
> >> copied to user memory. The FDGETPRM ioctl copies a floppy_struct to
> >> user memory, including the "name" field. This pointer cannot be used
> >> by the user, and it will leak a kernel address to user-space, which
> >> will reveal the location of kernel code and data and undermine KASLR
> >> protection. Instead, copy the floppy_struct except for the "name"
> >> field.
> >>
> >> Signed-off-by: Brian Belleville <bbellevi@uci.edu>
> >> ---
> >>  drivers/block/floppy.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> >> index eae484a..4d4a422 100644
> >> --- a/drivers/block/floppy.c
> >> +++ b/drivers/block/floppy.c
> >> @@ -3470,6 +3470,7 @@ static int fd_locked_ioctl(struct block_device *bdev, fmode_t mode, unsigned int
> >>                                         (struct floppy_struct **)&outparam);
> >>               if (ret)
> >>                       return ret;
> >> +             size = offsetof(struct floppy_struct, name);
> >>               break;
> >>       case FDMSGON:
> >>               UDP->flags |= FTD_MSG;
> >
> > I am not sure it is reasonable to simply set size here to the length of the
> > valid data.  Though in the real world everyonne should be using the defines
> > and those should include the full length, the code itself does not require
> > this, it only prevents overly long reads.  So I think it is possible to do
> > this read with a shorter userspace buffer; with this change we would
> > then write beyond the end of the buffer.
> >
> > This also seems to introduce a slight behavioural difference between the
> > primary and compat calls.  The compat call already elides the name but it
> > also is copying into a new structure for return and this is pre-cleared,
> > so the name will always be null for the compat case and undefined for
> > the primary ioctl.
> >
> > Perhaps the below patch would be more appropriate.
> >
> > -apw
> >
> > From ddb8c77229a9507fa5575c910d2847e123a9c94c Mon Sep 17 00:00:00 2001
> > From: Andy Whitcroft <apw@canonical.com>
> > Date: Tue, 29 May 2018 13:04:15 +0100
> > Subject: [PATCH 1/1] floppy: Do not copy a kernel pointer to user memory in
> >  FDGETPRM ioctl
> >
> > The final field of a floppy_struct is the field "name", which is a pointer
> > to a string in kernel memory.  The kernel pointer should not be copied to
> > user memory.  The FDGETPRM ioctl copies a floppy_struct to user memory,
> > including this "name" field.  This pointer cannot be used by the user
> > and it will leak a kernel address to user-space, which will reveal the
> > location of kernel code and data and undermine KASLR protection.
> >
> > Model this code after the compat ioctl which copies the returned data
> > to a previously cleared temporary structure on the stack (excluding the
> > name pointer) and copy out to userspace from there.  As we already have
> > an inparam union with an appropriate member and that memory is already
> > cleared even for read only calls make use of that as a temporary store.
> >
> > Based on an initial patch by Brian Belleville.
> >
> > CVE-2018-7755
> > Signed-off-by: Andy Whitcroft <apw@canonical.com>
> 
> I didn't see this land anywhere? Who's tree is this going through?
> 
> -Kees
> 

Looks like a pretty simple fix, but still don't see this one anywhere...
maybe Jiri or Jens could pick it up (as per get_maintainer output :)

-- Joe

> > ---
> >  drivers/block/floppy.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> > index 8ec7235fc93b..7512f6ff7c43 100644
> > --- a/drivers/block/floppy.c
> > +++ b/drivers/block/floppy.c
> > @@ -3470,6 +3470,8 @@ static int fd_locked_ioctl(struct block_device *bdev, fmode_t mode, unsigned int
> >                                           (struct floppy_struct **)&outparam);
> >                 if (ret)
> >                         return ret;
> > +               memcpy(&inparam.g, outparam, offsetof(struct floppy_struct, name));
> > +               outparam = &inparam.g;
> >                 break;
> >         case FDMSGON:
> >                 UDP->flags |= FTD_MSG;
> > --
> > 2.17.0
> >
> 
> 
> 
> -- 
> Kees Cook
> Pixel Security
