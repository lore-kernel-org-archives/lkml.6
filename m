Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4C3C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 436EB20855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ZX76AY0P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 436EB20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbeK0Eix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 23:38:53 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40497 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbeK0Eix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 23:38:53 -0500
Received: by mail-pf1-f195.google.com with SMTP id i12so6926070pfo.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 09:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NUCxedA8jCUh3/XWnCY1VzGLGAfytMQF+dvduY8RF9k=;
        b=ZX76AY0PUIWfUz11VWmh0ElI8jN4RFjPrJtV2nDkYghOvK67CD7TPAUfzzWLVDPFnH
         BSeIpi4UvM8beNt8RY1e86N0kZGbjx0WnsaGRtizagE9NcyGGsts+GyxJhAszXSS/UDB
         veTx42yye8+K38iGpLasQ6ZyKbi2mmwYDdSDG/jyAkP39f1XGGne5HK6FFW9zPFq2U0V
         INJBdf7BHXcinry2OwErCJYs65raojNqUoaTWCEwE37MIzQKrhJgEPXSs5HxZtNBB2BB
         eQ+iMfjc/3ckxYcdiqSYK6BGWD1fecrhNFuJS1WY+EE/CBLDZzZs70ZzuV9ZRFjuLa8x
         Xotw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NUCxedA8jCUh3/XWnCY1VzGLGAfytMQF+dvduY8RF9k=;
        b=LDlW++7zw9ISZb4Yij7U7GPsQJXqcJGR/OYDnC4DfnsZDLv7mZrzU7997KAdQYoBNQ
         qplvH+e4Oa8xxwxt84oWLIRuMbWSKUsZJ2RtxjPfOcqRHESeq7vpbdjCjkzEqiUGJitu
         5QHcmuw33Usun8HM9m2JZ0Ff778lTTUaa+kNCd8XHSmFdM0JyTBuvlozA87O5w+dSx63
         Xc+neBuqv0+7RPtW6mgcyAYQOL6sx7ZKxseLK3yhjygK29ZtXXuRq5eSVEJL94GCzfC6
         QVKikeZ72zmncbuDjSIXdHtGULAee80S8MNcitSDhiizWbw0Fg1XFOjtZrCpgSCJaMex
         wNDQ==
X-Gm-Message-State: AA+aEWYX0KdATJjI5oTeBU9Rkdb9RVfGCtPWLxbnehtVM0cKHdcaWTnZ
        K+GTy4S9sE6zUOpbbEy7c+SYOQ==
X-Google-Smtp-Source: AFSGD/V9cW7eRC+YHEDaIFoZflTcDKFlZ5QX6Sguk06dzw6xJUJ2T7UQywqtHfpUpaP07/2rrba5wg==
X-Received: by 2002:a62:3811:: with SMTP id f17mr1008496pfa.206.1543254243818;
        Mon, 26 Nov 2018 09:44:03 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id a10sm1096242pfi.138.2018.11.26.09.44.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 09:44:03 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gRKvS-00019y-6G; Mon, 26 Nov 2018 10:44:02 -0700
Date:   Mon, 26 Nov 2018 10:44:02 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Wei Hu (Xavier)" <xavier.huwei@huawei.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        lijun_nudt@163.com, oulijun@huawei.com, charles.chenxin@huawei.com,
        liuyixian@huawei.com, zhangxiping3@huawei.com, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org, xavier_huwei@163.com
Subject: Re: [PATCH rdma-next 3/3] RDMA/hns: Modify hns RoCE device's name
Message-ID: <20181126174402.GC32083@ziepe.ca>
References: <1542986065-44265-1-git-send-email-xavier.huwei@huawei.com>
 <1542986065-44265-4-git-send-email-xavier.huwei@huawei.com>
 <20181123203958.GJ3395@ziepe.ca>
 <5BF94B9F.5030409@huawei.com>
 <20181126031354.GA15463@ziepe.ca>
 <5BFBB002.8020703@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5BFBB002.8020703@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 04:34:10PM +0800, Wei Hu (Xavier) wrote:
