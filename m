Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B7DC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 17:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF2D92075D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 17:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PpOOMya4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF2D92075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbeJXBuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 21:50:11 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:54986 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbeJXBuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 21:50:11 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9NHPowp060664;
        Tue, 23 Oct 2018 12:25:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1540315550;
        bh=Nffd3cFuEehYsajgl1B5inUx5DJ0XN0cIJg+GTOK7eM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=PpOOMya4kybTHrL7pNuDQpp5kj3OWTf6iWbNQLsdWnI39niWSp7DCBChoafpc2Rih
         SWa0a3F/+lTNU8OlDdgBxbj9I5RbaTr/+iOcBARFuWdTgamAjeruvKBYaNyMpGFmsZ
         JcipLMxp4HBczGrq/8PhuekQOwg7MjWQguyA7WqU=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id w9NHPoYQ091419
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 23 Oct 2018 12:25:50 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 23
 Oct 2018 12:25:49 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 23 Oct 2018 12:25:49 -0500
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9NHPn22005866;
        Tue, 23 Oct 2018 12:25:49 -0500
Subject: Re: [PATCH v4 01/17] remoteproc: configure IOMMU only if device
 address requested
To:     Loic Pallardy <loic.pallardy@st.com>, <bjorn.andersson@linaro.org>,
        <ohad@wizery.com>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>
References: <1532697292-14272-1-git-send-email-loic.pallardy@st.com>
 <1532697292-14272-2-git-send-email-loic.pallardy@st.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <f6af2ded-dfcd-7cb9-6557-a17c40166836@ti.com>
Date:   Tue, 23 Oct 2018 12:25:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1532697292-14272-2-git-send-email-loic.pallardy@st.com>
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
> If there is no IOMMU associate to remote processor device,
> remoteproc_core won't be able to satisfy device address requested
> in firmware resource table.
> Return an error as configuration won't be coherent.
> 
> Signed-off-by: Loic Pallardy <loic.pallardy@st.com>

This patch is breaking my Davinci platforms. It is not really required
that you _should_ have IOMMUs when a valid DA is mentioned. Please see
the existing description (paras 4 and 5) on the fw_rsc_carveout
kerneldoc in remoteproc.h file.

We do have platforms where we have some internal sub-modules within the
remote processor sub-system that provides some linear
address-translation (most common case with 32-bit processors supporting
64-bit addresses). Also, we have some upcoming SoCs where we have an MMU
but is not programmable by Linux.

There is one comment there, but I don't think this is actually handled
in the current remoteproc core.
"If @da is set to
 * FW_RSC_ADDR_ANY, then the host will dynamically allocate it, and then
 * overwrite @da with the dynamically allocated address."

regards
Suman

> ---
>  drivers/remoteproc/remoteproc_core.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 4cd1a8e..437fabf 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -657,7 +657,15 @@ static int rproc_handle_carveout(struct rproc *rproc,
>  	 * to use the iommu-based DMA API: we expect 'dma' to contain the
>  	 * physical address in this case.
>  	 */
> -	if (rproc->domain) {
> +
> +	if (rsc->da != FW_RSC_ADDR_ANY && !rproc->domain) {
> +		dev_err(dev->parent,
> +			"Bad carveout rsc configuration\n");
> +		ret = -ENOMEM;
> +		goto dma_free;
> +	}
> +
> +	if (rsc->da != FW_RSC_ADDR_ANY && rproc->domain) {
>  		mapping = kzalloc(sizeof(*mapping), GFP_KERNEL);
>  		if (!mapping) {
>  			ret = -ENOMEM;
> 

