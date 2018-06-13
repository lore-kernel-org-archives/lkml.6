Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8497AC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 00:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 353B5208B1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 00:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V7Kx3cf0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 353B5208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934992AbeFMAHq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 20:07:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59744 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932596AbeFMAHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 20:07:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HX1gyr2WL2UZn+VqBNuK3kMGZItAcSEIDiLIXGQMu98=; b=V7Kx3cf0g2GUPwT9arLOTwaJm
        +vAsg3S6xOSy5M2CbJnvjQcEhoSKvoMH7+5Q+aR5xAdinbDtgczmVmX+6ReInuz1uL9PC+F4ZyYmh
        J1MlVZvo+BCE8O3l0BerwhxPukcjuNKFirKsVtrtUuhjjNCW1KNgIp3f+mRPDnDzxpO4hnMcsJL1F
        D+X0eW6clQxOBPZhZQPBZNiuNT2YzH4qbn5ycXn3niIxixCfzJLdhRqBVI0SCHCPRdWc7lb8pboHz
        h/KHKTxjMy8Mho3dgCo9DRmZS9iyFqmelm/bWpn2Ql/2SNxAIuS/RAzJinaHsOax7td4ycgVvVh3D
        vJPbvciKQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fStK8-0005fC-5O; Wed, 13 Jun 2018 00:07:40 +0000
Date:   Tue, 12 Jun 2018 17:07:39 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     hans.westgaard.ry@oracle.com, Doug Ledford <dledford@redhat.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        linux-rdma@vger.kernel.org,
        =?iso-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>,
        Parav Pandit <parav@mellanox.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Pravin Shedge <pravin.shedge4linux@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] IB/mad: Use IDR for agent IDs
Message-ID: <20180613000739.GA32191@bombadil.infradead.org>
References: <20180608174218.32455-1-willy@infradead.org>
 <20180608174218.32455-3-willy@infradead.org>
 <20180612203322.GG6314@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612203322.GG6314@ziepe.ca>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 02:33:22PM -0600, Jason Gunthorpe wrote:
> > @@ -377,13 +378,24 @@ struct ib_mad_agent *ib_register_mad_agent(struct ib_device *device,
> >  		goto error4;
> >  	}
> >  
> > -	spin_lock_irq(&port_priv->reg_lock);
> > -	mad_agent_priv->agent.hi_tid = atomic_inc_return(&ib_mad_client_id);
> > +	idr_preload(GFP_KERNEL);
> > +	idr_lock(&ib_mad_clients);
> > +	ret2 = idr_alloc_cyclic(&ib_mad_clients, mad_agent_priv, 0,
> > +			(1 << 24), GFP_ATOMIC);
> 
> I like this series, my only concern is this magic number here, at the
> very least it deserves a big comment explaining why it
> exists..

Yes, you're right.  Maybe something like this ...

/*
 * The mlx4 driver uses the top byte to distinguish which virtual function
 * generated the MAD, so we must avoid using it.
 */
#define AGENT_ID_LIMIT		(1 << 24)

...

	ret2 = idr_alloc_cyclic(&ib_mad_clients, mad_agent_priv, 0,
			AGENT_ID_LIMIT, GFP_ATOMIC);

> Let me see if I can get someone to give it some test time, I assume
> you haven't been able to test it it?

I don't have any IB hardware.  Frankly I'm scared of Infiniband ;-)

> > +#define idr_lock(idr)		xa_lock(&(idr)->idr_rt)
> > +#define idr_unlock(idr)		xa_unlock(&(idr)->idr_rt)
> > +#define idr_lock_irq(idr)	xa_lock_irq(&(idr)->idr_rt)
> > +#define idr_unlock_irq(idr)	xa_unlock_irq(&(idr)->idr_rt)
> > +#define idr_lock_irqsave(idr, flags) \
> > +				xa_lock_irqsave(&(idr)->idr_rt, flags)
> > +#define idr_unlock_irqrestore(idr, flags) \
> > +				xa_unlock_irqrestore(&(idr)->idr_rt, flags)
> > +
> 
> And you are Ok to take these through the rdma tree?

Yes, that's fine with me; I'm not planning on merging any IDR patches
this cycle.  Thanks!
