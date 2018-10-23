Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C79C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 17:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8F8F20834
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 17:05:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8F8F20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbeJXB3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 21:29:46 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:45336 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728034AbeJXB3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 21:29:45 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9NH5Sfn069722;
        Tue, 23 Oct 2018 12:05:28 -0500
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id w9NH5S2X126645
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 23 Oct 2018 12:05:28 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 23
 Oct 2018 12:05:28 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 23 Oct 2018 12:05:28 -0500
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9NH5SWh030078;
        Tue, 23 Oct 2018 12:05:28 -0500
Subject: Re: [PATCH v4 06/17] remoteproc: introduce rproc_add_carveout
 function
To:     Loic Pallardy <loic.pallardy@st.com>, <bjorn.andersson@linaro.org>,
        <ohad@wizery.com>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>
References: <1532697292-14272-1-git-send-email-loic.pallardy@st.com>
 <1532697292-14272-7-git-send-email-loic.pallardy@st.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <8f6737ec-6132-25df-107c-b646310b2dce@ti.com>
Date:   Tue, 23 Oct 2018 12:05:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1532697292-14272-7-git-send-email-loic.pallardy@st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn, Loic,

On 7/27/18 8:14 AM, Loic Pallardy wrote:
> This patch introduces a new API to allow platform driver to register
> platform specific carveout regions.
> 
> Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
> Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Hmm, I do not prefer that this function be exported. It adds no value,
and this adds an asymmetric API for remoteproc drivers to add a mem
entry to the internal remoteproc lists, while relying on the remoteproc
core to remove them. The carveout list maintenance is a remoteproc
internal scheme, and so should be maintained that way. Further more, on
the current series, all the existing calls are immediately after a
rproc_of_resm_mem_entry_init() or a rproc_mem_entry_init() function,
which means this could very well be folded into those individual functions.

regards
Suman

> ---
>  drivers/remoteproc/remoteproc_core.c | 16 +++++++++++++++-
>  include/linux/remoteproc.h           |  2 ++
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index b76760e..fe6c4e4 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -747,7 +747,7 @@ static int rproc_handle_carveout(struct rproc *rproc,
>  	if (!carveout)
>  		goto free_carv;
>  
> -	list_add_tail(&carveout->node, &rproc->carveouts);
> +	rproc_add_carveout(rproc, carveout);
>  
>  	return 0;
>  
> @@ -761,6 +761,20 @@ static int rproc_handle_carveout(struct rproc *rproc,
>  }
>  
>  /**
> + * rproc_add_carveout() - register an allocated carveout region
> + * @rproc: rproc handle
> + * @mem: memory entry to register
> + *
> + * This function registers specified memory entry in @rproc carveouts list.
> + * Specified carveout should have been allocated before registering.
> + */
> +void rproc_add_carveout(struct rproc *rproc, struct rproc_mem_entry *mem)
> +{
> +	list_add_tail(&mem->node, &rproc->carveouts);
> +}
> +EXPORT_SYMBOL(rproc_add_carveout);
> +
> +/**
>   * rproc_mem_entry_init() - allocate and initialize rproc_mem_entry struct
>   * @dev: pointer on device struct
>   * @va: virtual address
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index 4bc961f..55f30fc 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -558,6 +558,8 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
>  int rproc_del(struct rproc *rproc);
>  void rproc_free(struct rproc *rproc);
>  
> +void rproc_add_carveout(struct rproc *rproc, struct rproc_mem_entry *mem);
> +
>  struct rproc_mem_entry *
>  rproc_mem_entry_init(struct device *dev,
>  		     void *va, dma_addr_t dma, int len, u32 da,
> 

