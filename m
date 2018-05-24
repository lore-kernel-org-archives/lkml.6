Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935799AbeEXMfn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 08:35:43 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38232 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751791AbeEXMfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 08:35:39 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1CC8960213
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vviswana@codeaurora.org
Subject: Re: [PATCH V1 2/3] mmc: sdhci-msm: Add msm version specific ops and
 data structures
To: Evan Green <evgreen@chromium.org>
Cc: adrian.hunter@intel.com, Ulf Hansson <ulf.hansson@linaro.org>,
        robh+dt@kernel.org, mark.rutland@arm.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com,
        linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org,
        devicetree@vger.kernel.org, asutoshd@codeaurora.org,
        stummala@codeaurora.org, venkatg@codeaurora.org, jeremymc@redhat.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>, riteshh@codeaurora.org,
        vbadigan@codeaurora.org, Doug Anderson <dianders@google.com>,
        sayalil@codeaurora.org
References: <1526552938-21292-1-git-send-email-vviswana@codeaurora.org>
 <1526552938-21292-3-git-send-email-vviswana@codeaurora.org>
 <CAE=gft4ZQ34QankD_S5y_KjoZG8rxQkEfPo7vZsJTUB387P6dQ@mail.gmail.com>
From: Vijay Viswanath <vviswana@codeaurora.org>
Message-ID: <85d7d14c-fd1c-92af-4605-3441649c9fcd@codeaurora.org>
Date: Thu, 24 May 2018 18:05:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAE=gft4ZQ34QankD_S5y_KjoZG8rxQkEfPo7vZsJTUB387P6dQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/22/2018 11:40 PM, Evan Green wrote:
> On Thu, May 17, 2018 at 3:30 AM Vijay Viswanath <vviswana@codeaurora.org>
> wrote:
> 
>> In addition to offsets of certain registers changing, the registers in
>> core_mem have been shifted to HC mem as well. To access these registers,
>> define msm version specific functions. These functions can be loaded
>> into the function pointers at the time of probe based on the msm version
>> detected.
> 
>> Also defind new data structure to hold version specific Ops and register
>> addresses.
> 
>> Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
>> Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
>> ---
>>    drivers/mmc/host/sdhci-msm.c | 112
> +++++++++++++++++++++++++++++++++++++++++++
>>    1 file changed, 112 insertions(+)
> 
>> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
>> index 2524455..bb2bb59 100644
>> --- a/drivers/mmc/host/sdhci-msm.c
>> +++ b/drivers/mmc/host/sdhci-msm.c
>> @@ -226,6 +226,25 @@ struct sdhci_msm_offset {
>>           .core_ddr_config_2 = 0x1BC,
>>    };
> 
>> +struct sdhci_msm_variant_ops {
>> +       u8 (*msm_readb_relaxed)(struct sdhci_host *host, u32 offset);
> 
> I don't see any uses of msm_readb_relaxed or msm_writeb_relaxed in this
> patch or the next one. Are these needed?

They are not used as of now. Kept them since they can have use later. 
Felt it better to define base functions and addresses now itself.

> 
>> +       u32 (*msm_readl_relaxed)(struct sdhci_host *host, u32 offset);
>> +       void (*msm_writeb_relaxed)(u8 val, struct sdhci_host *host, u32
> offset);
>> +       void (*msm_writel_relaxed)(u32 val, struct sdhci_host *host,
>> +                       u32 offset);
>> +};
>> +
>> +/*
>> + * From V5, register spaces have changed. Wrap this info in a structure
>> + * and choose the data_structure based on version info mentioned in DT.
>> + */
>> +struct sdhci_msm_variant_info {
>> +       bool mci_removed;
>> +       const struct sdhci_msm_variant_ops *var_ops;
>> +       const struct sdhci_msm_offset *offset;
>> +};
>> +
>> +
> 
> Remove extra blank line.
> 
>>    struct sdhci_msm_host {
>>           struct platform_device *pdev;
>>           void __iomem *core_mem; /* MSM SDCC mapped address */
>> @@ -245,8 +264,75 @@ struct sdhci_msm_host {
>>           wait_queue_head_t pwr_irq_wait;
>>           bool pwr_irq_flag;
>>           u32 caps_0;
>> +       bool mci_removed;
>> +       const struct sdhci_msm_variant_ops *var_ops;
>> +       const struct sdhci_msm_offset *offset;
>>    };
> 
>> +/*
>> + * APIs to read/write to vendor specific registers which were there in
> the
>> + * core_mem region before MCI was removed.
>> + */
>> +static u8 sdhci_msm_mci_variant_readb_relaxed(struct sdhci_host *host,
>> +               u32 offset)
>> +{
>> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +       struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
>> +
>> +       return readb_relaxed(msm_host->core_mem + offset);
>> +}
>> +
>> +static u8 sdhci_msm_v5_variant_readb_relaxed(struct sdhci_host *host,
>> +               u32 offset)
>> +{
>> +       return readb_relaxed(host->ioaddr + offset);
>> +}
>> +
>> +static u32 sdhci_msm_mci_variant_readl_relaxed(struct sdhci_host *host,
>> +               u32 offset)
>> +{
>> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +       struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
>> +
>> +       return readl_relaxed(msm_host->core_mem + offset);
>> +}
>> +
>> +static u32 sdhci_msm_v5_variant_readl_relaxed(struct sdhci_host *host,
>> +               u32 offset)
>> +{
>> +       return readl_relaxed(host->ioaddr + offset);
>> +}
>> +
>> +static void sdhci_msm_mci_variant_writeb_relaxed(u8 val,
>> +               struct sdhci_host *host, u32 offset)
>> +{
>> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +       struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
>> +
>> +       writeb_relaxed(val, msm_host->core_mem + offset);
>> +}
>> +
>> +static void sdhci_msm_v5_variant_writeb_relaxed(u8 val, struct
> sdhci_host *host,
>> +               u32 offset)
>> +{
>> +       writeb_relaxed(val, host->ioaddr + offset);
>> +}
>> +
>> +static void sdhci_msm_mci_variant_writel_relaxed(u32 val,
>> +               struct sdhci_host *host, u32 offset)
>> +{
>> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +       struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
>> +
>> +       writel_relaxed(val, msm_host->core_mem + offset);
>> +}
>> +
>> +static void sdhci_msm_v5_variant_writel_relaxed(u32 val, struct
> sdhci_host *host,
> 
> You squeaked over 80 characters here. Move the second parameter down with
> the third.
> 
> -Evan
> 

Thanks for going through the patch thoroughly. Will address the comments.

Thanks,
Vijay
