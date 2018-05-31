Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932570AbeEaAes (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 20:34:48 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:34916 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932495AbeEaAep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 20:34:45 -0400
X-Google-Smtp-Source: ADUXVKLL998R8gn3QclUHUhy9qWbeQoKR08//P0SxZvHr/bq04th2z69buc0afP5T6G1q2zkNYi1L9disaW6Q1W6j+E=
MIME-Version: 1.0
In-Reply-To: <75088820-f20d-32ac-780a-5e7dacdf20ff@codeaurora.org>
References: <cover.1527040878.git.collinsd@codeaurora.org> <6d03576cf90f06afb1194301cb41fc31704def1d.1527040878.git.collinsd@codeaurora.org>
 <CAD=FV=VH0bTxPOmRr+jUyV0cGNQHLcwQTV9L-t0bxZOqD8FnHA@mail.gmail.com>
 <20180530103720.GH6920@sirena.org.uk> <CAD=FV=WTTKXwPchuWRh-RNTc8=X8Xo28oTqk=3wW4+SiTHhxuA@mail.gmail.com>
 <20180530155044.GR6920@sirena.org.uk> <CAD=FV=WVUmvPPd5BxXv9Sa_2CRPrrjQvYFyqroY-3fRr4f0Bzg@mail.gmail.com>
 <20180530162007.GU6920@sirena.org.uk> <CAD=FV=WL9enzYCoSx0fT_ny40ciLJU-hhS9joJ6nySXvWPqAxQ@mail.gmail.com>
 <75088820-f20d-32ac-780a-5e7dacdf20ff@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 30 May 2018 17:34:43 -0700
X-Google-Sender-Auth: KYtlvtIiAVWBCPObs3GX_1y4ekg
Message-ID: <CAD=FV=VNVE5ttNg+7xmgh-p1sFbCxCY1DJiri0JtHFax+zVsnA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] regulator: dt-bindings: add QCOM RPMh regulator bindings
To: David Collins <collinsd@codeaurora.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 30, 2018 at 4:39 PM, David Collins <collinsd@codeaurora.org> wrote:
> Consider the case of a regulator with physical 10 mA LPM max current. Say
> that modem and application processors each have a load on the regulator
> that draws 9 mA. If they each respect the 10 mA limit, then they'd each
> vote for LPM. The VRM block in RPMh hardware will aggregate these requests
> together using a max function which will result in the regulator being set
> to LPM, even though the total load is 18 mA (which would require high
> power mode (HPM)). To get around this corner case, a LPM max current of 1
> uA can be used for all LDO supplies that have non-application processor
> consumers. Thus, any non-zero regulator_set_load() current request will
> result in setting the regulator to HPM (which is always safe).

Is there any plan to change the way this works for future versions of RPMh?


> The second situation that needs board-level DRMS mode and current limit
> specification is SMPS regulator AUTO mode to PWM (HPM) mode switching.
> SMPS regulators should theoretically always be able to operate in AUTO
> mode as it switches automatically between PWM mode (which can provide the
> maximum current) and PFM mode (which supports lower current but has higher
> efficiency). However, there may be board/system issues that require
> switching to PWM mode for certain use cases as it has better load
> regulation (i.e. no PFM ripple for lower loads) and supports more
> aggressive load current steps (i.e. greater A/ns).
>
> If a Linux consumer requires the ability to force a given SMPS regulator
> from AUTO mode into PWM mode and that SMPS is shared by other Linux
> consumers (which may be the case, but at least must be guaranteed to work
> architecturally), then regulator_set_load() is the only option since it
> provides aggregation, where as regulator_set_mode() does not.
> regulator_set_load() can be utilized in this case by specifying AUTO mode
> and PWM mode as drms modes and specifying some particular AUTO mode
> maximum current (that is known by the consumer) in device tree.  The
> consumer can then call regulator_set_load() with the imposed AUTO mode
> limit + delta when PWM mode is required and a lower value when AUTO mode
> is sufficient.

Mark: I'm leaving this firmly in your hands.  I can see David's points
here.  I could even believe that some of this stuff could be board
specific where one board might have slightly different capacitors or
they might be placed differently and might need a higher power mode to
keep the signal clean.

-Doug
