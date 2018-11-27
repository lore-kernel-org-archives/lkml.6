Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB74C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 20:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B03552133F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 20:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQpvp1Cu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B03552133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbeK1HgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 02:36:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:34464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbeK1HgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 02:36:14 -0500
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB03A208E4;
        Tue, 27 Nov 2018 20:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543351028;
        bh=94tOdGSBsyehMaE+4coOrF+VVT+AjR1ahkqLitXkU/M=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=nQpvp1Cumjm7MhgLtA9iyOytXowFm4hR4BnRYPCQLhGKoLWA/lFLqZzgsbnqfMECF
         mN6VCwiHG7pe48YN2ALzLWpnrqklej9RPYzD/d+b6h9gkdAvn4rTLCmzm+sg0f+N7Z
         4ufGOMcoakwEsB4CSzXZrDiVJgMHZiO4W19+WeHA=
Date:   Tue, 27 Nov 2018 12:37:05 -0800 (PST)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-X260
To:     PanBian <bianpan2016@163.com>
cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: Re: [Xen-devel] [PATCH] pvcalls-front: fixes incorrect error
 handling
In-Reply-To: <20181127005823.GB125510@bp>
Message-ID: <alpine.DEB.2.10.1811271233550.4577@sstabellini-ThinkPad-X260>
References: <1542852432-30019-1-git-send-email-bianpan2016@163.com> <1f765e81-ed89-d110-74b1-cc8029a4555f@oracle.com> <20181127005823.GB125510@bp>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Nov 2018, PanBian wrote:
> On Mon, Nov 26, 2018 at 03:31:39PM -0500, Boris Ostrovsky wrote:
> > On 11/21/18 9:07 PM, Pan Bian wrote:
> > > kfree() is incorrectly used to release the pages allocated by
> > > __get_free_page() and __get_free_pages(). Use the matching deallocators
> > > i.e., free_page() and free_pages(), respectively.
> > >
> > > Signed-off-by: Pan Bian <bianpan2016@163.com>
> > > ---
> > >  drivers/xen/pvcalls-front.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/xen/pvcalls-front.c b/drivers/xen/pvcalls-front.c
> > > index 2f11ca7..77224d8 100644
> > > --- a/drivers/xen/pvcalls-front.c
> > > +++ b/drivers/xen/pvcalls-front.c
> > > @@ -385,8 +385,8 @@ static int create_active(struct sock_mapping *map, int *evtchn)
> > >  out_error:
> > >  	if (*evtchn >= 0)
> > >  		xenbus_free_evtchn(pvcalls_front_dev, *evtchn);
> > > -	kfree(map->active.data.in);
> > > -	kfree(map->active.ring);
> > > +	free_pages((unsigned long)map->active.data.in, PVCALLS_RING_ORDER);
> > 
> > Is map->active.data.in guaranteed to be NULL when entering this routine?
> 
> I am not sure yet. Sorry for that. I observed the mismatches between
> __get_free_page and kfree, and submitted the patch.
> 
> But I think your consideration is reasonable. A better solution is to
> directly free bytes, a local variable that holds __get_free_pages return
> value. If you agree, I will rewrite the patch.

Like Boris said, map->active.ring and map->active.data.in are not
guaranteed to be NULL or != NULL here. For instance,map->active.ring can
be != NULL and map->active.data.in can be NULL. However, free_pages and
free_page should be able to cope with it, the same way that kfree is
able to cope with it?


> > -boris
> > 
> > > +	free_page((unsigned long)map->active.ring);
> > >  	return ret;
> > >  }
> > >  
> > 
> 
