Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE9BC61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 08:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99E0920823
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 08:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547886104;
	bh=J+1lMmahFF+2xAU86wrLhXcyeBl2CI1DVErFUaEIX8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KD28jBKrCiY/oAMB2GYjBPc6lSeZDRtkTPMYb+2NxoQvaUZxCt0R4kCLmG+VIM0NP
	 asankYTl7K73lyHxMnsnsSLNETzbZ1luNmLufKI/4FtNfSzoWzXCtImNqs9wvbnIHN
	 uQ9Hl+Dq1aaAxp84z3CQcWeJUemJqwbsqj24WuMk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbfASIVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 03:21:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:40348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbfASIVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 03:21:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 655A220823;
        Sat, 19 Jan 2019 08:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547886102;
        bh=J+1lMmahFF+2xAU86wrLhXcyeBl2CI1DVErFUaEIX8o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dxo4P3GRQFC6DgmQA6WIFJ271Z+Bxn3NlpbuCM5a+kEt3D6QFi/6cBjlZTOuIRXsR
         M/yX1XUGp8Jf1vWG/9exkoSqhnv1a4jdz3YKXyinFeqI1hTb2yUaX720b8k8cCZUJ3
         FrQhFZHZ7C/qa4ftfN00Pw8trDoL4RkCSxb29G2M=
Date:   Sat, 19 Jan 2019 09:21:39 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     valentina.manea.m@gmail.com, shuah@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usbip: Fix vhci_urb_enqueue() URB null transfer buffer
 error path
Message-ID: <20190119082139.GB8204@kroah.com>
References: <20190118212931.18482-1-skhan@linuxfoundation.org>
 <20190118212931.18482-2-skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118212931.18482-2-skhan@linuxfoundation.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 02:29:31PM -0700, Shuah Khan wrote:
> From: Shuah Khan <shuah@kernel.org>
> 
> Fix vhci_urb_enqueue() to print error and return error instead of
> failing with WARN_ON.
> 
> Signed-off-by: Shuah Khan <shuah@kernel.org>
> ---
>  drivers/usb/usbip/vhci_hcd.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
> index 1e592ec94ba4..849ebfde87b5 100644
> --- a/drivers/usb/usbip/vhci_hcd.c
> +++ b/drivers/usb/usbip/vhci_hcd.c
> @@ -702,8 +702,10 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
>  	}
>  	vdev = &vhci_hcd->vdev[portnum-1];
>  
> -	/* patch to usb_sg_init() is in 2.5.60 */
> -	BUG_ON(!urb->transfer_buffer && urb->transfer_buffer_length);
> +	if (!urb->transfer_buffer && urb->transfer_buffer_length) {
> +		dev_err(dev, "Null URB transfer buffer\n");
> +		return -EINVAL;
> +	}

Could that BUG_ON be hit by userspace somehow?  Or is this just an
internal check for the api usage?

And sending out a 0 buffer length might be a valid thing (or at least a
crazy attempt at something), so you might want to make that dev_dbg() in
case userspace could trigger this to keep the log spam down.

thanks,

greg k-h
