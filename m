Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404E0C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 116A920827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbfAHRgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 12:36:42 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:53928 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727484AbfAHRgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 12:36:41 -0500
Received: (qmail 3960 invoked by uid 2102); 8 Jan 2019 12:36:40 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 Jan 2019 12:36:40 -0500
Date:   Tue, 8 Jan 2019 12:36:40 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] USB: core: urb: Use struct_size() in kmalloc()
In-Reply-To: <20190108152225.GA5721@embeddedor>
Message-ID: <Pine.LNX.4.44L0.1901081234260.1355-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jan 2019, Gustavo A. R. Silva wrote:

> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
> 
> struct foo {
>     int stuff;
>     void *entry[];
> };
> 
> instance = kmalloc(sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);
> 
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
> 
> instance = kmalloc(struct_size(instance, entry, count), GFP_KERNEL);
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/usb/core/urb.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/core/urb.c b/drivers/usb/core/urb.c
> index f51750bcd152..0eab79f82ce4 100644
> --- a/drivers/usb/core/urb.c
> +++ b/drivers/usb/core/urb.c
> @@ -70,9 +70,8 @@ struct urb *usb_alloc_urb(int iso_packets, gfp_t mem_flags)
>  {
>  	struct urb *urb;
>  
> -	urb = kmalloc(sizeof(struct urb) +
> -		iso_packets * sizeof(struct usb_iso_packet_descriptor),
> -		mem_flags);
> +	urb = kmalloc(struct_size(urb, iso_frame_desc, iso_packets),
> +		      mem_flags);
>  	if (!urb)
>  		return NULL;
>  	usb_init_urb(urb);

Acked-by: Alan Stern <stern@rowland.harvard.edu>

