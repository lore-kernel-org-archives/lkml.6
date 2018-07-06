Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C6CEC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 23:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB11922B4B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 23:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hs1Lg3oM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB11922B4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933510AbeGFXm2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 19:42:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:40384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932839AbeGFXm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 19:42:27 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D15222B4B;
        Fri,  6 Jul 2018 23:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530920546;
        bh=gFpvmpKp2BT1ca+5A6X9M1L2FVkDMn3Zk+MtutfBKRE=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=hs1Lg3oMUqsWqO8o6ilZkSB1pFtSZW7tXDvIXOB/KdMQRXU7wgANJTFg6E/KRtsfL
         AV8BeOwi8EkbTfXRixM9ArbiFPOfgswMSbCzfVmWmZtzGkmzoAdtymiqFtpPFrjiN8
         N2EvZJ7KwC689A5m24ltvTtj+8ruY5SK9Z5bcfI8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1530773721-14668-2-git-send-email-tdas@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        rohitkr@codeaurora.org, Taniya Das <tdas@codeaurora.org>
References: <1530773721-14668-1-git-send-email-tdas@codeaurora.org>
 <1530773721-14668-2-git-send-email-tdas@codeaurora.org>
Message-ID: <153092054581.143105.16123786121344421693@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: Introduce QCOM LPASS clock bindings
Date:   Fri, 06 Jul 2018 16:42:25 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-07-04 23:55:20)
> diff --git a/Documentation/devicetree/bindings/clock/qcom,lpasscc.txt b/D=
ocumentation/devicetree/bindings/clock/qcom,lpasscc.txt
> new file mode 100644
> index 0000000..fe7378b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,lpasscc.txt
> @@ -0,0 +1,22 @@
> +Qualcomm LPASS Clock Controller Binding
> +-----------------------------------------------
> +
> +Required properties :
> +- compatible   : shall contain "qcom,sdm845-lpasscc"
> +- #clock-cells : from common clock binding, shall contain 1.
> +- reg          : shall contain base register address and size.
> +- reg-names    : shall contain the register names of LPASS domain
> +                       "lpass_gcc", "lpass_cc", "lpass_qdsp6ss".
> +
> +Example:
> +
> +The below node has to be defined in the cases where the LPASS peripheral=
 loader
> +would bring the subsystem out of reset.
> +
> +       lpasscc: clock-controller {
> +               compatible =3D "qcom,sdm845-lpasscc";
> +               reg =3D <0x00147000 0x20>, <0x17014000 0x1f004>,

This first reg is inside GCC though? Why isn't it added to the gcc
sdm845 driver? And then the next two might make sense as a different
region, but the reg property ending in 20 looks really weird.

> +                       <0x17300020 0x20>;
> +               reg-names =3D "lpass_gcc", "lpass_cc", "lpass_qdsp6ss";
> +               #clock-cells =3D <1>;
> +       };
