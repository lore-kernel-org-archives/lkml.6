Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S940465AbeE1Qqh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 12:46:37 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34617 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S940428AbeE1Qq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 12:46:27 -0400
X-Google-Smtp-Source: AB8JxZqML3aAQebWoMwKuiYoajBDchpPnOEw7eGSIYk/TskbiNzAKPd/nw/quv8KXI6bsZjIRXnhjQ==
Date: Mon, 28 May 2018 10:46:22 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Wei Hu (Xavier)" <xavier.huwei@huawei.com>
Cc: dledford@redhat.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 rdma-next 3/4] RDMA/hns: Add reset process for RoCE in
 hip08
Message-ID: <20180528164622.GB17505@ziepe.ca>
References: <1527070590-94399-1-git-send-email-xavier.huwei@huawei.com>
 <1527070590-94399-4-git-send-email-xavier.huwei@huawei.com>
 <20180524213143.GE3948@ziepe.ca>
 <5B07A517.7030507@huawei.com>
 <20180525145553.GA27342@ziepe.ca>
 <5B08BCBF.9040001@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B08BCBF.9040001@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 26, 2018 at 09:47:43AM +0800, Wei Hu (Xavier) wrote:
> 
> 
> On 2018/5/25 22:55, Jason Gunthorpe wrote:
> > On Fri, May 25, 2018 at 01:54:31PM +0800, Wei Hu (Xavier) wrote:
> >>
> >> On 2018/5/25 5:31, Jason Gunthorpe wrote:
> >>>>  static const struct hnae3_client_ops hns_roce_hw_v2_ops = {
> >>>>  	.init_instance = hns_roce_hw_v2_init_instance,
> >>>>  	.uninit_instance = hns_roce_hw_v2_uninit_instance,
> >>>> +	.reset_notify = hns_roce_hw_v2_reset_notify,
> >>>>  };
> >>>>  
> >>>>  static struct hnae3_client hns_roce_hw_v2_client = {
> >>>> diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
> >>>> index 1b79a38..ac51372 100644
> >>>> +++ b/drivers/infiniband/hw/hns/hns_roce_main.c
> >>>> @@ -332,6 +332,9 @@ static struct ib_ucontext *hns_roce_alloc_ucontext(struct ib_device *ib_dev,
> >>>>  	struct hns_roce_ib_alloc_ucontext_resp resp = {};
> >>>>  	struct hns_roce_dev *hr_dev = to_hr_dev(ib_dev);
> >>>>  
> >>>> +	if (!hr_dev->active)
> >>>> +		return ERR_PTR(-EAGAIN);
> >>> This still doesn't make sense, ib_unregister_device already makes sure
> >>> that hns_roce_alloc_ucontext isn't running and won't be called before
> >>> returning, don't need another flag to do that.
> >>>
> >>> Since this is the only place the active flag is tested it can just be deleted
> >>> entirely.
> >> Hi, Jason
> >>    
> >>     roce reset process:
> >>     1. hr_dev->active = false;  //make sure no any process call
> >> ibv_open_device.   
> >>     2. call ib_dispatch_event() function to report IB_EVENT_DEVICE_FATAL
> >> event.
> >>     3. msleep(100);   // for some app to free resources
> >>     4. call ib_unregister_device().   
> >>     5. ...
> >>     6. ...
> >>
> >>     There are 2 steps as above before calling ib_unregister_device(), we
> >> evaluate
> >> hr_dev->active with false to avoid no any process call
> >> ibv_open_device.
> > If you think this is the right flow then it is core issue to block new
> > opens, not an individual driver issue, send a core patch - eg add a
> > 'ib_driver_fatal_error()' call that does the dispatch and call it from
> > all the drivers using this IB_EVENT_DEVICE_FATAL
> Hi, Jason
> 
> It seem to be no difference between calling ib_driver_fatal_error and
> calling ib_dispatch_event  directly in manufacturer driver.
> 
> void ib_driver_fatal_error(struct ib_device *ib_dev, u8 port_num)
>  {
>        struct ib_event event;
>                 
>   event.event = IB_EVENT_DEVICE_FATAL;
>     event.device = ib_dev;
>     event.element.port_num = port_num;
>     ib_dispatch_event(&event);
> }

My point was the core code should block calling
hns_roce_alloc_ucontext after DEVICE_FATAL if we agree that is
correct, the driver shouldn't be doing it.

Jason
