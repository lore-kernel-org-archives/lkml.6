Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01C5C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 21:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B521C218D3
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 21:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7h+kSYx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbfADVPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 16:15:41 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34037 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbfADVPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 16:15:41 -0500
Received: by mail-pf1-f196.google.com with SMTP id h3so18846982pfg.1;
        Fri, 04 Jan 2019 13:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q3r78EI54RMLx3YsrpNMRvybnJ3RAUvqPvKjPHWb8CY=;
        b=e7h+kSYxQTMpALPE6jE0ElR4uRIeMQjZ1IlXRpNrGaupiXe/HKqnjYZ1g0+x3mZQTD
         BFJADZopaxrEVT4xaW/qf8wVRCFTi7J16YGuhuSIe2IsWfGsxXvF+dTER/FnY15oLOSs
         yvBlqunHjA3pMFuAoprQFCUL2DJrMd7Gg0560F5rsqPYT81zWq4bTdjO/mftNS/QYH43
         GKbFVXQuWdCw2/GC/zlj1F5Fgz5E9g/BciONuu1nRZ8x3imFu3S3JnxWKOQS8aYfBJeg
         rY3zOZjw2YcBZUENrySIothUnN/87Aa0gZMf/1GRKW+g05EM9jj7QDEqi12LFNHAdkLb
         A+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q3r78EI54RMLx3YsrpNMRvybnJ3RAUvqPvKjPHWb8CY=;
        b=fEVYF8dVEn9/FQfHdmpq1ac61HzbXXT5sKBqCtov4aym+TD1ix1rwX/NA+O3wPUkqS
         hvtlVg5j+2mKTSihn17XJKGsoCVT/0yPlAzRcAdXv7g70di/rN55shFLGOrUHtzWqVKj
         wwejKZzQ1njrg/zcaT0ve9RTse13qeD4CQaWJUPvIaA94N94ctU7SSUizObCPJQPxeIG
         q1Vf/vXor9ATKXtOavxMo8xQbOW4sjli0anCFa61Ak5y/f9qc8yUb3n6w04CiOtARRda
         QCXws3na3+XjRrOcrqUQwFAC7lbAYGlqkB/bRmYwQTW1o03qMYKlYSUZ/kCTrLzU/P3b
         es6g==
X-Gm-Message-State: AA+aEWZgYBrBKQ0/JTF3WVK+8UqI7gzpUQ7jA8XRmhQWuwFOhsJ4dQaj
        s77krVhgZFZ72ILoHItW0+fOQcSb
X-Google-Smtp-Source: ALg8bN6gRcKjbtAl0z/WM1sNvM9lrr05Xg6bzOwxwquBoBVsuJUjs5HYuCj8yivGPBob+jx2iFVB2A==
X-Received: by 2002:a62:31c1:: with SMTP id x184mr55270801pfx.204.1546636540179;
        Fri, 04 Jan 2019 13:15:40 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r4sm116717829pgn.54.2019.01.04.13.15.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 13:15:39 -0800 (PST)
Date:   Fri, 4 Jan 2019 13:15:37 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     robdclark@gmail.com, jonathan@marek.ca,
        dri-devel@lists.freedesktop.org, bjorn.andersson@linaro.org,
        andy.gross@linaro.org, shawnguo@kernel.org, cphealy@gmail.com,
        linux-kernel@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] qcom-scm: Include <linux/err.h> header
Message-ID: <20190104211537.GA19545@roeck-us.net>
References: <20181226120619.18879-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181226120619.18879-1-festevam@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 26, 2018 at 10:06:19AM -0200, Fabio Estevam wrote:
> Since commit e6f6d63ed14c ("drm/msm: add headless gpu device for imx5")
> the DRM_MSM symbol can be selected by SOC_IMX5 causing the following
> error when building imx_v6_v7_defconfig:
> 
> In file included from ../drivers/gpu/drm/msm/adreno/a5xx_gpu.c:17:0:
> ../include/linux/qcom_scm.h: In function 'qcom_scm_set_cold_boot_addr':
> ../include/linux/qcom_scm.h:73:10: error: 'ENODEV' undeclared (first use in this function)
>   return -ENODEV;
> 
> Include the <linux/err.h> header file to fix this problem.
> 
> Reported-by: kernelci.org bot <bot@kernelci.org>
> Fixes: e6f6d63ed14c ("drm/msm: add headless gpu device for imx5")
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Tested-by: Guenter Roeck <linux@roeck-us.net>

Still broken upstream, and the commit window is about to close.
Any chance to send this patch upstream anytime soon ?

Guenter

> ---
>  include/linux/qcom_scm.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
> index 06996ad4f2bc..ce5a476fd733 100644
> --- a/include/linux/qcom_scm.h
> +++ b/include/linux/qcom_scm.h
> @@ -13,6 +13,7 @@
>  #ifndef __QCOM_SCM_H
>  #define __QCOM_SCM_H
>  
> +#include <linux/err.h>
>  #include <linux/types.h>
>  #include <linux/cpumask.h>
>  
