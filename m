Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754898AbeCRWqf (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 18:46:35 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:41470 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754710AbeCRWqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 18:46:32 -0400
X-Google-Smtp-Source: AG47ELueyas27hkg8cvKkE2Jxo217KdeEb5a+Znit0kDB2ML6L4/yHFHWrCApNJXqQhZE8murBrT8A==
Date: Sun, 18 Mar 2018 15:46:31 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Sibi S <sibis@codeaurora.org>
Cc: p.zabel@pengutronix.de, robh+dt@kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, georgi.djakov@linaro.org,
        jassisinghbrar@gmail.com, ohad@wizery.com, mark.rutland@arm.com,
        kyan@codeaurora.org, sricharan@codeaurora.org, akdwived@codeaurora.org,
        linux-arm-msm@vger.kernel.org, tsoni@codeaurora.org
Subject: Re: [PATCH v3 7/7] remoteproc: qcom: Always assert and deassert
 reset signals in SDM845
Message-ID: <20180318224631.GH5626@tuxbook-pro>
References: <1521019283-32212-1-git-send-email-sibis@codeaurora.org>
 <1521019283-32212-8-git-send-email-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521019283-32212-8-git-send-email-sibis@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 14 Mar 02:21 PDT 2018, Sibi S wrote:
> diff --git a/drivers/remoteproc/qcom_q6v5_pil.c b/drivers/remoteproc/qcom_q6v5_pil.c
[..]
> +struct q6v5_reset_ops {
> +	int (*reset_start)(struct q6v5 *qproc);
> +	int (*reset_stop)(struct q6v5 *qproc);
> +};

Please add these two ops directly in q6v5 instead and please keep the
naming "reset_assert" and "reset_deassert".

> +
>  enum {
>  	MSS_MSM8916,
>  	MSS_MSM8974,
> @@ -343,6 +354,52 @@ static int q6v5_load(struct rproc *rproc, const struct firmware *fw)
>  	return 0;
>  }
>  
> +static void alt_reset_restart(struct q6v5 *qproc, u32 restart)
> +{
> +	writel(restart, qproc->rmb_base + RMB_MBA_ALT_RESET);

Just move this write into q6v5_sdm_reset_start()

> +}
> +
> +static int q6v5_msm_reset_stop(struct q6v5 *qproc)
> +{
> +	return reset_control_assert(qproc->mss_restart);
> +}
> +
> +static int q6v5_msm_reset_start(struct q6v5 *qproc)
> +{
> +	return reset_control_deassert(qproc->mss_restart);
> +}
> +
> +static int q6v5_sdm_reset_stop(struct q6v5 *qproc)
> +{
> +	return reset_control_reset(qproc->mss_restart);
> +}
> +
> +static int q6v5_sdm_reset_start(struct q6v5 *qproc)
> +{
> +	int ret;
> +
> +	alt_reset_restart(qproc, 1);
> +	/* Ensure alt reset is written before restart reg */

That's not what udelay does ;)

If you want to make sure that the register is written and then give it
100us delay until you reset the reset you have to readl() the same
register back after the writel()

I think the delay deserves a comment on what we're waiting for.

> +	udelay(100);

Use usleep_range() for delays longer than 10us.

> +
> +	ret = reset_control_reset(qproc->mss_restart);
> +
> +	udelay(100);

Same as the delay above, what are we waiting for?

> +	alt_reset_restart(qproc, 0);
> +
> +	return ret;
> +}
> +
[..]
> @@ -1179,6 +1251,12 @@ static int q6v5_probe(struct platform_device *pdev)
>  	qproc->dev = &pdev->dev;
>  	qproc->rproc = rproc;
>  	platform_set_drvdata(pdev, qproc);
> +	qproc->version = desc->version;
> +
> +	if (qproc->version == MSS_SDM845)
> +		qproc->ops = &q6v5_sdm_ops;
> +	else
> +		qproc->ops = &q6v5_msm_ops;

Can we carry a boolean for "has_alt_reset" or something that picks the
new reset ops, rather than picking by version?

Regards,
Bjorn
