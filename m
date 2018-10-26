Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A5BECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 20:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 943CD2085B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 20:54:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 943CD2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbeJ0FdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 01:33:08 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:62597 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725947AbeJ0FdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 01:33:07 -0400
X-IronPort-AV: E=Sophos;i="5.54,429,1534802400"; 
   d="scan'208";a="353046059"
Received: from 89-157-201-244.rev.numericable.fr (HELO hadrien) ([89.157.201.244])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Oct 2018 22:54:34 +0200
Date:   Fri, 26 Oct 2018 22:54:34 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Sasha Levin <sashal@kernel.org>
cc:     Shayenne da Luz Moura <shayenneluzmoura@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Michael Thayer <michael.thayer@oracle.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, joe@perches.com
Subject: Re: [Outreachy kernel] [RESEND PATCH 2/2] staging: vboxvideo: Use
 unsigned int instead bool
In-Reply-To: <20181026204225.GH2015@sasha-vm>
Message-ID: <alpine.DEB.2.21.1810262252550.2791@hadrien>
References: <cover.1540580493.git.shayenneluzmoura@gmail.com> <211701e4ae42acd95afb24713314bce5a4c58ecf.1540580493.git.shayenneluzmoura@gmail.com> <20181026204225.GH2015@sasha-vm>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Adding Joe Perches]

On Fri, 26 Oct 2018, Sasha Levin wrote:

> On Fri, Oct 26, 2018 at 04:04:45PM -0300, Shayenne da Luz Moura wrote:
> > This change was suggested by checkpath.pl. Use unsigned int with bitfield
> > allocate only one bit to the boolean variable.
> >
> > CHECK: Avoid using bool structure members because of possible alignment
> > issues
> >
> > Signed-off-by: Shayenne da Luz Moura <shayenneluzmoura@gmail.com>
> > ---
> > drivers/staging/vboxvideo/vbox_drv.h        | 14 +++++++-------
> > drivers/staging/vboxvideo/vboxvideo_guest.h |  2 +-
> > 2 files changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/staging/vboxvideo/vbox_drv.h
> > b/drivers/staging/vboxvideo/vbox_drv.h
> > index 594f84272957..7d3e329a6b1c 100644
> > --- a/drivers/staging/vboxvideo/vbox_drv.h
> > +++ b/drivers/staging/vboxvideo/vbox_drv.h
> > @@ -81,7 +81,7 @@ struct vbox_private {
> > 	u8 __iomem *vbva_buffers;
> > 	struct gen_pool *guest_pool;
> > 	struct vbva_buf_ctx *vbva_info;
> > -	bool any_pitch;
> > +	unsigned int any_pitch:1;
> > 	u32 num_crtcs;
> > 	/** Amount of available VRAM, including space used for buffers. */
> > 	u32 full_vram_size;
>
> Using bitfields for booleans in these cases is less efficient than just
> using "regular" booleans for two reasons:
>
> 1. It will use the same amount of space. Due to alignment requirements,
> the compiler can't squeeze in anything into the 7 bits that are now
> "free". Each member, unless it's another bitfield, must start at a whole
> byte.
>
> 2. This is actually less efficient (slower) for the compiler to work
> with. The smallest granularity we have to access memory is 1 byte; we
> can't set individual bits directly in memory. For the original code, the
> assembly for 'vbox_private.any_pitch = true' would look something like
> this:
>
> 	movl   $0x1,-0x10(%rsp)
>
> As you can see, the compiler can directly write into the variable.
> However, when we switch to using bitfields, the compiler must preserve
> the original value of the other 7 bits, so it must first read them from
> memory, manipulate the value and write it back. The assembly would
> look something like this:
>
> 	movzbl -0x10(%rsp),%eax
> 	or     $0x1,%eax
> 	mov    %al,-0x10(%rsp)
>
> Which is less efficient than what was previously happening.

Maybe checkpatch could be more precise about what kind of bools should be
changed?

julia
