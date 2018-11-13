Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12EAAC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 03:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B91F9224E0
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 03:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AHT99+zy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B91F9224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730507AbeKMNin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 08:38:43 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45899 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728758AbeKMNin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 08:38:43 -0500
Received: by mail-pf1-f195.google.com with SMTP id g62so2061936pfd.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 19:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aTW55oK/6WvnaYCm0utX2I0vJ4k+Xwu6muZDCSviJP4=;
        b=AHT99+zyUjxrwH5aaPapWLEXqr1ubAD/ed00Zhvb9fWKQQoRzF79Rq+sYUA0cuPu4x
         oGOoCd3JKSCGXKhuvB4IJHjfDklpYAmKbL8p8AUtXb3e3Aw2szQSY9hZS7SZZzG0rBUH
         sQ+mkAeWgoixLegeKkLT0AJb/F/iFo8ow+Bfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aTW55oK/6WvnaYCm0utX2I0vJ4k+Xwu6muZDCSviJP4=;
        b=Ew16WfCows6gY4mTYqOTMs/63DlWNw/wG1QNfriI11rtt926VwItOF5nIrmXnJ6TB2
         4ZBY4pt8h4jc0wDU7nSfzG/ZdpTsjzu3IGcVkf/9JHAQveh+51fY+6bN6B26/V98BPD4
         WhRTSvQ1CWJK9YoNJXEsFS1pRQwoHp4FSxvW5+qd2idmpi1WEScMeG/Ipfw1IR0CoOKE
         hrsV/ntJf3EdS9U3Hhc0ss7fd4Yfz6a39LhlXVRAdssrOrhMlJZsi3syMEp7OsdV5HSK
         y9OE2blBoiTFANd8/2jdnht8CSRll914JUFs9EjvKpT2uwKrB7ETgO4byXODoct3ECHv
         N1KQ==
X-Gm-Message-State: AGRZ1gLG6/dl4Ne7ekPQMq3tX5VV1hz//ThZp77x7SCyk6BBNOmjclTp
        bsxJ4+Mxm4HeGlsBzQE+qPUHZA==
X-Google-Smtp-Source: AJdET5cv2JiJEG8iFlafpqjDzc+qlRsy8pZEIlM/4sZvYsUYaa1cXxCm4WZiQKOIvREzBpCEVBXJ8w==
X-Received: by 2002:a63:1258:: with SMTP id 24mr3212461pgs.114.1542080553012;
        Mon, 12 Nov 2018 19:42:33 -0800 (PST)
Received: from tiger (61-216-91-114.HINET-IP.hinet.net. [61.216.91.114])
        by smtp.gmail.com with ESMTPSA id l63-v6sm16078781pfb.75.2018.11.12.19.42.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Nov 2018 19:42:31 -0800 (PST)
Date:   Tue, 13 Nov 2018 11:42:08 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Sriharsha Allenki <sallenki@codeaurora.org>,
        Anu Ramanathan <anur@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: phy: Add Qualcomm Synopsys High-Speed
 USB PHY binding
Message-ID: <20181113034200.GD20049@tiger>
References: <20181108070449.23572-1-shawn.guo@linaro.org>
 <20181108070449.23572-2-shawn.guo@linaro.org>
 <5bea0ed8.1c69fb81.8715.38b2@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bea0ed8.1c69fb81.8715.38b2@mx.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Mon, Nov 12, 2018 at 01:24:51PM -0600, Rob Herring wrote:
