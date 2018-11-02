Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161F9C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 16:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C258A20657
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 16:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="R698LYao"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C258A20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbeKCBqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 21:46:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:45310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbeKCBqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 21:46:15 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51E0120657;
        Fri,  2 Nov 2018 16:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541176712;
        bh=kFJ71++l0DbRvUy3AN798kgs/TEkIPl3KpDh+nLQNcw=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=R698LYaobz+0K3OJGwZ5yn89NIxC35YIQkNFR8UEjviTHomFKyyyB3YRkrI4bvSmL
         gDJgP0sir/DctIGnVSMu8NTDiYUo007pnYBKRJexfwYsIXNYhCY/1xV6kHyK4JRJAD
         SVU8RQW/YubK78phkhd/FNs+pa3KZU0SxhxsIJuU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1540712140-26913-2-git-send-email-tdas@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <1540712140-26913-1-git-send-email-tdas@codeaurora.org>
 <1540712140-26913-2-git-send-email-tdas@codeaurora.org>
Message-ID: <154117671164.88331.752297297364277275@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v8] clk: qcom: Add lpass clock controller driver for SDM845
Date:   Fri, 02 Nov 2018 09:38:31 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-10-28 00:35:40)
> Add support for the lpass clock controller found on SDM845 based devices.
> This would allow lpass peripheral loader drivers to control the clocks to
> bring the subsystem out of reset.
> LPASS clocks present on the global clock controller would be registered
> with the clock framework based on the device tree flag. Also do not gate
> these clocks if they are left unused, as the lpass clocks require the
> global clock controller lpass clocks to be enabled before they are
> accessed. Mark the GCC lpass clocks as CRITICAL, for the LPASS clock
> access.

Thanks for the useful commit text!

> =

> diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
> index 08d593e..9d60474 100644
> --- a/drivers/clk/qcom/gcc-sdm845.c
> +++ b/drivers/clk/qcom/gcc-sdm845.c
> @@ -3583,6 +3613,13 @@ static int gcc_sdm845_probe(struct platform_device=
 *pdev)
>         if (ret)
>                 return ret;
> =

> +       if (!of_property_read_bool(pdev->dev.of_node, "qcom,lpass-protect=
ed")) {

Bjorn told me over IRC that the QSPI clks are also protected on MTP and
can't be read. So we're now causing MTP to fail on linus' tree. I think
we need to add a generic property to the GCC node to indicate what clks
are protected and shouldn't be touched by the OS. The function would go
and knock out any protected clks by replacing their pointers with NULL.
The property would be:

   protected-clocks =3D <clock-specifier-list>;

So for this node it would look like:

   gcc: clock-controller@f000 {
        reg =3D <0xf00 0xbaf>;

        protected-clocks =3D <&gcc GCC_LPASS_Q6_AXI_CLK>,
                           <&gcc GCC_LPASS_SWAY_CLK>,
                           <&gcc GCC_QSPI_CORE_CLK_SRC>,
                           etc.
   };

Sorry for derailing this patch series so late in the process. This patch
will need to be updated to work with that new DT property instead of
having a custom qcom property. Otherwise the patch looks good and I
think we're ready to merge it when the merge window closes and I can
rewind clk-next.

