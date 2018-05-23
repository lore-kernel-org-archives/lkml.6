Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754667AbeEWPue (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 11:50:34 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:42606 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754618AbeEWPuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 11:50:24 -0400
X-Google-Smtp-Source: AB8JxZqb9BSDBunQSAFmbSTULPPwha/2L51qU7B/Xb+W2SqyED+YQv7/O4izilM2aRx6qfH/l46vwIuaINlIB9yer50=
MIME-Version: 1.0
In-Reply-To: <20180523154057.GL4828@sirena.org.uk>
References: <869aad59-1cc5-28ef-1fb5-4ef846696c40@codeaurora.org>
 <CAD=FV=U-QOQekUHj=ck57YJbTFdFjCAWr4t2A92x+fCNf+yV9A@mail.gmail.com>
 <dc1fbe9c-8973-1c4d-0fbd-809c1ec0a6be@codeaurora.org> <CAD=FV=XfSGs14VB464cvMGDNwGS4yvSXjN8itZLffm+Sj-D=ww@mail.gmail.com>
 <fb390ccb-927a-8449-05c3-8dcac964bfae@codeaurora.org> <CAD=FV=XARtQNo5Cyg78XuT26JUFgn=7BjWRnXPjP566=a-sF1w@mail.gmail.com>
 <a106c337-0713-e5d6-cb40-13e05f4d361d@codeaurora.org> <CAD=FV=W=BquL5ojORz4HNP889s=-uNJ-QEzUfAxwXj2Oa3cGew@mail.gmail.com>
 <20180523082908.GB4828@sirena.org.uk> <CAD=FV=XfPkpGD32MfTfcw02wQ+QetpUhY=P299uhpX6pY_iEvg@mail.gmail.com>
 <20180523154057.GL4828@sirena.org.uk>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 23 May 2018 08:50:22 -0700
X-Google-Sender-Auth: Vrcd4dCnFhmS1S8povlhXNc6r38
Message-ID: <CAD=FV=XWVOdJ8rWJnBTwoNqnYqYRYjknkZtUvT86+skbrTdwig@mail.gmail.com>
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

On Wed, May 23, 2018 at 8:40 AM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, May 23, 2018 at 08:23:22AM -0700, Doug Anderson wrote:
>> Hi,
>>
>> On Wed, May 23, 2018 at 1:29 AM, Mark Brown <broonie@kernel.org> wrote:
>>
>> > It's arguable either way - you could say that the client gets to specify
>> > a safe range at all times or you could say that the machine constraints
>> > should cover all cases where the hardware is idling.  Of course RPMh
>> > is missing anything like the machine constraints (as we can see from all
>> > the fixing up of undesirable hard coding we have to do) so it's kind of
>> > pushed towards the first case.
>
>> OK, fair enough.  If others all agree that it's OK to make requests
>> about the voltage of a disabled regulator then I won't stand in the
>> way.  I guess it does call into question the whole idea of caching /
>> not sending the voltage until the first enable because it means
>> there's no way for the client to use this feature until they've
>> enabled / disabled the regulator once.  If you think of it as invalid
>> to adjust the voltage of a disabled regulator then the caching
>> argument is super clean, but once you say that you should normally be
>
> It's got to be valid to think about the voltage of a disabled regulator
> since drivers want to be able make sure that the regulator gets enabled
> with a sensible config.  With most hardware this is really easy since
> you can just look at the status reported by the hardware but the RPM
> makes this hard since there's so much write only stuff in there.

I should be more clear.  Certainly it should be valid to set the
voltage before enabling it so, as you said, the regulator turns on at
the right voltage.  I'm saying that it's weird (to me) to expect that
setting the voltage for a regulator that a client thinks is disabled
will affect any real voltages in the system until the regulator is
enabled.  In RPMh apparently setting a voltage of a regulator you
think is disabled can affect the regulator output if another client
(unbeknownst to you) happens to have it enabled.
