Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754920AbeCRWr0 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 18:47:26 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36933 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754281AbeCRWrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 18:47:23 -0400
X-Google-Smtp-Source: AG47ELtDYBg/2wP7JhyqBG0YuBIGgFKojnAz7eY4wmLiH79kmjFN+2HAu2/dUgWhc2eGgIROyC7jOg==
Date: Sun, 18 Mar 2018 15:47:24 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: srinivas.kandagatla@linaro.org, will.deacon@arm.com, joro@8bytes.org,
        ohad@wizery.com, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH 2/3] rpmsg: core: make rpmsg bus DMA capable
Message-ID: <20180318224724.GJ5626@tuxbook-pro>
References: <20180302145531.20463-1-srinivas.kandagatla@linaro.org>
 <20180302145531.20463-3-srinivas.kandagatla@linaro.org>
 <07503032-b08b-10ea-9d34-ddf85c682a9d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07503032-b08b-10ea-9d34-ddf85c682a9d@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 02 Mar 08:14 PST 2018, Robin Murphy wrote:

> On 02/03/18 14:55, srinivas.kandagatla@linaro.org wrote:
> > From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > 
> > Many of the rpmsg clients like audio drivers need to allocate
> > dma memory. Make this bus DMA capable so that the child devices
> > can use dma apis.
> 
> AFAICS after 15 minutes in the docs and code, the rpmsg "bus" is a virtual
> one based around shared-memory mailbox communication, so I don't really see
> how DMA exists in that context - I think maybe that abstraction needs
> looking at.
> 

That's right, rpmsg shuffles messages back and forth to some coprocessor
over shared memory, the contexts generating and receiving these messages
are "rpmsg devices".

The problem Srinivas is facing is that one of these rpmsg devices is
trying to allocate and map a larger chunk of memory to be shared with
the coprocessor, which is then going to be referenced in the messages
being passed in rpmsg.

> However, from grepping through the DTs it seems at first glance like the
> non-trivial things under the "qcom,smd" bus mostly map to actual platform
> devices via the "qcom,smd-edge" property - if those platform devices are the
> physical DMA masters, they should be the ones used for DMA API operations.
> 

One of the rpmsg implementations is virtio based and have a similar
problem, there dma_alloc*() is called with dev->parent->parent as
device, but this causes issues as dev->parent might not be what the
original author expected it to -- so this needs to be reworked as well.

> > Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > ---
> >   drivers/rpmsg/rpmsg_core.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
> > index e84c71f8d6ab..540a3f3567b8 100644
> > --- a/drivers/rpmsg/rpmsg_core.c
> > +++ b/drivers/rpmsg/rpmsg_core.c
> > @@ -472,6 +472,7 @@ struct bus_type rpmsg_bus = {
> >   	.uevent		= rpmsg_uevent,
> >   	.probe		= rpmsg_dev_probe,
> >   	.remove		= rpmsg_dev_remove,
> > +	.force_dma	= true,
> 
> Regardless of the above, would you really need to use this brute force hack
> instead of just fixing the DTs? I'm struggling to find which drivers might
> currently be relying on this :/
> 

The rpmsg devices, described as child nodes of rpmsg bus relates to
specific functions in the coprocessor firmware. The fact that the
firmware can be started and stopped dynamically makes the current layout
quite convenient (in comparison to e.g. how we would describe a
mailbox).

We know for these cases that dev->parent->parent is a remoteproc
instance representing the coprocessor that sits on the other side of the
communication channel. So we did investigate if we could just have that
to allocate and map buffers. The problem with this is that these
functions has multiple iommu contexts.

Regards,
Bjorn
