Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_DBL_ABUSE_MALW,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47439ECE568
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 21:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA661208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 21:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="InKPNs94"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA661208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbeIYDVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 23:21:03 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39632 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbeIYDVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 23:21:03 -0400
Received: by mail-pg1-f195.google.com with SMTP id 85-v6so6765071pge.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 14:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gNwDgJkYW7x1gocVeQumEvnZtXW8RgHhSl4s92OFiy0=;
        b=InKPNs94LfxgV1ZyFG7suJ48oVhB1uArzyrndQUN55bLv6HIp1dpL7ha5m+kSbYhUQ
         kK11nZqMkTgtQ+kJg42Twaqt02QPQPg5jH6POVAAlayXyxicka2MxRJdRUyoQaLbzujk
         20gCM3Ty90h66m7iLOsmTxHXCm+xNE1tm59hw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gNwDgJkYW7x1gocVeQumEvnZtXW8RgHhSl4s92OFiy0=;
        b=OcERHya6fJqXy1fGVxtFxMv0egLjmccdpdQrE0+pYaJkjTj7ZqsFiv7uqRoBxvbkCs
         //XrROAw9lYSV2WTyOAyI3MvYEoeZtTs0m5sOfZd48rdzuYmWFFiKVpBenndQ3FwD/pJ
         uYsheuQUMbytOnyy3A+lClo/EgbndgJ4EN0YoTaG8w9BnDhJhPARap7wKsUdE4cPGQLg
         tzZlnUdB4e2R6IK0mCkbPAc/WI1AFA31aD4OaRiha15nAXhJhhn+bUzGF2PITL2EBAwf
         BQ/VCN0rw6N4+OlKBSTeX7Ru+GYZuQBL0PVcytBn0V86+ha5RifJch3vyOfFCLO2BAy+
         NGCA==
X-Gm-Message-State: ABuFfoip22fRCVoSEayZTG4P1ppMuIgdsF/EJ0KcYaL05g9dZ3aBO1/K
        gfwRK1mX2fme8L3v+ZbzFR9tEg==
X-Google-Smtp-Source: ACcGV62/0vqJKHhgao8lTBSWh9Rf20zJPQVoHngBDwPyTzpfZ37xoHDQD2AaupdqPMWi1SAMMsIyzA==
X-Received: by 2002:a62:3644:: with SMTP id d65-v6mr510407pfa.133.1537823814143;
        Mon, 24 Sep 2018 14:16:54 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id h10-v6sm305234pfj.78.2018.09.24.14.16.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 14:16:53 -0700 (PDT)
Date:   Mon, 24 Sep 2018 14:16:51 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Craig <ctatlor97@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: sdm630 SoC and Sony Pioneer (Xperia XA2)
 support
Message-ID: <20180924211650.GH2523@minitux>
References: <20180811162549.12312-1-ctatlor97@gmail.com>
 <20180924191929.GQ1367@tuxbook-pro>
 <18147804-E195-4A4F-B215-77E8E4FF7C88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18147804-E195-4A4F-B215-77E8E4FF7C88@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 24 Sep 13:42 PDT 2018, Craig wrote:
> On 24 September 2018 20:19:29 BST, Bjorn Andersson <bjorn.andersson@linaro.org> wrote:
> >On Sat 11 Aug 09:25 PDT 2018, Craig Tatlor wrote:
> >
> >> Initial device tree support for Qualcomm SDM630 SoC and
> >> Sony Pioneer (Xperia XA2).
> >> 
> >> SDM630 is based off of the SDM660 soc and all SDM660 specific drivers
> >are
> >> compatible with it. SDM660 is also based off of MSM8998 so it uses
> >some
> >> of its drivers aswell.
> >
> >Consider adding both sdm630 and sdm660 compatibles to the bindings and
> >drivers and use the right one in the dts, in case we find details that
> >differs in the future.
> 
> This includes pinctrl and GCC?

Yes

> >
> >> 
> >> The device tree is based on the CAF 4.4 kernel tree.
> >> 
> >> The device can be booted into the initrd with a shell over UART.
> >> 
> >> Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
> >[..]
> >> diff --git a/arch/arm64/boot/dts/qcom/sdm630-pins.dtsi
> >b/arch/arm64/boot/dts/qcom/sdm630-pins.dtsi
> >> new file mode 100644
> >> index 000000000000..78b79c1076f1
> >> --- /dev/null
> >> +++ b/arch/arm64/boot/dts/qcom/sdm630-pins.dtsi
> >> @@ -0,0 +1,17 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/* Copyright (c) 2018, Craig Tatlor. */
> >> +
> >> +&tlmm {
> >> +	blsp1_uart1_default: blsp1_uart1_default {
> >> +		pinmux {
> >> +			pins = "gpio0", "gpio1", "gpio2", "gpio3";
> >> +			function = "gpio";
> >
> >Please put these in the sdm630.dtsi directly, rather than spreading the
> >pins out in a separate file.
> >
> Okay, just followed what 8996 did

I have started to rework that based on the last year's discussions, but
haven't posted any patches yet.

> >> +		};
> >> +
> >> +		pinconf {
> >> +			pins = "gpio0", "gpio1", "gpio2", "gpio3";
> >> +			drive-strength = <2>;
> >> +			bias-disable;
> >
> >Please extend &blsp1_uart1_default in the pioneer dtsi with these
> >"electrical properties".
> Are you meaning to put this in the pioneer DTS or just drive strength and bias?

The drive-strength and bias are board-specific properties, so we want to
keep those in the board file, so I mean push the pinconf part into the
board dtsi.

[..]
> >> +		gcc: clock-controller@100000 {
> >> +			compatible = "qcom,gcc-sdm660";
> >> +			#clock-cells = <1>;
> >> +			#reset-cells = <1>;
> >> +			#power-domain-cells = <1>;
> >> +			reg = <0x100000 0x94000>;
> >
> >Please 0-pad addresses in "reg", makes it easier to sort them as well
> >(but keep the @address after the node name unpadded)
> Sure, how much should I pad up to?

reg = <0x00100000 0xb0000>;

Regards,
Bjorn
