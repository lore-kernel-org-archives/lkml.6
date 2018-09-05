Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC40C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FE772073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="FzRHXpPN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FE772073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbeIFC23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:28:29 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41129 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727592AbeIFC22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:28:28 -0400
Received: by mail-pf1-f195.google.com with SMTP id h79-v6so4144214pfk.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 14:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xr8vOzAaR0iBULaImQfihetcCsDVZ1vneMDEACQcFsM=;
        b=FzRHXpPNfZHh+z/zEmeL7ME711TwrMTWJp5IGqBUBVZSFhZ44WxSUUBUvRE6IHpwNB
         GqesrmFVvMAQ46dpElgRGyd/QhzsCKBdYA9AP3+NWrPNArFWXoOaPF07SoOpr9WRUmLX
         7DD2Jk/ye1lYXmjTGsQ9rgcRdq3GD5V/VHdKnvJvW85/32iEjaIWfLaZIAY43QsVYkBX
         mbCtRlQEp/ToTxnwgPCmW3JzqQPw53abE3haNcPzJpXGBrAmwPLeBxEVoDiWa49jXG/w
         lFwZnibUpKvAEqsZBKv9jDJmVJV9pwmgmg4tB1ryDUMvXRGjy4IA1dGeMhnwDcMhdq7N
         ZptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xr8vOzAaR0iBULaImQfihetcCsDVZ1vneMDEACQcFsM=;
        b=WhjOCa9SLpAY12+Hwt7xz75DYAyf7iTBMsDtE2uc4ac2LNSm12b0L+9hKHYD7Ucmmk
         n/pRYqdFLs6oaJHVF/ag4Ss4JnkU/KgOn7Z+KVHfSnfL9EWPxqgClxXJB+CS7XmG1bX1
         LJ84ggyOTyBJcJqjVEWe4jeXFL/vlTFSgeaqGisYV42DMuzmdPKqkGugANAewoN2iUKL
         qY7yZmRos5EQyEO8eLiazQnzuLJb8zpJjy408rP30bkdaY7/JfDIlluOvnsId7Xfw1mW
         za+D+WaepRPYvgvktyQocRTF4bG/i2mpfrPC7AXoWQV6U5MJ150K6ChzBc0+ljspwKVf
         fO8Q==
X-Gm-Message-State: APzg51Bsmr0J2ghK45H/TPmOi9xi1MAF7JDbvjNkphKFehyFbE4/MvC8
        B58en3J5s/nZ+i3dyZdI/SUtzMOzXxA=
X-Google-Smtp-Source: ANB0VdY6ylp+n5paqJ0mv6xC3s8+k6SlEPMdphMjZfZoJCyHWh0RIK+DU29U+UzsPHBzmK+fPWYg9g==
X-Received: by 2002:a63:1865:: with SMTP id 37-v6mr23909807pgy.313.1536184579885;
        Wed, 05 Sep 2018 14:56:19 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id p19-v6sm7150280pgh.60.2018.09.05.14.56.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Sep 2018 14:56:19 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1fxfmc-0007uL-Dd; Wed, 05 Sep 2018 15:56:18 -0600
Date:   Wed, 5 Sep 2018 15:56:18 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Michal Kalderon <Michal.Kalderon@cavium.com>,
        Ariel Elior <Ariel.Elior@cavium.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/qedr: remove set but not used variable
 'ctx'
Message-ID: <20180905215618.GA30370@ziepe.ca>
References: <1535774026-160694-1-git-send-email-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535774026-160694-1-git-send-email-yuehaibing@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 01, 2018 at 03:53:46AM +0000, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/infiniband/hw/qedr/verbs.c: In function 'qedr_create_srq':
> drivers/infiniband/hw/qedr/verbs.c:1450:24: warning:
>  variable 'ctx' set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> Acked-by: Rahul Verma <rahul.verma@cavium.com>
> ---
>  drivers/infiniband/hw/qedr/verbs.c | 2 --
>  1 file changed, 2 deletions(-)

Applied to for-next, thanks

Jason
