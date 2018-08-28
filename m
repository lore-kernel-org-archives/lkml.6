Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD6B3C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 06:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A3D1208B8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 06:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fgtXPpQD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A3D1208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbeH1J6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 05:58:10 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41798 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbeH1J6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 05:58:10 -0400
Received: by mail-pl1-f195.google.com with SMTP id b12-v6so273191plr.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 23:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1gz0QUOyDELSXPq8oYLdkv91q2FkyPWu+KFLJVcfsZk=;
        b=fgtXPpQDeM8ElLKR66sxbEy1BIeQ/wV5skj42++tHHpp4N20OKNAVTXHmM/JJFEzpy
         mbuFi+ZpEI5enlw+e/ksVSRh4XF+1TupIfokiGnFL9EidEi/KUBvX9c6ER9kP7kS55mv
         RG9M1u1Y1bu5d6sPatTPr6jP++wkSWglyIRY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1gz0QUOyDELSXPq8oYLdkv91q2FkyPWu+KFLJVcfsZk=;
        b=SjfnstTzV7UqbNTkeGITTJbY4f3pfPWgQxp7ZTgFOukhLDNrJD/HMJL2n65coLe9Gw
         3zKDYqwGYiqTBB3PCvSgJ3cgaBi+crV5qHP4lblIfXItf5BpBrAQlglQM/lJY5ZZQoIH
         +OvbAChep4yt4MM26wsTBmgkBGPGSTZnGq5ZR2CW3o8uSf7rICrjmdQWp86Yfuck9dH2
         ZrxVD5F5Sp1z4tuFiLjIX2jKI8Qqi0afhOx1Gvr+Nm0kJBWHbLgVLIcEG1Mr6aTesnLA
         xGiGMdF0HDaZw/z/9pZFYJvwyQXzIhK02xKPURE+BRiW91C7ee9yQn83HS5OaUzeliuv
         cdeg==
X-Gm-Message-State: APzg51CwnfQZf0QP/nj4b4ngmUgBI48aukXuftGc9USxxEFTLa3VD297
        5LAfMVaO5fwze1IHYHnsR07Pxw==
X-Google-Smtp-Source: ANB0VdYgnzS0Kw3fe0KpZd8T6eqJVWYDH8cZemr8FH6uczS7cHtOwhn+x8eSV5yZ9sfEnXaA9aauJQ==
X-Received: by 2002:a17:902:aa46:: with SMTP id c6-v6mr117483plr.244.1535436486386;
        Mon, 27 Aug 2018 23:08:06 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id a19-v6sm233994pfj.38.2018.08.27.23.08.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Aug 2018 23:08:05 -0700 (PDT)
Date:   Mon, 27 Aug 2018 23:09:43 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rohit kumar <rohitkr@codeaurora.org>
Cc:     ohad@wizery.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bgoswami@codeaurora.org,
        sbpata@codeaurora.org
Subject: Re: [PATCH v2] remoteproc: qcom: Introduce Non-PAS ADSP PIL driver
Message-ID: <20180828060943.GI5090@builder>
References: <1530264053-8394-1-git-send-email-rohitkr@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530264053-8394-1-git-send-email-rohitkr@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 29 Jun 02:20 PDT 2018, Rohit kumar wrote:

> This adds APSS based ADSP PIL driver for QCOM SoCs.
> Added initial support for SDM845 with ADSP bootup and
> shutdown operation handled from Application Processor
> SubSystem(APSS).
> 

Hi Rohit,

I've submitted a patch that renames the PAS based adsp driver, please
rebase your patch upon this.

> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
> Changes since v1:
> - Used APIs from qcom_q6v5.c
> - Use clock, reset and regmap driver APIs instead of 
>   directly writing into the LPASS registers.
> - Created new file for non PAS ADSP PIL instead of extending
>   existing ADSP PIL driver.
> - cleanups as suggested by Bjorn and Rob.
> 
>  .../bindings/remoteproc/qcom,non-pas-adsp.txt      | 138 +++++
>  drivers/remoteproc/Kconfig                         |  18 +
>  drivers/remoteproc/Makefile                        |   1 +
>  drivers/remoteproc/qcom_nonpas_adsp_pil.c          | 667 +++++++++++++++++++++
>  4 files changed, 824 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,non-pas-adsp.txt
>  create mode 100644 drivers/remoteproc/qcom_nonpas_adsp_pil.c
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,non-pas-adsp.txt b/Documentation/devicetree/bindings/remoteproc/qcom,non-pas-adsp.txt
> new file mode 100644
> index 0000000..0581aaa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,non-pas-adsp.txt

qcom,adsp-pil.txt

> @@ -0,0 +1,138 @@
> +Qualcomm Technology Inc. Non PAS ADSP Peripheral Image Loader
> +
> +This document defines the binding for a component that loads and boots firmware
> +on the Qualcomm Technology Inc. ADSP Hexagon core.
> +
> +- compatible:
> +	Usage: required
> +	Value type: <string>
> +	Definition: must be one of:
> +		    "qcom,sdm845-apss-adsp-pil"

"qcom,sdm845-adsp-pil"

> +
> +- reg:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: must specify the base address and size of the qdsp6ss
> +
> +- reg-names:
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: must be "qdsp6ss"

No need for reg-names when we have a single reg.

> +
> +- interrupts-extended:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: must list the watchdog, fatal IRQs ready, handover and
> +		    stop-ack IRQs
> +
[..]
> +
> += EXAMPLE
> +The following example describes the resources needed to boot control the
> +ADSP, as it is found on SDM845 boards.
> +	adsp-pil {
> +		compatible = "qcom,sdm845-apss-adsp-pil";
> +
> +		reg = <0x17300000 0x40c>;
> +		reg-names = "qdsp6ss";
> +
> +		interrupts-extended = <&intc 0 162 IRQ_TYPE_EDGE_RISING>,
> +			<&adsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
> +			<&adsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
> +			<&adsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
> +			<&adsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
> +		interrupt-names = "wdog", "fatal", "ready",
> +			"handover", "stop-ack";
> +
> +		clocks = <&clock_rpmh RPMH_CXO_CLK>,
> +			<&lpasscc GCC_LPASS_SWAY_CLK>,
> +			<&lpasscc LPASS_AUDIO_WRAPPER_AON_CLK>,
> +			<&lpasscc LPASS_Q6SS_AHBS_AON_CLK>,
> +			<&lpasscc LPASS_Q6SS_AHBM_AON_CLK>,
> +			<&lpasscc LPASS_QDSP6SS_XO_CLK>,
> +			<&lpasscc LPASS_QDSP6SS_SLEEP_CLK>,
> +			<&lpasscc LPASS_QDSP6SS_CORE_CLK>;
> +		clock-names = "xo", "sway_cbcr", "lpass_aon",
> +			"lpass_ahbs_aon_cbcr",
> +			"lpass_ahbm_aon_cbcr", "qdsp6ss_xo",
> +			"qdsp6ss_sleep", "qdsp6ss_core";
> +
> +		cx-supply = <&pm8998_s9_level>;

If this is a corner you should use the power-domain reference to the
appropriate rpmhpd resource.

> +
> +		resets = <&pdc_reset PDC_AUDIO_SYNC_RESET>,
> +			 <&aoss_reset AOSS_CC_LPASS_RESTART>;
> +		reset-names = "pdc_sync", "cc_lpass";
> +
> +		qcom,halt-regs = <&tcsr_mutex_regs 0x22000>;
> +
> +		memory-region = <&pil_adsp_mem>;
> +
> +		qcom,smem-states = <&adsp_smp2p_out 0>;
> +		qcom,smem-state-names = "stop";
> +	};
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index 0dde375..9de0a53 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -100,6 +100,24 @@ config QCOM_ADSP_PIL
>  	  Say y here to support the TrustZone based Peripherial Image Loader
>  	  for the Qualcomm ADSP remote processors.
>  
> +config QCOM_NON_PAS_ADSP_PIL

