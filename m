Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753921AbeE3Qmz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 12:42:55 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:43103 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932142AbeE3Ql6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 12:41:58 -0400
X-Google-Smtp-Source: ADUXVKKdSVP5sVBKCl7RhoJakqjCbeTgz/JWMFFNI7VGW29iZnlyQEGD7tncRx42R7fqa2iYUCvlOfxIQnJsZMvBE2s=
MIME-Version: 1.0
In-Reply-To: <20180530163644.GW6920@sirena.org.uk>
References: <20180530093701.GD6920@sirena.org.uk> <CAD=FV=W-MLU9c-SvfLgKAKGP1eHN5xO-013f2M09XUa+QeHzrA@mail.gmail.com>
 <20180530150241.GO6920@sirena.org.uk> <CAD=FV=XJd-udEE6az0xP7i6x0oGsnd=BSCyZ0Og_+RjNCMXnCQ@mail.gmail.com>
 <20180530154849.GQ6920@sirena.org.uk> <CAD=FV=X2u=hMyWinSDtim-PmFwAy5mXcwg3HeYojAHcsUFhV3g@mail.gmail.com>
 <20180530160744.GS6920@sirena.org.uk> <CAD=FV=WVGu0f+=q-C9kiEmaLEUJqGY+Jbns83h72uF-9iasrUw@mail.gmail.com>
 <20180530161311.GT6920@sirena.org.uk> <CAD=FV=UpWEMSPUYOHmLQ0g_mF990kwn4_zm=ZCNttLKZiz7i=Q@mail.gmail.com>
 <20180530163644.GW6920@sirena.org.uk>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 30 May 2018 09:41:55 -0700
X-Google-Sender-Auth: 46KqakbkYK-6UlKdR-5C6gGm3f8
Message-ID: <CAD=FV=V1gGccKr1mHM0zx_-FFdLU1vrzUChwx6KTUyTGzj39Tw@mail.gmail.com>
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

On Wed, May 30, 2018 at 9:36 AM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, May 30, 2018 at 09:31:55AM -0700, Doug Anderson wrote:
>> On Wed, May 30, 2018 at 9:13 AM, Mark Brown <broonie@kernel.org> wrote:
>
>> > If we're just going to use the most recently set voltage then hopefully
>> > the hardware already knew that, and it might not be the lowest available
>> > voltage if the last consumer to get turned off was holding the voltage
>> > higher.
>
>> To circle back to the original point: the problem is that (IMHO) the
>> hardware is doing the wrong thing by still counting Linux's vote for a
>> voltage even though Linux also voted that the regulator should be
>> disabled.  So basically we're working around the hardware by
>> pretending to vote for a dummy lower voltage whenever Linux wants the
>> regulator disabled.  From Linux's point of view everything works as
>> normal--we just tell the hardware a falsehood so it doesn't count our
>> vote for a voltage while the regulator is disabled.
>
> Yeah, and I don't think that's unreasonable for the core to do - just
> drop the voltage to the constraint minimum after it has turned off the
> regulator, then recheck and raise if needed before it enables again.

Would it do this for all regulators, though?  Most regulators are
hooked up over a slow i2c bus, so that means that every regulator
disable would now do an extra i2c transfer even though for all
regulators (other than RPMh) the voltage of a regulator doesn't matter
when it's been "disabled' (from Linux's point of view).

Hrmmm, I suppose maybe it'd be OK though because for most regulators
we'd use "regcache" and most regulators that we enabled/disable a lot
are not expected to change voltage in Linux (so the regcache write
would hopefully be a noop), so maybe it wouldn't be _that_
inefficient...

-Doug
