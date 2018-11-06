Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B411C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D72D2081D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YdI02Sq5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D72D2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388461AbeKGAvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 19:51:54 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39844 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387685AbeKGAvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 19:51:53 -0500
Received: by mail-lj1-f195.google.com with SMTP id t9-v6so8607268ljh.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 07:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sVSCpPqq2TdIW/WDYjfhd9dY4fe6HQme6L8tGAoV9UM=;
        b=YdI02Sq5dezcAJxl0QGTP/+dctdCtwP90QD7FqFFf6cSmsBTBiAaSZhSBdHv4glst6
         tWBSb71WzrU4gTR2k4fEhFzT9qB2O/9e0oipLgSxAfR2au+OBehtni8Do6SujxR1rIGB
         rcxbny8J80KyPZZaOvDoV0ok6sfNXVwOvCpTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sVSCpPqq2TdIW/WDYjfhd9dY4fe6HQme6L8tGAoV9UM=;
        b=XLdd+ImmzBp+LUnJwVQX+Ox+EATOm08QQlE45HDUL76T2JgSJlSeKe3KR1eR606Rdj
         lTl7Xr3zwOk0TLbNnqDUulzmQJiamuB09GzFZPRQc1NpztRuXtEiruzrG2dQXU1Psx9s
         1x56CSjpBV2emXTWeb2Xl+a3YfdK8U57vxtUDrjVIjmFHP/+sLvxRK6pRJndj6Qw/yif
         IRyyw7Ns1AMCKdqMmf19/M7VCXzzorWqelDZVqYssQo57JEzcLBfpiLdMfZMQk+GNYXT
         ksBmWNlChKh/oKXwUSs7PZOX5c0lY8KUQvmHSxLOTDrB4JwRK21WKHe6xIknvfH1YFG9
         LSiw==
X-Gm-Message-State: AGRZ1gJnEse51aJJGLjKQT7iQp9W0gHCu3V7j2ymfMN1bkdisTbRVybN
        Hxry4IHStg5uYV8aOWAKKfnrTQ==
X-Google-Smtp-Source: AJdET5dof10jqooPBRfyYIab5mleV0iYAadGHSIeQ25VE6pYzzIbF7KZ2MjO2pntOYv3tlGjmP/Ecw==
X-Received: by 2002:a2e:5b1d:: with SMTP id p29-v6mr17415523ljb.176.1541517967233;
        Tue, 06 Nov 2018 07:26:07 -0800 (PST)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id z6sm3606775lfa.87.2018.11.06.07.26.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 07:26:06 -0800 (PST)
Date:   Tue, 6 Nov 2018 16:26:04 +0100
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     bgolaszewski@baylibre.com, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [regression 4.20-rc1, bisected] cpufreq fails to register on
 db820c
Message-ID: <20181106152604.GA27108@centauri.lan>
References: <20181106012928.GA32044@centauri.lan>
 <941ed402-4259-a9aa-b0d3-10e76e4ac946@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <941ed402-4259-a9aa-b0d3-10e76e4ac946@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 02:37:57PM +0000, Srinivas Kandagatla wrote:
> Hi Niklas,
> 
> thanks for reporting this..
> 
> I found the issue, DT support seems to be totally broken in NVMEM.
> Will send this fix once you can confirm it works for you!
> 
> Can you try this patch!
> ---------------------->cut<--------------------------
> 
> Author: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Date:   Tue Nov 6 14:32:30 2018 +0000
> 
>     nvmem: core: fix of_nvmem_cell_get()
> 
>     NVMEM DT support seems to be totally broken after
>     e888d445ac33 ("nvmem: resolve cells from DT at registration time")
>     Fix this!
> 
>     Fixes: e888d445ac33 ("nvmem: resolve cells from DT at registration
> time")
>     Reported-by: Niklas Cassel <niklas.cassel@linaro.org>
>     Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 9b18ce90f907..7ae8072f56ae 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -44,6 +44,7 @@ struct nvmem_cell {
>         int                     bytes;
>         int                     bit_offset;
>         int                     nbits;
> +       struct device_node      *np;
>         struct nvmem_device     *nvmem;
>         struct list_head        node;
>  };
> @@ -530,6 +531,7 @@ static int nvmem_add_cells_from_of(struct nvmem_device
> *nvmem)
>                         return -ENOMEM;
> 
>                 cell->nvmem = nvmem;
> +               cell->np = child;
>                 cell->offset = be32_to_cpup(addr++);
>                 cell->bytes = be32_to_cpup(addr);
>                 cell->name = kasprintf(GFP_KERNEL, "%pOFn", child);
> @@ -960,14 +962,13 @@ nvmem_cell_get_from_lookup(struct device *dev, const
> char *con_id)
> 
>  #if IS_ENABLED(CONFIG_OF)
>  static struct nvmem_cell *
> -nvmem_find_cell_by_index(struct nvmem_device *nvmem, int index)
> +nvmem_find_cell_by_node(struct nvmem_device *nvmem, struct device_node *np)
>  {
>         struct nvmem_cell *cell = NULL;
> -       int i = 0;
> 
>         mutex_lock(&nvmem_mutex);
>         list_for_each_entry(cell, &nvmem->cells, node) {
> -               if (index == i++)
> +               if (np == cell->np)
>                         break;
>         }
>         mutex_unlock(&nvmem_mutex);
> @@ -1001,7 +1002,6 @@ struct nvmem_cell *of_nvmem_cell_get(struct
> device_node *np, const char *id)
>         cell_np = of_parse_phandle(np, "nvmem-cells", index);
>         if (!cell_np)
>                 return ERR_PTR(-EINVAL);
> -
>         nvmem_np = of_get_next_parent(cell_np);
>         if (!nvmem_np)
>                 return ERR_PTR(-EINVAL);
> @@ -1011,7 +1011,7 @@ struct nvmem_cell *of_nvmem_cell_get(struct
> device_node *np, const char *id)
>         if (IS_ERR(nvmem))
>                 return ERR_CAST(nvmem);
> 
> -       cell = nvmem_find_cell_by_index(nvmem, index);
> +       cell = nvmem_find_cell_by_node(nvmem, cell_np);
>         if (!cell) {
>                 __nvmem_device_put(nvmem);
>                 return ERR_PTR(-ENOENT);
> 

Tested-by: Niklas Cassel <niklas.cassel@linaro.org>
