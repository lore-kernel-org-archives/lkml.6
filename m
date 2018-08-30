Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FA8C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D9762073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:34:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D9762073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbeH3Uh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 16:37:28 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45602 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbeH3Uh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 16:37:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D01257A9;
        Thu, 30 Aug 2018 09:34:30 -0700 (PDT)
Received: from [10.4.12.81] (melchizedek.emea.arm.com [10.4.12.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6BA843F557;
        Thu, 30 Aug 2018 09:34:29 -0700 (PDT)
Subject: Re: [PATCH] EDAC, ghes: use CPER module handles to locate DIMMs
Cc:     Fan Wu <wufan@codeaurora.org>, mchehab@kernel.org, bp@alien8.de,
        baicar.tyler@gmail.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1535567632-18089-1-git-send-email-wufan@codeaurora.org>
From:   James Morse <james.morse@arm.com>
To:     Zhengqiang <zhengqiang10@huawei.com>
Message-ID: <5eab89c6-c063-cbc2-4d02-459faf87698a@arm.com>
Date:   Thu, 30 Aug 2018 17:34:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1535567632-18089-1-git-send-email-wufan@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhengqiang,

On 29/08/18 19:33, Fan Wu wrote:
> The current ghes_edac driver does not update per-dimm error
> counters when reporting memory errors, because there is no
> platform-independent way to find DIMMs based on the error
> information provided by firmware. This patch offers a solution
> for platforms whose firmwares provide valid module handles
> (SMBIOS type 17) in error records. In this case ghes_edac will
> use the module handles to locate DIMMs and thus makes per-dimm
> error reporting possible.

Does your platform set CPER_MEM_VALID_MODULE_HANDLE in GHES Memory errors? If
so, any chance you could test this patch on your platform? [0]
(original patch: https://lore.kernel.org/patchwork/patch/978928/)

Thanks,

James

[0] https://marc.info/?l=linux-edac&m=152603960002324


> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> index 473aeec..db527f0 100644
> --- a/drivers/edac/ghes_edac.c
> +++ b/drivers/edac/ghes_edac.c
> @@ -81,6 +81,26 @@ static void ghes_edac_count_dimms(const struct dmi_header *dh, void *arg)
>  		(*num_dimm)++;
>  }
>  
> +static int ghes_edac_dimm_index(u16 handle)
> +{
> +	struct mem_ctl_info *mci;
> +	int i;
> +
> +	if (!ghes_pvt)
> +		return -1;
> +
> +	mci = ghes_pvt->mci;
> +
> +	if (!mci)
> +		return -1;
> +
> +	for (i = 0; i < mci->tot_dimms; i++) {
> +		if (mci->dimms[i]->smbios_handle == handle)
> +			return i;
> +	}
> +	return -1;
> +}
> +
>  static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
>  {
>  	struct ghes_edac_dimm_fill *dimm_fill = arg;
> @@ -177,6 +197,8 @@ static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
>  				entry->total_width, entry->data_width);
>  		}
>  
> +		dimm->smbios_handle = entry->handle;
> +
>  		dimm_fill->count++;
>  	}
>  }
> @@ -327,12 +349,20 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
>  		p += sprintf(p, "bit_pos:%d ", mem_err->bit_pos);
>  	if (mem_err->validation_bits & CPER_MEM_VALID_MODULE_HANDLE) {
>  		const char *bank = NULL, *device = NULL;
> +		int index = -1;
> +
>  		dmi_memdev_name(mem_err->mem_dev_handle, &bank, &device);
> +		p += sprintf(p, "DIMM DMI handle: 0x%.4x ",
> +			     mem_err->mem_dev_handle);
>  		if (bank != NULL && device != NULL)
>  			p += sprintf(p, "DIMM location:%s %s ", bank, device);
> -		else
> -			p += sprintf(p, "DIMM DMI handle: 0x%.4x ",
> -				     mem_err->mem_dev_handle);
> +
> +		index = ghes_edac_dimm_index(mem_err->mem_dev_handle);
> +		if (index >= 0) {
> +			e->top_layer = index;
> +			e->enable_per_layer_report = true;
> +		}
> +
>  	}
>  	if (p > e->location)
>  		*(p - 1) = '\0';
> diff --git a/include/linux/edac.h b/include/linux/edac.h
> index bffb978..a45ce1f 100644
> --- a/include/linux/edac.h
> +++ b/include/linux/edac.h
> @@ -451,6 +451,8 @@ struct dimm_info {
>  	u32 nr_pages;			/* number of pages on this dimm */
>  
>  	unsigned csrow, cschannel;	/* Points to the old API data */
> +
> +	u16 smbios_handle;              /* Handle for SMBIOS type 17 */
>  };
>  
>  /**
> 

