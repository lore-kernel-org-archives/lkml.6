Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935257AbeB1WEh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 17:04:37 -0500
Received: from muru.com ([72.249.23.125]:58796 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935105AbeB1WEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 17:04:36 -0500
Date: Wed, 28 Feb 2018 14:04:33 -0800
From: Tony Lindgren <tony@atomide.com>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Guo Zeng <Guo.Zeng@csr.com>, Barry Song <Baohua.Song@csr.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH] regmap: irq: fix ack-invert
Message-ID: <20180228220433.GJ5448@atomide.com>
References: <1519747558-17257-1-git-send-email-tharvey@gateworks.com>
 <20180227183908.GF5448@atomide.com>
 <CAJ+vNU2d-KKMHvb2bJt-b_9h7c2YM1NJS4PYYi7Y=YzT-VQJNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ+vNU2d-KKMHvb2bJt-b_9h7c2YM1NJS4PYYi7Y=YzT-VQJNg@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Tim Harvey <tharvey@gateworks.com> [180228 21:18]:
> On Tue, Feb 27, 2018 at 10:39 AM, Tony Lindgren <tony@atomide.com> wrote:
> > * Tim Harvey <tharvey@gateworks.com> [180227 16:07]:
> >> When acking irqs we need to take into account the ack-invert case. Without
> >> this chips that require 0's to ACK interrupts will never clear the interrupt.
> >>
> >> I am working on an mfd driver that will use ack-invert and discovered
> >> this issue. The only user of ack_invert currently appears to be the
> >> motorola-cpcap driver. I'm not clear why that driver doesn't appear affected
> >> so I'm cc'ing those involved with that driver for review and testing.
> >
> > I gave this a quick try and it fails with cpcap. So yeah, you're right,
> > it seems we still have the cpcap config wrong.
> >
> 
> Tony,
> 
> So you would agree with my findings/patch right? I certainly don't
> want to break regmap-irq in general :)

Yes I agree that it breaks now things for me, so if it works for you
it seems we're good to go. But I don't want to ack it yet as I'm
worried that it gets applied without the cpcap changes which would
break things :)

> Adding Guo Zeng and Barry Song to the thread as they were the authors
> of the ack_invert feature (a650fdd9427f1f5236f83d2d8137bea9b452fa53)
> and I'm not clear what happened to the chip they were needing it for.
> 
> > Things do work with the following patch and your patch for cpcap. So
> > they should both be applied together as a single patch.
> >
> > Care to fold in the following change and then repost your patch?
> >
> > Otherwise we might end up breaking things easily for booting or
> > bisect or stable. Or else the patch below needs to be applied first
> > to avoid breaking things.
> >
> 
> So cpcap needs to write 1's to clear irq's not 0's right?

Correct. And I tried to follow what the Motorola kernel tree
was doing to configure things but got the configuration wrong
but it worked so I never had a reason to doubt it before your
patch.

> Yes, I can certainly roll in the fix for cpcap if everyone agrees
> that's the right move.

OK thanks.

> I'll wait for some feedback from Mark Brown as well.

OK

Tony
