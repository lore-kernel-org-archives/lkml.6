Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C75C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 841EA2081D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PVRJg8V/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 841EA2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388859AbeKGADc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 19:03:32 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33467 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388659AbeKGADc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 19:03:32 -0500
Received: by mail-wr1-f68.google.com with SMTP id u9-v6so3429118wrr.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 06:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jqJj8RI/1oYTgoG9ZOVBMSE9EE+BDW6eLAa2fXWMUi8=;
        b=PVRJg8V/Nt+s+2IM6T9RmAeWrR1F69O5a406rIGhkGnfyC9EUvStQvqT2+C8+LRc8j
         a5um5vV2+beF4xC6/TrmOhYbVfM8z4DOthjBMsDPFBhlH8HL6c52+/1I1wmb+RW55V7L
         0z18E6s74QozDbRDcyRoupL5SouxaQZ+xpdlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jqJj8RI/1oYTgoG9ZOVBMSE9EE+BDW6eLAa2fXWMUi8=;
        b=kYWYdC48D+8dE7ZphOSZggso2FXIQQr/T4034Bt0INr9wq+VEI6F3dXSnPMQndb3GZ
         GpNr9C3ZpLb7DL2SG+KzJ935RYSPlTRp8tOaTxPdqErKm6uQJf7fb2l47GK5yTlCj/7u
         dhInUvifCsYu7GtOmPQRBXxiP0rQtUxxJjm6tpd8ouh8DGDBMCRJgHy196hzJ4gdZlmo
         maXX4/gW5of9XjqtC26M/mzkcB/o71A6pY+OVnmBoEhfguVM2V4jAbzWzU8iJbL9Isw2
         8BxVfA3oi3LJxfZv4isQHP78GVtDKny/bpwN2JDtUBOtNabTl6oNgWtbrOkHnTFBc80k
         CPQw==
X-Gm-Message-State: AGRZ1gJ+1x22d68LrZvzHdyq8+LadWS7g7IMe8Ln7HAbUefjvrZ/Vbuy
        NFPei8ilGmDiUJYR/lXmtnqIEKZl26E=
X-Google-Smtp-Source: AJdET5ddMTI0LSA2wf1YuOPF+hwdpUf/KDrOryvBXZFpFcgfnw75+FSrRc82mljDRUViaJ05uQ1u3w==
X-Received: by 2002:adf:8989:: with SMTP id x9-v6mr22253160wrx.184.1541515079125;
        Tue, 06 Nov 2018 06:37:59 -0800 (PST)
Received: from [192.168.0.19] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id v9-v6sm1690907wmh.32.2018.11.06.06.37.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 06:37:58 -0800 (PST)
Subject: Re: [regression 4.20-rc1, bisected] cpufreq fails to register on
 db820c
To:     Niklas Cassel <niklas.cassel@linaro.org>, bgolaszewski@baylibre.com
Cc:     viresh.kumar@linaro.org, linux-kernel@vger.kernel.org
References: <20181106012928.GA32044@centauri.lan>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <941ed402-4259-a9aa-b0d3-10e76e4ac946@linaro.org>
Date:   Tue, 6 Nov 2018 14:37:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20181106012928.GA32044@centauri.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Niklas,

thanks for reporting this..

I found the issue, DT support seems to be totally broken in NVMEM.
Will send this fix once you can confirm it works for you!

Can you try this patch!
---------------------->cut<--------------------------

