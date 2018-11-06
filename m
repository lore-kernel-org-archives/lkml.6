Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA1BC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F36520869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TexOEkXt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F36520869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389649AbeKGDNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 22:13:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:51252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730671AbeKGDN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 22:13:29 -0500
Received: from localhost (unknown [171.76.98.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6B1B20827;
        Tue,  6 Nov 2018 17:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541526429;
        bh=zeVEB2DrCdcA6KVXn1Ed7m+ibSt6qq27asVdDo9f/Gk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TexOEkXtndxahoC/pHI36MfAp0WXrH6gyQEMAxUvn4hxWs+UNrWBuSzBVgN2VxBQo
         K6Hf9AADkrTpSghcM3aaX6kkmyv0WAnh1xrKVVqbmGL9yeaicm9l3kVBFDJq6nbsw4
         /LjhiBvzsG7dYwJmXr8kgOC8sPw91IVIDNX9zdng=
Date:   Tue, 6 Nov 2018 23:17:01 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/17] arm64: dts: qcom: qcs404: Add remoteproc nodes
Message-ID: <20181106174701.GB12092@vkoul-mobl>
References: <20181105154529.7614-1-vkoul@kernel.org>
 <20181105154529.7614-14-vkoul@kernel.org>
 <20181105191035.GR2523@minitux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105191035.GR2523@minitux>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-11-18, 11:10, Bjorn Andersson wrote:
> On Mon 05 Nov 07:45 PST 2018, Vinod Koul wrote:
> 
> > From: Bjorn Andersson <bjorn.andersson@linaro.org>
> > 
> > Add the TrustZone based remoteproc nodes and their glink edges for
> > adsp, cdsp and wcss.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >  arch/arm64/boot/dts/qcom/qcs404.dtsi | 87 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 87 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> > index 8e207a25ddf0..b560ab6e49ff 100644
> > --- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> > @@ -373,4 +373,91 @@
> >  			#interrupt-cells = <2>;
> >  		};
> >  	};
> > +
> > +	remoteproc-adsp {
> > +		compatible = "qcom,qcs404-adsp-pas";
> > +
> > +		interrupts-extended = <&intc GIC_SPI 293 IRQ_TYPE_EDGE_RISING>,
> > +				      <&adsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
> > +				      <&adsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
> > +				      <&adsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
> > +				      <&adsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
> > +		interrupt-names = "wdog", "fatal", "ready",
> > +				  "handover", "stop-ack";
> > +
> > +		clocks = <&xo_board>;
> > +		clock-names = "xo";
> > +
> 
> As the TZ-backed remoteproc drivers will not be used on all variation of
> products on this platform please add status = "disabled"; to these nodes
> and enable them in the evb.

Sure will update this one

-- 
~Vinod