> 
> 
> On 2018/11/26 11:13, Jason Gunthorpe wrote:
> > On Sat, Nov 24, 2018 at 09:01:19PM +0800, Wei Hu (Xavier) wrote:
> >>
> >> On 2018/11/24 4:39, Jason Gunthorpe wrote:
> >>> On Fri, Nov 23, 2018 at 11:14:25PM +0800, Wei Hu (Xavier) wrote:
> >>>> This patch modifies the name of hns RoCE device's name in order
> >>>> to ensure that the name is consistent before and after reset.
> >>>>
> >>>> Signed-off-by: Wei Hu (Xavier) <xavier.huwei@huawei.com>
> >>>>  drivers/infiniband/hw/hns/hns_roce_device.h | 1 +
> >>>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 3 +++
> >>>>  drivers/infiniband/hw/hns/hns_roce_main.c   | 4 +++-
> >>>>  3 files changed, 7 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
> >>>> index 259977b..a8cfe76 100644
> >>>> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
> >>>> @@ -954,6 +954,7 @@ struct hns_roce_dev {
> >>>>  	struct pci_dev		*pci_dev;
> >>>>  	struct device		*dev;
> >>>>  	struct hns_roce_uar     priv_uar;
> >>>> +	char			name[IB_DEVICE_NAME_MAX];
> >>>>  	const char		*irq_names[HNS_ROCE_MAX_IRQ_NUM];
> >>>>  	spinlock_t		sm_lock;
> >>>>  	spinlock_t		bt_cmd_lock;
> >>>> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> >>>> index 1d639a0..678c7ec 100644
> >>>> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> >>>> @@ -6110,6 +6110,9 @@ static int hns_roce_hw_v2_get_cfg(struct hns_roce_dev *hr_dev,
> >>>>  		hr_dev->irq[i] = pci_irq_vector(handle->pdev,
> >>>>  						i + handle->rinfo.base_vector);
> >>>>  
> >>>> +	snprintf(hr_dev->name, IB_DEVICE_NAME_MAX, "hns%s",
> >>>> +		 handle->rinfo.netdev->name);
> >>> Why is this making up its own driver name? How is this avoiding
> >>> colliding with an existing name?
> >>>
> >>> This is very dangerous since we now have device renaming, the driver
> >>> could fail to load with no recovery.
> >> Hi, Jason
> >>        
> >>     The NIC driver notifies the RoCE driver to perform reset related
> >> processing by calling the .reset_notify() interface registered by the
> >> RoCE driver. If the RoCE reset processing fails, .reset_notify()
> >> returns non-zero, and then hns NIC driver will reschedule the
> >> reset task again.
> >>    
> >>     The current hardware version in hip08 SoC cannot support
> >> after reset process the application still communicates with the
> >> resources like QP requested before reset. In RoCE reset process,
> >> we will release the resources through ib_unregister_device, after
> >> the hardware reset is completed, driver will re-execute
> >> ib_register_device.
> >>    
> >>     Currently, we find that the ib_device's name after reset
> >> and the one before reset may be different. We can specify the
> >> device name to solve this problem.
> > No, now you just have unsolved races.
> >
> > If you want to reset like this then you will need to do some kind of
> > revision to the IB core code to not loose the name assigned to the
> > device and not hacks like this.
> Hi, Jason
> 
>     In fact, We only specified the name of the ib_device to be generated
> when
> calling ib_register_device on the hip08 SoC, and doesn't modify its name
> during the existence of ib_device.
> 
>     In this example, if you always use hns_%d when registering, I think that
> no matter how you modify IB core code, we can't solve this problem. We
> need to specify the name of the ib_device device when calling
> ib_register_device, and this name should be unique in the OS.
> 
>     The NIC and the RoCE hardware engine share the function On the hip08
> SoC.
> The NIC driver will execute register_netdev firstly, and then the RoCE
> driver will
> execute ib_register_device. In the following statement, where
> handle->rinfo.netdev->name is the name of the corresponding net_device
> device,
> this will ensure the uniqueness of the hnsXXX ib_device's name on the OS.
> 
>     snprintf(hr_dev->name, IB_DEVICE_NAME_MAX, "hns%s",
>          handle->rinfo.netdev->name);

It does not. We support rename in ib_core now, so users can set device
names to whatever they like and break these naming assumptions.

The only solution I can see is to make a reset function in IB core
that retains the name but forces all clients to disconnect and
reconnect.

Jason
