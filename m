Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1186FC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3D28206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:44:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3D28206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbeI2FKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 01:10:22 -0400
Received: from mga18.intel.com ([134.134.136.126]:2642 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726941AbeI2FKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 01:10:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Sep 2018 15:44:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,316,1534834800"; 
   d="scan'208";a="94865968"
Received: from ahduyck-mobl.amr.corp.intel.com (HELO [10.7.198.165]) ([10.7.198.165])
  by orsmga001.jf.intel.com with ESMTP; 28 Sep 2018 15:44:27 -0700
Subject: Re: [PATCH] libnvdimm, dimm: Maximize label transfer size
To:     Dan Williams <dan.j.williams@intel.com>, linux-nvdimm@lists.01.org
Cc:     linux-kernel@vger.kernel.org
References: <153816098159.2233877.8382846671636531035.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
Message-ID: <3cf89dd3-a024-dbab-36ed-923f9466669c@linux.intel.com>
Date:   Fri, 28 Sep 2018 15:44:27 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <153816098159.2233877.8382846671636531035.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/2018 11:56 AM, Dan Williams wrote:
> Use kvzalloc() to bypass the arbitrary PAGE_SIZE limit of label transfer
> operations. Given the expense of calling into firmware, maximize the
> amount of label data we transfer per call to be up to the total label
> space if allowed by the firmware.
> 
> Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

This looks mostly fine to me.

The only thing I am not certain about is if we want to use the raw 
max_cmd_size value or not since there is no guarantee it is aligned to 
any sort of boundary. It might be beneficial to either cache line align 
it or align it to 256B if it is larger than that since that way we at 
least would be getting full labels instead of partial ones.

> ---
>   drivers/nvdimm/dimm_devs.c |   12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
> index 863cabc35215..82ab96a9f560 100644
> --- a/drivers/nvdimm/dimm_devs.c
> +++ b/drivers/nvdimm/dimm_devs.c
> @@ -111,8 +111,8 @@ int nvdimm_init_config_data(struct nvdimm_drvdata *ndd)
>   	if (!ndd->data)
>   		return -ENOMEM;
>   
> -	max_cmd_size = min_t(u32, PAGE_SIZE, ndd->nsarea.max_xfer);
> -	cmd = kzalloc(max_cmd_size + sizeof(*cmd), GFP_KERNEL);
> +	max_cmd_size = min_t(u32, ndd->nsarea.config_size, ndd->nsarea.max_xfer);
> +	cmd = kvzalloc(max_cmd_size + sizeof(*cmd), GFP_KERNEL);
>   	if (!cmd)
>   		return -ENOMEM;
>   
> @@ -134,7 +134,7 @@ int nvdimm_init_config_data(struct nvdimm_drvdata *ndd)
>   		memcpy(ndd->data + offset, cmd->out_buf, cmd->in_length);
>   	}
>   	dev_dbg(ndd->dev, "len: %zu rc: %d\n", offset, rc);
> -	kfree(cmd);
> +	kvfree(cmd);
>   
>   	return rc;
>   }
> @@ -157,9 +157,9 @@ int nvdimm_set_config_data(struct nvdimm_drvdata *ndd, size_t offset,
>   	if (offset + len > ndd->nsarea.config_size)
>   		return -ENXIO;
>   
> -	max_cmd_size = min_t(u32, PAGE_SIZE, len);
> +	max_cmd_size = min_t(u32, ndd->nsarea.config_size, len);
>   	max_cmd_size = min_t(u32, max_cmd_size, ndd->nsarea.max_xfer);
> -	cmd = kzalloc(max_cmd_size + sizeof(*cmd) + sizeof(u32), GFP_KERNEL);
> +	cmd = kvzalloc(max_cmd_size + sizeof(*cmd) + sizeof(u32), GFP_KERNEL);
>   	if (!cmd)
>   		return -ENOMEM;
>   
> @@ -183,7 +183,7 @@ int nvdimm_set_config_data(struct nvdimm_drvdata *ndd, size_t offset,
>   			break;
>   		}
>   	}
> -	kfree(cmd);
> +	kvfree(cmd);
>   
>   	return rc;
>   }
> 
