Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C92ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 21:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA9D620877
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 21:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DuBhdZvH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA9D620877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733052AbeITDMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 23:12:44 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34093 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732504AbeITDMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 23:12:44 -0400
Received: by mail-pg1-f193.google.com with SMTP id d19-v6so3360178pgv.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 14:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5zWKKd4PzX7Zx22I+g+mrILQbKTG4zL5INPKZz8m+Jg=;
        b=DuBhdZvHdgALhiQyoOe0Z+A84L4WPqn8L4Ugsv5560aqrZ76HvIcZ0NqvSdReoge5v
         CZzhrh4/1E6SkSxrK9vyHRmYl1WxP8EqC+UcMh4wKvkcCtZBW3356TQr6G2bt0IMT2eX
         Ca8Y4BJ+ECij1LrCakoSEZInnb1Z9JMZmjbEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5zWKKd4PzX7Zx22I+g+mrILQbKTG4zL5INPKZz8m+Jg=;
        b=QfYgHTzucSTWiCweFVuVTjUSa091LFp3ErBcPNUvEiimmeCMVkH0Ct98TrPyWVAlFp
         d8fGfYLjP/5dlJBZx0CkpdoRnQoTSvK3DFQAFATyeQCQfmr9+FysZ/HMFrqd6Dbdd23Y
         E49mmwQNvOdd3yzWrwGy572AP6/bidJ21nZ7K+8oDxXZ8Ls9Em/lj3cpPCmK3vNVbgo5
         q8yqtW7zItwjdRf3masv/fW+4rTSBVy6EAVaWNwJapzg8xhkMK7K/ajBPXDkDSjjyRFD
         hsvN24sI3D5X4ETCoc7q0DjPvpLqdi0rFi/hWam1ABPWUY4h/5ALnjtqReF2H/mw4igt
         S/kA==
X-Gm-Message-State: APzg51ArbvzzTJ89e17STKzSY57hDU8he/ktOUie/NhY/NiMXNUgW5Hf
        hLvLELjsCRPCVXyjWfDfBIlXhUqvdNw=
X-Google-Smtp-Source: ANB0VdZ90jKNYYwayYQgK4xlqjJsD1q1EgxrMkdAuphndzxAUkp743c9BhHAW096VRyFqCRmORgp3g==
X-Received: by 2002:a62:63c2:: with SMTP id x185-v6mr37694763pfb.13.1537392774528;
        Wed, 19 Sep 2018 14:32:54 -0700 (PDT)
Received: from localhost ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id o10-v6sm22905714pgp.70.2018.09.19.14.32.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 14:32:53 -0700 (PDT)
Date:   Wed, 19 Sep 2018 14:32:53 -0700
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Ilia Lin <ilia.lin@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2] cpufreq: qcom-kryo: Fix section mismatch warning
Message-ID: <20180919213253.dphckfar3fnrfvl3@vireshk-mac-ubuntu>
References: <20180919182247.1101-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919182247.1101-1-natechancellor@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-09-18, 11:22, Nathan Chancellor wrote:
> WARNING: vmlinux.o(.text+0x8aa424): Section mismatch in reference from
> the function qcom_cpufreq_kryo_probe() to the function
> .init.text:qcom_cpufreq_kryo_get_msm_id()
> The function qcom_cpufreq_kryo_probe() references
> the function __init qcom_cpufreq_kryo_get_msm_id().
> This is often because qcom_cpufreq_kryo_probe lacks a __init
> annotation or the annotation of qcom_cpufreq_kryo_get_msm_id is wrong.
> 
> Add the '__init' annotation to qcom_cpufreq_kryo_probe so that there is
> no more mismatch warning.
> 
> Fixes: 46e2856b8e18 ("cpufreq: Add Kryo CPU scaling driver")
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
> 
> v1 -> v2:
> 
> Add '__init' to qcom_cpufreq_kryo_probe instead of removing it from
> qcom_cpufreq_kryo_get_msm_id.
> 
>  drivers/cpufreq/qcom-cpufreq-kryo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-kryo.c
> index a1830fa25fc5..e001ef8ea7de 100644
> --- a/drivers/cpufreq/qcom-cpufreq-kryo.c
> +++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
> @@ -73,7 +73,7 @@ static enum _msm8996_version __init qcom_cpufreq_kryo_get_msm_id(void)
>  	return version;
>  }
>  
> -static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
> +static int __init qcom_cpufreq_kryo_probe(struct platform_device *pdev)
>  {
>  	struct opp_table *opp_tables[NR_CPUS] = {0};
>  	enum _msm8996_version msm8996_version;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
