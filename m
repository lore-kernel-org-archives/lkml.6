Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754913AbeEXFTO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 01:19:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51802 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751809AbeEXFTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 01:19:09 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5378660117
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
Subject: Re: [PATCH] remoteproc: Add APSS based Qualcomm ADSP PIL driver for
 SDM845
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: ohad@wizery.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bgoswami@codeaurora.org,
        sbpata@codeaurora.org, asishb@codeaurora.org, rkarra@codeaurora.org,
        RajendraBabu Medisetti <rajendrabm@codeaurora.org>,
        Krishnamurthy Renu <krishnamurthy.renu@codeaurora.org>,
        asishb@qti.qualcomm.com, Ramlal Karra <rkarra@qti.qualcomm.com>,
        Rohit Kumar <rohkumar@qti.qualcomm.com>
References: <1526194908-19027-1-git-send-email-rohitkr@codeaurora.org>
 <20180523062645.GY14924@minitux>
From: Rohit Kumar <rohitkr@codeaurora.org>
Message-ID: <767dc01f-abed-8192-0274-ff5fc092f60b@codeaurora.org>
Date: Thu, 24 May 2018 10:48:59 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180523062645.GY14924@minitux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Bjorn for reviewing.


On 5/23/2018 11:56 AM, Bjorn Andersson wrote:
> On Sun 13 May 00:01 PDT 2018, Rohit kumar wrote:
>
>> --- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
>> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
>> @@ -10,6 +10,7 @@ on the Qualcomm ADSP Hexagon core.
>>   		    "qcom,msm8974-adsp-pil"
>>   		    "qcom,msm8996-adsp-pil"
>>   		    "qcom,msm8996-slpi-pil"
>> +		    "qcom,sdm845-apss-adsp-pil"
> Afaict there's nothing in this binding that ties this to the apss, so I
> don't think we should base the compatible on this. The differentiation
> is PAS vs non-PAS; so let's start naming the PAS variants
> "qcom,platform-subsystem-pas" and the non-PAS
> "qcom,platform-subsystem-pil" instead.
>
> I.e. please make this "qcom,sdm845-adsp-pil".
>
> More importantly, any resources such as clocks or reset lines should
> come from DT and as such you need to extend the binding quite a bit -
> which I suggest you do by introducing a new binding document.
Sure. Will create new dt-binding document with clocks and reset driver 
info added for sdm845 PIL.

>>   
>>   - interrupts-extended:
>>   	Usage: required
>> diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
>> index 02627ed..759831b 100644
>> --- a/drivers/remoteproc/Makefile
>> +++ b/drivers/remoteproc/Makefile
>> @@ -14,7 +14,8 @@ obj-$(CONFIG_OMAP_REMOTEPROC)		+= omap_remoteproc.o
>>   obj-$(CONFIG_WKUP_M3_RPROC)		+= wkup_m3_rproc.o
>>   obj-$(CONFIG_DA8XX_REMOTEPROC)		+= da8xx_remoteproc.o
>>   obj-$(CONFIG_KEYSTONE_REMOTEPROC)	+= keystone_remoteproc.o
>> -obj-$(CONFIG_QCOM_ADSP_PIL)		+= qcom_adsp_pil.o
>> +obj-$(CONFIG_QCOM_ADSP_PIL)		+= qcom_adsp.o
>> +qcom_adsp-objs				+= qcom_adsp_pil.o qcom_adsp_pil_sdm845.o
>>   obj-$(CONFIG_QCOM_RPROC_COMMON)		+= qcom_common.o
>>   obj-$(CONFIG_QCOM_Q6V5_PIL)		+= qcom_q6v5_pil.o
>>   obj-$(CONFIG_QCOM_SYSMON)		+= qcom_sysmon.o
>> diff --git a/drivers/remoteproc/qcom_adsp_pil.c b/drivers/remoteproc/qcom_adsp_pil.c
> I get the feeling that the main reason for modifying this file is its
> name, not that it reduces the complexity of the final solution. I
> definitely think it's cleaner to have some structural duplication and
> keep this driver handling the various PAS based remoteprocs.
The main intention was to re-use exisiting APIs in PAS based PIL driver 
as the major change was
w.r.t. start and stop of ADSP firmware. Load(), interrupt handling and 
few other APIs will be same
as done in exisiting PAS based PIL driver.
> Please see the RFC series I posted reducing the duplication between the
> various "Q6V5 drivers".
I went through the RFC. Our code will fit into the design. However, we 
will still have some amount of code
duplication between PAS and Non-PAS ADSP PIL driver. Will this be fine? 
Please suggest.
Will wait for your response whether to write complete new driver or 
reuse exisitng one.

