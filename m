Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AAA2C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6A9E2077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kq1jcrfe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6A9E2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbeICXls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 19:41:48 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46160 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbeICXls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 19:41:48 -0400
Received: by mail-pf1-f196.google.com with SMTP id u24-v6so518692pfn.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 12:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c2+4tOF2BIFm9K9iN5UYAZ65HT/STokt3Xl5WK62BhA=;
        b=Kq1jcrfeqhJzm/ETj/bDIGcS42tkHIri2n1kfpm347HqILTzlwoBOunXUxiTwyQdRz
         YJGqD+cdoMC8xvB7+Wh8JnC/upblbTvFj2jjdYfmVvaXKjcjLPE97A+NQImw2FkXk9fY
         3wGXx5tQx1iYR++DN3Q2jivPrXb5Ydi1MvkzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c2+4tOF2BIFm9K9iN5UYAZ65HT/STokt3Xl5WK62BhA=;
        b=E/2LJLptiwbQp+r33/RnwjOj3abfntkz6KsIAyzNdDKXjKWEwZnq6rpByLPB16T4Jp
         pmGKYVk/vcdQfKk5754c1Xj6NMCO1DzUE6PLx1N+wFKzFuACqOI5GoSLJ2JYMNhBBeXT
         idQ00A2VUIJ29uxVwpopOI64AWSEEskHdeLkVCXMd3ZbYIEz+QKhM+ja7gg+2Bg+vbHA
         1T1TfjQO/AcCV9uncdO8vIxu+ql5BFNKLZPe1rZa6Voz4avATXXzYDB1FqDlLnrC26b9
         H56erxyn1rtQnbslgAx4uveVxQs8M4+aZKPZJHHkQqmp97inicCuyekfgQaKuARP092E
         TqYg==
X-Gm-Message-State: APzg51CyVAHwHk74jxPXIYUymLjrvwN7CBjViv3wOq8AhUEs+p3N6td7
        g5zklhNNRn3NV+OyYlIs1RZ0sA==
X-Google-Smtp-Source: ANB0VdZYkvlSJ6LwxLTt/DnHlx7DIW7k0vNF51hde6WaRHBksxzk9EVvLrFt8ottUqCSvcOp+vUGvA==
X-Received: by 2002:a63:1021:: with SMTP id f33-v6mr27534448pgl.72.1536002413591;
        Mon, 03 Sep 2018 12:20:13 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id f13-v6sm19514049pgs.92.2018.09.03.12.20.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Sep 2018 12:20:12 -0700 (PDT)
Date:   Mon, 3 Sep 2018 12:24:07 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 6/9] soc: qcom: Remove depends on OF from QCOM_RPMH
Message-ID: <20180903192407.GC3456@tuxbook-pro>
References: <20180829075724.9095-1-niklas.cassel@linaro.org>
 <20180829075724.9095-7-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829075724.9095-7-niklas.cassel@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 29 Aug 00:57 PDT 2018, Niklas Cassel wrote:

> QCOM_RPHM already selects ARM64, which always selects OF.

Nit. "already depends on ARM64"

> 
> Additionally, the rpmh driver only uses linux/of.h, which has dummy
> definitions for all functions, in order for code to to be able to
> build without CONFIG_OF set.
> 
> Remove the superfluous depends on OF.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/soc/qcom/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index ac657164a136..cf4ece232897 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -94,7 +94,7 @@ config QCOM_RMTFS_MEM
>  
>  config QCOM_RPMH
>  	bool "Qualcomm RPM-Hardened (RPMH) Communication"
> -	depends on ARCH_QCOM && ARM64 && OF || COMPILE_TEST
> +	depends on ARCH_QCOM && ARM64 || COMPILE_TEST
>  	help
>  	  Support for communication with the hardened-RPM blocks in
>  	  Qualcomm Technologies Inc (QTI) SoCs. RPMH communication uses an
> -- 
> 2.17.1
> 
