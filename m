Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E4FC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C46823FD1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNYtdbZ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C46823FD1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932835AbeGFMHR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 08:07:17 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:38091 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753705AbeGFMHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 08:07:12 -0400
Received: by mail-lf0-f66.google.com with SMTP id a4-v6so9613310lff.5;
        Fri, 06 Jul 2018 05:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0WBBJZze3UrHsFZnE0txFiBwjTWgkROTPnzK26C6LMs=;
        b=NNYtdbZ36eZ4zNG2ELEcKSKXncn+6WGy0VNfrSWdVvITBws8tVnfLgVqNVT2zGLLSO
         rY8MLawVPvqH69nGjqv6ABNx9SqyRkMoWmjK+Q9/1sP7heysBuPj0j/wXULFC4aLPQia
         kHdxxOZZlxLl+GshjWvXe8ET1Tvr6bdUkg/nJVTC/3GlQ4MmMIk0skJKm3Yf8IWsq262
         foQ/yMYTSy1zW8sx8JxSHGWRmERhHgdFVCVypN5mejQQwOG0m0TRohqnq1QeaYIzL17A
         ZpOaQ9klKeNckyCg2T9t+cR1V+bAKu5FWSUWIe60RLjQPkLAGesBpswiEZ4ai37GPRCS
         5QbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=0WBBJZze3UrHsFZnE0txFiBwjTWgkROTPnzK26C6LMs=;
        b=S9JIFDezHHxa4Ps5WudT0fF1QiyvnkxE06zknEzAtzC02XujNqi6EfYszzjn9GqLUv
         GHDIkCfbVQD5QM2gwdaYbvGHXGMAnf2xI3Yiyi2Xb1V6HSD/ltu1KwVKoEzfqW3ewuhj
         Xa8eo63AnOFluev2CMMWz7KvtdbBTDKRnCvm5wposLcSKBgN3TQA7G8cr4xB6wdWNfSN
         3SAdNp0lfOw91PwJiffFyyU+/JWMVbSZlAT+oPTmat7eNCSQF/+eK69qK/HzdRmmc4er
         gaqQcpm2mzMBrploDVkXJO05pokQtwttC/Xjedr3OrGwlzGgEkj5iMCGpT9vr4IDXQYg
         LPUw==
X-Gm-Message-State: APt69E0K0T8kQorrGFHLNTnrhsk8+sMvnlHsug/0RO5VSKr4YIV7jPFv
        UwD8eO7e/SGijp9O0t3ViGGnYIrV
X-Google-Smtp-Source: AAOMgpfieRADtmFUMYX2gSWEhpbf6yPtIEf60pxbYPZdrmsVC3VPFB1t/78W1sdl1W/puyi8LimAkw==
X-Received: by 2002:a19:8e5c:: with SMTP id q89-v6mr6886667lfd.35.1530878830922;
        Fri, 06 Jul 2018 05:07:10 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id u203-v6sm2094007lff.40.2018.07.06.05.07.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 05:07:10 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1fbPVq-0004pY-Ds; Fri, 06 Jul 2018 14:06:59 +0200
Date:   Fri, 6 Jul 2018 14:06:58 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Andy Gross <andy.gross@linaro.org>
Cc:     David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        stable <stable@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH] soc: qcom: rmtfs-mem: fix memleak in probe error paths
Message-ID: <20180706120658.GF9802@localhost>
References: <20180612124141.6307-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612124141.6307-1-johan@kernel.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 02:41:41PM +0200, Johan Hovold wrote:
> Make sure to set the mem device release callback before calling
> put_device() in a couple of probe error paths so that the containing
> object also gets freed.
> 
> Fixes: d1de6d6c639b ("soc: qcom: Remote filesystem memory driver")
> Cc: stable <stable@vger.kernel.org>     # 4.15
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Johan Hovold <johan@kernel.org>

I noticed that this one hasn't made it into linux-next yet, so sending a
reminder.

> ---
>  drivers/soc/qcom/rmtfs_mem.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/qcom/rmtfs_mem.c b/drivers/soc/qcom/rmtfs_mem.c
> index c8999e38b005..8a3678c2e83c 100644
> --- a/drivers/soc/qcom/rmtfs_mem.c
> +++ b/drivers/soc/qcom/rmtfs_mem.c
> @@ -184,6 +184,7 @@ static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
>  	device_initialize(&rmtfs_mem->dev);
>  	rmtfs_mem->dev.parent = &pdev->dev;
>  	rmtfs_mem->dev.groups = qcom_rmtfs_mem_groups;
> +	rmtfs_mem->dev.release = qcom_rmtfs_mem_release_device;
>  
>  	rmtfs_mem->base = devm_memremap(&rmtfs_mem->dev, rmtfs_mem->addr,
>  					rmtfs_mem->size, MEMREMAP_WC);
> @@ -206,8 +207,6 @@ static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
>  		goto put_device;
>  	}
>  
> -	rmtfs_mem->dev.release = qcom_rmtfs_mem_release_device;
> -
>  	ret = of_property_read_u32(node, "qcom,vmid", &vmid);
>  	if (ret < 0 && ret != -EINVAL) {
>  		dev_err(&pdev->dev, "failed to parse qcom,vmid\n");

Thanks,
Johan
