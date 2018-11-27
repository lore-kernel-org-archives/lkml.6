Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9D0C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A21208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:43:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1A21208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mess.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730862AbeK0Vkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 16:40:55 -0500
Received: from gofer.mess.org ([88.97.38.141]:39103 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbeK0Vkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 16:40:55 -0500
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 9B49D60317; Tue, 27 Nov 2018 10:43:25 +0000 (GMT)
Date:   Tue, 27 Nov 2018 10:43:25 +0000
From:   Sean Young <sean@mess.org>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        viro@zeniv.linux.org.uk,
        "open list:STAGING - ATOMISP DRIVER" <linux-media@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] media: dvb: fix a missing-check bug
Message-ID: <20181127104325.x23qy6cq6ddxee57@gofer.mess.org>
References: <1539958334-11531-1-git-send-email-wang6495@umn.edu>
 <CAAa=b7ceXdaB9KcZy9ML5pcEwMjYF0ibaB_f6LuuHFe_jSuMYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAa=b7ceXdaB9KcZy9ML5pcEwMjYF0ibaB_f6LuuHFe_jSuMYQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wenwen,

On Mon, Oct 29, 2018 at 01:46:04PM -0500, Wenwen Wang wrote:
> Hello,
> 
> Can anyone confirm this bug? Thanks!
> 
> Wenwen
> 
> On Fri, Oct 19, 2018 at 9:12 AM Wenwen Wang <wang6495@umn.edu> wrote:
> >
> > In dvb_audio_write(), the first byte of the user-space buffer 'buf' is
> > firstly copied and checked to see whether this is a TS packet, which always
> > starts with 0x47 for synchronization purposes. If yes, ts_play() will be
> > called. Otherwise, dvb_aplay() will be called. In ts_play(), the content of
> > 'buf', including the first byte, is copied again from the user space.
> > However, after the copy, no check is re-enforced on the first byte of the
> > copied data.  Given that 'buf' is in the user space, a malicious user can
> > race to change the first byte after the check in dvb_audio_write() but
> > before the copy in ts_play().

Up to here your analysis makes sense.

> >  Through this way, the user can supply
> > inconsistent code, which can cause undefined behavior of the kernel and
> > introduce potential security risk.

So how can this cause undefined behaviour?

> > This patch adds a necessary check in ts_play() to make sure the first byte
> > acquired in the second copy contains the expected value. Otherwise, an
> > error code EINVAL will be returned.

So what about the other case, if dvb_play() was called due to the first
byte not being 0x47 and then swapped for 0x47?


Sean

> >
> > Signed-off-by: Wenwen Wang <wang6495@umn.edu>
> > ---
> >  drivers/media/pci/ttpci/av7110_av.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/media/pci/ttpci/av7110_av.c b/drivers/media/pci/ttpci/av7110_av.c
> > index ef1bc17..1ff6062 100644
> > --- a/drivers/media/pci/ttpci/av7110_av.c
> > +++ b/drivers/media/pci/ttpci/av7110_av.c
> > @@ -468,6 +468,8 @@ static ssize_t ts_play(struct av7110 *av7110, const char __user *buf,
> >                 }
> >                 if (copy_from_user(kb, buf, TS_SIZE))
> >                         return -EFAULT;
> > +               if (kb[0] != 0x47)
> > +                       return -EINVAL;
> >                 write_ts_to_decoder(av7110, type, kb, TS_SIZE);
> >                 todo -= TS_SIZE;
> >                 buf += TS_SIZE;
> > --
> > 2.7.4
> >
