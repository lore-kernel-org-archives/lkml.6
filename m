Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D991DC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 932B22081F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RHP1/OM4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 932B22081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbeLJRAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:00:16 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46450 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727515AbeLJRAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:00:16 -0500
Received: by mail-wr1-f68.google.com with SMTP id l9so11189974wrt.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 09:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YnOVPTnN8dX/BYzujInLN1FwrnYyPwOhbFWA6dfnqf4=;
        b=RHP1/OM4RMfntZ4kJY9BspCpSeZe8eJNB76zF9nKX8TPg2LKtvu6tJn/MU0xVq9wQQ
         dchzaMDud3qWQv+V62n16lmAF4ICf3SwnBAtaSzSA2Lb3Ag2ItO7VVj0Uu1BPW7MLf/F
         NCNG8H+fBVcr2zhLWn3d27fd+gAYX/gnKItRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YnOVPTnN8dX/BYzujInLN1FwrnYyPwOhbFWA6dfnqf4=;
        b=aY1k5Ky+9a8C1Ubh45TCRA4lEqIWBRghAM+zJsTWVy/O+lkNB/W2Xp8O+PxZnGcAgb
         2O6iIo3hPgljf7DcwnRmj7xlBp4P5l4duBoJSybMdfZiMvC2bR0gX+wbdgoN3x0avZ3Q
         zdQj32zaB+05ZrFRsGnY4yFDuxiZyRR0EkG1F1VKsBgFSnk/CRLJceIl4Z+x66ceTBA1
         57RD9a5W8Rwi76coPiRRXYMeq6k5nI+g04cIhte2C3pEbN50VbATastWyKLNxZ2HYFJr
         F9CxPTSj+Vq8xFNO7LCMyOOTKp1PCgj0vQldBcZU0BQEr+6wVEFn2fj2lWO1SDFPdGSi
         i7jw==
X-Gm-Message-State: AA+aEWa/DdFKHame7DNDJ5OoFaSxvkU9E9s3hEVl7bNB2rV70ruv/pAR
        xZYTPNGjd8cwGCELtznrtOm13/vOiUc=
X-Google-Smtp-Source: AFSGD/Xe/y0QaSU1vdBPhK9uO3AFsVB7CeNvn08oTccplmXC9+kqougHvb34EFSF1+NtQ5P5wumwVQ==
X-Received: by 2002:adf:ba05:: with SMTP id o5mr10045227wrg.325.1544461214290;
        Mon, 10 Dec 2018 09:00:14 -0800 (PST)
Received: from [192.168.0.40] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id w80sm14344460wme.38.2018.12.10.09.00.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 09:00:13 -0800 (PST)
Subject: Re: [PATCH v4] cpuidle: big.LITTLE: fix refcount leak
To:     Yangtao Li <tiny.windzz@gmail.com>, lorenzo.pieralisi@arm.com,
        rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20181210162641.21029-1-tiny.windzz@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <ee49b2fc-f855-4406-8780-0638d5fe09a0@linaro.org>
Date:   Mon, 10 Dec 2018 18:00:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181210162641.21029-1-tiny.windzz@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/2018 17:26, Yangtao Li wrote:
> of_find_node_by_path() acquires a reference to the node
> returned by it and that reference needs to be dropped by its caller.
> bl_idle_init() doesn't do that, so fix it.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
> changes in v4:
> -update tile
> -refactor code,suggested by Daniel
> ---
>  drivers/cpuidle/cpuidle-big_little.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-big_little.c b/drivers/cpuidle/cpuidle-big_little.c
> index db2ede565f1a..b44476a1b7ad 100644
> --- a/drivers/cpuidle/cpuidle-big_little.c
> +++ b/drivers/cpuidle/cpuidle-big_little.c
> @@ -167,6 +167,7 @@ static int __init bl_idle_init(void)
>  {
>  	int ret;
>  	struct device_node *root = of_find_node_by_path("/");
> +	const struct of_device_id *match_id;
>  
>  	if (!root)
>  		return -ENODEV;
> @@ -174,7 +175,11 @@ static int __init bl_idle_init(void)
>  	/*
>  	 * Initialize the driver just for a compliant set of machines
>  	 */
> -	if (!of_match_node(compatible_machine_match, root))
> +	match_id = of_match_node(compatible_machine_match, root);
> +
> +	of_node_put(root);
> +
> +	if (!match_id)
>  		return -ENODEV;
>  
>  	if (!mcpm_is_available())
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

