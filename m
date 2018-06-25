Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31567C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D524221A6F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:33:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D524221A6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933772AbeFYMdg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 08:33:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46292 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932404AbeFYMde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 08:33:34 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 916B4C9E;
        Mon, 25 Jun 2018 12:33:31 +0000 (UTC)
Date:   Mon, 25 Jun 2018 20:33:26 +0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: storage: add error handling for kcalloc
Message-ID: <20180625123326.GA14987@kroah.com>
References: <1528707147-35623-1-git-send-email-jiazhouyang09@gmail.com>
 <1528982951-52753-1-git-send-email-jiazhouyang09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528982951-52753-1-git-send-email-jiazhouyang09@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 09:29:11PM +0800, Zhouyang Jia wrote:
> When kcalloc fails, the lack of error-handling code may
> cause unexpected results.
> 
> This patch adds error-handling code after calling kcalloc.
> 
> Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
> Acked-by: Alan Stern <stern@rowland.harvard.edu>
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

You just leaked memory if only one of these succeeded :(
