Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC91C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 22:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 559852075D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 22:14:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 559852075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbeJXGjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 02:39:42 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47848 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbeJXGjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 02:39:42 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9NMEJKZ120778;
        Tue, 23 Oct 2018 17:14:19 -0500
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id w9NMEJot038105
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 23 Oct 2018 17:14:19 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 23
 Oct 2018 17:14:18 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 23 Oct 2018 17:14:18 -0500
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9NMEIpf026892;
        Tue, 23 Oct 2018 17:14:18 -0500
Subject: Re: [PATCH v4 10/17] remoteproc: add helper function to check
 carveout device address
To:     Loic Pallardy <loic.pallardy@st.com>, <bjorn.andersson@linaro.org>,
        <ohad@wizery.com>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>
References: <1532697292-14272-1-git-send-email-loic.pallardy@st.com>
 <1532697292-14272-11-git-send-email-loic.pallardy@st.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <2844874b-9484-aeee-c614-411d0ff38d12@ti.com>
Date:   Tue, 23 Oct 2018 17:14:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1532697292-14272-11-git-send-email-loic.pallardy@st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Loic,

On 7/27/18 8:14 AM, Loic Pallardy wrote:
> This patch introduces a function to verify that a specified carveout
> is fitting request device address and associated length
> 
> Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
> ---
>  drivers/remoteproc/remoteproc_core.c | 47 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 1e0fe3e..5dd5edf 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -259,6 +259,53 @@ struct rproc_mem_entry *
>  	return mem;
>  }
>  
> +/**
> + * rproc_check_carveout_da() - Check specified carveout da configuration
> + * @rproc: handle of a remote processor
> + * @mem: pointer on carveout to check
> + * @da: area device address
> + * @len: associated area size
> + *
> + * This function is a helper function to verify requested device area (couple
> + * da, len) is part of specified carevout.

%s/carevout/carveout/

> + *
> + * Return: 0 if carveout matchs request else -ENOMEM

%s/matchs/matches/

> + */
> +int rproc_check_carveout_da(struct rproc *rproc, struct rproc_mem_entry *mem,

static int since this seems to be only a local function.

> +			    u32 da, u32 len)
> +{
> +	struct device *dev = &rproc->dev;
> +	int delta = 0;
> +
> +	/* Check requested resource length */
> +	if (len > mem->len) {
> +		dev_err(dev, "Registered carveout doesn't fit len request\n");
> +		return -ENOMEM;

ENOMEM not typically used for these kind of errors, you were probably
inclined to used this since it is dealing with memory.

> +	}
> +

Both the below codepaths are exercised only when da is not
FW_RSC_ADDR_ANY, and you are returning 0 otherwise (which is the case of
matches as per your description above). Is that what you really want -
should it be an error

> +	if (da != FW_RSC_ADDR_ANY && mem->da == FW_RSC_ADDR_ANY) {
> +		/* Update existing carveout da */
> +		mem->da = da;

Where would you need to update this?

regards
Suman

> +	} else if (da != FW_RSC_ADDR_ANY && mem->da != FW_RSC_ADDR_ANY) {
> +		delta = da - mem->da;
> +
> +		/* Check requested resource belongs to registered carveout */
> +		if (delta < 0) {
> +			dev_err(dev,
> +				"Registered carveout doesn't fit da request\n");
> +			return -ENOMEM;
> +		}
> +
> +		if (delta + len > mem->len) {
> +			dev_err(dev,
> +				"Registered carveout doesn't fit len request\n");
> +			return -ENOMEM;
> +		}
> +	}
> +
> +	return 0;


> +}
> +
>  int rproc_alloc_vring(struct rproc_vdev *rvdev, int i)
>  {
>  	struct rproc *rproc = rvdev->rproc;
> 

