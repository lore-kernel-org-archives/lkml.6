Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C03C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 03:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8E3E20868
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 03:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="etuExfam"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8E3E20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbeKZOGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 09:06:39 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42907 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbeKZOGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 09:06:39 -0500
Received: by mail-pg1-f194.google.com with SMTP id d72so5448821pga.9
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 19:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k2NAUpg8hIpRTRatoIHkVdf65DOg56tM/yNshkjiy8Y=;
        b=etuExfamK81sPOdlR32UEePFsIsVtQSh3/ckAs73rmnM4B72Hxm04WJlGWih0R3Vd0
         YisIqFCV7HAjXsAAQRhJWZdsLrsvhAnM5F8P/FAK3Wdi/OQu1IFCu+NlSdNDo1XOHus0
         K7BMxx2QzmtHZsBjsRH+qDLNmFLnHtuZViClNoNPNzZR+cw1phD75AvYf1GlBIUR16m8
         hoUI10fHmvog3Eo5Hxh1eZXcv68d+8OhiSAra9gsAt5fTp7iUkMWXddQTDMhPUHUM4mi
         j3aJh8XDLhNYk8NueIp6F6XQPI2CsUxbzzS2Cvg5kMVB3qVLo38x84SAZEjBeK7VQV5S
         aKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k2NAUpg8hIpRTRatoIHkVdf65DOg56tM/yNshkjiy8Y=;
        b=qMLKZymjyc5rqnqE3iKxoGeleKjbKXy/uzD/St0nwAuksCO8I7SOowpOTJ2u7jYXbn
         U5OzZ07UJTFrJGJNFFoiel2JNFkABSKISbnPWBH5YRZJ5vzaCj9+xj7OlnTFTjXgKa4b
         WdImtYreOvT+ypNLXzHka5bWzHPeIA8wniaUO518qwQX0YGm1j836o1F7Z2PW+BQvWgG
         5w03CmKDNvGjsE4FyuUeOfqxgYPKuhQu1mRHhCjry79G35X6EIEejtpGlfZAXxnB3J9U
         2Ha8Xj4gZNTxtAwErU0PgKoCPiBIUS5lYh0FP9Cm0NWqksxErpceR2MwWeYYDmtl0YaZ
         txbw==
X-Gm-Message-State: AA+aEWbL1ZUHghh+aHReno+MVGEJUDEjZMzIrrgI8nocApro1Hb5ZTH6
        vOvdJze6Ghimn2YFYgENRrgh+w==
X-Google-Smtp-Source: AFSGD/WiVMW+kfgwqu5e+jlwKGRRLIRHbb3bLs7xiR3DzQiZYBp4Putlhf0HtCBiX82pVtUAYX/d8Q==
X-Received: by 2002:a65:534b:: with SMTP id w11mr23151587pgr.125.1543202036532;
        Sun, 25 Nov 2018 19:13:56 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id x7sm72190215pga.68.2018.11.25.19.13.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 19:13:55 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gR7LO-00047u-5I; Sun, 25 Nov 2018 20:13:54 -0700
Date:   Sun, 25 Nov 2018 20:13:54 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Wei Hu (Xavier)" <xavier.huwei@huawei.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        lijun_nudt@163.com, oulijun@huawei.com, charles.chenxin@huawei.com,
        liuyixian@huawei.com, zhangxiping3@huawei.com, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org, xavier_huwei@163.com
Subject: Re: [PATCH rdma-next 3/3] RDMA/hns: Modify hns RoCE device's name
Message-ID: <20181126031354.GA15463@ziepe.ca>
References: <1542986065-44265-1-git-send-email-xavier.huwei@huawei.com>
 <1542986065-44265-4-git-send-email-xavier.huwei@huawei.com>
 <20181123203958.GJ3395@ziepe.ca>
 <5BF94B9F.5030409@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5BF94B9F.5030409@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2018 at 09:01:19PM +0800, Wei Hu (Xavier) wrote:
> 
> 
> On 2018/11/24 4:39, Jason Gunthorpe wrote:
> > On Fri, Nov 23, 2018 at 11:14:25PM +0800, Wei Hu (Xavier) wrote:
> >> This patch modifies the name of hns RoCE device's name in order
> >> to ensure that the name is consistent before and after reset.
> >>
> >> Signed-off-by: Wei Hu (Xavier) <xavier.huwei@huawei.com>
> >>  drivers/infiniband/hw/hns/hns_roce_device.h | 1 +
> >>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 3 +++
> >>  drivers/infiniband/hw/hns/hns_roce_main.c   | 4 +++-
> >>  3 files changed, 7 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
> >> index 259977b..a8cfe76 100644
> >> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
> >> @@ -954,6 +954,7 @@ struct hns_roce_dev {
> >>  	struct pci_dev		*pci_dev;
> >>  	struct device		*dev;
> >>  	struct hns_roce_uar     priv_uar;
> >> +	char			name[IB_DEVICE_NAME_MAX];
> >>  	const char		*irq_names[HNS_ROCE_MAX_IRQ_NUM];
> >>  	spinlock_t		sm_lock;
> >>  	spinlock_t		bt_cmd_lock;
> >> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> >> index 1d639a0..678c7ec 100644
> >> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> >> @@ -6110,6 +6110,9 @@ static int hns_roce_hw_v2_get_cfg(struct hns_roce_dev *hr_dev,
> >>  		hr_dev->irq[i] = pci_irq_vector(handle->pdev,
> >>  						i + handle->rinfo.base_vector);
> >>  
> >> +	snprintf(hr_dev->name, IB_DEVICE_NAME_MAX, "hns%s",
> >> +		 handle->rinfo.netdev->name);
> > Why is this making up its own driver name? How is this avoiding
> > colliding with an existing name?
> >
> > This is very dangerous since we now have device renaming, the driver
> > could fail to load with no recovery.
> Hi, Jason
>        
>     The NIC driver notifies the RoCE driver to perform reset related
> processing by calling the .reset_notify() interface registered by the
> RoCE driver. If the RoCE reset processing fails, .reset_notify()
> returns non-zero, and then hns NIC driver will reschedule the
> reset task again.
>    
>     The current hardware version in hip08 SoC cannot support
> after reset process the application still communicates with the
> resources like QP requested before reset. In RoCE reset process,
> we will release the resources through ib_unregister_device, after
> the hardware reset is completed, driver will re-execute
> ib_register_device.
>    
>     Currently, we find that the ib_device's name after reset
> and the one before reset may be different. We can specify the
> device name to solve this problem.

No, now you just have unsolved races.

If you want to reset like this then you will need to do some kind of
revision to the IB core code to not loose the name assigned to the
device and not hacks like this.

Jason
