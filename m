Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754261AbeEaUEm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 16:04:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:44194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754071AbeEaUEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 16:04:40 -0400
X-Google-Smtp-Source: ADUXVKJhIFa9pWVcfa4Kxo4I+aqOmUpGjIDgnXrGFccR94Ev6NA0DbnDdsA1L8Jw6Xi4TsHY8+5ZC3EXdm7iV27azR8=
MIME-Version: 1.0
In-Reply-To: <20180531183404.GB88063@google.com>
References: <20180525203043.249193-1-mka@chromium.org> <20180525203043.249193-11-mka@chromium.org>
 <20180531163159.GA4369@rob-hp-laptop> <20180531183404.GB88063@google.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 31 May 2018 15:04:18 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK_nFtuxhNbAn3yYueLKAxvwfnY=5M6zFdGrwwwPVrP5g@mail.gmail.com>
Message-ID: <CAL_JsqK_nFtuxhNbAn3yYueLKAxvwfnY=5M6zFdGrwwwPVrP5g@mail.gmail.com>
Subject: Re: [PATCH 10/11] dt-bindings: misc: add bindings for throttler
To: Matthias Kaehlcke <mka@chromium.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 1:34 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> Hi Rob,
>
> On Thu, May 31, 2018 at 11:31:59AM -0500, Rob Herring wrote:
>> On Fri, May 25, 2018 at 01:30:42PM -0700, Matthias Kaehlcke wrote:
>>
>> Commit msg?
>
> Will add some more info in the next revision.
>
>> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
>> > ---
>> >  .../devicetree/bindings/misc/throttler.txt    | 41 +++++++++++++++++++
>> >  1 file changed, 41 insertions(+)
>> >  create mode 100644 Documentation/devicetree/bindings/misc/throttler.txt
>> >
>> > diff --git a/Documentation/devicetree/bindings/misc/throttler.txt b/Documentation/devicetree/bindings/misc/throttler.txt
>> > new file mode 100644
>> > index 000000000000..92f13e94451a
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/misc/throttler.txt
>> > @@ -0,0 +1,41 @@
>> > +Throttler driver
>> > +
>> > +The Throttler is used for non-thermal throttling of system components like
>> > +CPUs or devfreq devices.
>>
>> This all looks very Linux specific and not a h/w device. Perhaps you can
>> add hint properties to OPP tables as to what entries can be used for
>> throttling, but otherwise this doesn't belong in DT.
>
> My idea is to allow multiple throttlers, which might operate on
> different throttling devices or use different OPPs for the same
> device. To support this a simple boolean hint that the OPP can be used
> for throttling would not be sufficient.
>
> What should work is a property with an array of phandles of the
> throttlers that use a given OPP.
>
> AFAIK it is currently not possible to enumerate the devfreq devices in
> the system, so besides the info in the OPPs the throttler itself would
> still need a phandle to the devfreq device(s) it uses.

Why don't you fix that OS problem instead of working around it in DT?

>
> I envision something like this:
>
> gpu_opp_table: opp-table2 {
>   compatible = "operating-points-v2";
>
>   opp00 {
>     opp-hz = /bits/ 64 <200000000>;
>     opp-microvolt = <800000>;
>   };
>   opp01 {
>     opp-hz = /bits/ 64 <297000000>;
>     opp-microvolt = <800000>;
>     opp-throttlers = <&cros_ec_throttler>;
>   };
>   ...
> };
>
> cros_ec_throttler: cros-ec-throttler {
>   compatible = "google,cros-ec-throttler";

Is this an actual h/w device?

>
>   devfreq-devices = <&gpu>;
> };
>
> Would this be acceptable?
>
> Thanks
>
> Matthias
