Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2E8C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 04:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15401240B0
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 04:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8vPA4Be"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15401240B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753941AbeGFEGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 00:06:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:38660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751704AbeGFEGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 00:06:24 -0400
Received: from localhost (unknown [223.226.33.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C95B240B6;
        Fri,  6 Jul 2018 04:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530849983;
        bh=BUY9rRIp6ZCkXxOey1idUThZPeh80dNyeXs0yOhnkDg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C8vPA4BeAGRq3QsU/HESlJgEJ7co7QsH5XGDM2DZYXGlDpaEEa518U9ecT1uxsNAG
         3gKNl6wuhyPojrTXILr28HCrg1wXDugPD7PsjhCtAQHbsPSquFZV221BhWIVZeOhae
         bizyAyI3KYMvIWKrgDwy2CQbGWsq395+7kyGyiAY=
Date:   Fri, 6 Jul 2018 09:36:15 +0530
From:   Vinod <vkoul@kernel.org>
To:     Loic Pallardy <loic.pallardy@st.com>
Cc:     bjorn.andersson@linaro.org, ohad@wizery.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnaud.pouliquen@st.com, benjamin.gaignard@linaro.org
Subject: Re: [PATCH 1/1] remoteproc: correct rproc_free_vring() to avoid
 invalid kernel paging
Message-ID: <20180706040615.GN22377@vkoul-mobl>
References: <1530806353-13664-1-git-send-email-loic.pallardy@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530806353-13664-1-git-send-email-loic.pallardy@st.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-07-18, 17:59, Loic Pallardy wrote:
> If rproc_start() failed, rproc_resource_cleanup() is called to clean
> debufs entries, then associated iommu mappings, carveouts and vdev.

typo debufs...

> Issue occurs when rproc_free_vring() is trying to reset vring resource
> table entry.
> At this time, table_ptr is pointing on loaded resource table and carveouts
> amready released, so access to loaded resource table is generating a kernel

typo amready..

> paging error:
> 
> [   12.696535] Unable to handle kernel paging request at virtual address f0f357cc
> [   12.696540] pgd = (ptrval)
> [   12.696542] [f0f357cc] *pgd=6d2d0811, *pte=00000000, *ppte=00000000
> [   12.696558] Internal error: Oops: 807 [#1] SMP ARM
> [   12.696563] Modules linked in: rpmsg_core v4l2_mem2mem videobuf2_dma_contig sti_drm v4l2_common vida
> [   12.696598] CPU: 1 PID: 48 Comm: kworker/1:1 Tainted: G        W         4.18.0-rc2-00018-g3170fdd-8
> [   12.696602] Hardware name: STi SoC with Flattened Device Tree
> [   12.696625] Workqueue: events request_firmware_work_func
> [   12.696659] PC is at rproc_free_vring+0x84/0xbc [remoteproc]
> [   12.696667] LR is at rproc_free_vring+0x70/0xbc [remoteproc]
> 
> This patch proposes to simply remove reset of resource table vring entries,
> as firmware and resource table are reloaded at each rproc boot.
> rproc_trigger_recovery() not impacted as resources not touched during recovery
> procedure.
> 
> Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
> ---
>  drivers/remoteproc/remoteproc_core.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index a9609d9..9a8b47c 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -289,16 +289,10 @@ void rproc_free_vring(struct rproc_vring *rvring)
>  {
>  	int size = PAGE_ALIGN(vring_size(rvring->len, rvring->align));
>  	struct rproc *rproc = rvring->rvdev->rproc;
> -	int idx = rvring->rvdev->vring - rvring;
> -	struct fw_rsc_vdev *rsc;
>  
>  	dma_free_coherent(rproc->dev.parent, size, rvring->va, rvring->dma);
>  	idr_remove(&rproc->notifyids, rvring->notifyid);
>  
> -	/* reset resource entry info */
> -	rsc = (void *)rproc->table_ptr + rvring->rvdev->rsc_offset;
> -	rsc->vring[idx].da = 0;
> -	rsc->vring[idx].notifyid = -1;
>  }
>  
>  static int rproc_vdev_do_probe(struct rproc_subdev *subdev)
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-remoteproc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
~Vinod
