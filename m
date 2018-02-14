Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162759AbeBNTLe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 14:11:34 -0500
Received: from mail-qt0-f171.google.com ([209.85.216.171]:46166 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162665AbeBNTLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 14:11:31 -0500
X-Google-Smtp-Source: AH8x224zynYt1v7myroGArFomGLqArCk4jrEpGsgeYRnOGUq08rKZ0iSDK9doGxMaFVC2dbFX1UOdg==
Date: Wed, 14 Feb 2018 11:11:25 -0800
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Rajendra Nayak <rnayak@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Stephen Boyd <sboyd@codeaurora.org>, evgreen@chromium.org
Subject: Re: [PATCH v3 3/3] arm64: dts: sdm845: Add serial console support
Message-ID: <20180214191125.GD93895@bjorns-mbp-2.lan>
References: <20180212062832.2791-1-rnayak@codeaurora.org>
 <20180212062832.2791-4-rnayak@codeaurora.org>
 <CAD=FV=UXrmpsK3k+8yZCqVi6S+c_3icPUViDST+shnrQW1A6EA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=UXrmpsK3k+8yZCqVi6S+c_3icPUViDST+shnrQW1A6EA@mail.gmail.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 13 Feb 16:32 PST 2018, Doug Anderson wrote:
> On Sun, Feb 11, 2018 at 10:28 PM, Rajendra Nayak <rnayak@codeaurora.org> wrote:
[..]
> > +&soc {
> > +       geni-se@ac0000 {
> > +               serial@a84000 {
> > +                       status = "okay";
> > +               };
> > +       };
> 
> If others at QC have already decided that they like the style above
> then it's OK with me, but I'd prefer instead (at the top level):
> 
> &qup_uart2 {
>   status = "okay";
> };
> 
> ...then you don't need to replicate all the hierarchy.
> 
> > +       pinctrl@3400000 {
> 
> Similar here.  This could be:
> 
> &qup_uart2_default {
>   pinconf {
>     ...
>   }
> };
> 
> If you're upset about things being in a "random" order at the top
> level, you can still create commented sections in the "dts" file to
> organize things, but the above means that you don't end up tabbed in
> several levels of indentation for no reason.
> 

I prefer using the hierarchy to describe the relationship between
sibling nodes, in favour of using comments and code review to keep
things in order.

This also mean that nodes that are not references by other parts of the
tree does not need a label.

That said, I've promised to write some patches to convert the prior
platforms to this structure, so let's see how that turns out in
practice - although it's still just an indication of what a fully
described board would look like.

> 
> > +               qup-uart2-default {
> > +                       pinconf {
> > +                               pins = "gpio4", "gpio5";
> > +                               drive-strength = <2>;
> > +                               bias-disable;
> 
> Possibly you'd want some sort of pull on the "receive" pin unless
> you're guaranteed that on this board that the other side will always
> be driving the pin.  As far as I can tell this UART goes to a debug
> connector.  If that debug connector is not populated this pin will be
> floating, no?
> 

The rx pin is typically bias-pull-up and tx bias-disable, so I would
expect the same.

[..]
> > +
> > +               qup_1: geni-se@ac0000 {
> 
> Color me confused.  So you're saying here that this is "qup_1".
> ...but above you turn the pinmux for pins "GPIO4" and "GPIO5" to
> "qup9", right?  So UART2 is on "qup 1" and "qup 9"?
> 
> ...OK, so I stared at manuals a bunch more, and _maybe_ I get it.
> Maybe there are 3 "QUP v3 modules" each of which handles up to 8
> "QUP"s.  So QUP 9 is on "QUP module 1", is that right?  If everyone
> understands this already and it's just me that's confused then I guess
> you can just ignore this comment.  However, if you can think of any
> better alias than "qup_1" that makes this less confusing then that
> would make me extra happy.  Like maybe "qupv3_id_1" to match the
> manual?

This is indeed a source of confusion, in particular since there tend to
be different numbering depending on what part of the puzzle you look at.
But you're right that each QUP has a number of engines, each one being a
UART/I2C/SPI controller.

I don't see a reason for labeling this particular node though, aliases
references individual engines, not the wrapper.

Regards,
Bjorn
