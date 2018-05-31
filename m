Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755850AbeEaQzS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 12:55:18 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:42653 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755829AbeEaQzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 12:55:13 -0400
X-Google-Smtp-Source: ADUXVKKBFfN96EClLwNKiSTdY9pPFrcVB8oXsHk1RQc6kxEx0j4B/zqIkU/aNzDxyCuXuO/JLhNs/w==
Subject: Re: [PATCH v2 01/21] usb: phy: use match_string() helper
To: Yisheng Xie <xieyisheng1@huawei.com>, linux-kernel@vger.kernel.org
Cc: andy.shevchenko@gmail.com, linux-usb@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com>
 <1527765086-19873-2-git-send-email-xieyisheng1@huawei.com>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <af7838f0-9cae-d526-b52f-15996cd8031c@cogentembedded.com>
Date: Thu, 31 May 2018 19:55:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1527765086-19873-2-git-send-email-xieyisheng1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 05/31/2018 02:11 PM, Yisheng Xie wrote:

> match_string() returns the index of an array for a matching string,
> which can be used instead of open coded variant.
> 
> Cc: linux-usb@vger.kernel.org
> Cc: Felipe Balbi <balbi@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> ---
> v2:
>  - donot rename err to ret  - per Andy

   Hm...

> 
>  drivers/usb/phy/of.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/phy/of.c b/drivers/usb/phy/of.c
> index 1ab134f..9d74081 100644
> --- a/drivers/usb/phy/of.c
> +++ b/drivers/usb/phy/of.c
> @@ -28,16 +28,16 @@
>  enum usb_phy_interface of_usb_get_phy_mode(struct device_node *np)
>  {
>  	const char *phy_type;
> -	int err, i;
> +	int err;
>  
>  	err = of_property_read_string(np, "phy_type", &phy_type);
>  	if (err < 0)
>  		return USBPHY_INTERFACE_MODE_UNKNOWN;
>  
> -	for (i = 0; i < ARRAY_SIZE(usbphy_modes); i++)
> -		if (!strcmp(phy_type, usbphy_modes[i]))
> -			return i;
> +	err = match_string(usbphy_modes, ARRAY_SIZE(usbphy_modes), phy_type);
> +	if (err < 0)

   This is one of the few cases when 'err' is not the best name for such a
variable. I'd prefer to see something like 'match' or even 'rc' or 'ret'... :-)

> +		return USBPHY_INTERFACE_MODE_UNKNOWN;
>  
> -	return USBPHY_INTERFACE_MODE_UNKNOWN;
> +	return err;
>  }
>  EXPORT_SYMBOL_GPL(of_usb_get_phy_mode);
> 

MBR, Sergei
