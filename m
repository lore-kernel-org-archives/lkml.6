Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 70178C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 02:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25E21208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 02:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jItcSqYv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25E21208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965501AbeFOCqc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 22:46:32 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34000 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964995AbeFOCqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 22:46:30 -0400
Received: by mail-pl0-f66.google.com with SMTP id g20-v6so4583326plq.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 19:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qtg//35iDJAV+Jn+SRVYNNk7jV28Y8tP+R/xqZ5bpYA=;
        b=jItcSqYvDLPW5oEg7DtmfSdMHYluQuTw1fZGzTZhSkR+ixd3357Q9bRbFpbjNFFnln
         IYBu/hBlwCvFez3uaEsMF9DmDw7O9zz24HCb3rQFjyHb/HMv8lSy3zcdpfM7oeHWxMWk
         9Iu5GtXye1WKmLIYHNtR9oMuIkuzBl8cip0sw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qtg//35iDJAV+Jn+SRVYNNk7jV28Y8tP+R/xqZ5bpYA=;
        b=uMhxxCMi6FN/Ke0lDmGeZkTqvGO0eiJkXyH8/2B6ro91JjdYvmmEuPvKONrjkGhfWB
         ezXOaKBofLTPKTVt1sB6Dw2BTqqiuPbdpGvms++kSg4lC86Zgl/4ZTHM4JHfAJGZv1JG
         cVPzOFLzAFs9G8J14qS8L6FCNYB+LkFMaWbmUEbxhqx4obS+d8a4tzqdc8vo1/tLSP+C
         40u9cUMiMB4oqNZKPEuKnPsDK6vJWnX3/XSYUQRzs2ov1j4Al9HeEdIHQKx+6RoZTUs9
         RyLEhggF1fl89nSGibvADLWVXfjulDMSkUecO1tBVVs/ZwNh6py5/lOEertCmg3wkNaA
         3zeQ==
X-Gm-Message-State: APt69E3XItVTs1nfyCvTxaWjb8W5TO3f8ALnb0I934LiIwDv1Ac335gB
        WbmzjjvUELTCtEwiM6e6X0nvcw==
X-Google-Smtp-Source: ADUXVKKGZ5ONkjU5nPklVJM4l+43NJUrzFyHFT7azqu4HP3om2ZMB5qXNuO9ubdjwU/0Qm0JQI7dVg==
X-Received: by 2002:a17:902:a581:: with SMTP id az1-v6mr5897768plb.61.1529030789994;
        Thu, 14 Jun 2018 19:46:29 -0700 (PDT)
Received: from localhost ([122.167.141.115])
        by smtp.gmail.com with ESMTPSA id 76-v6sm17198445pfr.172.2018.06.14.19.46.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 19:46:29 -0700 (PDT)
Date:   Fri, 15 Jun 2018 08:16:25 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     ilia.lin@gmail.com
Cc:     Ilia Lin <ilialin@codeaurora.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: kryo: Fix possible error code dereference
Message-ID: <20180615024625.rzr4644n77zrtomm@vireshk-i7>
References: <20180614202921.32535-1-ilia.lin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180614202921.32535-1-ilia.lin@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-06-18, 22:29, ilia.lin@gmail.com wrote:
> From: Ilia Lin <ilia.lin@gmail.com>
> 
> In event of error returned by the nvmem_cell_read() non-pointer value
> may be dereferenced. Fix this with error handling.
> 
> Signed-off-by: Ilia Lin <ilia.lin@gmail.com>

Fixes tag ?

> ---
>  drivers/cpufreq/qcom-cpufreq-kryo.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-kryo.c
> index d049fe4b80c4..5e9511223ce9 100644
> --- a/drivers/cpufreq/qcom-cpufreq-kryo.c
> +++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
> @@ -115,6 +115,8 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
>  
>  	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
>  	nvmem_cell_put(speedbin_nvmem);
> +	if (IS_ERR(speedbin))
> +		return PTR_ERR(speedbin);
>  
>  	switch (msm8996_version) {
>  	case MSM8996_V3:
> -- 
> 2.11.0

-- 
viresh
