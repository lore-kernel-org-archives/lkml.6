Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751686AbeC0Sr3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 14:47:29 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:40688 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751196AbeC0Sr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 14:47:26 -0400
X-Google-Smtp-Source: AIpwx4+I6oPqXVBJI42tH3NJiO/4B8PP2f6w7mbrlpY+6mY2k5l/32fponXwSLmIZ5rG00cU/f2cgQ==
Date: Tue, 27 Mar 2018 11:47:22 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Thierry Escande <thierry.escande@linaro.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        Rob Herring <robh+dt@kernel.org>, Andy Gross <andy.gross@linaro.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] dt-bindings: net: bluetooth: Add
 qualcomm-bluetooth
Message-ID: <20180327184722.GB18510@minitux>
References: <20180320032331.29865-1-thierry.escande@linaro.org>
 <20180320032331.29865-3-thierry.escande@linaro.org>
 <FAC61078-6298-47A7-A51C-73D72BEF6E4A@holtmann.org>
 <20180326225106.GC1403@tuxbook-pro>
 <2e0db4b4-80cc-9a5b-9e0a-812f1bc9fbcf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e0db4b4-80cc-9a5b-9e0a-812f1bc9fbcf@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 27 Mar 08:56 PDT 2018, Thierry Escande wrote:

> Hi Bjorn,
> 
> On 27/03/2018 00:51, Bjorn Andersson wrote:
> > On Tue 20 Mar 23:58 HKT 2018, Marcel Holtmann wrote:
> > > > Signed-off-by: Thierry Escande <thierry.escande@linaro.org>
> > [..]
> > > > + - clocks: clock phandle for SUSCLK_32KHZ
> > > 
> > > if I compare this with broadcom-bluetooth.txt or ti-bluetooth.txt then
> > > besides compatible, everything else is optional. The
> > > nokia-bluetooth.txt has everything required, but that is also a really
> > > specific platform.
> > > 
> > > Can we be less restrictive for a QCA general purpose chip?
> > > 
> > 
> > The way we deal with this in other bindings is that we tie such
> > requirements to the compatible; i.e. we would say that qcom,qca6174-bt
> > requires a clock and we would have something like qcom,qca-bt that makes
> > it optional.
> > 
> > The beauty of this is that the driver will tell you if you forgot to
> > specify the clock when it actually is required, which saves you
> > considerable amount of debugging time.
> > 
> > 
> > NB. The way the bcm driver handles this is insufficient, as it treats
> > any error from clk_get as "there's no clock specified". The driver
> > should accept a clock not being specified, but should fail properly when
> > a clock is specified but can't be acquired (e.g. due to clk_get()
> > returning EPROBE_DEFER).
> > 
> > > > +
> > > > +Example:
> > > > +
> > > > +serial@7570000 {
> > > > +	pinctrl-names = "default", "sleep";
> > > > +	pinctrl-0 = <&blsp1_uart1_default>;
> > > > +	pinctrl-1 = <&blsp1_uart1_sleep>;
> > > > +
> > > > +	bluetooth {
> > > > +		compatible = "qcom,qca6174-bt";
> > > > +
> > > > +		enable-gpios = <&pm8994_gpios 19 GPIO_ACTIVE_HIGH>;
> > > > +
> > > > +		pinctrl-names = "default";
> > > > +		pinctrl-0 = <&bt_en_pin_a>;
> > > 
> > > This one I do not understand and you might want to shed some light
> > > into why this is done that way.
> > > 
> > 
> > This is completely generic and only relates to getting the electrical
> > properties of the gpio pin set up correctly. So I would recommend that
> > we omit this from the binding and example (including the pinctrl
> > properties for the serial above).
> 
> If I remove the pinctrl entry in the bluetooth node, the gpio19 is then
> marked as unclaimed. The drive strength also defaults to low but that
> doesn't seem to be an issue and the the chip can still be enabled through
> gpio19. Is it ok to have it unclaimed? If so I can remove it from the
> binding and the doc then.
> 
> Regarding the blsp1_uart1_default of the serial node, I can still enable the
> chip if I remove it but the hci commands all end in timeout. It seems that
> the function for these pins has to be explicitly set to blsp_uart2. So at
> least, the default pinctrl seems mandatory.
> 

Our board needs these properties to get the uart and gpio in the right
state, but this is unrelated to BT - that's why I suggested that you
omit these properties from the BT binding.

Regards,
Bjorn
