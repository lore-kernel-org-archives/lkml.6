Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F112CC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 03:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90B9D208B9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 03:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XCHP2Qrn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90B9D208B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbeH1G4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 02:56:40 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34635 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbeH1G4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 02:56:40 -0400
Received: by mail-pf1-f194.google.com with SMTP id k19-v6so95395pfi.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 20:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zf0DU59//PN8Uftc7ir8k0LJw9loa05rEXH1xtoY6Vk=;
        b=XCHP2Qrnw2eKULxs3XmJR19BEwmhTcbKzeHttlNC9em5bAjT/555pQS0+OI/0cFuQ5
         GQSSyF2dOLt2hqT3DKuXkCVBl02JjQDmQ8h1ZjqKzDQ3W3G0rtc20AgvnIzvvyi3rEhO
         9bHlyPI+UJogwtXYXg18e0EyWQZtr5ScRiMEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zf0DU59//PN8Uftc7ir8k0LJw9loa05rEXH1xtoY6Vk=;
        b=bxz93NXG1VlEam/BaiqES6Ox02z32WA5tvFWtIvGPw0hl3L/OGJbRXomc0zJpMja1G
         Pfkx11pIUm5zx5BAeRCwifarXR8PTKO9KLnvzLua8VHJnXYv/bJ/XqmMipu/9YmtraFY
         VF4ATwbZckmHVUShjGDAeyOvHyHoPqcOJuTZ2/9SuSaQholtLTio6PqI1APr4uMDcb0/
         nm522aFwxH3qeJFaRTrxcGiParI1lvfDDnhSGqQY8suFndf/fk3AkQUt9HgKNtDYywNT
         f9Nbd8//ZJ0RT4bJzeXGPi0CY5mC6UBXbIMl1OW39qND/eYjFQN5bMRC0f9Ue3xVdW8g
         qVtA==
X-Gm-Message-State: APzg51CcY5G5BJvp0RnDnor4QVkYHDO948dvoifyI0Q6mlHqjs8IhnoM
        3ngVxhzDUfTKr4nZ+l84dXCm+g==
X-Google-Smtp-Source: ANB0VdaQf1oRXlYYUGTmEFmAiTD/3FP/wjvvh6GC4nH7KCUNvu/81p145C6k/gmENr1frhiSTfI7UA==
X-Received: by 2002:a63:1d3:: with SMTP id 202-v6mr14614706pgb.136.1535425630410;
        Mon, 27 Aug 2018 20:07:10 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z22-v6sm774697pgc.67.2018.08.27.20.07.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Aug 2018 20:07:09 -0700 (PDT)
Date:   Mon, 27 Aug 2018 20:08:47 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH] rpmsg: Convert to using %pOFn instead of device_node.name
Message-ID: <20180828030847.GH5090@builder>
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-42-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828015252.28511-42-robh@kernel.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 27 Aug 18:52 PDT 2018, Rob Herring wrote:

> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
> 
> Cc: Ohad Ben-Cohen <ohad@wizery.com>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: linux-remoteproc@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied

Thanks,
Bjorn

> ---
>  drivers/rpmsg/qcom_glink_smem.c | 2 +-
>  drivers/rpmsg/qcom_smd.c        | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rpmsg/qcom_glink_smem.c b/drivers/rpmsg/qcom_glink_smem.c
> index 2b5cf2790954..ab23da3d7131 100644
> --- a/drivers/rpmsg/qcom_glink_smem.c
> +++ b/drivers/rpmsg/qcom_glink_smem.c
> @@ -205,7 +205,7 @@ struct qcom_glink *qcom_glink_smem_register(struct device *parent,
>  	dev->parent = parent;
>  	dev->of_node = node;
>  	dev->release = qcom_glink_smem_release;
> -	dev_set_name(dev, "%s:%s", node->parent->name, node->name);
> +	dev_set_name(dev, "%pOFn:%pOFn", node->parent, node);
>  	ret = device_register(dev);
>  	if (ret) {
>  		pr_err("failed to register glink edge\n");
> diff --git a/drivers/rpmsg/qcom_smd.c b/drivers/rpmsg/qcom_smd.c
> index 8da83a4ebadc..0dae7c9f4a8f 100644
> --- a/drivers/rpmsg/qcom_smd.c
> +++ b/drivers/rpmsg/qcom_smd.c
> @@ -1454,7 +1454,7 @@ struct qcom_smd_edge *qcom_smd_register_edge(struct device *parent,
>  	edge->dev.release = qcom_smd_edge_release;
>  	edge->dev.of_node = node;
>  	edge->dev.groups = qcom_smd_edge_groups;
> -	dev_set_name(&edge->dev, "%s:%s", dev_name(parent), node->name);
> +	dev_set_name(&edge->dev, "%s:%pOFn", dev_name(parent), node);
>  	ret = device_register(&edge->dev);
>  	if (ret) {
>  		pr_err("failed to register smd edge\n");
> -- 
> 2.17.1
> 
