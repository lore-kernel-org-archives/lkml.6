Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A7EC00449
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 00:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F24D2098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 00:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AUklqD8m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F24D2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbeJDHRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 03:17:37 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39945 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbeJDHRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 03:17:36 -0400
Received: by mail-pl1-f195.google.com with SMTP id 1-v6so4251253plv.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 17:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Pu+/MNSmssfVnfC0GoBTE79yvYkr3WN76F9lOnSLGyk=;
        b=AUklqD8m2RzPbGMdGt+sIxqjH3YtD7APywijItl7yHpfUGxBUxVv1OcNQh7kPn1kR8
         tjZN2SUrzq+isc8h8KmuaU/Vw1ccMKWI0T2rOBO1xvJbgmsLJCU70l8T9z5xqCkDwu8l
         MyKoMV1g8BMWRO/953r1kLpfxPWsrZ6LVcYF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Pu+/MNSmssfVnfC0GoBTE79yvYkr3WN76F9lOnSLGyk=;
        b=rYFHE+B8BfVOD5uWTu9+4okKOnizt+LVMc2R9maD4FFkjfZZ8Sr3hUqtP1/b0tLGXm
         ikzWFnoF1mATW1TOiS3YKcz6xIfxS0gFPToKyE8V9IsrpQoBUIWRUPgdYWF9yJmNFkn9
         GALkaUSope6oscPUjbuZ0jIGPx/7QKG1gb41cDmMD4MM2Gqh74kZwGxaMDjb4sQqiSyN
         yfXb8IMUGBlwhdz8y3UK8sgThx3ZWzJLuNWj7JxHEBEySCTqN/p/SMzwm1KHYVCX/1i/
         l1RL3rhELPZJ6zoSulog3JcBHPzrLeceIs293JO/3M1zfBeVx4JYxLNHnxG6RN2AifOZ
         7e6g==
X-Gm-Message-State: ABuFfohvUnCACyFtGvT8C0D/JqyAzbt+MP88fFwrPHgIPWIskYfmCHpD
        mjzVUYpJmqHOD+wqTCdZwivHE8RlzVEAbw==
X-Google-Smtp-Source: ACcGV63eg/dGTqIqO2OECzHMhD72MR5TfJywlsLFs5xylXEKVGGUKc8K2w+ycVXUvBfCBrvU21kIfw==
X-Received: by 2002:a17:902:4225:: with SMTP id g34-v6mr4003185pld.161.1538612814321;
        Wed, 03 Oct 2018 17:26:54 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id a190-v6sm3684817pge.47.2018.10.03.17.26.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Oct 2018 17:26:53 -0700 (PDT)
Date:   Wed, 3 Oct 2018 17:26:51 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Arun Kumar Neelakantam <aneela@codeaurora.org>
Cc:     ohad@wizery.com, clew@codeaurora.org, sricharan@codeaurora.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] rpmsg: Add signal callback to rpmsg char device
Message-ID: <20181004002651.GU2523@minitux>
References: <1538566463-24627-1-git-send-email-aneela@codeaurora.org>
 <1538566463-24627-3-git-send-email-aneela@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538566463-24627-3-git-send-email-aneela@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 03 Oct 04:34 PDT 2018, Arun Kumar Neelakantam wrote:

> Register a callback to get the signal notifications from rpmsg.
> 
> Signed-off-by: Arun Kumar Neelakantam <aneela@codeaurora.org>

Please incorporate this into patch 4.

Regards,
Bjorn
 
> ---
>  drivers/rpmsg/rpmsg_char.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
> index a76b963..86003d5 100644
> --- a/drivers/rpmsg/rpmsg_char.c
> +++ b/drivers/rpmsg/rpmsg_char.c
> @@ -5,6 +5,7 @@
>   * Copyright (c) 2012, PetaLogix
>   * Copyright (c) 2011, Texas Instruments, Inc.
>   * Copyright (c) 2011, Google, Inc.
> + * Copyright (c) 2018, The Linux Foundation.
>   *
>   * Based on rpmsg performance statistics driver by Michal Simek, which in turn
>   * was based on TI & Google OMX rpmsg driver.
> @@ -120,6 +121,12 @@ static int rpmsg_ept_cb(struct rpmsg_device *rpdev, void *buf, int len,
>  	return 0;
>  }
>  
> +static int rpmsg_sigs_cb(struct rpmsg_device *rpdev, void *priv,
> +			 u32 old, u32 new)
> +{
> +	return 0;
> +}
> +
>  static int rpmsg_eptdev_open(struct inode *inode, struct file *filp)
>  {
>  	struct rpmsg_eptdev *eptdev = cdev_to_eptdev(inode->i_cdev);
> @@ -136,6 +143,7 @@ static int rpmsg_eptdev_open(struct inode *inode, struct file *filp)
>  		return -EINVAL;
>  	}
>  
> +	ept->sig_cb = rpmsg_sigs_cb;
>  	eptdev->ept = ept;
>  	filp->private_data = eptdev;
>  
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
