Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B9FC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C73AB2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="U5WQZQ2P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C73AB2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbeIJWly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 18:41:54 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44441 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbeIJWly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 18:41:54 -0400
Received: by mail-pf1-f194.google.com with SMTP id k21-v6so10822450pff.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 10:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=29HCe/EhldUmh+4rTeRxl6GO6f3C3aV3fNhodvMraIY=;
        b=U5WQZQ2PuNIVdKMfEK0hC97ApIGoSMucrzhinzbyLsGDuwMB5zdkU8C7JJpoV/MNNV
         V29vngZj2EoMDlPVF6JtAKHaZMLk90D4bDXPnxPOD/qswbO5AWLlleOTZqQx62hIH+iF
         6S1AqtJBv4oD5pHE28fBE1k3dxUxDyGo4r+eI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=29HCe/EhldUmh+4rTeRxl6GO6f3C3aV3fNhodvMraIY=;
        b=DxOVCDPYYAxioswOlMq3j8VsEBLF0x3Zm5mwNa0SawtfVYahAAjfxQTmosS0bKiKYz
         F9RPlT6uAKmydtDMl6zxa5bsV4S8Y+C4Gwo8LFU2et305a6Px+FLYwn0hR7ce+DC+Gel
         TKbgKfr4a0x4DULNGbPCAStPgWCIKX5Fs42NEKZneXLWGu+l5KQyh+ZdT1jRgLRj5rpH
         34d7oagJbB2tIx7mxNDm2wh4nqCRf4FR+UFqJBRWwErGTHXRvDFEWzpT6H/fkp/Zq8+o
         DqCPotBUwdPjBy1M0ecLVy0B5s5w6y0Wc5JFEXKQKn1rT74L1Ni1hihTa5VRFXTYG8bJ
         Lbpw==
X-Gm-Message-State: APzg51DxwgPXECiphkE1wrud+23xEBi5N+27FrslGwhbnjz9ipQgZXEh
        oWeg1e859tRHGJB4NBFVGlGx1A==
X-Google-Smtp-Source: ANB0VdZ4QSvcizvv2mjuywtX/ux4BZzpkdNGeKlrAGRBnoKVyrjQUE8fp75kIvVhhAqv4GgY87ya8A==
X-Received: by 2002:a63:9a42:: with SMTP id e2-v6mr24605935pgo.263.1536601601592;
        Mon, 10 Sep 2018 10:46:41 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id e202-v6sm27374498pfh.16.2018.09.10.10.46.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 10:46:40 -0700 (PDT)
Date:   Mon, 10 Sep 2018 10:46:38 -0700
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
Subject: Re: [PATCH v3 2/3] arm64: dts: qcom: sdm845-mtp: Add RPMh VRM/XOB
 regulators
Message-ID: <20180910174638.GB2523@minitux>
References: <20180822173629.202885-1-dianders@chromium.org>
 <20180822173629.202885-3-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180822173629.202885-3-dianders@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 22 Aug 10:36 PDT 2018, Douglas Anderson wrote:
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
[..]
> +
> +		vdd_qusb_hs0:
> +		vdda_hp_pcie_core:
> +		vdda_mipi_csi0_0p9:
> +		vdda_mipi_csi1_0p9:
> +		vdda_mipi_csi2_0p9:
> +		vdda_mipi_dsi0_pll:
> +		vdda_mipi_dsi1_pll:
> +		vdda_qlink_lv:
> +		vdda_qlink_lv_ck:
> +		vdda_qrefs_0p875:
> +		vdda_pcie_core:
> +		vdda_pll_cc_ebi01:
> +		vdda_pll_cc_ebi23:
> +		vdda_sp_sensor:
> +		vdda_ufs1_core:
> +		vdda_ufs2_core:
> +		vdda_usb1_ss_core:
> +		vdda_usb2_ss_core:

While I agree with Doug that it would be connect to use the input pin
name to describe the supplies of the various block I don't like the
level of indirection it results in when reading the dts.

So I would prefer that any of these just reference vreg_l1a_0p875
directly.


That said, the patch looks good.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn
