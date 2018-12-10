Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACDBC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ED5F2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DQ/8yQFF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ED5F2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbeLJNxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 08:53:21 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36195 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbeLJNxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 08:53:20 -0500
Received: by mail-pg1-f195.google.com with SMTP id n2so5005600pgm.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 05:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xYkuV0k8aBBeyyBaATPTKd/YixCx26NfJlDybN3AfPU=;
        b=DQ/8yQFFgOLJajz3T9XE/oiQ5JAzwHBGCRgvnrhldOwbhDkGb/+V19hy3dCELu6zcp
         xa369bg+/uuE2bZj69zZwyd068dtpuRk4i8z1z4LXuan2SqgjkMWPTbEVHNY2oOMds0C
         1y0xzyjiTQPWbn8Gzg2adQ2zjMMjENeFyPvRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xYkuV0k8aBBeyyBaATPTKd/YixCx26NfJlDybN3AfPU=;
        b=gAnlkrKvqOOPRDDhGb7QToFHeJu38SCYhx/HVxwBob++YAg7d2Z3BXiqEiNQdR6dYN
         IhAf/UA0uhklaQQkKVWCGqX0NWdtucFRdOv+NZL90ENnbFvxaxys6qlhxPgywSyScFOq
         P0E7IghBpQt/1GonNxa58ddwxPwKuGwT57rhV+nXoWJe6o50ZaC6eyEn1mlmHbdGqNXl
         c4jpv+Nh7GI3p4BvXyJMEcmRVYAVEjCDUr66tqe3VpMGTh9as4D2isZfmRrJ++iXm/zt
         hyAWCSLkmMpa0E6/93BH/YA1bqHOmtP2/7sdd9Kqa7bh3fbH4zOKXs3bUNg/P+OLWNHQ
         kI4g==
X-Gm-Message-State: AA+aEWYDmBtZAvdgfYnVUAiFmAdjCP/t4+Url+GZ4dRSBJs4od0I3K1l
        ZpN1o7o1qLAvqqNsoxXLpQST
X-Google-Smtp-Source: AFSGD/Wt9gRb0DhY+iLQ1M7UOj8U44kU8/3yaK9jSLAB9nMUjtht8RCP/ez0PhQucquiIZ5nClEquA==
X-Received: by 2002:a63:b94c:: with SMTP id v12mr10872025pgo.221.1544449999806;
        Mon, 10 Dec 2018 05:53:19 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:91e:2c01:40e1:a028:b090:9e12])
        by smtp.gmail.com with ESMTPSA id l3sm20824651pga.92.2018.12.10.05.53.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 05:53:19 -0800 (PST)
Date:   Mon, 10 Dec 2018 19:23:09 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Parthiban Nallathambi <pn@denx.de>
Cc:     afaerber@suse.de, robh+dt@kernel.org, mark.rutland@arm.com,
        wsa@the-dreams.de, linux-arm-kernel@lists.infradead.org,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@cubietech.com,
        thomas.liau@actions-semi.com
Subject: Re: [PATCH v2 2/4] i2c: Add Actions Semiconductor Owl family S700
 I2C support
Message-ID: <20181210135309.GD25368@Mani-XPS-13-9360>
References: <20181126185821.2480449-1-pn@denx.de>
 <20181126185821.2480449-3-pn@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126185821.2480449-3-pn@denx.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 07:58:19PM +0100, Parthiban Nallathambi wrote:
> Add S700 to the list of devices supported by Owl I2C driver.
> 
> Add Actions Semiconductor Owl family S900 I2C driver.

S700 ;-)

> 
> Signed-off-by: Parthiban Nallathambi <pn@denx.de>

With the change in subject,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Cheers,
Mani

> ---
>  drivers/i2c/busses/i2c-owl.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/i2c/busses/i2c-owl.c b/drivers/i2c/busses/i2c-owl.c
> index 96b4572e6d9c..b6b5a495118b 100644
> --- a/drivers/i2c/busses/i2c-owl.c
> +++ b/drivers/i2c/busses/i2c-owl.c
> @@ -475,6 +475,7 @@ static int owl_i2c_probe(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id owl_i2c_of_match[] = {
> +	{ .compatible = "actions,s700-i2c" },
>  	{ .compatible = "actions,s900-i2c" },
>  	{ /* sentinel */ }
>  };
> -- 
> 2.17.2
> 
