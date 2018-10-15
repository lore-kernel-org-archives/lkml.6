Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE7EC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 771642098A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8w5vgLx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 771642098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbeJPCWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 22:22:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:38854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726594AbeJPCWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 22:22:33 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A494020881;
        Mon, 15 Oct 2018 18:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539628568;
        bh=W9jTNov0Zydk0CK4fau7/ZXACI/7cGhgJLVwaxMP97Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P8w5vgLxVv7CVJzwmQcYs1EGuO2l4DNjMJs/8EdmexFC5SG3+G5MewUhNsoUoq+75
         8MPK0SF2AeavMM9UhVXCUfDUEsDhf7KECytP9aSs1i7kS0kffazyMrSpWaoWH+AICk
         1ps2NMx9oUwwsFTWBo1L3+3IXKZC6AwXMPrw75kU=
Date:   Mon, 15 Oct 2018 20:36:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     rkir@google.com
Cc:     linux-kernel@vger.kernel.org, tkjos@google.com
Subject: Re: [PATCH v3 07/15] platform: goldfish: pipe: Return status from
 "deinit" since "remove" does not do much
Message-ID: <20181015183605.GB28454@kroah.com>
References: <20181003171720.169953-1-rkir@google.com>
 <20181003171720.169953-7-rkir@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181003171720.169953-7-rkir@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2018 at 10:17:12AM -0700, rkir@google.com wrote:
> From: Roman Kiryanov <rkir@google.com>
> 
> This way deinit will have a chance to report an error.
> 
> Signed-off-by: Roman Kiryanov <rkir@google.com>
> ---
> Changes in v3:
>  - No change.
> Changes in v2:
>  - No change.
> 
>  drivers/platform/goldfish/goldfish_pipe.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
> index 445c0c0c66c4..1822d4146778 100644
> --- a/drivers/platform/goldfish/goldfish_pipe.c
> +++ b/drivers/platform/goldfish/goldfish_pipe.c
> @@ -888,13 +888,15 @@ static int goldfish_pipe_device_init(struct platform_device *pdev,
>  	return 0;
>  }
>  
> -static void goldfish_pipe_device_deinit(struct platform_device *pdev,
> -					struct goldfish_pipe_dev *dev)
> +static int goldfish_pipe_device_deinit(struct platform_device *pdev,
> +				       struct goldfish_pipe_dev *dev)
>  {
>  	misc_deregister(&dev->miscdev);
>  	tasklet_kill(&dev->irq_tasklet);
>  	kfree(dev->pipes);
>  	free_page((unsigned long)dev->buffers);
> +
> +	return 0;
>  }

This function can not fail, why are you returning 0 always?  That
doesn't make sense.

thanks,

greg k-h
