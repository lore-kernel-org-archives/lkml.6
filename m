Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DEFEC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 14:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE37A208FC
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 14:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zFbqWFTu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE37A208FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbeHVSG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 14:06:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:44718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728343AbeHVSG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 14:06:27 -0400
Received: from mail-qk0-f179.google.com (mail-qk0-f179.google.com [209.85.220.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 651E92147C;
        Wed, 22 Aug 2018 14:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534948876;
        bh=+Ot0mFJBUnPSMzS4p/h67ASbMdzM8m5cWDyiNmWcKC8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zFbqWFTueKpZ/wRdKTNLn93wzWOt7xm4NJxG8GbYmWt/OmzoDOtwFVgVsW9xSBrck
         ZMPf9zjibnPv9Z3iE8mBNV7j74TZDM2nz1+++FLJsPQuiCyJDV3etdj87WmJZHJiLh
         +34ovBTcPokFxn/2sOx58rvifcJz3VQNwehJl64g=
Received: by mail-qk0-f179.google.com with SMTP id j7-v6so1326504qkd.13;
        Wed, 22 Aug 2018 07:41:16 -0700 (PDT)
X-Gm-Message-State: AOUpUlG83BnsnsVRwJbHfIpf5cuAmhgftXkd4MhjmeCATmEI/9duT4A8
        BnlkCV0d2ScodgTMTbCtx3Prd5I+BFBlO8L+jQ==
X-Google-Smtp-Source: ANB0VdbXs0UP2goSRa9c1Zr2B15nbMRAK5GsAuFn8kmqWzi0VoOnviZBp39l1HExJ5DSLVtu4Ya5/rTa1yeRcLo9O+o=
X-Received: by 2002:a37:169c:: with SMTP id 28-v6mr21659735qkw.184.1534948875622;
 Wed, 22 Aug 2018 07:41:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180822105547.9634-1-johan@kernel.org> <20180822105547.9634-4-johan@kernel.org>
In-Reply-To: <20180822105547.9634-4-johan@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 22 Aug 2018 09:41:04 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+6rftT-FfXGs_WSFDMLqNWbgBqHwtEXmxkgCjf9yf07g@mail.gmail.com>
Message-ID: <CAL_Jsq+6rftT-FfXGs_WSFDMLqNWbgBqHwtEXmxkgCjf9yf07g@mail.gmail.com>
Subject: Re: [PATCH 3/9] drm/msm: fix OF child-node lookup
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 5:57 AM Johan Hovold <johan@kernel.org> wrote:
>
> Use the new of_get_compatible_child() helper to lookup the legacy
> pwrlevels child node instead of using of_find_compatible_node(), which
> searches the entire tree and thus can return an unrelated (i.e.
> non-child) node.
>
> This also addresses a potential use-after-free (e.g. after probe
> deferral) as the tree-wide helper drops a reference to its first
> argument (i.e. the probed device's node).
>
> While at it, also fix the related child-node reference leak.
>
> Fixes: e2af8b6b0ca1 ("drm/msm: gpu: Use OPP tables if we can")
> Cc: stable <stable@vger.kernel.org>     # 4.12
> Cc: Jordan Crouse <jcrouse@codeaurora.org>
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: David Airlie <airlied@linux.ie>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> index da1363a0c54d..93d70f4a2154 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -633,8 +633,7 @@ static int adreno_get_legacy_pwrlevels(struct device *dev)
>         struct device_node *child, *node;
>         int ret;
>
> -       node = of_find_compatible_node(dev->of_node, NULL,
> -               "qcom,gpu-pwrlevels");
> +       node = of_get_compatible_child(dev->of_node, "qcom,gpu-pwrlevels");

Not really your problem, but this is undocumented and a downstream
binding. There's been OPP support in addition for more than a year
now, we should just remove this code IMO. For some reason though, no
one updated the 8064 dts though.

Rob
