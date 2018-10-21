Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF87ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 18:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1847620838
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 18:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xp7AV3n1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1847620838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbeJVCgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 22:36:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:54416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728069AbeJVCgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 22:36:41 -0400
Received: from localhost (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9968820838;
        Sun, 21 Oct 2018 18:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540146091;
        bh=A3dDb7NU2G3EyIjT10wSiSaUc/XS8EbIWyI24+7X+hE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xp7AV3n1TDCCP8SJtfLRQ7fW8dWZtfVh69yUm9hun/7ID3+DsspQFA2vT8d0GbjtV
         ByqeKLrSlhJsk2ixfcWUtkoi5wYOlm0bvnJQBBB/+KvZfJZ2HHvzK0nuOlupN1sf/x
         x5Xytl9bDyR9QhA8+PTc1AugWmAHW1ZPyLyP472U=
Date:   Sun, 21 Oct 2018 19:21:28 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Aaron Ma <aaron.ma@canonical.com>
Cc:     mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] usb: xhci: fix timeout for transition from RExit to
 U0
Message-ID: <20181021182128.GA6485@kroah.com>
References: <1540141725-13047-1-git-send-email-aaron.ma@canonical.com>
 <1540141725-13047-2-git-send-email-aaron.ma@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540141725-13047-2-git-send-email-aaron.ma@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 01:08:45AM +0800, Aaron Ma wrote:
> This definition is used by msecs_to_jiffies in milliseconds.
> According to the comments, max rexit timeout should be 20ms.
> Align with the comments to properly calculate the delay.
> 
> Verified on Sunrise Point-LP and Cannon Lake.
> 
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> ---
>  drivers/usb/host/xhci.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
> index 6230a578324c..30225c53be1c 100644
> --- a/drivers/usb/host/xhci.h
> +++ b/drivers/usb/host/xhci.h
> @@ -1678,7 +1678,7 @@ struct xhci_bus_state {
>   * It can take up to 20 ms to transition from RExit to U0 on the
>   * Intel Lynx Point LP xHCI host.
>   */
> -#define	XHCI_MAX_REXIT_TIMEOUT	(20 * 1000)
> +#define	XHCI_MAX_REXIT_TIMEOUT	20

Can we put the units in the #define itself so that this will be more
obvious in the future?  Like XHCI_MAX_REXIT_TIMEOUT_MS?

thanks,

greg k-h
