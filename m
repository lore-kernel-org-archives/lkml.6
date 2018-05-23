Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753979AbeEWDr5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 23:47:57 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51613 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753787AbeEWDry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 23:47:54 -0400
X-Google-Smtp-Source: AB8JxZoe4KdJRFQMELmQAsL6mKLxNn7wP7aHDtsE6aIMvRy1d5f+e7iCkAVpM3kpn/eGmSscFE//wQ==
Date: Tue, 22 May 2018 21:47:48 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Wei Hu (Xavier)" <xavier.huwei@huawei.com>
Cc: dledford@redhat.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, xavier.huwei@tom.com, lijun_nudt@163.com
Subject: Re: [PATCH rdma-next 4/5] RDMA/hns: Add reset process for RoCE in
 hip08
Message-ID: <20180523034748.GC21148@ziepe.ca>
References: <1526544173-106587-1-git-send-email-xavier.huwei@huawei.com>
 <1526544173-106587-5-git-send-email-xavier.huwei@huawei.com>
 <20180517151459.GD10842@ziepe.ca>
 <5AFE484B.2080206@huawei.com>
 <20180518041502.GS10842@ziepe.ca>
 <5AFE7F54.9030201@huawei.com>
 <20180522202612.GB21148@ziepe.ca>
 <5B04D7FE.70806@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B04D7FE.70806@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 10:54:54AM +0800, Wei Hu (Xavier) wrote:
> 
> 
> On 2018/5/23 4:26, Jason Gunthorpe wrote:
> > On Fri, May 18, 2018 at 03:23:00PM +0800, Wei Hu (Xavier) wrote:
> >>
> >> On 2018/5/18 12:15, Jason Gunthorpe wrote:
> >>> On Fri, May 18, 2018 at 11:28:11AM +0800, Wei Hu (Xavier) wrote:
> >>>> On 2018/5/17 23:14, Jason Gunthorpe wrote:
> >>>>> On Thu, May 17, 2018 at 04:02:52PM +0800, Wei Hu (Xavier) wrote:
> >>>>>> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> >>>>>> index 86ef15f..e1c44a6 100644
> >>>>>> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> >>>>>> @@ -774,6 +774,9 @@ static int hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
> >>>>>>  	int ret = 0;
> >>>>>>  	int ntc;
> >>>>>>  
> >>>>>> +	if (hr_dev->is_reset)
> >>>>>> +		return 0;
> >>>>>> +
> >>>>>>  	spin_lock_bh(&csq->lock);
> >>>>>>  
> >>>>>>  	if (num > hns_roce_cmq_space(csq)) {
> >>>>>> @@ -4790,6 +4793,7 @@ static int hns_roce_hw_v2_init_instance(struct hnae3_handle *handle)
> >>>>>>  	return 0;
> >>>>>>  
> >>>>>>  error_failed_get_cfg:
> >>>>>> +	handle->priv = NULL;
> >>>>>>  	kfree(hr_dev->priv);
> >>>>>>  
> >>>>>>  error_failed_kzalloc:
> >>>>>> @@ -4803,14 +4807,70 @@ static void hns_roce_hw_v2_uninit_instance(struct hnae3_handle *handle,
> >>>>>>  {
> >>>>>>  	struct hns_roce_dev *hr_dev = (struct hns_roce_dev *)handle->priv;
> >>>>>>  
> >>>>>> +	if (!hr_dev)
> >>>>>> +		return;
> >>>>>> +
> >>>>>>  	hns_roce_exit(hr_dev);
> >>>>>> +	handle->priv = NULL;
> >>>>>>  	kfree(hr_dev->priv);
> >>>>>>  	ib_dealloc_device(&hr_dev->ib_dev);
> >>>>>>  }
> >>>>> Why are these hunks here? If init fails then uninit should not be
> >>>>> called, so why meddle with priv?
> >>>> In hns_roce_hw_v2_init_instance function, we evaluate handle->priv with 
> >>>> hr_dev,
> >>>> We want clear the value in hns_roce_hw_v2_uninit_instance function.
> >>>> So we can ensure no problem in RoCE driver.
> >>> What problem could happen?
> >>>
> >>> I keep removing unnecessary sets to null and checks of null, so please
> >>> don't add them if they cannot happen.
> >>>
> >>> Eg uninit should never be called with a null priv, that is a serious
> >>> logic mis-design someplace if it happens.
> >>>
> >>> Jason
> >> NIC driver call the registered reset_notify() function to finish the
> >> part of RoCE reset process.
> >> In RoCE driver,  when hnae3_reset_notify_type is HNAE3_UNINIT_CLIENT,
> >> we call hns_roce_hw_v2_uninit_instance(handle, false) to release the
> >> resources.
> >> when hnae3_reset_notify_type is HNAE3_INIT_CLIENT, we call
> >> hns_roce_hw_v2_init_instance.
> >> if hns_roce_hw_v2_init_instance failed, we should ensure no problem in
> >> the other callback
> >> function registered by RoCE driver.
> > Don't design things like this.
> >
> > init/uninit are paired - do not call something uninit if it can be
> > called after init fails, or better, arrange to prevent that so things
> > are sane.
> >
> > Jason
> >
> > .
> The current RoCE driver registered 3 callback function to NIC driver as
> belows:
> 1.init_instance/uninit_instance are paired.
> 2.In reset_notify function,  RoCE dirver still call
> init_instance/uninit_instance function.
> but NIC driver does not perceive the behavior.  We need to judge in RoCE
> driver.

fix the nic driver

Jason