Author: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date:   Tue Nov 6 14:32:30 2018 +0000

     nvmem: core: fix of_nvmem_cell_get()

     NVMEM DT support seems to be totally broken after
     e888d445ac33 ("nvmem: resolve cells from DT at registration time")
     Fix this!

     Fixes: e888d445ac33 ("nvmem: resolve cells from DT at registration 
time")
     Reported-by: Niklas Cassel <niklas.cassel@linaro.org>
     Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 9b18ce90f907..7ae8072f56ae 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -44,6 +44,7 @@ struct nvmem_cell {
         int                     bytes;
         int                     bit_offset;
         int                     nbits;
+       struct device_node      *np;
         struct nvmem_device     *nvmem;
         struct list_head        node;
  };
@@ -530,6 +531,7 @@ static int nvmem_add_cells_from_of(struct 
nvmem_device *nvmem)
                         return -ENOMEM;

                 cell->nvmem = nvmem;
+               cell->np = child;
                 cell->offset = be32_to_cpup(addr++);
                 cell->bytes = be32_to_cpup(addr);
                 cell->name = kasprintf(GFP_KERNEL, "%pOFn", child);
@@ -960,14 +962,13 @@ nvmem_cell_get_from_lookup(struct device *dev, 
const char *con_id)

  #if IS_ENABLED(CONFIG_OF)
  static struct nvmem_cell *
-nvmem_find_cell_by_index(struct nvmem_device *nvmem, int index)
+nvmem_find_cell_by_node(struct nvmem_device *nvmem, struct device_node *np)
  {
         struct nvmem_cell *cell = NULL;
-       int i = 0;

         mutex_lock(&nvmem_mutex);
         list_for_each_entry(cell, &nvmem->cells, node) {
-               if (index == i++)
+               if (np == cell->np)
                         break;
         }
         mutex_unlock(&nvmem_mutex);
@@ -1001,7 +1002,6 @@ struct nvmem_cell *of_nvmem_cell_get(struct 
device_node *np, const char *id)
         cell_np = of_parse_phandle(np, "nvmem-cells", index);
         if (!cell_np)
                 return ERR_PTR(-EINVAL);
-
         nvmem_np = of_get_next_parent(cell_np);
         if (!nvmem_np)
                 return ERR_PTR(-EINVAL);
@@ -1011,7 +1011,7 @@ struct nvmem_cell *of_nvmem_cell_get(struct 
device_node *np, const char *id)
         if (IS_ERR(nvmem))
                 return ERR_CAST(nvmem);

-       cell = nvmem_find_cell_by_index(nvmem, index);
+       cell = nvmem_find_cell_by_node(nvmem, cell_np);
         if (!cell) {
                 __nvmem_device_put(nvmem);
                 return ERR_PTR(-ENOENT);

---------------------->cut<--------------------------
On 06/11/18 01:29, Niklas Cassel wrote:
> Hello Bartosz,
> 
> I've run into a regression on v4.20-rc1, where cpufreq on dragonboard 820c
> fails to register.
> 
> I've bisected the issue to:
> e888d445ac33 ("nvmem: resolve cells from DT at registration time")
> 
> If I revert that patch, cpufreq starts working on dragonboard 820c again.
> 
> 
> Before your patch:
> [    5.052985] qcom_cpufreq_kryo_probe:110 speedbin_nvmem: ffff8000d4d51e00
> [    5.053133] qcom_cpufreq_kryo_probe:120 speedbin: ffff8000d4d51d00
> [    5.058895] qcom_cpufreq_kryo_probe:121 *speedbin: 0
> 
> 
> After your patch:
> [    4.791664] qcom_cpufreq_kryo_probe:110 speedbin_nvmem: ffff8000d472ed00
> [    4.791815] qcom_cpufreq_kryo_probe:120 speedbin: ffff8000d451b300
> [    4.797575] qcom_cpufreq_kryo_probe:121 *speedbin: 12
> 
> 
> The prints are debug prints that I've added locally:
> 
> --- a/drivers/cpufreq/qcom-cpufreq-kryo.c
> +++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
> @@ -107,6 +107,7 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
>          }
>   
>          speedbin_nvmem = of_nvmem_cell_get(np, NULL);
> +       pr_err("%s:%d speedbin_nvmem: %lx\n", __func__, __LINE__, speedbin_nvmem);
>          of_node_put(np);
>          if (IS_ERR(speedbin_nvmem)) {
>                  if (PTR_ERR(speedbin_nvmem) != -EPROBE_DEFER)
> @@ -116,6 +117,8 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
>          }
>   
>          speedbin = nvmem_cell_read(speedbin_nvmem, &len);
> +       pr_err("%s:%d speedbin: %lx\n", __func__, __LINE__, speedbin);
> +       pr_err("%s:%d *speedbin: %u\n", __func__, __LINE__, (unsigned int)(*speedbin));
>          nvmem_cell_put(speedbin_nvmem);
>          if (IS_ERR(speedbin))
>                  return PTR_ERR(speedbin);
> 
> 
> So it appears that the read from nvmem_cell_read()
> gets another value after your commit.
> 
> This value is then given to dev_pm_opp_set_supported_hw(),
> however, since this new value (12) from nvmem_cell_read()
> doesn't have any matching opp-supported-hw in device tree,
> cpufreq fails to register.
> 
> This error only happens when we read this new incorrect value
> (12 instead of 0).
> Any idea why nvmem_cell_read() returns a new value for the
> same efuse?
> 
> 
> Kind regards,
> Niklas
> 
