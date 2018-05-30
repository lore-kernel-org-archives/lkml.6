Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935552AbeE3Fcn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 01:32:43 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:33744 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934541AbeE3Fck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 01:32:40 -0400
X-Google-Smtp-Source: ADUXVKLXNooWRvI4JHQxFwoERMd1Wi3o+2Sj/9fLyaAHKoBcps44IppdlsWyySTuCjeJwTbQxIA7934se2X57Ealli0=
MIME-Version: 1.0
In-Reply-To: <7489cd65fedb8a31488cf8188885759bcd4820ce.1527040878.git.collinsd@codeaurora.org>
References: <cover.1527040878.git.collinsd@codeaurora.org> <7489cd65fedb8a31488cf8188885759bcd4820ce.1527040878.git.collinsd@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 29 May 2018 22:32:38 -0700
X-Google-Sender-Auth: iFkzJXiXtFTnJ7VI8j0SxXBRiTE
Message-ID: <CAD=FV=WF+onhAAWrbmwcHiWyCjuZ=6vvnhodUsia=Ps-da6_4A@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] regulator: add QCOM RPMh regulator driver
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

On Tue, May 22, 2018 at 7:43 PM, David Collins <collinsd@codeaurora.org> wrote:
> + * @ever_enabled:              Boolean indicating that the regulator has been
> + *                             explicitly enabled at least once.  Voltage
> + *                             requests should be cached when this flag is not
> + *                             set.

Do you really need this extra boolean?  Can't you just check if
"enabled" is still "-EINVAL"?  If it is then you don't pass the
voltage along.

...this would mean that you'd also need to send the voltage vote when
the regulator core tries to disable unused regulators at the end of
bootup, but that should be OK right?  If we never touched a regulator
anywhere at probe time and we're about to vote to disable it, we know
there's nobody requiring it to still be on.  We can vote for the
voltage now without fear of messing up a vote that the BIOS left in
place.

In theory this should also allow you to assert your vote about the
voltage of a regulator that has never been enabled, which (if I
understand correctly) you consider to be a feature.

---

Other than that comment, everything else here looks good to go if Mark
is good with it.  As per the previous threads there are some things
that I don't like a ton, but I feel it is between you and Mark to
decide if you're good with it.  A summary of those issues are:

1. I still believe that when we disable a regulator in Linux we should
tell RPMh that we vote for the lowest voltage.  ...but if Mark is
happy with the way the driver works now I won't push it.

2. As per my comments in the bindings patch, I still believe that
"qcom,drms-mode-max-microamps" belongs in the core.  Again, up to
Mark.

3. As per my comments in the bindings patch, I still believe that
we're just adding lots of noise to the DT most of the time by
specifying both "qcom,regulator-drms-modes" and
"regulator-allowed-modes".  Again, up to Mark.


-Doug
