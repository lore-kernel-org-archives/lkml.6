Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753542AbeE3Pe5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 11:34:57 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:46479 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751547AbeE3Pex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 11:34:53 -0400
X-Google-Smtp-Source: ADUXVKIp9WfAsAFoF47LHqk2mh8fT5HXaUSeSGSQCu/NVMZheaS4YSTt+G5wIWNnsgH/QjxNj8/TdWpnof30snvRVio=
MIME-Version: 1.0
In-Reply-To: <20180530150241.GO6920@sirena.org.uk>
References: <a106c337-0713-e5d6-cb40-13e05f4d361d@codeaurora.org>
 <CAD=FV=W=BquL5ojORz4HNP889s=-uNJ-QEzUfAxwXj2Oa3cGew@mail.gmail.com>
 <20180523082908.GB4828@sirena.org.uk> <CAD=FV=XfPkpGD32MfTfcw02wQ+QetpUhY=P299uhpX6pY_iEvg@mail.gmail.com>
 <20180523154057.GL4828@sirena.org.uk> <CAD=FV=XWVOdJ8rWJnBTwoNqnYqYRYjknkZtUvT86+skbrTdwig@mail.gmail.com>
 <20180523155617.GN4828@sirena.org.uk> <CAD=FV=W4aDxWbcaJ9GZ1KkvyiTPAPR-oUoTFzJfS+LftU5ZP=Q@mail.gmail.com>
 <20180530093701.GD6920@sirena.org.uk> <CAD=FV=W-MLU9c-SvfLgKAKGP1eHN5xO-013f2M09XUa+QeHzrA@mail.gmail.com>
 <20180530150241.GO6920@sirena.org.uk>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 30 May 2018 08:34:50 -0700
X-Google-Sender-Auth: Vny9-bg1QiAogzibPECfC-W_tHA
Message-ID: <CAD=FV=XJd-udEE6az0xP7i6x0oGsnd=BSCyZ0Og_+RjNCMXnCQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] regulator: dt-bindings: add QCOM RPMh regulator bindings
To: Mark Brown <broonie@kernel.org>
Cc: David Collins <collinsd@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 30, 2018 at 8:02 AM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, May 30, 2018 at 07:46:50AM -0700, Doug Anderson wrote:
>> On Wed, May 30, 2018 at 2:37 AM, Mark Brown <broonie@kernel.org> wrote:
>
>> >> Linux vote for the lowest voltage it's comfortable with.  Linux keeps
>> >> track of the true voltage that the driver wants and will always change
>> >> its vote back to that before enabling.  Thus (assuming Linux is OK
>> >> with 1.2 V - 1.4 V for a rail):
>
>> > That's pretty much what it should do anyway with normally designed
>> > hardware.
>
>> I guess the question is: do we insist that the driver include this
>> workaround, or are we OK with letting the hardware behave as the
>> hardware does?
>
> What you're describing sounds like what we should be doing normally, if
> we're not doing that we should probably be fixing the core.

I'm not convinced that this behavior makes sense to move to the core.
On most regulators I'd expect that when the regulator driver says to
turn them off that they will output no voltage.  The reason RPMh is
special is that there's an aggregation outside of Linux.  Specifically
I like to make it concrete use the example where both Linux and "the
modem" make requests for the same regulator and RPMh aggregates these
requests.  This aggregation happens separately for "enabled" and
"voltage".

Thus if you consider:
Modem: vote for 1.3V and enabled=true
Linux: vote for 1.4V and enabled=false

The aggregated voltage is 1.4V and the aggregated enabled is true.
Said another way: Linux's vote for the voltage affected the state of
the rail even though Linux wanted the rail disabled.

In any other system when Linux disabled the regulator it wouldn't
matter that you left it set at 1.4V.  Thus RPMh is special and IMO the
workaround belongs there.


-Doug
