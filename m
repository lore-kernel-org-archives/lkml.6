Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3508C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 21:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8551F218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 21:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="FhdrwMNI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbfAYVuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 16:50:21 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40200 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfAYVuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 16:50:20 -0500
Received: by mail-pf1-f194.google.com with SMTP id i12so5327968pfo.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 13:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9+DBtuGjCp2Q60+t9cZOc0VZSPnC3YYLZ8i2NyOn0+A=;
        b=FhdrwMNI0phvAvR02vwY+oxUFi6Stt60J2SQwmVSXIbeBJxbRctJNV8CPHQBr2yVmv
         hw7pjH4HgADm92WB1Q5PdAUecgwiAE0pDmPIQjNcKNPpDAxSEyy6m2CDnImltoaOp6Yj
         R/50EXX0FmJ/iC4IJfbpIFYYrSF3X0T7uXE2Z8gpOuuZwNd8mQjm6qmcDAhL0sLovaFQ
         LmLNfIMPTWlO1BM27cL1sZjdHrF4eER3fhN96XWvXwiM8c8YBrWbmn8PYGWb3bdn+/+2
         JjAoDf2KTKFdQpJmGVMTUaAzRcyfm9CHl8hTlHR0LkGrK9ccovYILPZZocWGu0v+DeNW
         tgxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9+DBtuGjCp2Q60+t9cZOc0VZSPnC3YYLZ8i2NyOn0+A=;
        b=VpFd6v7d7ZhVd8QpCuSJxxAbRwzkclC/9ltJaqP2jVn6YSI/L5hqd1814Es58JDkcl
         RB3gEo7vvC0udYcqrp7skRclI4i4YVkYxbd4v61cb+Ehtk05M2eK36oi5fGi6Ar+cKwE
         N7WX6geTUYGpl8JbF4ph//lSq2KxSZWqcoRJ17vqpUiBLwTcIagyjIOj+zNwyEWx4Fva
         itt4HF7Zpa5MFjb5MedhE/YEpY611BjcS0WLnGBrcmA1sHz4wjk9hE+Hx4+I07hfvrdC
         5tXrCgaHxNkQVLUEdkJlquv6VIm25CDfp9Z+0uwMKwlJ+dYP3NkTQ4+CVIYck9s49rBe
         vMvg==
X-Gm-Message-State: AJcUukdX+ewxGypvpdL6l8cXlL1HrPwhbu3jVM+dgFGxZJKNz2aBobiT
        BblDMIJKq3lM/pOV8elto0BAOQ==
X-Google-Smtp-Source: ALg8bN7+4ENmh9wjS9+xie2rjwhoaAKN3bEsmPulRrvULeDe8zjKaV/+Tk4RWpiQ1yu4y1+0HogkyQ==
X-Received: by 2002:a65:51ca:: with SMTP id i10mr11118790pgq.371.1548453020032;
        Fri, 25 Jan 2019 13:50:20 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id z191sm31824706pgd.74.2019.01.25.13.50.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 13:50:19 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gn9Mg-0005M7-DU; Fri, 25 Jan 2019 14:50:18 -0700
Date:   Fri, 25 Jan 2019 14:50:18 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Wei Hu (Xavier)" <xavier.huwei@huawei.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        lijun_nudt@163.com, oulijun@huawei.com, liudongdong3@huawei.com,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org,
        xavier_huwei@163.com
Subject: Re: [PATCH V2 rdma-next 2/3] RDMA/hns: Fix the chip hanging caused
 by sending mailbox&CMQ during reset
Message-ID: <20190125215018.GF23001@ziepe.ca>
References: <1547868967-115951-1-git-send-email-xavier.huwei@huawei.com>
 <1547868967-115951-3-git-send-email-xavier.huwei@huawei.com>
 <20190123224041.GA11605@ziepe.ca>
 <5C492D59.8030707@huawei.com>
 <20190124183120.GD17167@ziepe.ca>
 <5C4A714C.2070109@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5C4A714C.2070109@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 10:15:40AM +0800, Wei Hu (Xavier) wrote:
> 
> 
> On 2019/1/25 2:31, Jason Gunthorpe wrote:
> > On Thu, Jan 24, 2019 at 11:13:29AM +0800, Wei Hu (Xavier) wrote:
> >>
> >> On 2019/1/24 6:40, Jason Gunthorpe wrote:
> >>> On Sat, Jan 19, 2019 at 11:36:06AM +0800, Wei Hu (Xavier) wrote:
> >>>
> >>>> +static int hns_roce_v2_cmd_hw_resetting(struct hns_roce_dev *hr_dev,
> >>>> +					unsigned long instance_stage,
> >>>> +					unsigned long reset_stage)
> >>>> +{
> >>>> +	struct hns_roce_v2_priv *priv = (struct hns_roce_v2_priv *)hr_dev->priv;
> >>>> +	struct hnae3_handle *handle = priv->handle;
> >>>> +	const struct hnae3_ae_ops *ops = handle->ae_algo->ops;
> >>>> +	unsigned long end;
> >>>> +
> >>>> +	/* When hardware reset is detected, we should stop sending mailbox&cmq
> >>>> +	 * to hardware, and wait until hardware reset finished. If now
> >>>> +	 * in .init_instance() function, we should exit with error. If now at
> >>>> +	 * HNAE3_INIT_CLIENT stage of soft reset process, we should exit with
> >>>> +	 * error, and then HNAE3_INIT_CLIENT related process can rollback the
> >>>> +	 * operation like notifing hardware to free resources, HNAE3_INIT_CLIENT
> >>>> +	 * related process will exit with error to notify NIC driver to
> >>>> +	 * reschedule soft reset process once again.
> >>>> +	 */
> >>>> +	end = msecs_to_jiffies(HNS_ROCE_V2_HW_RST_TIMEOUT) + jiffies;
> >>>> +	while (ops->get_hw_reset_stat(handle) && time_before(jiffies, end))
> >>>> +		udelay(1);
> >>> I thought you were getting rid of these loops?
> >> Hi, Jason
> >>
> >>     Upper applications maybe notify driver to issue mailbox or CMD
> >>     commands to hardware, some commands used to cancel resources,
> >>     destory bt/destory cq/unreg mr/destory qp etc. when such
> >>     commands are executed successfully, the hardware engine will
> >>     no longer access some memory registered by the driver.
> >>
> >>     When reset occurs, it is possible for upper applications notify driver
> >>     to issue mailbox or CMD commands, we need to wait until hardware
> >>     reset finished to ensure that hardware no longer accesses related
> >> memory.
> > You should not wait for things using loops like the above.
> Hi, Jason
> 
>     Are your comments foucsing on udelay? If not, thanks for your detail
> information.
>     In hns3 RoCE driver, some CMQ/mailbox operation are called inside
> the lock,
>     we can't use msleep in the lock, otherwise it will cause deadlock.
>     When reset occurs, RDMA service cannot be provided normally, I think
> in this
>     case using udelay will not have a great impact.

You should not use any kind of sleep call in a loop like this.

Jason
