Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751722AbeEVAsv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 20:48:51 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:36991 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751148AbeEVAsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 20:48:50 -0400
X-Google-Smtp-Source: AB8JxZqAaXnNqKjf4HlWcPalCaPID0xiG7yzGwXWDzDN5+EkXg0rtNIGUuSldonERYls1YFOKBcoWA==
Date: Mon, 21 May 2018 20:48:47 -0400
From: Jon Mason <jdmason@kudzu.us>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: dave.jiang@intel.com, allenbh@gmail.com, linux-kernel@vger.kernel.org,
        linux-ntb@googlegroups.com
Subject: Re: [PATCH] ntb_transport: use put_device() instead of kfree()
Message-ID: <20180522004846.GC3255@kudzu.us>
References: <6717325ea580df9a0294db6f83fd72a5db3daad9.1520591515.git.arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6717325ea580df9a0294db6f83fd72a5db3daad9.1520591515.git.arvind.yadav.cs@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 09, 2018 at 04:03:24PM +0530, Arvind Yadav wrote:
> Never directly free @dev after calling device_register(), even
> if it returned an error! Always use put_device() to give up the
> reference initialized.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/ntb/ntb_transport.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 9878c48..8182a3a 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -393,7 +393,7 @@ int ntb_transport_register_client_dev(char *device_name)
>  
>  		rc = device_register(dev);
>  		if (rc) {
> -			kfree(client_dev);
> +			put_device(dev);

Now we are leaking client_dev, which is bigger than just dev.  I think
we are going to need both now.

Thanks,
Jon

>  			goto err;
>  		}
>  
> -- 
> 1.9.1
> 
