Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966011AbeEIXZI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 19:25:08 -0400
Received: from mail-pl0-f45.google.com ([209.85.160.45]:35026 "EHLO
        mail-pl0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965949AbeEIXZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 19:25:05 -0400
X-Google-Smtp-Source: AB8JxZqEhOpbgW3LllKHJ3PBmLfSI7dO18Qr8ZqQDYwMPpPC1gMpmluHd51RAj01qzGgF3CJR8hR7g==
Date: Wed, 9 May 2018 16:25:03 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Lina Iyer <ilina@codeaurora.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org,
        dianders@chromium.org, rplsssn@codeaurora.org
Subject: Re: [PATCH v8 05/10] drivers: qcom: rpmh-rsc: write sleep/wake
 requests to TCS
Message-ID: <20180509232503.GJ19594@google.com>
References: <20180509170159.29682-1-ilina@codeaurora.org>
 <20180509170159.29682-6-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180509170159.29682-6-ilina@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lina,

On Wed, May 09, 2018 at 11:01:54AM -0600, Lina Iyer wrote:
> Sleep and wake requests are sent when the application processor
> subsystem of the SoC is entering deep sleep states like in suspend.
> These requests help lower the system power requirements when the
> resources are not in use.
> 
> Sleep and wake requests are written to the TCS slots but are not
> triggered at the time of writing. The TCS are triggered by the firmware
> after the last of the CPUs has executed its WFI. Since these requests
> may come in different batches of requests, it is the job of this
> controller driver to find and arrange the requests into the available
> TCSes.
> 
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> Reviewed-by: Evan Green <evgreen@chromium.org>
> 
> ---
>
> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> index c0edf3850147..b5894b001ae1 100644
> --- a/drivers/soc/qcom/rpmh-rsc.c
> +++ b/drivers/soc/qcom/rpmh-rsc.c
>
> <snip>
>
> +static int find_match(const struct tcs_group *tcs, const struct tcs_cmd *cmd,
> +		      int len)
> +{
> +	int i, j;
> +
> +	/* Check for already cached commands */
> +	for_each_set_bit(i, tcs->slots, MAX_TCS_SLOTS) {
> +		if (tcs->cmd_cache[i] != cmd[0].addr)
> +			continue;
> +		if (i + len >= MAX_TCS_SLOTS)
> +			goto seq_err;

The command cache can have less than MAX_TCS_SLOTS slot:

static int rpmh_probe_tcs_config(struct platform_device *pdev,
				 struct rsc_drv *drv)
{
	...
	tcs->cmd_cache = devm_kcalloc(&pdev->dev,
				      tcs->num_tcs * ncpt, sizeof(u32),
				      GFP_KERNEL);
	...
}

So the condition needs to be:

if (i + len >= tcs->num_tcs * tcs->ncpt)

> +static int find_slots(struct tcs_group *tcs, const struct tcs_request *msg,
> +		      int *tcs_id, int *cmd_id)
> +{
> +	int slot, offset;
> +	int i = 0;
> +
> +	/* Find if we already have the msg in our TCS */
> +	slot = find_match(tcs, msg->cmds, msg->num_cmds);
> +	if (slot >= 0)
> +		goto copy_data;
> +
> +	/* Do over, until we can fit the full payload in a TCS */
> +	do {
> +		slot = bitmap_find_next_zero_area(tcs->slots, MAX_TCS_SLOTS,
> +						  i, msg->num_cmds, 0);
> +		if (slot == MAX_TCS_SLOTS)
> +			return -ENOMEM;

Like above, use 'tcs->num_tcs * tcs->ncpt' as maximum instead of
MAX_TCS_SLOTS.

> +static int tcs_ctrl_write(struct rsc_drv *drv, const struct tcs_request *msg)
> +{
> +	struct tcs_group *tcs;
> +	int tcs_id = 0, cmd_id = 0;
> +	unsigned long flags;
> +	int ret;
> +
> +	tcs = get_tcs_for_msg(drv, msg);
> +	if (IS_ERR(tcs))
> +		return PTR_ERR(tcs);
> +
> +	spin_lock_irqsave(&tcs->lock, flags);
> +	/* find the m-th TCS and the n-th position in the TCS to write to */

The comment still refers to the old names 'm' and 'n'.

Thanks

Matthias
