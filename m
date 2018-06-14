Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id F0F82C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD1B6208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:58:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD1B6208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755381AbeFNO6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:58:50 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:42916 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1755305AbeFNO6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:58:49 -0400
Received: (qmail 2501 invoked by uid 2102); 14 Jun 2018 10:58:48 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 14 Jun 2018 10:58:48 -0400
Date:   Thu, 14 Jun 2018 10:58:48 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Zhouyang Jia <jiazhouyang09@gmail.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>,
        <usb-storage@lists.one-eyed-alien.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] usb: storage: add error handling for kcalloc
In-Reply-To: <1528982951-52753-1-git-send-email-jiazhouyang09@gmail.com>
Message-ID: <Pine.LNX.4.44L0.1806141057560.1303-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jun 2018, Zhouyang Jia wrote:

> When kcalloc fails, the lack of error-handling code may
> cause unexpected results.
> 
> This patch adds error-handling code after calling kcalloc.
> 
> Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
> ---
> v1->v2:
> - Remove pr_warn statement.
> ---
>  drivers/usb/storage/alauda.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/storage/alauda.c b/drivers/usb/storage/alauda.c
> index 900591d..4e17609 100644
> --- a/drivers/usb/storage/alauda.c
> +++ b/drivers/usb/storage/alauda.c
> @@ -437,6 +437,9 @@ static int alauda_init_media(struct us_data *us)
>  		+ MEDIA_INFO(us).blockshift + MEDIA_INFO(us).pageshift);
>  	MEDIA_INFO(us).pba_to_lba = kcalloc(num_zones, sizeof(u16*), GFP_NOIO);
>  	MEDIA_INFO(us).lba_to_pba = kcalloc(num_zones, sizeof(u16*), GFP_NOIO);
> +	if ((MEDIA_INFO(us).pba_to_lba == NULL)
> +		|| (MEDIA_INFO(us).lba_to_pba == NULL))
> +		return USB_STOR_TRANSPORT_ERROR;
>  
>  	if (alauda_reset_media(us) != USB_STOR_XFER_GOOD)
>  		return USB_STOR_TRANSPORT_ERROR;
> 

Acked-by: Alan Stern <stern@rowland.harvard.edu>

