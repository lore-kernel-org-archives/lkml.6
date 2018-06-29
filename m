Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF9FC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6140F27E8C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:34:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6140F27E8C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxdriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936063AbeF2Lei (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 07:34:38 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:51066 "EHLO
        smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934003AbeF2Leg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 07:34:36 -0400
Received: from cpe-2606-a000-111b-40b7-640c-26a-4e16-9225.dyn6.twc.com ([2606:a000:111b:40b7:640c:26a:4e16:9225] helo=localhost)
        by smtp.tuxdriver.com with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.63)
        (envelope-from <nhorman@tuxdriver.com>)
        id 1fYrfY-0005kf-8I; Fri, 29 Jun 2018 07:34:33 -0400
Date:   Fri, 29 Jun 2018 07:33:55 -0400
From:   Neil Horman <nhorman@tuxdriver.com>
To:     Adit Ranadive <aditr@vmware.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        pv-drivers <pv-drivers@vmware.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vmw_pvrdma: Release netdev when vmxnet3 module is removed
Message-ID: <20180629113355.GB16153@hmswarspite.think-freely.org>
References: <20180628135938.19625-1-nhorman@tuxdriver.com>
 <20180628185946.GC379@ziepe.ca>
 <20180628194526.GA14168@hmswarspite.think-freely.org>
 <20180628203709.GD379@ziepe.ca>
 <74E5B871-3D33-4C75-8FD4-C5D5BE2182AD@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74E5B871-3D33-4C75-8FD4-C5D5BE2182AD@vmware.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 09:15:46PM +0000, Adit Ranadive wrote:
> On 6/28/18, 1:37 PM, "Jason Gunthorpe" <jgg@ziepe.ca> wrote:
> > On Thu, Jun 28, 2018 at 03:45:26PM -0400, Neil Horman wrote:
> > > On Thu, Jun 28, 2018 at 12:59:46PM -0600, Jason Gunthorpe wrote:
> > > > On Thu, Jun 28, 2018 at 09:59:38AM -0400, Neil Horman wrote:
> > > > > On repeated module load/unload cycles, its possible for the pvrmda
> > > > > driver to encounter this crash:
> <snip>
> > > > > @@ -962,6 +982,7 @@ static int pvrdma_pci_probe(struct pci_dev *pdev,
> > > > >  	}
> > > > >  
> > > > >  	dev->netdev = pci_get_drvdata(pdev_net);
> > > > > +	dev_hold(dev->netdev);
> 
> That doesn't seem right. If the vmxnet3 driver isn't loaded at all or failed
> to create a netdev, you would be requesting a hold on a NULL netdev. What if
> you moved this to after the if(!dev->netdev) check?
> 
You're correct, I was thinking that there was a null check in dev_hold, but
there isn't, it needs to be moved after the the !dev->netdev, and released in
the error path.

> > > > >  	pci_dev_put(pdev_net);
> > > > >  	if (!dev->netdev) {
> > > > >  		dev_err(&pdev->dev, "failed to get vmxnet3 device\n");
> > > > 
> > > > I see a lot of new dev_hold's here, where are the matching
> > > > dev_puts()?
> > > > 
> > I'm not sure I'd call 2 alot, but sure, there is a new dev_hold in the
> > pvrdma_pci_probe routine, to hold a reference to the netdev that is looked up
> > there.  It is balanced by the NETDEV_UNREGISTER case in
> > pvrdma_netdevice_event_handle.  The UNREGISTER clause is also balancing the
> > NETDEV_REGISTER case of the hanlder that looks up the matching netdev should a
> > new device be registered.  Note that we will only hold a single device at a
> > time, because a given pvrdma device only recongnizes a single vmxnet3 device
> > (the one on function 0 of its own bus/device tuple).
> > 
> > I don't see how the dev_hold in pvrdma_pci_probe is undone during
> > error unwind (eg goto err_free_cq_ring)
> > 
> > And I don't see how it is put when pvrdma_pci_remove() is called.
> 
> That's right. These seem missing as well. 
> 
yup

