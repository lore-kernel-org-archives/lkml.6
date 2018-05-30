Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935157AbeE3Fat (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 01:30:49 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:37815 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933924AbeE3Faf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 01:30:35 -0400
X-Google-Smtp-Source: ADUXVKKiK/Z9dBB2H6tU8aSz7JRxmG02K0v1jsKSdWnwoIsEr4vYBoFXDI1B3gWdihA78GiRIawvItrPpPwSrLLEz7E=
MIME-Version: 1.0
In-Reply-To: <20180523155617.GN4828@sirena.org.uk>
References: <dc1fbe9c-8973-1c4d-0fbd-809c1ec0a6be@codeaurora.org>
 <CAD=FV=XfSGs14VB464cvMGDNwGS4yvSXjN8itZLffm+Sj-D=ww@mail.gmail.com>
 <fb390ccb-927a-8449-05c3-8dcac964bfae@codeaurora.org> <CAD=FV=XARtQNo5Cyg78XuT26JUFgn=7BjWRnXPjP566=a-sF1w@mail.gmail.com>
 <a106c337-0713-e5d6-cb40-13e05f4d361d@codeaurora.org> <CAD=FV=W=BquL5ojORz4HNP889s=-uNJ-QEzUfAxwXj2Oa3cGew@mail.gmail.com>
 <20180523082908.GB4828@sirena.org.uk> <CAD=FV=XfPkpGD32MfTfcw02wQ+QetpUhY=P299uhpX6pY_iEvg@mail.gmail.com>
 <20180523154057.GL4828@sirena.org.uk> <CAD=FV=XWVOdJ8rWJnBTwoNqnYqYRYjknkZtUvT86+skbrTdwig@mail.gmail.com>
 <20180523155617.GN4828@sirena.org.uk>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 29 May 2018 22:30:33 -0700
X-Google-Sender-Auth: 2yGLt45TW1J3U7aoD5A5_4Plr2s
Message-ID: <CAD=FV=W4aDxWbcaJ9GZ1KkvyiTPAPR-oUoTFzJfS+LftU5ZP=Q@mail.gmail.com>
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

On Wed, May 23, 2018 at 8:56 AM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, May 23, 2018 at 08:50:22AM -0700, Doug Anderson wrote:
>> On Wed, May 23, 2018 at 8:40 AM, Mark Brown <broonie@kernel.org> wrote:
>
>> > It's got to be valid to think about the voltage of a disabled regulator
>> > since drivers want to be able make sure that the regulator gets enabled
>> > with a sensible config.  With most hardware this is really easy since
>> > you can just look at the status reported by the hardware but the RPM
>> > makes this hard since there's so much write only stuff in there.
>
>> I should be more clear.  Certainly it should be valid to set the
>> voltage before enabling it so, as you said, the regulator turns on at
>> the right voltage.  I'm saying that it's weird (to me) to expect that
>> setting the voltage for a regulator that a client thinks is disabled
>> will affect any real voltages in the system until the regulator is
>> enabled.  In RPMh apparently setting a voltage of a regulator you
>> think is disabled can affect the regulator output if another client
>> (unbeknownst to you) happens to have it enabled.
>
> Yes, that's definitely not what's expected but it's unfortunately what
> the firmware chose to implement so we may well be stuck with it
> unfortunately.

We're not really stuck with it if we do what I was suggesting.  I was
suggesting that every time we disable the regulator in Linux we have
Linux vote for the lowest voltage it's comfortable with.  Linux keeps
track of the true voltage that the driver wants and will always change
its vote back to that before enabling.  Thus (assuming Linux is OK
with 1.2 V - 1.4 V for a rail):

Modem: want 1.3 V and enabled.
=> Modem votes for 1.3 V
=> Modem votes for enabled.
=> At least one vote for enabled? Yes
=> Highest voltage vote: 1.3V
=> True output: 1.3V

Linux: want 1.4 V and enabled.
=> Linux votes for 1.4 V
=> Linux votes for enabled
=> At least one vote for enabled? Yes
=> Highest voltage vote: 1.4V
=> True output: 1.4V

Linux: want disabled
=> Linux votes for disabled
=> Linux votes for 1.2 V (keeps 1.4 V in local var)
=> At least one vote for enabled? Yes
=> Highest voltage vote: 1.3V
=> True output: 1.3V

Linux: want enabled
=> Linux votes for 1.4 V (from local var)
=> Linux votes for enabled
=> At least one vote for enabled? Yes
=> Highest voltage vote: 1.4V
=> True output: 1.4V


...but I'll leave it to you if you think this is a big deal.  If
you're happy with how David's driver works without my suggestion then
I won't push it.

-Doug
