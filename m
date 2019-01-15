Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 170A1C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D441220656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389894AbfAOUfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 15:35:25 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:35967 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729067AbfAOUfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 15:35:25 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id x0FKZ3g2007201;
        Tue, 15 Jan 2019 21:35:03 +0100
Date:   Tue, 15 Jan 2019 21:35:03 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Silvio Cesare <silvio.cesare@gmail.com>,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will.deacon@arm.com>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH 2/8] libertas: change snprintf to scnprintf for possible
 overflow
Message-ID: <20190115203503.GA7117@1wt.eu>
References: <20190112152844.26550-1-w@1wt.eu>
 <20190112152844.26550-2-w@1wt.eu>
 <878szma2hz.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878szma2hz.fsf@codeaurora.org>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 07:55:36AM +0200, Kalle Valo wrote:
> Willy Tarreau <w@1wt.eu> writes:
> 
> > From: Silvio Cesare <silvio.cesare@gmail.com>
> >
> > Change snprintf to scnprintf. There are generally two cases where using
> > snprintf causes problems.
> >
> > 1) Uses of size += snprintf(buf, SIZE - size, fmt, ...)
> > In this case, if snprintf would have written more characters than what the
> > buffer size (SIZE) is, then size will end up larger than SIZE. In later
> > uses of snprintf, SIZE - size will result in a negative number, leading
> > to problems. Note that size might already be too large by using
> > size = snprintf before the code reaches a case of size += snprintf.
> >
> > 2) If size is ultimately used as a length parameter for a copy back to user
> > space, then it will potentially allow for a buffer overflow and information
> > disclosure when size is greater than SIZE. When the size is used to index
> > the buffer directly, we can have memory corruption. This also means when
> > size = snprintf... is used, it may also cause problems since size may become
> > large.  Copying to userspace is mitigated by the HARDENED_USERCOPY kernel
> > configuration.
> >
> > The solution to these issues is to use scnprintf which returns the number of
> > characters actually written to the buffer, so the size variable will never
> > exceed SIZE.
> >
> > Signed-off-by: Silvio Cesare <silvio.cesare@gmail.com>
> > Cc: Kalle Valo <kvalo@codeaurora.org>
> > Cc: Dan Carpenter <dan.carpenter@oracle.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Greg KH <greg@kroah.com>
> > Signed-off-by: Willy Tarreau <w@1wt.eu>
> 
> I don't see any mention about which tree this should go to. Can I take
> this to wireless-drivers-next?

Possibly. It addresses a small memory disclosure issue when using debugfs,
and as such it should probably also be submitted to stable branches, so
please use the most suitable tree that doesn't add too much extra delay.

Thanks,
Willy
