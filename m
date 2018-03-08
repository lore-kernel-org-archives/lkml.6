Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755623AbeCHMOU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 07:14:20 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:45362 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751523AbeCHMOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 07:14:17 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8778160386
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilialin@codeaurora.org
From: <ilialin@codeaurora.org>
To: "'Rob Herring'" <robh@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <mark.rutland@arm.com>,
        <amit.kucheria@linaro.org>, <nicolas.dechesne@linaro.org>,
        <celster@codeaurora.org>, <tfinkel@codeaurora.org>
References: <1520166709-554-1-git-send-email-ilialin@codeaurora.org> <1520166709-554-3-git-send-email-ilialin@codeaurora.org> <20180307204115.mugm7m3egrc73og2@rob-hp-laptop>
In-Reply-To: <20180307204115.mugm7m3egrc73og2@rob-hp-laptop>
Subject: RE: [PATCH 2/2] dt-bindings: Add support for SAW documentation
Date: Thu, 8 Mar 2018 14:14:12 +0200
Message-ID: <09f301d3b6d6$fa79cfe0$ef6d6fa0$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIyATyPBIHMFdFAhru6zRrLgNGo2wIpamQeAjVpTaOi5rRM8A==
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review, Rob.

I used existing drivers as reference and defined in the same way. Could you
point me to a reference that is correct from your point of view?

> -----Original Message-----
> From: Rob Herring [mailto:robh@kernel.org]
> Sent: Wednesday, March 7, 2018 22:41
> To: Ilia Lin <ilialin@codeaurora.org>
> Cc: linux-kernel@vger.kernel.org; devicetree@vger.kernel.org;
> lgirdwood@gmail.com; broonie@kernel.org; mark.rutland@arm.com;
> amit.kucheria@linaro.org; nicolas.dechesne@linaro.org;
> celster@codeaurora.org; tfinkel@codeaurora.org
> Subject: Re: [PATCH 2/2] dt-bindings: Add support for SAW documentation
> 
> On Sun, Mar 04, 2018 at 02:31:49PM +0200, Ilia Lin wrote:
> > Add support for SAW controlled regulators in 8x96.
> > Document it.
> >
> > Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
> > ---
> >  .../bindings/regulator/qcom,spmi-regulator.txt     | 45
> ++++++++++++++++++++++
> >  1 file changed, 45 insertions(+)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
> > b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
> > index 57d2c65..406f2e5 100644
> > ---
> > a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
> > +++ b/Documentation/devicetree/bindings/regulator/qcom,spmi-
> regulator.
> > +++ txt
> > @@ -110,6 +110,11 @@ Qualcomm SPMI Regulators
> >  	Definition: Reference to regulator supplying the input pin, as
> >  		    described in the data sheet.
> >
> > +- qcom,saw-reg:
> > +	Usage: optional
> > +	Value type: <phandle>
> > +	Description: Reference to syscon node defining the SAW registers.
> > +
> >
> >  The regulator node houses sub-nodes for each regulator within the
> > device. Each  sub-node is identified using the node's name, with valid
> > values listed for each @@ -201,6 +206,17 @@ see regulator.txt - with
> additional custom properties described below:
> >  			2 = 0.55 uA
> >  			3 = 0.75 uA
> >
> > +- qcom,saw-slave:
> > +	Usage: optional
> > +	Value type: <boo>
> > +	Description: SAW controlled gang slave. Will not be configured.
> > +
> > +- qcom,saw-leader:
> > +	Usage: optional
> > +	Value type: <boo>
> > +	Description: SAW controlled gang leader. Will be configured as
> > +		     SAW regulator.
> > +
> >  Example:
> >
> >  	regulators {
> > @@ -221,3 +237,32 @@ Example:
> >
> >  		....
> >  	};
> > +
> > +Example 2:
> > +
> > +	saw3: syscon@9A10000 {
> > +		compatible = "syscon";
> 
> syscon should not be used alone. It should have a specific compatible too.
> 
> > +		reg = <0x9A10000 0x1000>;
> > +	};
> > +
> > +	...
> > +
> > +	spm-regulators {
> > +		compatible = "qcom,pm8994-regulators";
> > +		qcom,saw-reg = <&saw3>;
> 
> Why not just a child of the syscon?
> 
> > +		s8 {
> > +			qcom,saw-slave;
> > +		};
> > +		s9 {
> > +			qcom,saw-slave;
> > +		};
> > +		s10 {
> > +			qcom,saw-slave;
> > +		};
> > +		pm8994_s11_saw: s11 {
> > +			qcom,saw-leader;
> > +			regulator-always-on;
> > +			regulator-min-microvolt = <900000>;
> > +			regulator-max-microvolt = <1140000>;
> > +		};
> > +	};
> > --
> > Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> > a Linux Foundation Collaborative Project
> >