> On Thu, Nov 08, 2018 at 03:04:48PM +0800, Shawn Guo wrote:
> > From: Sriharsha Allenki <sallenki@codeaurora.org>
> > 
> > It adds bindings for Synopsys 28nm femto phy controller that supports
> > LS/FS/HS usb connectivity on Qualcomm chipsets.
> > 
> > Signed-off-by: Sriharsha Allenki <sallenki@codeaurora.org>
> > Signed-off-by: Anu Ramanathan <anur@codeaurora.org>
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> >  .../phy/qcom,snps-28nm-usb-hs-phy.txt         | 101 ++++++++++++++++++
> >  1 file changed, 101 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/phy/qcom,snps-28nm-usb-hs-phy.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/qcom,snps-28nm-usb-hs-phy.txt b/Documentation/devicetree/bindings/phy/qcom,snps-28nm-usb-hs-phy.txt
> > new file mode 100644
> > index 000000000000..75e7a09dd558
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/qcom,snps-28nm-usb-hs-phy.txt
> > @@ -0,0 +1,101 @@
> > +Qualcomm Synopsys 28nm Femto phy controller
> > +===========================================
> > +
> > +Synopsys 28nm femto phy controller supports LS/FS/HS usb connectivity on
> > +Qualcomm chipsets.
> > +
> > +Required properties:
> > +
> > +- compatible:
> > +    Value type: <string>
> > +    Definition: Should contain "qcom,usb-snps-hsphy".
> 
> SoC specific compatible?

Agreed.  A SoC prefixed compatible would be more specific and scalable
for handling different programming model of the same IP.  I will use
"qcom,qcs404-usb-hsphy" in v3.

> 
> > +
> > +- reg:
> > +    Value type: <prop-encoded-array>
> > +    Definition: USB PHY base address and length of the register map.
> > +
> > +- #phy-cells:
> > +    Value type: <u32>
> > +    Definition: Should be 0.
> > +
> > +- clocks:
> > +    Value type: <prop-encoded-array>
> > +    Definition: See clock-bindings.txt section "consumers". List of
> > +		three clock specifiers for reference, phy core and
> > +		sleep clocks.
> > +
> > +- clock-names:
> > +    Value type: <string>
> > +    Definition: Names of the clocks in 1-1 correspondence with the "clocks"
> > +		property. Must contain "ref", "phy" and "sleep".
> > +
> > +- resets:
> > +    Value type: <prop-encoded-array>
> > +    Definition: See reset.txt section "consumers". PHY reset specifiers
> > +		for phy core and POR resets.
> > +
> > +- reset-names:
> > +    Value type: <string>
> > +    Definition: Names of the resets in 1-1 correspondence with the "resets"
> > +		property. Must contain "phy" and "por".
> > +
> > +- vdd-supply:
> > +    Value type: <phandle>
> > +    Definition: phandle to the regulator VDD supply node.
> > +
> > +- vdda1p8-supply:
> > +    Value type: <phandle>
> > +    Definition: phandle to the regulator 1.8V supply node.
> > +
> > +- vdda3p3-supply:
> > +    Value type: <phandle>
> > +    Definition: phandle to the regulator 3.3V supply node.
> > +
> > +- qcom,vdd-voltage-level:
> > +    Value type: <prop-array>
> > +    Definition: This is a list of three integer values <no min max> where
> > +		each value corresponding to voltage corner in uV.
> > +
> > +Optional properties:
> > +
> > +- extcon:
> > +    Value type: <prop-encoded-array>
> > +    Definition: Should contain the vbus extcon.
> 
> Don't use extcon for new bindings. Use usb-connector binding.

Okay, I just did a bit of research and found that 'extcon' is becoming
a deprecated DT property recently and we should OF graph bindings to
specify the connector.  Will do in v3.

> 
> > +
> > +- qcom,init-seq:
> > +    Value type: <u32 array>
> > +    Definition: Should contain a sequence of <offset value delay> tuples to
> > +                program 'value' into phy register at 'offset' with 'delay'
> > +		in us afterwards.
> 
> If we wanted this type of thing in DT, we'd have a generic binding (or 
> forth).

Right now, this is a qualcomm usb phy specific bindings - first used in
qcom,usb-hs-phy.txt and I extended it a bit for my phy.  As this is not
a so good hardware description, I'm a little hesitated to make it
generic for other platforms to use in general.  What about we put off it
a little bit until we see more platforms need the same thing?

Shawn

> This should probably be split between SoC specific settings in 
> the driver and board properties in DT.
