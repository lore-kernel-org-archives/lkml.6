Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA327C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9668E20841
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:28:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9668E20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbeJHUkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 16:40:35 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45707 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbeJHUkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 16:40:35 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1g9Vab-0005V7-Ai; Mon, 08 Oct 2018 15:28:49 +0200
Message-ID: <1539005329.11512.26.camel@pengutronix.de>
Subject: Re: [PATCH] reset: Fix potential use-after-free in
 __of_reset_control_get()
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Date:   Mon, 08 Oct 2018 15:28:49 +0200
In-Reply-To: <CAMuHMdU_ECQxxD1HK5bq5QY7QnxzaBKSJsZFw+284oSnJfSFAA@mail.gmail.com>
References: <20181008111435.25994-1-geert+renesas@glider.be>
         <1539003375.11512.19.camel@pengutronix.de>
         <CAMuHMdU_ECQxxD1HK5bq5QY7QnxzaBKSJsZFw+284oSnJfSFAA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-10-08 at 15:12 +0200, Geert Uytterhoeven wrote:
> Hi Philipp,
> 
> On Mon, Oct 8, 2018 at 2:56 PM Philipp Zabel <p.zabel@pengutronix.de> wrote:
> > On Mon, 2018-10-08 at 13:14 +0200, Geert Uytterhoeven wrote:
> > > Calling of_node_put() decreases the reference count of a device tree
> > > object, and may free some data.
> > > 
> > > However, the of_phandle_args structure embedding it is passed to
> > > reset_controller_dev.of_xlate() after that, so it may still be accessed.
> > > 
> > > Move the call to of_node_put() down to fix this.
> > > 
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > ---
> > >  drivers/reset/core.c | 15 ++++++++-------
> > >  1 file changed, 8 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> > > index 225e34c56b94a2e3..bc9df10d31b4bae1 100644
> > > --- a/drivers/reset/core.c
> > > +++ b/drivers/reset/core.c
> > > @@ -496,27 +496,28 @@ struct reset_control *__of_reset_control_get(struct device_node *node,
[...]
> > >       /* reset_list_mutex also protects the rcdev's reset_control list */
> > >       rstc = __reset_control_get_internal(rcdev, rstc_id, shared);
> > > 
> > > +out:
> > > +     of_node_put(args.np);
> > >       mutex_unlock(&reset_list_mutex);
> > 
> > Thank you for the patch. I'd like to move of_node_put after mutex_unlock
> > for symmetry. If you agree, I can switch the two when applying.
> 
> No objection, thanks!

Applied to reset/next with that change.

regards
Philipp
