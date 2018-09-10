Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684D8C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CC9A2086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aMKMRtAA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CC9A2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbeIJWmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 18:42:46 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34322 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbeIJWmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 18:42:45 -0400
Received: by mail-pg1-f195.google.com with SMTP id d19-v6so10853571pgv.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 10:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1q8LGEIEm94ztqfZHR2aRBt+M7Rt6ccL6+NSpxddyl0=;
        b=aMKMRtAArJMsp/J7p9DeDb3TIuKtH8TU07fXLTdOV0aPnjp8HeoDryUm54gZxeBzpp
         9JxjlpFWFXJtkMwT0Dd6prCo4Hh5GKstE0Uvsa81tyrQh1XkTOx2smE6IHg9DdwJ/fHy
         4wYvrbgWZNJyMVH4aZS//c4PYkEDAnbxd4wwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1q8LGEIEm94ztqfZHR2aRBt+M7Rt6ccL6+NSpxddyl0=;
        b=kglymIlVTg2SC3OVxXNhg/6VZEiu3AssNfTyebDUWCPL4Gjyu2PNKwuivGwvMdW2Yy
         VxgnC12pSKDvCqwx/1RxhBZC6x4qZjrgKs5Osvq3BhoQ46hortcjFFtxP0w4hq876vhB
         T72Xqi2qbCLQcatVl31ms4yiaAV3I5mPzgLJ3vbe9YF0w+KlL8PCc5KOw8EDuExlv5xo
         DDNCVW2H2weTAZgeKhPzawMxWPZ6FIr6xVbS/cf4OwVwaFSnL/o7UQWlZLhk7UwNRhUS
         oM3Zmqt4UvH99aPPvHgkLx0ztbSuZUHNe4Kzm/KMxcDXyGTVikWPJ8HBfvLMnnsP/Er5
         6f9g==
X-Gm-Message-State: APzg51BLOL6Srn0VCthvRhTsBnmb7I5hZsS1v58Zxw9xX81LLBzzLESz
        iAoXtkBFYXx+/c1TdUMf4ns9qoUz1x4=
X-Google-Smtp-Source: ANB0VdYtzYY4B+FjZiUt0o0zGZ0H2pMBZnxgI9uNPgrXJsVl5Zdhm31xySFugVGYrUpo1vcOk94a4g==
X-Received: by 2002:a62:59d5:: with SMTP id k82-v6mr24832134pfj.143.1536601652518;
        Mon, 10 Sep 2018 10:47:32 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id i3-v6sm18406157pgq.35.2018.09.10.10.47.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 10:47:31 -0700 (PDT)
Date:   Mon, 10 Sep 2018 10:47:29 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>, swboyd@chromium.org,
        tfiga@chromium.org, Manu Gautam <mgautam@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: sdm845-mtp: Add nodes for USB
Message-ID: <20180910174729.GC2523@minitux>
References: <20180822173629.202885-1-dianders@chromium.org>
 <20180822173629.202885-4-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180822173629.202885-4-dianders@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 22 Aug 10:36 PDT 2018, Douglas Anderson wrote:

> Set the various nodes to "okay" and hook up the regulators.
> 
> NOTE: For now the main USB port (the one that goes out the Type C
> connector) is forced to host.  Eventually someone will need to get the
> Type C detection hooked up and get this all integrated with the
> PMI8998 PMIC.  The reason for forcing to "host" in the meantime is
> that this will leave us with one "host" and one "peripheral" port.
> 
> In order for host mode this to work, we assume that the bootloader
> left things configured enough for us.  Apparently the magic for that
> is is to do these writes on pmi8998:
> - pm_comm_write_byte(2, 0x1153, 0x2C, 0);
> - pm_comm_write_byte(2, 0x1152, 0x07, 0);
> - pm_comm_write_byte(2, 0x1140, 0x00, 0);
> - pm_comm_write_byte(2, 0x1140, 0x01, 0);
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
> 
> Changes in v3: None
> Changes in v2: None
> 
>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 61 +++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> index ef53c4ae60b0..eedfaf8922e2 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> @@ -356,6 +356,67 @@
>  	status = "okay";
>  };
>  
> +&usb_1 {
> +	status = "okay";
> +};
> +
> +&usb_1_dwc3 {
> +	/* Until we have Type C hooked up we'll force this as host. */
> +	dr_mode = "host";
> +};
> +
> +&usb_1_hsphy {
> +	status = "okay";
> +
> +	vdd-supply = <&vdda_usb1_ss_core>;
> +	vdda-pll-supply = <&vdda_qusb_hs0_1p8>;
> +	vdda-phy-dpdm-supply = <&vdda_qusb_hs0_3p1>;
> +
> +	qcom,imp-res-offset-value = <8>;
> +	qcom,hstx-trim-value = <QUSB2_V2_HSTX_TRIM_21_6_MA>;
> +	qcom,preemphasis-level = <QUSB2_V2_PREEMPHASIS_5_PERCENT>;
> +	qcom,preemphasis-width = <QUSB2_V2_PREEMPHASIS_WIDTH_HALF_BIT>;
> +};
> +
> +&usb_1_qmpphy {
> +	status = "okay";
> +
> +	vdda-phy-supply = <&vdda_usb1_ss_1p2>;
> +	vdda-pll-supply = <&vdda_usb1_ss_core>;
> +};
> +
> +&usb_2 {
> +	status = "okay";
> +};
> +
> +&usb_2_dwc3 {
> +	/*
> +	 * Though the USB block on SDM845 can support host, there's no vbus
> +	 * signal for this port on MTP.  Thus (unless you have a non-compliant
> +	 * hub that works without vbus) the only sensible thing is to force
> +	 * peripheral mode.
> +	 */
> +	dr_mode = "peripheral";
> +};
> +
> +&usb_2_hsphy {
> +	status = "okay";
> +
> +	vdd-supply = <&vdda_usb2_ss_core>;
> +	vdda-pll-supply = <&vdda_qusb_hs0_1p8>;
> +	vdda-phy-dpdm-supply = <&vdda_qusb_hs0_3p1>;
> +
> +	qcom,imp-res-offset-value = <8>;
> +	qcom,hstx-trim-value = <QUSB2_V2_HSTX_TRIM_22_8_MA>;
> +};
> +
> +&usb_2_qmpphy {
> +	status = "okay";
> +
> +	vdda-phy-supply = <&vdda_usb2_ss_1p2>;
> +	vdda-pll-supply = <&vdda_usb2_ss_core>;
> +};
> +
>  /* PINCTRL - additions to nodes defined in sdm845.dtsi */
>  
>  &qup_i2c10_default {
> -- 
> 2.18.0.1017.ga543ac7ca45-goog
> 
