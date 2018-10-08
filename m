Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE9EC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 06:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FCC320882
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 06:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DHQzeXGv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FCC320882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbeJHNzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 09:55:49 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36817 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbeJHNzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 09:55:49 -0400
Received: by mail-pl1-f195.google.com with SMTP id y11-v6so6450648plt.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 23:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8anaAmd7wFeZWmeyn24MjswTuCLe7ZVawP9h02Ufgy4=;
        b=DHQzeXGvJClpNRflqs3/LfM2WfCUnAvC9j2IDjh1dgn0/7vqWymAlFHKWGE1XHccBq
         V55lcHCLGo1KNTX0K2C0TspruIYFtbHSbJTQSMd8K7++u6iqD7i8ZMhr7wwcJBoZWniV
         4ByjeE0Q3letS7p/qp1WSW7Iaub7eUq30kYM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8anaAmd7wFeZWmeyn24MjswTuCLe7ZVawP9h02Ufgy4=;
        b=qsRwt6muKGtysPGJ3dJsB+DVRwMvNXeGA4zTGeXjJHaDtSX/CLgNmU6NVU+u76dgT0
         w7QbsmKInXcr+ssH/3lFEFNs0BFOETmq3uFcBQpEPyaI/u/He7Hm+v2fGbNtj4kRMydW
         ee4UCEIF5DsDzJDkzpMBzKexkHZNnMLO/jaMobREUSEHITYOYanaxdFZ5YRIOFZwayVn
         yx5UTitatSeAtJCi8wPvLmfsFBbzV26aGozHDd9DzARvueaLjRSKgphNV/qznl7CtouD
         EvMiuZil8/Ai7L8Ri7PjdJligLpQHnwKP2ZKE8Yk5uFP38fSRtZbfXK+/0yWgRdMVTK1
         Yi/w==
X-Gm-Message-State: ABuFfoijyZCFvGngpqyA1H3o/vu6bftaspl9rc6LErgJ3kqi8X2BQhOt
        WA5opt1v+RTO4w3NMqtVFrMN8w==
X-Google-Smtp-Source: ACcGV614rPcZlRPSEU8x7Ulmct5PbwuSXEz6hLV+Y0Jnz1PfbmNk3ZBZIQGZaL3M112nKcJskxIrkA==
X-Received: by 2002:a17:902:124:: with SMTP id 33-v6mr22775535plb.205.1538981139275;
        Sun, 07 Oct 2018 23:45:39 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id u9-v6sm30162153pfi.104.2018.10.07.23.45.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Oct 2018 23:45:38 -0700 (PDT)
Date:   Sun, 7 Oct 2018 23:48:28 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ohad@wizery.com, kyan@codeaurora.org, sricharan@codeaurora.org,
        akdwived@codeaurora.org, linux-arm-msm@vger.kernel.org,
        tsoni@codeaurora.org
Subject: Re: [PATCH v3 5/6] remoteproc: qcom: q6v5-pil: Register
 segments/dumpfn for coredump
Message-ID: <20181008064828.GP12063@builder>
References: <20180727152003.11663-1-sibis@codeaurora.org>
 <20180727152003.11663-6-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727152003.11663-6-sibis@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 27 Jul 08:20 PDT 2018, Sibi Sankar wrote:

> Register the MDT segments and custom dumpfn with the remoteproc core
> dump functionality.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  drivers/remoteproc/qcom_q6v5_pil.c | 40 ++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_pil.c b/drivers/remoteproc/qcom_q6v5_pil.c
> index ac3342f9ea5a..22bb049c3e7f 100644
> --- a/drivers/remoteproc/qcom_q6v5_pil.c
> +++ b/drivers/remoteproc/qcom_q6v5_pil.c
> @@ -1058,10 +1058,50 @@ static void *q6v5_da_to_va(struct rproc *rproc, u64 da, int len)
>  	return qproc->mpss_region + offset;
>  }
>  
> +static int qcom_q6v5_register_dump_segments(struct rproc *rproc,
> +				const struct firmware *fw_unused)

How about naming it mba_fw instead of unused? Just as unused, but easier
to understand why it isn't used.

> +{
> +	const struct firmware *fw;
> +	const struct elf32_phdr *phdrs;
> +	const struct elf32_phdr *phdr;
> +	const struct elf32_hdr *ehdr;
> +	struct q6v5 *qproc = (struct q6v5 *)rproc->priv;

No need for an explicit typecast from void *.

The rest looks good!

Regards,
Bjorn