> [..]
>> diff --git a/drivers/remoteproc/qcom_adsp_pil.h b/drivers/remoteproc/qcom_adsp_pil.h
> [..]
>> +static inline void update_bits(void *reg, u32 mask_val, u32 set_val, u32 shift)
>> +{
>> +	u32 reg_val = 0;
>> +
>> +	reg_val = ((readl(reg)) & ~mask_val) | ((set_val << shift) & mask_val);
>> +	writel(reg_val, reg);
>> +}
>> +
>> +static inline unsigned int read_bit(void *reg, u32 mask, int shift)
>> +{
>> +	return ((readl(reg) & mask) >> shift);
>> +}
> I don't like these helper functions, their prototype is nonstandard and
> makes it really hard to read all the calling code.
>
> I would prefer if you just inline the operations directly, to make it
> clearer what's going on in each case - if not then at least follow the
> prototype of e.g. regmap_udpate_bits(), which people might be used to.
Sure. Will update these APIs to follow standard format used in regmap 
and other drivers.
>> +
>> +#endif
>> diff --git a/drivers/remoteproc/qcom_adsp_pil_sdm845.c b/drivers/remoteproc/qcom_adsp_pil_sdm845.c
>> new file mode 100644
>> index 0000000..7518385
>> --- /dev/null
>> +++ b/drivers/remoteproc/qcom_adsp_pil_sdm845.c
>> @@ -0,0 +1,304 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Qualcomm APSS Based ADSP bootup/shutdown ops for SDM845.
>> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
>> + */
>> +
>> +#include <linux/delay.h>
>> +#include <linux/io.h>
>> +
>> +#include "qcom_adsp_pil.h"
>> +
>> +/* set values */
>> +#define CLK_ENABLE				0x1
>> +#define CLK_DISABLE				0x0
> Just write 0 and 1 in the code, it saves future readers the trouble of
> having to remember if these are special in any way.
OK.
>> +/* time out value */
>> +#define ACK_TIMEOUT				200000
> This is currently given in the rather awkward unit of 5uS. As it's input
> to what should have been a call to readl_poll_timeout() please express
> it in micro seconds.
sure. will do that in next patch
>> +/* mask values */
>> +#define CLK_MASK				GENMASK(4, 0)
>> +#define EVB_MASK				GENMASK(27, 4)
>> +#define SPIN_CLKOFF_MASK			BIT(31)
>> +#define AUDIO_SYNC_RESET_MASK			BIT(2)
>> +#define CLK_ENABLE_MASK				BIT(0)
>> +#define HAL_CLK_MASK				BIT(1)
>> +/* GCC register offsets */
>> +#define GCC_BASE				0x00147000
> This doesn't belong here, expose the resource from the gcc driver using
> existing frameworks.
Ok.  Will use gcc clock driver for this.
>> +#define SWAY_CBCR_OFFSET			0x00000008
>> +/*LPASS register base address and offsets*/
>> +#define LPASS_BASE				0x17000000
> This should be in the lpass clock driver.
Sure. Will use clock driver for these.
>> +/*QDSP6SS register base address and offsets*/
>> +#define QDSP6SS_BASE				0x17300000
> This should come from the reg property in DT.
OK
>> +/*TCSR register base address and offsets*/
>> +#define TCSR_BASE				0x01F62000
> Look at how we deal with TCSR in the MSS driver instead.
OK Sure. Thanks for the reference.

>
>> +
>> +#define RPMH_PDC_SYNC_RESET_ADDR		0x0B2E0100
>> +#define AOSS_CC_LPASS_RESTART_ADDR		0x0C2D0000
> Please expose these from an appropriate driver using appropriate
> frameworks.
Sure. Will use reset driver for this.

>> +
>> +struct sdm845_reg {
>> +	void __iomem *gcc_base;
>> +	void __iomem *lpass_base;
>> +	void __iomem *qdsp6ss_base;
>> +	void __iomem *tcsr_base;
>> +	void __iomem *pdc_sync;
>> +	void __iomem *cc_lpass;
> I expect to see only qdsp6ss_base remain here.
OK
>
>> +static int clk_enable_spin(void *reg, int read_shift, int write_shift)
> This should be in the appropriate clock drivers.
Right. Will cleanup this.

>
>> +	/* Enable the QDSP6SS AHBM and AHBS clocks */
>> +	ret = clk_enable_spin(reg->lpass_base + AHBS_AON_CBCR_OFFSET,
>> +				CLK_MASK, 0x0);
>> +	if (ret)
>> +		return ret;
>> +	ret = clk_enable_spin(reg->lpass_base + AHBM_AON_CBCR_OFFSET,
>> +				CLK_MASK, 0x0);
>> +	if (ret)
>> +		return ret;
> Above should be calls to the clock framework.
OK.
>
>> +	/* Wait for core to come out of reset */
>> +	while ((!(readl(reg->qdsp6ss_base +
>> +			BOOT_STATUS_OFFSET))) && (timeout-- > 0))
>> +		udelay(5);
> Use readl_poll_timeout() from linux/iopoll.h
OK

>> +
>> +	if (!timeout)
>> +		return -ETIMEDOUT;
>> +
>> +	return 0;
>> +}
>> +
>> +static int sdm845_bringup(struct qcom_adsp *adsp)
> This is called "start" in other places, please use existing naming
> convention to make your code feel familiar to people reading other
> drivers.
OK Sure. Will rename this in next version.
>
>> +{
>> +	u32 ret;
> ret is exclusively used to store data of the type "int".
Yep. Will change it.
>> +	}
>> +	/* Program boot address */
>> +	update_bits(reg->qdsp6ss_base + RST_EVB_OFFSET,
>> +				EVB_MASK, (adsp->mem_phys) >> 8, 0x4);
> In the WCSS PIL driver this is:
>
> 	writel(rproc->bootaddr >> 4, wcss->reg_base + QDSP6SS_RST_EVB);
>
> Which I think is the same as you're doing here, although you're shifting
> 8 bits right and then 4 (base 16) to the left.
Right. Will make it similar.

