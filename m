Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752202AbeERT6v (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 15:58:51 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:34248 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751156AbeERT6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 15:58:48 -0400
X-Google-Smtp-Source: AB8JxZrFIN0MdeYHT0nDQM+3xy602HL64GDoCpMRI1eMfBg/ZE1FTvleKbCwCqg7/GOYJajQ5ZlhqA==
Date: Fri, 18 May 2018 12:58:45 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Sibi Sankar <sibis@codeaurora.org>
Cc: ohad@wizery.com, clew@codeaurora.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] remoteproc: Proxy unvote clk/regs in handover context
Message-ID: <20180518195845.GS14924@minitux>
References: <20180425145025.21654-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425145025.21654-1-sibis@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 25 Apr 07:50 PDT 2018, Sibi Sankar wrote:

> Introduce interrupt handler for smp2p ready interrupt and
> handle start completion. Remove the proxy votes for clocks
> and regulators in the handover interrupt context. Disable
> wdog and fatal interrupts on remoteproc device stop and
> re-enable them on remoteproc device start.

Can't the enable/disable dance be split out into a separate commit?
Making the introduction of them cleaner in the git history?

> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  drivers/remoteproc/qcom_q6v5_pil.c | 71 +++++++++++++++++++++++++-----
>  1 file changed, 60 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_pil.c b/drivers/remoteproc/qcom_q6v5_pil.c
> index 296eb3f8b551..7e2d04d4f2f0 100644
> --- a/drivers/remoteproc/qcom_q6v5_pil.c
> +++ b/drivers/remoteproc/qcom_q6v5_pil.c
> @@ -143,6 +143,10 @@ struct q6v5 {
>  	struct qcom_smem_state *state;
>  	unsigned stop_bit;
>  
> +	unsigned int handover_interrupt;
> +	unsigned int wdog_interrupt;
> +	unsigned int fatal_interrupt;

Make these "int", and write "irq" instead of "interrupt".

> +
>  	struct clk *active_clks[8];
>  	struct clk *proxy_clks[4];
>  	int active_clk_count;
> @@ -170,6 +174,7 @@ struct q6v5 {
>  	struct qcom_rproc_ssr ssr_subdev;
>  	struct qcom_sysmon *sysmon;
>  	bool need_mem_protection;
> +	bool unvoted_flag;
>  	int mpss_perm;
>  	int mba_perm;
>  	int version;
> @@ -727,6 +732,7 @@ static int q6v5_start(struct rproc *rproc)
>  	int xfermemop_ret;
>  	int ret;
>  
> +	qproc->unvoted_flag = false;
>  	ret = q6v5_regulator_enable(qproc, qproc->proxy_regs,
>  				    qproc->proxy_reg_count);
>  	if (ret) {
> @@ -793,9 +799,16 @@ static int q6v5_start(struct rproc *rproc)
>  	if (ret)
>  		goto reclaim_mpss;
>  
> +	enable_irq(qproc->handover_interrupt);
> +	enable_irq(qproc->wdog_interrupt);
> +	enable_irq(qproc->fatal_interrupt);
> +
>  	ret = wait_for_completion_timeout(&qproc->start_done,
>  					  msecs_to_jiffies(5000));
>  	if (ret == 0) {
> +		disable_irq(qproc->handover_interrupt);
> +		disable_irq(qproc->wdog_interrupt);
> +		disable_irq(qproc->fatal_interrupt);
>  		dev_err(qproc->dev, "start timed out\n");
>  		ret = -ETIMEDOUT;
>  		goto reclaim_mpss;
> @@ -809,11 +822,6 @@ static int q6v5_start(struct rproc *rproc)
>  			"Failed to reclaim mba buffer system may become unstable\n");
>  	qproc->running = true;
>  
> -	q6v5_clk_disable(qproc->dev, qproc->proxy_clks,
> -			 qproc->proxy_clk_count);
> -	q6v5_regulator_disable(qproc, qproc->proxy_regs,
> -			       qproc->proxy_reg_count);
> -
>  	return 0;
>  
>  reclaim_mpss:
> @@ -892,6 +900,16 @@ static int q6v5_stop(struct rproc *rproc)
>  	WARN_ON(ret);
>  
>  	reset_control_assert(qproc->mss_restart);
> +	disable_irq(qproc->handover_interrupt);
> +	if (!qproc->unvoted_flag) {
> +		q6v5_clk_disable(qproc->dev, qproc->proxy_clks,
> +				 qproc->proxy_clk_count);
> +		q6v5_regulator_disable(qproc, qproc->proxy_regs,
> +				       qproc->proxy_reg_count);
> +	}

Perhaps break this out into a separate function and call it from the two
places?

> +	disable_irq(qproc->wdog_interrupt);
> +	disable_irq(qproc->fatal_interrupt);

Any particular reason why you didn't group the disable_irq() calls
together? Would look prettier than spreading them on each side of the
resource disable.

> +
>  	q6v5_clk_disable(qproc->dev, qproc->active_clks,
>  			 qproc->active_clk_count);
>  	q6v5_regulator_disable(qproc, qproc->active_regs,
[..]
> @@ -1184,19 +1221,31 @@ static int q6v5_probe(struct platform_device *pdev)
>  
>  	qproc->version = desc->version;
>  	qproc->need_mem_protection = desc->need_mem_protection;
> -	ret = q6v5_request_irq(qproc, pdev, "wdog", q6v5_wdog_interrupt);
> +	ret = q6v5_request_irq(qproc, pdev, "wdog", q6v5_wdog_interrupt,
> +			       &qproc->wdog_interrupt);

I think it's time to inline this function instead. You can omit the
first error handling and rely on request_irq to fail if you pass it an
invalid irq number.

> +	if (ret < 0)
> +		goto free_rproc;
> +	disable_irq(qproc->wdog_interrupt);

I presume this is to balance the IRQ enable/disable later?

> +

Regards,
Bjorn
