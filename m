Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751336AbeFAGZi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 02:25:38 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43540 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750796AbeFAGZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 02:25:35 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B704160249
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [RFC PATCH 3/5] remoteproc: qcom: adsp: Use common q6v5 helpers
To: Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>, Sibi Sankar <sibis@codeaurora.org>,
        Rohit kumar <rohitkr@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20180523052054.19025-1-bjorn.andersson@linaro.org>
 <20180523052054.19025-4-bjorn.andersson@linaro.org>
From: Sricharan R <sricharan@codeaurora.org>
Message-ID: <9eee7d06-d28d-233e-3e23-a8d0c86104ef@codeaurora.org>
Date: Fri, 1 Jun 2018 11:55:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180523052054.19025-4-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On 5/23/2018 10:50 AM, Bjorn Andersson wrote:
> Migrate the Hexagon V5 PAS (ADSP) driver to using the newly extracted
> helper functions. The use of the handover callback does introduce latent
> disabling of proxy resources. But apart from this there should be no
> change in functionality.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/remoteproc/Kconfig         |   1 +
>  drivers/remoteproc/qcom_adsp_pil.c | 156 +++++------------------------
>  2 files changed, 28 insertions(+), 129 deletions(-)
> 
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index 63b79ea91a21..d51d155cf8bd 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -93,6 +93,7 @@ config QCOM_ADSP_PIL
>  	depends on QCOM_SYSMON || QCOM_SYSMON=n
>  	select MFD_SYSCON
>  	select QCOM_MDT_LOADER
> +	select QCOM_Q6V5_COMMON
>  	select QCOM_RPROC_COMMON
>  	select QCOM_SCM
>  	help
> diff --git a/drivers/remoteproc/qcom_adsp_pil.c b/drivers/remoteproc/qcom_adsp_pil.c
> index 89a86ce07f99..d4339a6da616 100644
> --- a/drivers/remoteproc/qcom_adsp_pil.c
> +++ b/drivers/remoteproc/qcom_adsp_pil.c
> @@ -31,6 +31,7 @@
>  #include <linux/soc/qcom/smem_state.h>
>  
>  #include "qcom_common.h"
> +#include "qcom_q6v5.h"
>  #include "remoteproc_internal.h"
>  
>  struct adsp_data {
> @@ -48,14 +49,7 @@ struct qcom_adsp {
>  	struct device *dev;
>  	struct rproc *rproc;
>  
> -	int wdog_irq;
> -	int fatal_irq;
> -	int ready_irq;
> -	int handover_irq;
> -	int stop_ack_irq;
> -
> -	struct qcom_smem_state *state;
> -	unsigned stop_bit;
> +	struct qcom_q6v5 q6v5;
>  
>  	struct clk *xo;
>  	struct clk *aggre2_clk;
> @@ -96,6 +90,8 @@ static int adsp_start(struct rproc *rproc)
>  	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
>  	int ret;
>  
> +	qcom_q6v5_prepare(&adsp->q6v5);
> +
>  	ret = clk_prepare_enable(adsp->xo);
>  	if (ret)
>  		return ret;
> @@ -119,16 +115,14 @@ static int adsp_start(struct rproc *rproc)
>  		goto disable_px_supply;
>  	}
>  
> -	ret = wait_for_completion_timeout(&adsp->start_done,
> -					  msecs_to_jiffies(5000));
> -	if (!ret) {
> +	ret = qcom_q6v5_wait_for_start(&adsp->q6v5, msecs_to_jiffies(5000));
> +	if (ret == -ETIMEDOUT) {
>  		dev_err(adsp->dev, "start timed out\n");
>  		qcom_scm_pas_shutdown(adsp->pas_id);
> -		ret = -ETIMEDOUT;
>  		goto disable_px_supply;
>  	}
>  
> -	ret = 0;
> +	return 0;
>  
>  disable_px_supply:
>  	regulator_disable(adsp->px_supply);
> @@ -142,28 +136,34 @@ static int adsp_start(struct rproc *rproc)
>  	return ret;
>  }
>  
> +static void qcom_pas_handover(struct qcom_q6v5 *q6v5)
> +{
> +	struct qcom_adsp *adsp = container_of(q6v5, struct qcom_adsp, q6v5);
> +
> +	regulator_disable(adsp->px_supply);
> +	regulator_disable(adsp->cx_supply);
> +	clk_disable_unprepare(adsp->aggre2_clk);
> +	clk_disable_unprepare(adsp->xo);
> +}
> +
>  static int adsp_stop(struct rproc *rproc)
>  {
>  	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
> +	int handover;
>  	int ret;
>  
> -	qcom_smem_state_update_bits(adsp->state,
> -				    BIT(adsp->stop_bit),
> -				    BIT(adsp->stop_bit));
> -
> -	ret = wait_for_completion_timeout(&adsp->stop_done,
> -					  msecs_to_jiffies(5000));
> -	if (ret == 0)
> +	ret = qcom_q6v5_request_stop(&adsp->q6v5);
> +	if (ret == -ETIMEDOUT)
>  		dev_err(adsp->dev, "timed out on wait\n");
>  
> -	qcom_smem_state_update_bits(adsp->state,
> -				    BIT(adsp->stop_bit),
> -				    0);
> -
>  	ret = qcom_scm_pas_shutdown(adsp->pas_id);
>  	if (ret)
>  		dev_err(adsp->dev, "failed to shutdown: %d\n", ret);
>  
> +	handover = qcom_q6v5_unprepare(&adsp->q6v5);
> +	if (handover)
> +		qcom_pas_handover(&adsp->q6v5);
> +
>  	return ret;
>  }
>  
> @@ -187,53 +187,6 @@ static const struct rproc_ops adsp_ops = {
>  	.load = adsp_load,
>  };
>  
> -static irqreturn_t adsp_wdog_interrupt(int irq, void *dev)
> -{
> -	struct qcom_adsp *adsp = dev;
> -
> -	rproc_report_crash(adsp->rproc, RPROC_WATCHDOG);
> -
> -	return IRQ_HANDLED;
> -}
> -
> -static irqreturn_t adsp_fatal_interrupt(int irq, void *dev)
> -{
> -	struct qcom_adsp *adsp = dev;
> -	size_t len;
> -	char *msg;
> -
> -	msg = qcom_smem_get(QCOM_SMEM_HOST_ANY, adsp->crash_reason_smem, &len);
> -	if (!IS_ERR(msg) && len > 0 && msg[0])
> -		dev_err(adsp->dev, "fatal error received: %s\n", msg);
> -
> -	rproc_report_crash(adsp->rproc, RPROC_FATAL_ERROR);
> -
> -	return IRQ_HANDLED;
> -}
> -
> -static irqreturn_t adsp_ready_interrupt(int irq, void *dev)
> -{
> -	return IRQ_HANDLED;
> -}
> -
> -static irqreturn_t adsp_handover_interrupt(int irq, void *dev)
> -{
> -	struct qcom_adsp *adsp = dev;
> -
> -	complete(&adsp->start_done);
> -
> -	return IRQ_HANDLED;
> -}
> -
> -static irqreturn_t adsp_stop_ack_interrupt(int irq, void *dev)
> -{
> -	struct qcom_adsp *adsp = dev;
> -
> -	complete(&adsp->stop_done);
> -
> -	return IRQ_HANDLED;
> -}
> -
>  static int adsp_init_clock(struct qcom_adsp *adsp)
>  {
>  	int ret;
> @@ -272,29 +225,6 @@ static int adsp_init_regulator(struct qcom_adsp *adsp)
>  	return PTR_ERR_OR_ZERO(adsp->px_supply);
>  }
>  
> -static int adsp_request_irq(struct qcom_adsp *adsp,
> -			     struct platform_device *pdev,
> -			     const char *name,
> -			     irq_handler_t thread_fn)
> -{
> -	int ret;
> -
> -	ret = platform_get_irq_byname(pdev, name);
> -	if (ret < 0) {
> -		dev_err(&pdev->dev, "no %s IRQ defined\n", name);
> -		return ret;
> -	}
> -
> -	ret = devm_request_threaded_irq(&pdev->dev, ret,
> -					NULL, thread_fn,
> -					IRQF_ONESHOT,
> -					"adsp", adsp);
> -	if (ret)
> -		dev_err(&pdev->dev, "request %s IRQ failed\n", name);
> -
> -	return ret;
> -}
> -
>  static int adsp_alloc_memory_region(struct qcom_adsp *adsp)
>  {
>  	struct device_node *node;
> @@ -348,13 +278,9 @@ static int adsp_probe(struct platform_device *pdev)
>  	adsp->dev = &pdev->dev;
>  	adsp->rproc = rproc;
>  	adsp->pas_id = desc->pas_id;
> -	adsp->crash_reason_smem = desc->crash_reason_smem;
>  	adsp->has_aggre2_clk = desc->has_aggre2_clk;
>  	platform_set_drvdata(pdev, adsp);
>  
> -	init_completion(&adsp->start_done);
> -	init_completion(&adsp->stop_done);
> -
>  	ret = adsp_alloc_memory_region(adsp);
>  	if (ret)
>  		goto free_rproc;
> @@ -367,37 +293,10 @@ static int adsp_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto free_rproc;
>  
> -	ret = adsp_request_irq(adsp, pdev, "wdog", adsp_wdog_interrupt);
> -	if (ret < 0)
> -		goto free_rproc;
> -	adsp->wdog_irq = ret;
> -
> -	ret = adsp_request_irq(adsp, pdev, "fatal", adsp_fatal_interrupt);
> -	if (ret < 0)
> -		goto free_rproc;
> -	adsp->fatal_irq = ret;
> -
> -	ret = adsp_request_irq(adsp, pdev, "ready", adsp_ready_interrupt);
> -	if (ret < 0)
> -		goto free_rproc;
> -	adsp->ready_irq = ret;
> -
> -	ret = adsp_request_irq(adsp, pdev, "handover", adsp_handover_interrupt);
> -	if (ret < 0)
> -		goto free_rproc;
> -	adsp->handover_irq = ret;
> -
> -	ret = adsp_request_irq(adsp, pdev, "stop-ack", adsp_stop_ack_interrupt);
> -	if (ret < 0)
> -		goto free_rproc;
> -	adsp->stop_ack_irq = ret;
> -
> -	adsp->state = qcom_smem_state_get(&pdev->dev, "stop",
> -					  &adsp->stop_bit);
> -	if (IS_ERR(adsp->state)) {
> -		ret = PTR_ERR(adsp->state);
> +	ret = qcom_q6v5_init(&adsp->q6v5, pdev, rproc, desc->crash_reason_smem,
> +			     qcom_pas_handover);
> +	if (ret)
>  		goto free_rproc;
> -	}
>  
>  	qcom_add_glink_subdev(rproc, &adsp->glink_subdev);
>  	qcom_add_smd_subdev(rproc, &adsp->smd_subdev);
> @@ -422,7 +321,6 @@ static int adsp_remove(struct platform_device *pdev)
>  {
>  	struct qcom_adsp *adsp = platform_get_drvdata(pdev);
>  
> -	qcom_smem_state_put(adsp->state);

 Is this change required ?

  Otherwise,
       reviewed-by: Sricharan R <sricharan@codeaurora.org>

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

---
This email has been checked for viruses by Avast antivirus software.
https://www.avast.com/antivirus