QCOM_ADSP_PIL

[..]
> diff --git a/drivers/remoteproc/qcom_nonpas_adsp_pil.c b/drivers/remoteproc/qcom_nonpas_adsp_pil.c
> new file mode 100644
> index 0000000..826d3d4
> --- /dev/null
> +++ b/drivers/remoteproc/qcom_nonpas_adsp_pil.c

Now qcom_adsp_pil.c

[..]
> +struct qcom_adsp {
[..]
> +
> +	struct qcom_rproc_glink glink_subdev;
> +	struct qcom_rproc_subdev smd_subdev;

We don't use smd on sdm845, so omit this until we have a user.

> +	struct qcom_rproc_ssr ssr_subdev;
> +	struct qcom_sysmon *sysmon;
> +};
> +
> +static int adsp_clk_enable(struct qcom_adsp *adsp)
> +{
> +	int ret;
> +
> +	/* Enable SWAY clock */
> +	ret = clk_prepare_enable(adsp->gcc_sway_cbcr);
> +	if (ret)
> +		return ret;
> +
> +	/* Enable LPASS AHB AON Bus */
> +	ret = clk_prepare_enable(adsp->lpass_audio_aon_clk);
> +	if (ret)
> +		return ret;
> +
> +	/* Enable the QDSP6SS AHBM and AHBS clocks */
> +	ret = clk_prepare_enable(adsp->lpass_ahbs_aon_cbcr);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_prepare_enable(adsp->lpass_ahbm_aon_cbcr);
> +	if (ret)
> +		return ret;
> +
> +	/* Turn on the XO clock, required to boot FSM */
> +	ret = clk_prepare_enable(adsp->qdsp6ss_xo_cbcr);
> +	if (ret)
> +		return ret;
> +
> +	/* Enable the QDSP6SS sleep clock for the QDSP6 watchdog enablement */
> +	ret = clk_prepare_enable(adsp->qdsp6ss_sleep_cbcr);
> +	if (ret)
> +		return ret;
> +
> +	/* Configure QDSP6 core CBC to enable clock */
> +	ret = clk_prepare_enable(adsp->qdsp6ss_core_cbcr);
> +	if (ret)
> +		return ret;

Can we use the clk_bulk interface instead of using this expanded form?

> +
> +	return ret;
> +}
> +
> +static int adsp_reset(struct qcom_adsp *adsp)
> +{
> +	unsigned int val;
> +	int ret = 0;

No need to initialize ret.

> +
> +	/* De-assert QDSP6 stop core. QDSP6 will execute after out of reset */
> +	writel(0x1, adsp->qdsp6ss_base + CORE_START_REG);
> +
> +	/* Trigger boot FSM to start QDSP6 */
> +	writel(0x1, adsp->qdsp6ss_base + BOOT_CMD_REG);
> +
> +	/* Wait for core to come out of reset */
> +	ret = readl_poll_timeout(adsp->qdsp6ss_base + BOOT_STATUS_REG,
> +			val, (val & BIT(0)) != 0, 10, BOOT_FSM_TIMEOUT);
> +	if (ret)
> +		dev_err(adsp->dev, "Boot FSM failed to complete.\n");
> +
> +	return ret;
> +}
> +
> +static int qcom_adsp_start(struct qcom_adsp *adsp)

I don't see the reason why adsp_reset() is split out from this function,
or why qcom_adsp_start() is split out from adsp_start.

