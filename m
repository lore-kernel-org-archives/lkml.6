Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753633AbeDJOKi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 10:10:38 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.170]:16821 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753091AbeDJOKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 10:10:36 -0400
X-RZG-AUTH: :JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw87WisNN2ETuY
X-RZG-CLASS-ID: mo00
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2 5/5] DTS: Bindings: pca953x: add example how to use interrupt-controller and gpio-controller
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20180410135749.dq3ub3kcb72e3hlr@rob-hp-laptop>
Date: Tue, 10 Apr 2018 16:10:23 +0200
Cc: galak@codeaurora.org, andy.shevchenko@gmail.com,
        Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com
Message-Id: <52F2CECC-242A-4633-A4BE-D064E53549FD@goldelico.com>
References: <cover.1522868422.git.hns@goldelico.com> <4d00318d00bf0c946ee9b83e30e38d3b7a636183.1522868423.git.hns@goldelico.com> <20180410135749.dq3ub3kcb72e3hlr@rob-hp-laptop>
To: Rob Herring <robh@kernel.org>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3AEAifh032581


> Am 10.04.2018 um 15:57 schrieb Rob Herring <robh@kernel.org>:
> 
> On Wed, Apr 04, 2018 at 09:00:24PM +0200, H. Nikolaus Schaller wrote:
>> It is not completely obvious that these are required as
>> some .dts files don't specify them.
>> 
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>> .../devicetree/bindings/gpio/gpio-pca953x.txt      | 33 ++++++++++++++++++++++
>> 1 file changed, 33 insertions(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/gpio/gpio-pca953x.txt b/Documentation/devicetree/bindings/gpio/gpio-pca953x.txt
>> index 6a7cddb187c1..7f3b50a6d681 100644
>> --- a/Documentation/devicetree/bindings/gpio/gpio-pca953x.txt
>> +++ b/Documentation/devicetree/bindings/gpio/gpio-pca953x.txt
>> @@ -36,6 +36,10 @@ Optional properties:
>>  - reset-gpios: GPIO specification for the RESET input. This is an
>> 		active low signal to the PCA953x.
>>  - vcc-supply:	power supply regulator.
>> + - gpio-controller: if used as gpio expander.
>> + - #gpio-cells: if used as gpio expander.
>> + - interrupt-controller: if to be used as interrupt expander.
>> + - #interrupt-cells: if to be used as interrupt expander.
> 
> These should be required. It's a mistake if dts files don't have them.

Well, it seems to be a config option if the chip handles interrupts
at all, but I also tend to say they are required.

> 
>> 
>> Example:
>> 
>> @@ -48,3 +52,32 @@ Example:
>> 		interrupt-parent = <&gpio3>;
>> 		interrupts = <23 IRQ_TYPE_LEVEL_LOW>;
>> 	};
>> +
>> +
>> +Example with Interrupts:
>> +
>> +
>> +	gpio99: tca6424@22 {
> 
> gpio@22

Ok!

> 
>> +		compatible = "nxp,pcal6524";
>> +		reg = <0x22>;
>> +		interrupt-parent = <&gpio6>;
>> +		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;	/* gpio6_161 */
>> +		interrupt-controller;
>> +		#interrupt-cells = <2>;
>> +		vcc-supply = <&vdds_1v8_main>;
>> +		gpio-controller;
>> +		#gpio-cells = <2>;
>> +		gpio-line-names =
>> +			"hdmi-ct-hpd", "hdmi.ls-oe", "p02", "p03", "vibra", "fault2", "p06", "p07",
>> +			"en-usb", "en-host1", "en-host2", "chg-int", "p14", "p15", "mic-int", "en-modem",
>> +			"shdn-hs-amp", "chg-status+red", "green", "blue", "en-esata", "fault1", "p26", "p27";
>> +	};
>> +
>> +	ts3a227@3b {
>> +		compatible = "ti,ts3a227e";
>> +		reg = <0x3b>;
>> +		interrupt-parent = <&gpio99>;
>> +		interrupts = <14 IRQ_TYPE_EDGE_RISING>;
>> +		ti,micbias = <0>;	/* 2.1V */
>> +	};
>> +
>> -- 
>> 2.12.2
>> 

BR and thanks,
Nikolaus
