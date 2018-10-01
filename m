Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D520C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 21:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDB792089A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 21:44:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDB792089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbeJBEYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 00:24:04 -0400
Received: from mga03.intel.com ([134.134.136.65]:53214 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbeJBEYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 00:24:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2018 14:44:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,328,1534834800"; 
   d="scan'208";a="262013135"
Received: from ahduyck-mobl.amr.corp.intel.com (HELO [10.7.198.166]) ([10.7.198.166])
  by orsmga005.jf.intel.com with ESMTP; 01 Oct 2018 14:44:11 -0700
Subject: Re: [PATCH v2] libnvdimm, dimm: Maximize label transfer size
To:     Dan Williams <dan.j.williams@intel.com>, linux-nvdimm@lists.01.org
Cc:     linux-kernel@vger.kernel.org
References: <153842839852.2679462.16816747305002065908.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
Message-ID: <71e2a4b6-68d9-d90d-b927-90840d8c6ee1@linux.intel.com>
Date:   Mon, 1 Oct 2018 14:44:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <153842839852.2679462.16816747305002065908.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/1/2018 2:14 PM, Dan Williams wrote:
> Use kvzalloc() to bypass the arbitrary PAGE_SIZE limit of label transfer
> operations. Given the expense of calling into firmware, maximize the
> amount of label data we transfer per call to be up to the total label
> space if allowed by the firmware, or 256K whichever is smaller.
> 
> Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
> Changes in v2:
> * clamp the max allocation size at 256K in case large label areas with
>    unlimited transfer sizes appear in the future.
> 
>   drivers/nvdimm/dimm_devs.c       |   14 ++++++++------
>   tools/testing/nvdimm/test/nfit.c |    2 +-
>   2 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
> index 863cabc35215..3616e2e47788 100644
> --- a/drivers/nvdimm/dimm_devs.c
> +++ b/drivers/nvdimm/dimm_devs.c
> @@ -111,8 +111,9 @@ int nvdimm_init_config_data(struct nvdimm_drvdata *ndd)
>   	if (!ndd->data)
>   		return -ENOMEM;
>   
> -	max_cmd_size = min_t(u32, PAGE_SIZE, ndd->nsarea.max_xfer);
> -	cmd = kzalloc(max_cmd_size + sizeof(*cmd), GFP_KERNEL);
> +	max_cmd_size = min_t(u32, ndd->nsarea.config_size, SZ_256K);
> +	max_cmd_size = min_t(u32, max_cmd_size, ndd->nsarea.max_xfer);
> +	cmd = kvzalloc(max_cmd_size + sizeof(*cmd), GFP_KERNEL);
>   	if (!cmd)
>   		return -ENOMEM;
>   

So I wouldn't use 256K as the limit, maybe 256K minus the sizeof(*cmd). 
Otherwise you are still allocating additional memory to take care of 
that little trailing bit that is being added.

> @@ -134,7 +135,7 @@ int nvdimm_init_config_data(struct nvdimm_drvdata *ndd)
>   		memcpy(ndd->data + offset, cmd->out_buf, cmd->in_length);
>   	}
>   	dev_dbg(ndd->dev, "len: %zu rc: %d\n", offset, rc);
> -	kfree(cmd);
> +	kvfree(cmd);
>   
>   	return rc;
>   }
> @@ -157,9 +158,10 @@ int nvdimm_set_config_data(struct nvdimm_drvdata *ndd, size_t offset,
>   	if (offset + len > ndd->nsarea.config_size)
>   		return -ENXIO;
>   
> -	max_cmd_size = min_t(u32, PAGE_SIZE, len);
> +	max_cmd_size = min_t(u32, ndd->nsarea.config_size, SZ_256K);
>   	max_cmd_size = min_t(u32, max_cmd_size, ndd->nsarea.max_xfer);
> -	cmd = kzalloc(max_cmd_size + sizeof(*cmd) + sizeof(u32), GFP_KERNEL);
> +	max_cmd_size = min_t(u32, max_cmd_size, len);
> +	cmd = kvzalloc(max_cmd_size + sizeof(*cmd) + sizeof(u32), GFP_KERNEL);
>   	if (!cmd)
>   		return -ENOMEM;
>   

For the set operation I am not sure you have any code that is going to 
be updating things multiple labels at a time. From what I can tell the 
largest set call you ever make is probably for a namespace index and 
odds are that will only ever be 256 or 512 bytes.

Also the limitations here could probably use some additional clean-up. 
For example you have a check for offset + len > config_size above this 
min_t calls. As such it should be impossible for length to ever be 
greater than config_size so you shouldn't need to test for the min of 
both and could just use the min of len versus the max_xfer.

> @@ -183,7 +185,7 @@ int nvdimm_set_config_data(struct nvdimm_drvdata *ndd, size_t offset,
>   			break;
>   		}
>   	}
> -	kfree(cmd);
> +	kvfree(cmd);
>   
>   	return rc;
>   }
> diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
> index cffc2c5a778d..caa58d8533f5 100644
> --- a/tools/testing/nvdimm/test/nfit.c
> +++ b/tools/testing/nvdimm/test/nfit.c
> @@ -448,7 +448,7 @@ static int nfit_test_cmd_get_config_size(struct nd_cmd_get_config_size *nd_cmd,
>   
>   	nd_cmd->status = 0;
>   	nd_cmd->config_size = LABEL_SIZE;
> -	nd_cmd->max_xfer = SZ_4K;
> +	nd_cmd->max_xfer = LABEL_SIZE;
>   
>   	return 0;
>   }
> 
