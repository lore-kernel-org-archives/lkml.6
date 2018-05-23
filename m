Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754070AbeEWG0v (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 02:26:51 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37632 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753989AbeEWG0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 02:26:49 -0400
X-Google-Smtp-Source: AB8JxZqSFCuS/xjE5ix7WXrD8bfai4iLT5kJVHgLEhpcqKaB3wMwi6PfoaXl0/PVpj2bKrsgSqhyQA==
Date: Tue, 22 May 2018 23:26:45 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Rohit kumar <rohitkr@codeaurora.org>
Cc: ohad@wizery.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bgoswami@codeaurora.org,
        sbpata@codeaurora.org, asishb@codeaurora.org, rkarra@codeaurora.org,
        RajendraBabu Medisetti <rajendrabm@codeaurora.org>,
        Krishnamurthy Renu <krishnamurthy.renu@codeaurora.org>
Subject: Re: [PATCH] remoteproc:  Add APSS based Qualcomm ADSP PIL driver for
 SDM845
Message-ID: <20180523062645.GY14924@minitux>
References: <1526194908-19027-1-git-send-email-rohitkr@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526194908-19027-1-git-send-email-rohitkr@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 13 May 00:01 PDT 2018, Rohit kumar wrote:

> This adds Qualcomm ADSP PIL driver support for SDM845 with ADSP bootup
> and shutdown operation handled from Application Processor SubSystem(APSS).
> 
> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
> Signed-off-by: RajendraBabu Medisetti <rajendrabm@codeaurora.org>
> Signed-off-by: Krishnamurthy Renu <krishnamurthy.renu@codeaurora.org>
> ---
>  .../devicetree/bindings/remoteproc/qcom,adsp.txt   |   1 +
>  drivers/remoteproc/Makefile                        |   3 +-
>  drivers/remoteproc/qcom_adsp_pil.c                 | 122 ++++-----
>  drivers/remoteproc/qcom_adsp_pil.h                 |  86 ++++++
>  drivers/remoteproc/qcom_adsp_pil_sdm845.c          | 304 +++++++++++++++++++++
>  5 files changed, 454 insertions(+), 62 deletions(-)
>  create mode 100644 drivers/remoteproc/qcom_adsp_pil.h
>  create mode 100644 drivers/remoteproc/qcom_adsp_pil_sdm845.c
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
> index 728e419..a9fe033 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
> @@ -10,6 +10,7 @@ on the Qualcomm ADSP Hexagon core.
>  		    "qcom,msm8974-adsp-pil"
>  		    "qcom,msm8996-adsp-pil"
>  		    "qcom,msm8996-slpi-pil"
> +		    "qcom,sdm845-apss-adsp-pil"

Afaict there's nothing in this binding that ties this to the apss, so I
don't think we should base the compatible on this. The differentiation
is PAS vs non-PAS; so let's start naming the PAS variants
"qcom,platform-subsystem-pas" and the non-PAS
"qcom,platform-subsystem-pil" instead.

I.e. please make this "qcom,sdm845-adsp-pil".

More importantly, any resources such as clocks or reset lines should
come from DT and as such you need to extend the binding quite a bit -
which I suggest you do by introducing a new binding document.

>  
>  - interrupts-extended:
>  	Usage: required
> diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
> index 02627ed..759831b 100644
> --- a/drivers/remoteproc/Makefile
> +++ b/drivers/remoteproc/Makefile
> @@ -14,7 +14,8 @@ obj-$(CONFIG_OMAP_REMOTEPROC)		+= omap_remoteproc.o
>  obj-$(CONFIG_WKUP_M3_RPROC)		+= wkup_m3_rproc.o
>  obj-$(CONFIG_DA8XX_REMOTEPROC)		+= da8xx_remoteproc.o
>  obj-$(CONFIG_KEYSTONE_REMOTEPROC)	+= keystone_remoteproc.o
> -obj-$(CONFIG_QCOM_ADSP_PIL)		+= qcom_adsp_pil.o
> +obj-$(CONFIG_QCOM_ADSP_PIL)		+= qcom_adsp.o
> +qcom_adsp-objs				+= qcom_adsp_pil.o qcom_adsp_pil_sdm845.o
>  obj-$(CONFIG_QCOM_RPROC_COMMON)		+= qcom_common.o
>  obj-$(CONFIG_QCOM_Q6V5_PIL)		+= qcom_q6v5_pil.o
>  obj-$(CONFIG_QCOM_SYSMON)		+= qcom_sysmon.o
> diff --git a/drivers/remoteproc/qcom_adsp_pil.c b/drivers/remoteproc/qcom_adsp_pil.c

I get the feeling that the main reason for modifying this file is its
name, not that it reduces the complexity of the final solution. I
definitely think it's cleaner to have some structural duplication and
keep this driver handling the various PAS based remoteprocs.

Please see the RFC series I posted reducing the duplication between the
various "Q6V5 drivers".

[..]
> diff --git a/drivers/remoteproc/qcom_adsp_pil.h b/drivers/remoteproc/qcom_adsp_pil.h
[..]
> +static inline void update_bits(void *reg, u32 mask_val, u32 set_val, u32 shift)
> +{
> +	u32 reg_val = 0;
> +
> +	reg_val = ((readl(reg)) & ~mask_val) | ((set_val << shift) & mask_val);
> +	writel(reg_val, reg);
> +}
> +
> +static inline unsigned int read_bit(void *reg, u32 mask, int shift)
> +{
> +	return ((readl(reg) & mask) >> shift);
> +}

I don't like these helper functions, their prototype is nonstandard and
makes it really hard to read all the calling code.

I would prefer if you just inline the operations directly, to make it
clearer what's going on in each case - if not then at least follow the
prototype of e.g. regmap_udpate_bits(), which people might be used to.

> +
> +#endif
> diff --git a/drivers/remoteproc/qcom_adsp_pil_sdm845.c b/drivers/remoteproc/qcom_adsp_pil_sdm845.c
> new file mode 100644
> index 0000000..7518385
> --- /dev/null
> +++ b/drivers/remoteproc/qcom_adsp_pil_sdm845.c
> @@ -0,0 +1,304 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Qualcomm APSS Based ADSP bootup/shutdown ops for SDM845.
> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +
> +#include "qcom_adsp_pil.h"
> +
> +/* set values */
> +#define CLK_ENABLE				0x1
> +#define CLK_DISABLE				0x0

Just write 0 and 1 in the code, it saves future readers the trouble of
having to remember if these are special in any way.

> +/* time out value */
> +#define ACK_TIMEOUT				200000

This is currently given in the rather awkward unit of 5uS. As it's input
to what should have been a call to readl_poll_timeout() please express
it in micro seconds.

> +/* mask values */
> +#define CLK_MASK				GENMASK(4, 0)
> +#define EVB_MASK				GENMASK(27, 4)
> +#define SPIN_CLKOFF_MASK			BIT(31)
> +#define AUDIO_SYNC_RESET_MASK			BIT(2)
> +#define CLK_ENABLE_MASK				BIT(0)
> +#define HAL_CLK_MASK				BIT(1)
> +/* GCC register offsets */
> +#define GCC_BASE				0x00147000

This doesn't belong here, expose the resource from the gcc driver using
existing frameworks.

> +#define SWAY_CBCR_OFFSET			0x00000008
> +/*LPASS register base address and offsets*/
> +#define LPASS_BASE				0x17000000

This should be in the lpass clock driver.

> +#define AON_CBCR_OFFSET				0x00014098
> +#define CMD_RCGR_OFFSET				0x00014000
> +#define CFG_RCGR_OFFSET				0x00014004
> +#define AHBS_AON_CBCR_OFFSET			0x00033000
> +#define AHBM_AON_CBCR_OFFSET			0x00026000
> +/*QDSP6SS register base address and offsets*/
> +#define QDSP6SS_BASE				0x17300000

This should come from the reg property in DT.

> +#define RST_EVB_OFFSET				0x00000010
> +#define SLEEP_CBCR_OFFSET			0x0000003C
> +#define XO_CBCR_OFFSET				0x00000038
> +#define CORE_CBCR_OFFSET			0x00000020
> +#define CORE_START_OFFSET			0x00000400
> +#define BOOT_CMD_OFFSET				0x00000404
> +#define BOOT_STATUS_OFFSET			0x00000408
> +#define RET_CFG_OFFSET				0x0000001C
> +/*TCSR register base address and offsets*/
> +#define TCSR_BASE				0x01F62000

Look at how we deal with TCSR in the MSS driver instead.

> +#define TCSR_LPASS_MASTER_IDLE_OFFSET		0x00000008
> +#define TCSR_LPASS_HALTACK_OFFSET		0x00000004
> +#define TCSR_LPASS_PWR_ON_OFFSET		0x00000010
> +#define TCSR_LPASS_HALTREQ_OFFSET		0X00000000
> +
> +#define RPMH_PDC_SYNC_RESET_ADDR		0x0B2E0100
> +#define AOSS_CC_LPASS_RESTART_ADDR		0x0C2D0000

Please expose these from an appropriate driver using appropriate
frameworks.

> +
> +struct sdm845_reg {
> +	void __iomem *gcc_base;
> +	void __iomem *lpass_base;
> +	void __iomem *qdsp6ss_base;
> +	void __iomem *tcsr_base;
> +	void __iomem *pdc_sync;
> +	void __iomem *cc_lpass;

I expect to see only qdsp6ss_base remain here.

> +};
> +
> +static int sdm845_map_registers(struct qcom_adsp *adsp,
> +				struct platform_device *pdev)
> +{
> +	struct sdm845_reg *reg;
> +
> +	adsp->priv_reg = devm_kzalloc(&pdev->dev, sizeof(struct sdm845_reg),
> +			GFP_KERNEL);
> +	if (!adsp->priv_reg)
> +		return -ENOMEM;
> +
> +	reg = adsp->priv_reg;
> +
> +	reg->gcc_base = devm_ioremap(adsp->dev, GCC_BASE, 0xc);
> +	if (!reg->gcc_base) {
> +		dev_err(adsp->dev, "%s: failed to map GCC base registers\n",
> +				__func__);
> +		return -ENOMEM;
> +	}
> +
> +	reg->lpass_base = devm_ioremap(adsp->dev, LPASS_BASE, 0x8E004);
> +	if (!reg->lpass_base) {
> +		dev_err(adsp->dev, "%s: failed to map LPASS base registers\n",
> +				__func__);
> +		return -ENOMEM;
> +	}
> +	reg->qdsp6ss_base =  devm_ioremap(adsp->dev, QDSP6SS_BASE, 0x40c);
> +	if (!reg->qdsp6ss_base) {
> +		dev_err(adsp->dev, "%s: failed to map QDSP6SS base registers\n",
> +				__func__);
> +		return -ENOMEM;
> +	}
> +	reg->tcsr_base = devm_ioremap(adsp->dev, TCSR_BASE, 0x14);
> +	if (!reg->tcsr_base) {
> +		dev_err(adsp->dev, "%s: failed to map TCSR base registers\n",
> +				__func__);
> +		return -ENOMEM;
> +	}
> +	reg->pdc_sync = devm_ioremap(adsp->dev, RPMH_PDC_SYNC_RESET_ADDR, 0x4);
> +	if (!reg->pdc_sync) {
> +		dev_err(adsp->dev, "%s: failed to map RPMH_PDC_SYNC_RESET register\n",
> +				__func__);
> +		return -ENOMEM;
> +	}
> +	reg->cc_lpass = devm_ioremap(adsp->dev, AOSS_CC_LPASS_RESTART_ADDR,
> +			0x4);
> +	if (!reg->cc_lpass) {
> +		dev_err(adsp->dev, "%s:failed to map AOSS_CC_LPASS_RESTART register\n",
> +				__func__);
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +static int clk_enable_spin(void *reg, int read_shift, int write_shift)

This should be in the appropriate clock drivers.

> +{
> +	u32 maxDelay = 500;
> +	u32 val;
> +
> +	update_bits(reg, CLK_ENABLE_MASK, CLK_ENABLE, write_shift);
> +	val = readl(reg);
> +	if (!(readl(reg) & HAL_CLK_MASK)) {
> +		/*
> +		 * wait for disabling of HW signal CLK_OFF to confirm that
> +		 * clock is actually ON.
> +		 */
> +		while (maxDelay-- && read_bit(reg, SPIN_CLKOFF_MASK,
> +							read_shift))
> +			udelay(1);
> +	}
> +	if (!maxDelay) {
> +		pr_err("%s: fail to update register = %p\n", __func__, reg);
> +		return -ETIMEDOUT;
> +	}
> +	return 0;
> +}
> +
> +static int sdm845_adsp_clk_enable(struct qcom_adsp *adsp)
> +{
> +	u32 ret;
> +	u32 maxDelay = 100;
> +	struct sdm845_reg *reg = adsp->priv_reg;
> +
> +	/* Enable SWAY clock */
> +	ret = clk_enable_spin(reg->gcc_base + SWAY_CBCR_OFFSET, CLK_MASK, 0x0);
> +	if (ret)
> +		return ret;
> +
> +	/* Enable LPASS AHB AON Bus */
> +	ret = clk_enable_spin(reg->lpass_base + AON_CBCR_OFFSET, CLK_MASK, 0x0);
> +	if (ret)
> +		return ret;
> +
> +	/* Set the AON clock root to be sourced by XO */
> +	writel(CLK_DISABLE, reg->lpass_base + CFG_RCGR_OFFSET);
> +	writel(CLK_ENABLE, reg->lpass_base + CMD_RCGR_OFFSET);
> +
> +	while (read_bit((reg->lpass_base + CMD_RCGR_OFFSET), CLK_ENABLE, 0)
> +						&& maxDelay--)
> +		udelay(2);
> +
> +	if (!maxDelay) {
> +		pr_err("%s: fail to enable CMD_RCGR clock\n", __func__);
> +		return -ETIMEDOUT;
> +	}
> +
> +	/* Enable the QDSP6SS AHBM and AHBS clocks */
> +	ret = clk_enable_spin(reg->lpass_base + AHBS_AON_CBCR_OFFSET,
> +				CLK_MASK, 0x0);
> +	if (ret)
> +		return ret;
> +	ret = clk_enable_spin(reg->lpass_base + AHBM_AON_CBCR_OFFSET,
> +				CLK_MASK, 0x0);
> +	if (ret)
> +		return ret;

Above should be calls to the clock framework.

> +
> +	/* Turn on the XO clock, required to boot FSM */
> +	update_bits(reg->qdsp6ss_base + XO_CBCR_OFFSET, CLK_ENABLE_MASK,
> +							CLK_ENABLE, 0x0);
> +
> +	/* Enable the QDSP6SS sleep clock for the QDSP6 watchdog enablement */
> +	update_bits(reg->qdsp6ss_base + SLEEP_CBCR_OFFSET,
> +					CLK_ENABLE_MASK, CLK_ENABLE, 0x0);
> +
> +	/* Configure QDSP6 core CBC to enable clock */
> +	update_bits(reg->qdsp6ss_base + CORE_CBCR_OFFSET, CLK_ENABLE_MASK,
> +					CLK_ENABLE, 0x0);
> +	return 0;
> +}
> +
> +static int sdm845_adsp_reset(struct qcom_adsp *adsp)
> +{
> +	u32 timeout = ACK_TIMEOUT;
> +	struct sdm845_reg *reg = adsp->priv_reg;
> +
> +	/* De-assert QDSP6 stop core. QDSP6 will execute after out of reset */
> +	update_bits(reg->qdsp6ss_base + CORE_START_OFFSET,
> +					CLK_ENABLE_MASK, CLK_ENABLE, 0x0);
> +	/* Trigger boot FSM to start QDSP6 */
> +	writel(CLK_ENABLE, reg->qdsp6ss_base + BOOT_CMD_OFFSET);
> +
> +	/* Wait for core to come out of reset */
> +	while ((!(readl(reg->qdsp6ss_base +
> +			BOOT_STATUS_OFFSET))) && (timeout-- > 0))
> +		udelay(5);

Use readl_poll_timeout() from linux/iopoll.h

> +
> +	if (!timeout)
> +		return -ETIMEDOUT;
> +
> +	return 0;
> +}
> +
> +static int sdm845_bringup(struct qcom_adsp *adsp)

This is called "start" in other places, please use existing naming
convention to make your code feel familiar to people reading other
drivers.

> +{
> +	u32 ret;

ret is exclusively used to store data of the type "int".

> +	struct sdm845_reg *reg = adsp->priv_reg;
> +
> +	ret = sdm845_adsp_clk_enable(adsp);
> +	if (ret) {
> +		dev_err(adsp->dev, "%s: sdm845_adsp_clk_enable failed\n",
> +				__func__);
> +		return ret;
> +	}
> +	/* Program boot address */
> +	update_bits(reg->qdsp6ss_base + RST_EVB_OFFSET,
> +				EVB_MASK, (adsp->mem_phys) >> 8, 0x4);

In the WCSS PIL driver this is:

	writel(rproc->bootaddr >> 4, wcss->reg_base + QDSP6SS_RST_EVB);          

Which I think is the same as you're doing here, although you're shifting
8 bits right and then 4 (base 16) to the left.

> +
> +	/* Wait for addresses to be programmed before starting adsp */

That's not what mb() does, it just ensures that any read and writes
coming after this point isn't reordered with any operations before it.

And as sdm845_adsp_reset() used writel() there is already a wmb() there,
so you can drop this one.

> +	mb();
> +	ret = sdm845_adsp_reset(adsp);
> +	if (ret)
> +		dev_err(adsp->dev, "%s: De-assert QDSP6 out of reset failed\n",
> +					__func__);

This string is unique in the kernel, so you don't need __func__.

> +	return ret;
> +}
> +
> +static int sdm845_bringdown(struct qcom_adsp *adsp)
> +{
> +	u32 acktimeout = ACK_TIMEOUT;
> +	u32 temp;

We know this is a temporary variable, name it "val" as we do in the
other functions.

> +	struct sdm845_reg *reg = adsp->priv_reg;
> +
> +	/* Reset the retention logic */
> +	update_bits(reg->qdsp6ss_base + RET_CFG_OFFSET,
> +			CLK_ENABLE_MASK, CLK_ENABLE, 0x0);
> +	/* Disable the slave way clock to LPASS */
> +	update_bits(reg->gcc_base + SWAY_CBCR_OFFSET,
> +			CLK_ENABLE_MASK, CLK_DISABLE, 0x0);
> +
> +	/* QDSP6 master port needs to be explicitly halted */
> +	temp = read_bit(reg->tcsr_base + TCSR_LPASS_PWR_ON_OFFSET,
> +			CLK_ENABLE, 0x0);
> +	temp = temp && !read_bit(reg->tcsr_base + TCSR_LPASS_MASTER_IDLE_OFFSET,
> +			CLK_ENABLE, 0x0);
> +	if (temp) {
> +		writel(CLK_ENABLE, reg->tcsr_base + TCSR_LPASS_HALTREQ_OFFSET);

CLK_ENABLE happens to have the right value, but the value you write is
"request halt" not "enable clock".

> +		/*  Wait for halt ACK from QDSP6 */
> +		while ((read_bit(reg->tcsr_base + TCSR_LPASS_HALTACK_OFFSET,
> +				CLK_DISABLE, 0x0) == 0) && (acktimeout-- > 0))
> +			udelay(5);
> +
> +		if (acktimeout) {
> +			if (read_bit(reg->tcsr_base +
> +					TCSR_LPASS_MASTER_IDLE_OFFSET,
> +						CLK_ENABLE, 0x0) != 1)
> +				dev_warn(adsp->dev,
> +						"%s: failed to receive %s\n",
> +						__func__, "TCSR MASTER ACK");
> +		} else {
> +			dev_err(adsp->dev, "%s: failed to receive halt ack\n",
> +					__func__);
> +			return -ETIMEDOUT;
> +		}
> +	}

Take a look at q6v5proc_halt_axi_port() in qcom_q6v5_pil.c instead of
this thing.

> +
> +	/* Assert the LPASS PDC Reset */
> +	update_bits(reg->pdc_sync,  AUDIO_SYNC_RESET_MASK,
> +			CLK_ENABLE, 0x2);

Use https://patchwork.kernel.org/patch/10415991/

reset_control_assert();

> +	/* Place the LPASS processor into reset */
> +	writel(CLK_ENABLE, reg->cc_lpass);
> +	/* wait after asserting subsystem restart from AOSS */
> +	udelay(200);
> +
> +	/* Clear the halt request for the AXIM and AHBM for Q6 */
> +	writel(CLK_DISABLE, reg->tcsr_base + TCSR_LPASS_HALTREQ_OFFSET);

Disable the clock that is the halt request register?

> +
> +	/* De-assert the LPASS PDC Reset */
> +	update_bits(reg->pdc_sync, AUDIO_SYNC_RESET_MASK,
> +			CLK_DISABLE, 0x2);

reset_control_deassert();

> +	/* Remove the LPASS reset */
> +	writel(CLK_DISABLE, reg->cc_lpass);
> +	/* wait after de-asserting subsystem restart from AOSS */
> +	udelay(200);
> +
> +	return 0;
> +}

Regards,
Bjorn