>
>> +
>> +	/* Wait for addresses to be programmed before starting adsp */
> That's not what mb() does, it just ensures that any read and writes
> coming after this point isn't reordered with any operations before it.
>
> And as sdm845_adsp_reset() used writel() there is already a wmb() there,
> so you can drop this one.
Sure
>
>> +	mb();
>> +	ret = sdm845_adsp_reset(adsp);
>> +	if (ret)
>> +		dev_err(adsp->dev, "%s: De-assert QDSP6 out of reset failed\n",
>> +					__func__);
> This string is unique in the kernel, so you don't need __func__.
OK
>
>> +
>> +static int sdm845_bringdown(struct qcom_adsp *adsp)
>> +{
>> +	u32 acktimeout = ACK_TIMEOUT;
>> +	u32 temp;
> We know this is a temporary variable, name it "val" as we do in the
> other functions.
Sure.

>> +	struct sdm845_reg *reg = adsp->priv_reg;
>> +
>> +	/* Reset the retention logic */
>> +	update_bits(reg->qdsp6ss_base + RET_CFG_OFFSET,
>> +			CLK_ENABLE_MASK, CLK_ENABLE, 0x0);
>> +	/* Disable the slave way clock to LPASS */
>> +	update_bits(reg->gcc_base + SWAY_CBCR_OFFSET,
>> +			CLK_ENABLE_MASK, CLK_DISABLE, 0x0);
>> +
>> +	/* QDSP6 master port needs to be explicitly halted */
>> +	temp = read_bit(reg->tcsr_base + TCSR_LPASS_PWR_ON_OFFSET,
>> +			CLK_ENABLE, 0x0);
>> +	temp = temp && !read_bit(reg->tcsr_base + TCSR_LPASS_MASTER_IDLE_OFFSET,
>> +			CLK_ENABLE, 0x0);
>> +	if (temp) {
>> +		writel(CLK_ENABLE, reg->tcsr_base + TCSR_LPASS_HALTREQ_OFFSET);
> CLK_ENABLE happens to have the right value, but the value you write is
> "request halt" not "enable clock".
Right. We will remove CLK_ENABLE/DISABLE macros as suggested by you.
>
>> +		/*  Wait for halt ACK from QDSP6 */
>> +		while ((read_bit(reg->tcsr_base + TCSR_LPASS_HALTACK_OFFSET,
>> +				CLK_DISABLE, 0x0) == 0) && (acktimeout-- > 0))
>> +			udelay(5);
>> +
>> +		if (acktimeout) {
>> +			if (read_bit(reg->tcsr_base +
>> +					TCSR_LPASS_MASTER_IDLE_OFFSET,
>> +						CLK_ENABLE, 0x0) != 1)
>> +				dev_warn(adsp->dev,
>> +						"%s: failed to receive %s\n",
>> +						__func__, "TCSR MASTER ACK");
>> +		} else {
>> +			dev_err(adsp->dev, "%s: failed to receive halt ack\n",
>> +					__func__);
>> +			return -ETIMEDOUT;
>> +		}
>> +	}
> Take a look at q6v5proc_halt_axi_port() in qcom_q6v5_pil.c instead of
> this thing.
OK Sure.

>
>> +
>> +	/* Assert the LPASS PDC Reset */
>> +	update_bits(reg->pdc_sync,  AUDIO_SYNC_RESET_MASK,
>> +			CLK_ENABLE, 0x2);
> Use https://patchwork.kernel.org/patch/10415991/
>
> reset_control_assert();
Yes. Will do this change in next patchset.

>
>> +	/* Place the LPASS processor into reset */
>> +	writel(CLK_ENABLE, reg->cc_lpass);
>> +	/* wait after asserting subsystem restart from AOSS */
>> +	udelay(200);
>> +
>> +	/* Clear the halt request for the AXIM and AHBM for Q6 */
>> +	writel(CLK_DISABLE, reg->tcsr_base + TCSR_LPASS_HALTREQ_OFFSET);
> Disable the clock that is the halt request register?
Will remove Macro. Its actually clearing halt request.

>
>> +
>> +	/* De-assert the LPASS PDC Reset */
>> +	update_bits(reg->pdc_sync, AUDIO_SYNC_RESET_MASK,
>> +			CLK_DISABLE, 0x2);
> reset_control_deassert();
OK.
>> +	/* Remove the LPASS reset */
>> +	writel(CLK_DISABLE, reg->cc_lpass);
>> +	/* wait after de-asserting subsystem restart from AOSS */
>> +	udelay(200);
>> +
>> +	return 0;
>> +}
> Regards,
> Bjorn
Thanks,
Rohit

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
