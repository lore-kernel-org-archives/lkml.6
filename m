Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755971AbeEaSeK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 14:34:10 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:42633 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755900AbeEaSeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 14:34:06 -0400
X-Google-Smtp-Source: ADUXVKIIQ7Osg1+2priXK6iu4l6eCAL6Likn9fDRxXvzAfCDFibHsMrLeZNEoCdhF+fQoHHdP28P4g==
Date: Thu, 31 May 2018 11:34:04 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Rob Herring <robh@kernel.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH 10/11] dt-bindings: misc: add bindings for throttler
Message-ID: <20180531183404.GB88063@google.com>
References: <20180525203043.249193-1-mka@chromium.org>
 <20180525203043.249193-11-mka@chromium.org>
 <20180531163159.GA4369@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180531163159.GA4369@rob-hp-laptop>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Thu, May 31, 2018 at 11:31:59AM -0500, Rob Herring wrote:
> On Fri, May 25, 2018 at 01:30:42PM -0700, Matthias Kaehlcke wrote:
> 
> Commit msg?

Will add some more info in the next revision.

> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >  .../devicetree/bindings/misc/throttler.txt    | 41 +++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/misc/throttler.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/misc/throttler.txt b/Documentation/devicetree/bindings/misc/throttler.txt
> > new file mode 100644
> > index 000000000000..92f13e94451a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/misc/throttler.txt
> > @@ -0,0 +1,41 @@
> > +Throttler driver
> > +
> > +The Throttler is used for non-thermal throttling of system components like
> > +CPUs or devfreq devices.
> 
> This all looks very Linux specific and not a h/w device. Perhaps you can 
> add hint properties to OPP tables as to what entries can be used for 
> throttling, but otherwise this doesn't belong in DT.

My idea is to allow multiple throttlers, which might operate on
different throttling devices or use different OPPs for the same
device. To support this a simple boolean hint that the OPP can be used
for throttling would not be sufficient.

What should work is a property with an array of phandles of the
throttlers that use a given OPP.

AFAIK it is currently not possible to enumerate the devfreq devices in
the system, so besides the info in the OPPs the throttler itself would
still need a phandle to the devfreq device(s) it uses.

I envision something like this:

gpu_opp_table: opp-table2 {
  compatible = "operating-points-v2";

  opp00 {
    opp-hz = /bits/ 64 <200000000>;
    opp-microvolt = <800000>;
  };
  opp01 {
    opp-hz = /bits/ 64 <297000000>;
    opp-microvolt = <800000>;
    opp-throttlers = <&cros_ec_throttler>;
  };
  ...
};

cros_ec_throttler: cros-ec-throttler {
  compatible = "google,cros-ec-throttler";

  devfreq-devices = <&gpu>;
};

Would this be acceptable?

Thanks

Matthias