> +{
> +	int ret;
> +
> +	ret = adsp_clk_enable(adsp);
> +	if (ret) {
> +		dev_err(adsp->dev, "adsp clk_enable failed\n");
> +		return ret;
> +	}
> +
> +	/* Program boot address */
> +	writel(adsp->mem_phys >> 4, adsp->qdsp6ss_base + RST_EVB_REG);
> +
> +	ret = adsp_reset(adsp);
> +	if (ret)
> +		dev_err(adsp->dev, "De-assert QDSP6 out of reset failed\n");
> +
> +	return ret;
> +}
> +
> +static int qcom_adsp_shutdown(struct qcom_adsp *adsp)
> +{
> +	unsigned long timeout;
> +	unsigned int val;
> +	int ret;
> +
> +	/* Reset the retention logic */
> +	val = readl(adsp->qdsp6ss_base + RET_CFG_REG);
> +	val |= 0x1;
> +	writel(val, adsp->qdsp6ss_base + RET_CFG_REG);
> +
> +	/* Disable QDSP6 core CBCR clock */
> +	clk_disable_unprepare(adsp->qdsp6ss_core_cbcr);
> +
> +	/* Disable the QDSP6SS sleep clock */
> +	clk_disable_unprepare(adsp->qdsp6ss_sleep_cbcr);
> +
> +	/* Turn off the XO clock */
> +	clk_disable_unprepare(adsp->qdsp6ss_xo_cbcr);
> +
> +	/* Disable the QDSP6SS AHBM and AHBS clocks */
> +	clk_disable_unprepare(adsp->lpass_ahbs_aon_cbcr);
> +
> +	clk_disable_unprepare(adsp->lpass_ahbm_aon_cbcr);
> +
> +	/* Disable LPASS AHB AON Bus */
> +	clk_disable_unprepare(adsp->lpass_audio_aon_clk);
> +
> +	/* Disable the slave way clock to LPASS */
> +	clk_disable_unprepare(adsp->gcc_sway_cbcr);
> +
> +	/* QDSP6 master port needs to be explicitly halted */
> +	ret = regmap_read(adsp->halt_map,
> +			adsp->halt_lpass + LPASS_PWR_ON_REG, &val);
> +	if (ret || !val)
> +		goto reset;
> +
> +	ret = regmap_read(adsp->halt_map,
> +			adsp->halt_lpass + LPASS_MASTER_IDLE_REG,
> +			&val);
> +	if (ret || val)
> +		goto reset;
> +
> +	regmap_write(adsp->halt_map,
> +			adsp->halt_lpass + LPASS_HALTREQ_REG, 1);
> +
> +	/*  Wait for halt ACK from QDSP6 */
> +	timeout = jiffies + msecs_to_jiffies(ACK_TIMEOUT);
> +	for (;;) {
> +		ret = regmap_read(adsp->halt_map,
> +			adsp->halt_lpass + LPASS_HALTACK_REG, &val);
> +		if (ret || val || time_after(jiffies, timeout))
> +			break;
> +
> +		udelay(1000);
> +	}
> +
> +	ret = regmap_read(adsp->halt_map,
> +			adsp->halt_lpass + LPASS_MASTER_IDLE_REG, &val);
> +	if (ret || !val)
> +		dev_err(adsp->dev, "port failed halt\n");
> +
> +reset:
> +	/* Assert the LPASS PDC Reset */
> +	reset_control_assert(adsp->pdc_sync_reset);
> +	/* Place the LPASS processor into reset */
> +	reset_control_assert(adsp->cc_lpass_restart);
> +	/* wait after asserting subsystem restart from AOSS */
> +	udelay(200);
> +
> +	/* Clear the halt request for the AXIM and AHBM for Q6 */
> +	regmap_write(adsp->halt_map, adsp->halt_lpass + LPASS_HALTREQ_REG, 0);
> +
> +	/* De-assert the LPASS PDC Reset */
> +	reset_control_deassert(adsp->pdc_sync_reset);
> +	/* Remove the LPASS reset */
> +	reset_control_deassert(adsp->cc_lpass_restart);
> +	/* wait after de-asserting subsystem restart from AOSS */
> +	udelay(200);

Is the core halted at this point?

> +
> +	return 0;
> +}
> +
> +static int adsp_load(struct rproc *rproc, const struct firmware *fw)
> +{
> +	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
> +
> +	return qcom_mdt_load_no_init(adsp->dev, fw, rproc->firmware, 0,
> +			     adsp->mem_region, adsp->mem_phys, adsp->mem_size,
> +			     &adsp->mem_reloc);
> +}
> +
> +static int adsp_start(struct rproc *rproc)
> +{
> +	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
> +	int ret;
> +
> +	qcom_q6v5_prepare(&adsp->q6v5);
> +
> +	ret = clk_prepare_enable(adsp->xo);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_prepare_enable(adsp->aggre2_clk);
> +	if (ret)
> +		goto disable_xo_clk;

Just skip aggre2_clk for now, unless there's going to be some other
subsystem added soon that uses it.

> +
> +	ret = regulator_enable(adsp->cx_supply);
> +	if (ret)
> +		goto disable_aggre2_clk;
> +
> +	ret = regulator_enable(adsp->px_supply);
> +	if (ret)
> +		goto disable_cx_supply;

Skip px_supply for now.

> +
> +	ret = qcom_adsp_start(adsp);
> +	if (ret) {
> +		dev_err(adsp->dev,
> +			"failed to bootup adsp\n");
> +		goto disable_px_supply;
> +	}
> +
> +	ret = qcom_q6v5_wait_for_start(&adsp->q6v5, msecs_to_jiffies(5000));

Use 5 * HZ

> +	if (ret == -ETIMEDOUT) {
> +		dev_err(adsp->dev, "start timed out\n");
> +		qcom_adsp_shutdown(adsp);
> +		goto disable_px_supply;
> +	}
> +
> +	return 0;
> +
> +disable_px_supply:
> +	regulator_disable(adsp->px_supply);
> +disable_cx_supply:
> +	regulator_disable(adsp->cx_supply);
> +disable_aggre2_clk:
> +	clk_disable_unprepare(adsp->aggre2_clk);
> +disable_xo_clk:
> +	clk_disable_unprepare(adsp->xo);
> +
> +	return ret;
> +}
> +
> +static void qcom_adsp_pil_handover(struct qcom_q6v5 *q6v5)
> +{
> +	struct qcom_adsp *adsp = container_of(q6v5, struct qcom_adsp, q6v5);
> +
> +	regulator_disable(adsp->px_supply);
> +	regulator_disable(adsp->cx_supply);
> +	clk_disable_unprepare(adsp->aggre2_clk);
> +	clk_disable_unprepare(adsp->xo);

Omit px_supply and aggre2_clk for now.

> +}
[..]
> +static int adsp_init_clock(struct qcom_adsp *adsp)
> +{
> +	int ret;
> +
> +	adsp->xo = devm_clk_get(adsp->dev, "xo");
> +	if (IS_ERR(adsp->xo)) {
> +		ret = PTR_ERR(adsp->xo);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(adsp->dev, "failed to get xo clock");
> +		return ret;
> +	}
> +
> +	if (adsp->has_aggre2_clk) {

Omit this for now.

> +		adsp->aggre2_clk = devm_clk_get(adsp->dev, "aggre2");
> +		if (IS_ERR(adsp->aggre2_clk)) {
> +			ret = PTR_ERR(adsp->aggre2_clk);
> +			if (ret != -EPROBE_DEFER)
> +				dev_err(adsp->dev,
> +						"failed to get aggre2 clock");
> +			return ret;
> +		}
> +	}
> +
> +	adsp->gcc_sway_cbcr = devm_clk_get(adsp->dev, "sway_cbcr");

Use the clk_bulk api to acquire the rest of these clocks.

> +	if (IS_ERR(adsp->gcc_sway_cbcr)) {
> +		ret = PTR_ERR(adsp->xo);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(adsp->dev, "failed to get gcc_sway clock\n");
> +		return PTR_ERR(adsp->gcc_sway_cbcr);
> +	}
> +
[..]
> +
> +static const struct non_pas_adsp_data adsp_resource_init = {
> +		.crash_reason_smem = 423,
> +		.firmware_name = "adsp.mdt",
> +		.has_aggre2_clk = false,
> +		.ssr_name = "lpass",
> +		.sysmon_name = "adsp",
> +		.ssctl_id = 0x14,

Please don't inherit the broken indentation.

> +};

Regards,
Bjorn
