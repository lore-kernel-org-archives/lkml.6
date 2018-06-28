Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929A8C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 11:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5551123D15
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 11:01:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5551123D15
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965419AbeF1LBW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 07:01:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54480 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934000AbeF1LBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 07:01:21 -0400
Received: from localhost (unknown [104.153.224.166])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 94F4686A;
        Thu, 28 Jun 2018 11:01:17 +0000 (UTC)
Date:   Thu, 28 Jun 2018 19:52:41 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: storage: add error handling for kcalloc
Message-ID: <20180628105241.GC5191@kroah.com>
References: <20180625123326.GA14987@kroah.com>
 <Pine.LNX.4.44L0.1806251118110.1779-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1806251118110.1779-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 11:22:34AM -0400, Alan Stern wrote:
> On Mon, 25 Jun 2018, Greg Kroah-Hartman wrote:
> 
> > On Thu, Jun 14, 2018 at 09:29:11PM +0800, Zhouyang Jia wrote:
> > > When kcalloc fails, the lack of error-handling code may
> > > cause unexpected results.
> > > 
> > > This patch adds error-handling code after calling kcalloc.
> > > 
> > > Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
> > > Acked-by: Alan Stern <stern@rowland.harvard.edu>
> > > ---
> > > v1->v2:
> > > - Remove pr_warn statement.
> > > ---
> > >  drivers/usb/storage/alauda.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/drivers/usb/storage/alauda.c b/drivers/usb/storage/alauda.c
> > > index 900591d..4e17609 100644
> > > --- a/drivers/usb/storage/alauda.c
> > > +++ b/drivers/usb/storage/alauda.c
> > > @@ -437,6 +437,9 @@ static int alauda_init_media(struct us_data *us)
> > >  		+ MEDIA_INFO(us).blockshift + MEDIA_INFO(us).pageshift);
> > >  	MEDIA_INFO(us).pba_to_lba = kcalloc(num_zones, sizeof(u16*), GFP_NOIO);
> > >  	MEDIA_INFO(us).lba_to_pba = kcalloc(num_zones, sizeof(u16*), GFP_NOIO);
> > > +	if ((MEDIA_INFO(us).pba_to_lba == NULL)
> > > +		|| (MEDIA_INFO(us).lba_to_pba == NULL))
> > > +		return USB_STOR_TRANSPORT_ERROR;
> > 
> > You just leaked memory if only one of these succeeded :(
> 
> That's not really true.  The memory gets deallocated later on in any 
> case, when alauda_info_destructor() calls alauda_free_maps() if not 
> before.
> 
> More troubling is the fact that this routine (i.e, alauda_init_media)  
> gets called from only one place, in alauda_check_media, and the caller
> completely ignores the return value!  Furthermore, the caller always
> returns USB_STOR_TRANSPORT_FAILED.
> 
> So on the whole, I don't think this patch is going to make any 
> difference to the driver's operation.

Ok, I'm just going to drop it then.

thanks,

greg k-h
