Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B831C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2D2A25C9E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:22:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2D2A25C9E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934918AbeFYPWi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:22:38 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:37136 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S934743AbeFYPWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:22:35 -0400
Received: (qmail 3270 invoked by uid 2102); 25 Jun 2018 11:22:34 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Jun 2018 11:22:34 -0400
Date:   Mon, 25 Jun 2018 11:22:34 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <usb-storage@lists.one-eyed-alien.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] usb: storage: add error handling for kcalloc
In-Reply-To: <20180625123326.GA14987@kroah.com>
Message-ID: <Pine.LNX.4.44L0.1806251118110.1779-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jun 2018, Greg Kroah-Hartman wrote:

> On Thu, Jun 14, 2018 at 09:29:11PM +0800, Zhouyang Jia wrote:
> > When kcalloc fails, the lack of error-handling code may
> > cause unexpected results.
> > 
> > This patch adds error-handling code after calling kcalloc.
> > 
> > Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
> > Acked-by: Alan Stern <stern@rowland.harvard.edu>
> > ---
> > v1->v2:
> > - Remove pr_warn statement.
> > ---
> >  drivers/usb/storage/alauda.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/usb/storage/alauda.c b/drivers/usb/storage/alauda.c
> > index 900591d..4e17609 100644
> > --- a/drivers/usb/storage/alauda.c
> > +++ b/drivers/usb/storage/alauda.c
> > @@ -437,6 +437,9 @@ static int alauda_init_media(struct us_data *us)
> >  		+ MEDIA_INFO(us).blockshift + MEDIA_INFO(us).pageshift);
> >  	MEDIA_INFO(us).pba_to_lba = kcalloc(num_zones, sizeof(u16*), GFP_NOIO);
> >  	MEDIA_INFO(us).lba_to_pba = kcalloc(num_zones, sizeof(u16*), GFP_NOIO);
> > +	if ((MEDIA_INFO(us).pba_to_lba == NULL)
> > +		|| (MEDIA_INFO(us).lba_to_pba == NULL))
> > +		return USB_STOR_TRANSPORT_ERROR;
> 
> You just leaked memory if only one of these succeeded :(

That's not really true.  The memory gets deallocated later on in any 
case, when alauda_info_destructor() calls alauda_free_maps() if not 
before.

More troubling is the fact that this routine (i.e, alauda_init_media)  
gets called from only one place, in alauda_check_media, and the caller
completely ignores the return value!  Furthermore, the caller always
returns USB_STOR_TRANSPORT_FAILED.

So on the whole, I don't think this patch is going to make any 
difference to the driver's operation.

Alan Stern

