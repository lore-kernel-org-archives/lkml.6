Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9098AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 07:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C90720672
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 07:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SJFkUorY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C90720672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbeKUSKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 13:10:17 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33702 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbeKUSKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 13:10:16 -0500
Received: by mail-lj1-f196.google.com with SMTP id v1-v6so3949243ljd.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 23:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9Od011HKcMAp9G7y/qSJgDzDxUdghRQK7R9VpPQ1O2o=;
        b=SJFkUorYyUToroQdjHp8eFcCcUdZhZ9xg9QDZJvOfij6+G4n+tcRGFUxTPmo+7PsJP
         GMkmz59jXlUKJLmhmvomMvo+B5MWmQR8LlkUfCpCGXQb3lfEGXvwgkVczwb/SXfUabZ3
         DH0eg4T+NzOQx6YhKRNL+t/uv2hEhKrIFuwtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9Od011HKcMAp9G7y/qSJgDzDxUdghRQK7R9VpPQ1O2o=;
        b=Y+IvhApcS9UmVKUuLNjM7cZclI2GG/S6Wx5ssS35KtrCU2kLc+IDeJX0mwafBAv+KZ
         VAt3MJUJcoM2YWNXXbXtPk5wR4SUR599YV/BnaPEKkry0fJxW09s/4nKroamZK1cmSEV
         PGUSxb9mzFNEQxl6n7WcDAacpTSyL4m2w/lqjIfwOC5FtOP+R0UgKsuKP6LA3CUAyNrN
         D8gfnAkm5BFJby4y1efiF0sl/pPJFvOr1wJcoEAZ2Q0bp9diM0t/XhbF0OgEIOBZYS82
         3U95aH1SkGbEn1LeJqG9ny7jC091h+UT7HciZbihr1lheJFO/kcHM0lAqovkagdb7SeB
         NFQA==
X-Gm-Message-State: AA+aEWafNlKsFDdecCo5yacDWmgeifVhW8/VvgNNWl2JCXLaU/SrH2HZ
        z1HB57sjqm/WezA9OpOMgS2cyNbuReU=
X-Google-Smtp-Source: AFSGD/Xy6EXBpOKY75gPIHoPtnFuIC3jtXTo9kjd6vV/v/9RiPCMv/8zZY8NV9Y1VJC152dzJcFZTw==
X-Received: by 2002:a2e:9849:: with SMTP id e9-v6mr1872793ljj.9.1542785812134;
        Tue, 20 Nov 2018 23:36:52 -0800 (PST)
Received: from jax.urgonet (h-84-105.A175.priv.bahnhof.se. [79.136.84.105])
        by smtp.gmail.com with ESMTPSA id k11-v6sm3363385ljk.40.2018.11.20.23.36.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 23:36:51 -0800 (PST)
Date:   Wed, 21 Nov 2018 08:36:49 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Victor Chong <victor.chong@linaro.org>
Cc:     tee-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] tee: optee: log message if dynamic shm is enabled
Message-ID: <20181121073648.GA20049@jax.urgonet>
References: <CAHqM-Qjr+5T1pMatJ=5MSsJvzaRqPybt_2TtyzHPwLnt=WjCEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHqM-Qjr+5T1pMatJ=5MSsJvzaRqPybt_2TtyzHPwLnt=WjCEA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Victor,

On Tue, Sep 11, 2018 at 06:09:02PM +0900, Victor Chong wrote:
> When dynamic shared memory support is enabled in the OP-TEE Trusted
> OS, it doesn't mean that the driver supports it, which can confuse
> users during debugging. Log a message when dynamic shared memory is
> enabled in the driver, to let users know for sure.
> 
> Suggested-by: Jerome Forissier <jerome.forissier@linaro.org>
> Signed-off-by: Victor Chong <victor.chong@linaro.org>
> Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
> 
> v2:
> * Added patch description
> 
> [v1] lore.kernel.org/patchwork/patch/983949/
> 
>  drivers/tee/optee/core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index e1aafe842d66..cca5c091e55a 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -631,6 +631,9 @@ static struct optee *optee_probe(struct device_node *np)
> 
>         optee_enable_shm_cache(optee);
> 
> +       if (optee->sec_caps & OPTEE_SMC_SEC_CAP_DYNAMIC_SHM)
> +               pr_info("dynamic shared memory is enabled\n");
> +
>         pr_info("initialized driver\n");
>         return optee;
>  err:
> --
> 2.17.1

Looks good. I'm picking this up.

Thanks,
Jens
