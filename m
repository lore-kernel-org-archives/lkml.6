Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3BDC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0A8E20867
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1UXdihqh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0A8E20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbeLAKBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 05:01:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:60688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726474AbeLAKBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 05:01:55 -0500
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB33C2082F;
        Fri, 30 Nov 2018 22:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543618263;
        bh=d/wwN8QyojM8TZ60cr9NqkDeCyYeIxy46fwdS1usIqE=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=1UXdihqhSSK3ld4zuanFaipdLELEBxjcR5kVIMcsOaNyL1iXpQmaKOxIo0FwAUnNH
         c+OtlZ0jKgWH26uD/TbYToZ7PiRrzEp3/jEWBmqFsQ1wxl2Hztg3Swmo3/4ocOgkkC
         ZaaBSJ36t3ygMTCdrSD2u2Vwn8x9UAMVSYi1uRLk=
Date:   Fri, 30 Nov 2018 14:51:01 -0800 (PST)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-X260
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
cc:     Wen Yang <wen.yang99@zte.com.cn>, jgross@suse.com,
        sstabellini@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn,
        Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH v3] pvcalls-front: Avoid __get_free_pages(GFP_KERNEL)
 under spinlock
In-Reply-To: <810c02f4-4436-79fb-5da1-0cf80f8486d1@oracle.com>
Message-ID: <alpine.DEB.2.10.1811301449570.16463@sstabellini-ThinkPad-X260>
References: <20181130110107.31468-1-wen.yang99@zte.com.cn> <810c02f4-4436-79fb-5da1-0cf80f8486d1@oracle.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2018, Boris Ostrovsky wrote:
> On 11/30/18 6:01 AM, Wen Yang wrote:
> > The problem is that we call this with a spin lock held.
> > The call tree is:
> > pvcalls_front_accept() holds bedata->socket_lock.
> >     -> create_active()
> >         -> __get_free_pages() uses GFP_KERNEL
> >
> > The create_active() function is only called from pvcalls_front_accept()
> > with a spin_lock held, The allocation is not allowed to sleep and
> > GFP_KERNEL is not sufficient.
> >
> > This issue was detected by using the Coccinelle software.
> >
> > v2: Add a function doing the allocations which is called
> >     outside the lock and passing the allocated data to
> >     create_active().
> > v3: Use the matching deallocators i.e., free_page()
> >     and free_pages(), respectively.
> >
> > Suggested-by: Juergen Gross <jgross@suse.com>
> > Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> > CC: Julia Lawall <julia.lawall@lip6.fr>
> > CC: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> > CC: Juergen Gross <jgross@suse.com>
> > CC: Stefano Stabellini <sstabellini@kernel.org>
> > CC: xen-devel@lists.xenproject.org
> > CC: linux-kernel@vger.kernel.org
> > ---
> >  drivers/xen/pvcalls-front.c | 71 ++++++++++++++++++++++++++++++-------
> >  1 file changed, 59 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/xen/pvcalls-front.c b/drivers/xen/pvcalls-front.c
> > index 2f11ca72a281..a26f416daf46 100644
> > --- a/drivers/xen/pvcalls-front.c
> > +++ b/drivers/xen/pvcalls-front.c
> > @@ -335,7 +335,43 @@ int pvcalls_front_socket(struct socket *sock)
> >  	return ret;
> >  }
> >  
> > -static int create_active(struct sock_mapping *map, int *evtchn)
> > +struct sock_mapping_active_ring {
> > +	struct pvcalls_data_intf *ring;
> > +	RING_IDX ring_order;
> > +	void *bytes;
> > +};
> > +
> > +static int alloc_active_ring(struct sock_mapping_active_ring *active_ring)
> > +{
> > +	active_ring->ring = NULL;
> 
> This is not necessary.
> 
> > +	active_ring->bytes = NULL;
> > +
> > +	active_ring->ring = (struct pvcalls_data_intf *)
> > +		__get_free_page(GFP_KERNEL | __GFP_ZERO);
> > +	if (active_ring->ring == NULL)
> > +		goto out_error;
> > +	active_ring->ring_order = PVCALLS_RING_ORDER;
> > +	active_ring->bytes = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
> > +			PVCALLS_RING_ORDER);
> > +	if (active_ring->bytes == NULL)
> > +		goto out_error;
> > +
> > +	return 0;
> > +
> > +out_error:
> > +	free_pages((unsigned long)active_ring->bytes, active_ring->ring_order);
> > +	free_page((unsigned long)active_ring->ring);
> > +	return -ENOMEM;
> > +}
> > +
> 
> 
> 
> > @@ -397,6 +427,7 @@ int pvcalls_front_connect(struct socket *sock, struct sockaddr *addr,
> >  	struct sock_mapping *map = NULL;
> >  	struct xen_pvcalls_request *req;
> >  	int notify, req_id, ret, evtchn;
> > +	struct sock_mapping_active_ring active_ring;
> >  
> >  	if (addr->sa_family != AF_INET || sock->type != SOCK_STREAM)
> >  		return -EOPNOTSUPP;
> > @@ -406,15 +437,21 @@ int pvcalls_front_connect(struct socket *sock, struct sockaddr *addr,
> >  		return PTR_ERR(map);
> >  
> >  	bedata = dev_get_drvdata(&pvcalls_front_dev->dev);
> > +	ret = alloc_active_ring(&active_ring);
> 
> Why not just alloc_active_ring(map)?

Yes, I think it would be better to pre-populate map (struct
sock_mapping), rather than introducing one more new struct (struct
sock_mapping_active_ring).
