Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 36225C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCB9D208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:31:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCB9D208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933477AbeFLObW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 10:31:22 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:46928 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1754290AbeFLObV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 10:31:21 -0400
Received: (qmail 3104 invoked by uid 2102); 12 Jun 2018 10:31:20 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Jun 2018 10:31:20 -0400
Date:   Tue, 12 Jun 2018 10:31:20 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Zhouyang Jia <jiazhouyang09@gmail.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>,
        <usb-storage@lists.one-eyed-alien.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: storage: add error handling for kcalloc
In-Reply-To: <1528707147-35623-1-git-send-email-jiazhouyang09@gmail.com>
Message-ID: <Pine.LNX.4.44L0.1806121028580.1582-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jun 2018, Zhouyang Jia wrote:

> When kcalloc fails, the lack of error-handling code may
> cause unexpected results.
> 
> This patch adds error-handling code after calling kcalloc.
> 
> Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
> ---
>  drivers/usb/storage/alauda.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/usb/storage/alauda.c b/drivers/usb/storage/alauda.c
> index 900591d..c56355c 100644
> --- a/drivers/usb/storage/alauda.c
> +++ b/drivers/usb/storage/alauda.c
> @@ -437,6 +437,11 @@ static int alauda_init_media(struct us_data *us)
>  		+ MEDIA_INFO(us).blockshift + MEDIA_INFO(us).pageshift);
>  	MEDIA_INFO(us).pba_to_lba = kcalloc(num_zones, sizeof(u16*), GFP_NOIO);
>  	MEDIA_INFO(us).lba_to_pba = kcalloc(num_zones, sizeof(u16*), GFP_NOIO);
> +	if ((MEDIA_INFO(us).pba_to_lba == NULL)
> +		|| (MEDIA_INFO(us).lba_to_pba == NULL)) {
> +		pr_warn("alauda_init_media: memory allocation failed\n");
> +		return USB_STOR_TRANSPORT_ERROR;
> +	}

pr_info() isn't a good routine to use here, because it doesn't print 
the device or driver name.

In any case, a log message isn't necessary.  kcalloc() will already 
put a message in the log if either of the allocations fails.

Alan Stern

>  
>  	if (alauda_reset_media(us) != USB_STOR_XFER_GOOD)
>  		return USB_STOR_TRANSPORT_ERROR;
> 

