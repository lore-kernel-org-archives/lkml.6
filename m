Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B493C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 23:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC47F2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 23:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="N2JZZeJv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC47F2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbeIGEJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 00:09:36 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:50430 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725745AbeIGEJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 00:09:36 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 853415C00FA;
        Fri,  7 Sep 2018 01:31:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1536276703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8AFx999YG4x9nzEIiS2ow9h7MmRRuB2TWyq5UQa+9Po=;
        b=N2JZZeJv11r7VpZERLmj5IlEr5kddgoBiPU/3Mr6fLv3ZZ4+7azk0Kp9oztHH5VXhgbM8h
        VMk0VQXXo7HHBrSQ55fUfusbuJRJrHxtG1LGlDOXQtlypkm8E8Z8Rfpf5IaGwT5hgfR5CN
        gQ8s6R1KZHCZDOLsZJgqCUERLafruTo=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Thu, 06 Sep 2018 16:31:42 -0700
From:   Stefan Agner <stefan@agner.ch>
To:     thierry.reding@gmail.com, airlied@linux.ie
Cc:     jonathanh@nvidia.com, dri-devel@lists.freedesktop.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/tegra: return with probe defer if GPIO subsystem is
 not ready
In-Reply-To: <20180726133606.14587-1-stefan@agner.ch>
References: <20180726133606.14587-1-stefan@agner.ch>
Message-ID: <de84d04c902d1f7f22b6f024b853a1c7@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.07.2018 06:36, Stefan Agner wrote:
> If the GPIO subsystem is not ready make sure to return -EPROBE_DEFER
> instead of silently continuing without HPD.
> 
> Reported-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

I think this did not get merged yet, any chance to get it in?

--
Stefan

> ---
>  drivers/gpu/drm/tegra/output.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/tegra/output.c b/drivers/gpu/drm/tegra/output.c
> index ffe34bd0bb9d..4bcefe455afd 100644
> --- a/drivers/gpu/drm/tegra/output.c
> +++ b/drivers/gpu/drm/tegra/output.c
> @@ -133,7 +133,9 @@ int tegra_output_probe(struct tegra_output *output)
>  	output->hpd_gpio = of_get_named_gpio_flags(output->of_node,
>  						   "nvidia,hpd-gpio", 0,
>  						   &output->hpd_gpio_flags);
> -	if (gpio_is_valid(output->hpd_gpio)) {
> +	if (output->hpd_gpio == -EPROBE_DEFER) {
> +		return -EPROBE_DEFER;
> +	} else if (gpio_is_valid(output->hpd_gpio)) {
>  		unsigned long flags;
>  
>  		err = gpio_request_one(output->hpd_gpio, GPIOF_DIR_IN,
