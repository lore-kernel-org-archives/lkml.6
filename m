Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B18ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35911214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="w5ctPZcT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35911214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbeJQPk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 11:40:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:56044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbeJQPk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 11:40:58 -0400
Received: from localhost (unknown [188.88.119.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B148214C3;
        Wed, 17 Oct 2018 07:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539762393;
        bh=2vy/I7F+Z+ImscZ0yCNrK9DifRUbMuYINhlMDo5sLBM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w5ctPZcTOD/kVl+XXYpA5hIOxIFF2N1wQGQKG1AN18PXci4icCYHLO5mYdIuvepgH
         nZ1IVFIUIArp8mBJdNRc6kNn8Ah0Asce+789WppLeZWm8B8YX/Sjla4R+wjbitLWbO
         nczRNAKMWJMNhC2OJ/qxG6K0RXRdR5qKPhCWGMZk=
Date:   Wed, 17 Oct 2018 09:46:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: Re: [PATCH 4.18 101/135] hv_netvsc: pair VF based on serial number
Message-ID: <20181017074629.GD25537@kroah.com>
References: <20181016170515.447235311@linuxfoundation.org>
 <20181016170522.303317746@linuxfoundation.org>
 <DM5PR2101MB10138BCFD40D703FEE14EC35CAFE0@DM5PR2101MB1013.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR2101MB10138BCFD40D703FEE14EC35CAFE0@DM5PR2101MB1013.namprd21.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 07:13:12PM +0000, Haiyang Zhang wrote:
> 
> 
> > -----Original Message-----
> > From: linux-kernel-owner@vger.kernel.org <linux-kernel-
> > owner@vger.kernel.org> On Behalf Of Greg Kroah-Hartman
> > Sent: Tuesday, October 16, 2018 1:06 PM
> > To: linux-kernel@vger.kernel.org
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>;
> > stable@vger.kernel.org; Stephen Hemminger <sthemmin@microsoft.com>;
> > David S. Miller <davem@davemloft.net>; Sasha Levin
> > <Alexander.Levin@microsoft.com>
> > Subject: [PATCH 4.18 101/135] hv_netvsc: pair VF based on serial number
> > 
> > 4.18-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Stephen Hemminger <stephen@networkplumber.org>
> > 
> > [ Upstream commit 00d7ddba1143623b31bc2c15d18216e2da031b14 ]
> > 
> > Matching network device based on MAC address is problematic since a non VF
> > network device can be creted with a duplicate MAC address causing confusion
> > and problems.  The VMBus API does provide a serial number that is a better
> > matching method.
> > 
> > Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
> > Signed-off-by: David S. Miller <davem@davemloft.net>
> > Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/net/hyperv/netvsc.c     |    3 ++
> >  drivers/net/hyperv/netvsc_drv.c |   58 ++++++++++++++++++++++-----------------
> > -
> >  2 files changed, 36 insertions(+), 25 deletions(-)
> > 
> > --- a/drivers/net/hyperv/netvsc.c
> > +++ b/drivers/net/hyperv/netvsc.c
> > @@ -1203,6 +1203,9 @@ static void netvsc_send_vf(struct net_de
> > 
> >  	net_device_ctx->vf_alloc = nvmsg->msg.v4_msg.vf_assoc.allocated;
> >  	net_device_ctx->vf_serial = nvmsg->msg.v4_msg.vf_assoc.serial;
> > +	netdev_info(ndev, "VF slot %u %s\n",
> > +		    net_device_ctx->vf_serial,
> > +		    net_device_ctx->vf_alloc ? "added" : "removed");
> >  }
> > 
> >  static  void netvsc_receive_inband(struct net_device *ndev,
> > --- a/drivers/net/hyperv/netvsc_drv.c
> > +++ b/drivers/net/hyperv/netvsc_drv.c
> > @@ -1794,20 +1794,6 @@ out_unlock:
> >  	rtnl_unlock();
> >  }
> > 
> > -static struct net_device *get_netvsc_bymac(const u8 *mac) -{
> > -	struct net_device_context *ndev_ctx;
> > -
> > -	list_for_each_entry(ndev_ctx, &netvsc_dev_list, list) {
> > -		struct net_device *dev = hv_get_drvdata(ndev_ctx-
> > >device_ctx);
> > -
> > -		if (ether_addr_equal(mac, dev->perm_addr))
> > -			return dev;
> > -	}
> > -
> > -	return NULL;
> > -}
> > -
> >  static struct net_device *get_netvsc_byref(struct net_device *vf_netdev)  {
> >  	struct net_device_context *net_device_ctx; @@ -1936,26 +1922,48
> > @@ static void netvsc_vf_setup(struct work_
> >  	rtnl_unlock();
> >  }
> > 
> > +/* Find netvsc by VMBus serial number.
> > + * The PCI hyperv controller records the serial number as the slot.
> > + */
> > +static struct net_device *get_netvsc_byslot(const struct net_device
> > +*vf_netdev) {
> > +	struct device *parent = vf_netdev->dev.parent;
> > +	struct net_device_context *ndev_ctx;
> > +	struct pci_dev *pdev;
> > +
> > +	if (!parent || !dev_is_pci(parent))
> > +		return NULL; /* not a PCI device */
> > +
> > +	pdev = to_pci_dev(parent);
> > +	if (!pdev->slot) {
> > +		netdev_notice(vf_netdev, "no PCI slot information\n");
> > +		return NULL;
> > +	}
> > +
> > +	list_for_each_entry(ndev_ctx, &netvsc_dev_list, list) {
> > +		if (!ndev_ctx->vf_alloc)
> > +			continue;
> > +
> > +		if (ndev_ctx->vf_serial == pdev->slot->number)
> > +			return hv_get_drvdata(ndev_ctx->device_ctx);
> 
> Greg,
> 
> I had a fix to this patch. If not already, Could you include my following fix together?
> hv_netvsc: fix vf serial matching with pci slot info
> https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git/commit/?id=005479556197f80139771960dda0dfdcd2d2aad5

I can not take a patch that is not "upstream" yet, sorry.

Also, this really feels like a "new feature" to me.  Can someone explain
what bug this is fixing?

thanks,

greg k-h
