Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4078C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 706A220C0D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:18:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 706A220C0D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732520AbeGKJWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 05:22:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54730 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726398AbeGKJWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 05:22:12 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 21C97CCC;
        Wed, 11 Jul 2018 09:18:50 +0000 (UTC)
Date:   Wed, 11 Jul 2018 11:18:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nicolas Pitre <nicolas.pitre@linaro.org>,
        Dave Mielke <Dave@mielke.cc>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Adam Borowski <kilobyte@angband.pl>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-console@vger.kernel.org
Subject: Re: [PATCH v3 1/3] vt: preserve unicode values corresponding to
 screen characters
Message-ID: <20180711091848.GA2889@kroah.com>
References: <20180627035642.8561-1-nicolas.pitre@linaro.org>
 <20180627035642.8561-2-nicolas.pitre@linaro.org>
 <CAGXu5j+KLvJ-n_QRrfq15E8iO_rqfpp+K7PDAZHZMHcemy9y7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5j+KLvJ-n_QRrfq15E8iO_rqfpp+K7PDAZHZMHcemy9y7g@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 05:52:01PM -0700, Kees Cook wrote:
> On Tue, Jun 26, 2018 at 8:56 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> > The vt code translates UTF-8 strings into glyph index values and stores
> > those glyph values directly in the screen buffer. Because there can only
> > be at most 512 glyphs, it is impossible to represent most unicode
> > characters, in which case a default glyph (often '?') is displayed
> > instead. The original unicode value is then lost.
> >
> > This patch implements the basic screen buffer handling to preserve unicode
> > values alongside corresponding display glyphs.  It is not activated by
> > default, meaning that people not relying on that functionality won't get
> > the implied overhead.
> >
> > Signed-off-by: Nicolas Pitre <nico@linaro.org>
> > Tested-by: Dave Mielke <Dave@mielke.cc>
> > Acked-by: Adam Borowski <kilobyte@angband.pl>
> > ---
> >  drivers/tty/vt/vt.c            | 220 +++++++++++++++++++++++++++++++--
> >  include/linux/console_struct.h |   2 +
> >  2 files changed, 211 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> > index 1eb1a376a0..7b636638b3 100644
> > --- a/drivers/tty/vt/vt.c
> > +++ b/drivers/tty/vt/vt.c
> > [...]
> > +static void vc_uniscr_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
> > +                            enum con_scroll dir, unsigned int nr)
> > +{
> > +       struct uni_screen *uniscr = get_vc_uniscr(vc);
> > +
> > +       if (uniscr) {
> > +               unsigned int s, d, rescue, clear;
> > +               char32_t *save[nr];
> 
> Can you adjust this to avoid the VLA here? I've almost gotten all VLAs
> removed from the kernel[1], and this is introducing a new one. :)

This is already in my tree, sorry :(

greg k-h
