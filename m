Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D18C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 08:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6AE420870
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 08:54:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6AE420870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730513AbeGaKdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 06:33:53 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:60433 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729769AbeGaKdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 06:33:53 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1fkQQK-0006GH-GV; Tue, 31 Jul 2018 10:54:32 +0200
Message-ID: <1533027272.3444.9.camel@pengutronix.de>
Subject: Re: [PATCH 4/4] remoteproc: qcom: q6v5-pil: Add PDC restart for
 modem on SDM845 SoCs
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Sibi Sankar <sibis@codeaurora.org>, bjorn.andersson@linaro.org,
        robh+dt@kernel.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, ohad@wizery.com, mark.rutland@arm.com,
        sricharan@codeaurora.org, akdwived@codeaurora.org,
        linux-arm-msm@vger.kernel.org, tsoni@codeaurora.org
Date:   Tue, 31 Jul 2018 10:54:32 +0200
In-Reply-To: <20180727152811.15258-4-sibis@codeaurora.org>
References: <20180727152811.15258-1-sibis@codeaurora.org>
         <20180727152811.15258-4-sibis@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-07-27 at 20:58 +0530, Sibi Sankar wrote:
> In the presence of a PDC block working with subsystem RSC,
> assert/deassert PDC restart in modem start/stop path.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  .../bindings/remoteproc/qcom,q6v5.txt         |  4 +++
>  drivers/remoteproc/qcom_q6v5_pil.c            | 27 ++++++++++++++++---
>  2 files changed, 27 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
> index 601dd9f389aa..124fb1dc6fb8 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
[...]
> @@ -1182,6 +1192,15 @@ static int q6v5_init_reset(struct q6v5 *qproc)
>  		return PTR_ERR(qproc->mss_restart);
>  	}
>  
> +	if (qproc->has_alt_reset) {
> +		qproc->pdc_restart = devm_reset_control_get(qproc->dev,
> +							    "pdc_restart");

Please use devm_reset_control_get_exclusive() instead.

> +		if (IS_ERR(qproc->pdc_restart)) {
> +			dev_err(qproc->dev, "failed to acquire pdc restart\n");
> +			return PTR_ERR(qproc->pdc_restart);
> +		}
> +	}
> +
>  	return 0;
>  }

regards
Philipp
