Return-Path: <sergei.shtylyov@cogentembedded.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521538591; cv=none;
        d=google.com; s=arc-20160816;
        b=lVQWj5s6P6S+cRkrlIgeS+BJmlhG5FvfdsWFsJWZ5Fficq71EBAINseSrawcrbRXHe
         pHmN+1kElRtN/oJF8VTWEe+7UsvwgH0E4wcs11stpR5WrRMIKo8/4LUXtRP3fdbJN8nO
         v9NJSSNoxbaEtqGm4hQGYGniqMxi0WVTjj7hXJum1zwJ9Spjj6HOPLgVYIKSe5Ci5ifJ
         iCD4iGOk9oQYvz1WLf6uHb6cS76zbk9Emq6X+yoHAF4fNzz0bPvkpdDGsoX4q68WBaNr
         Jl4Of0Bhx0YJpKNxwStbtZ4ZxTOnLzc/tl8mnrXXUsRoDPwJ0eOpRQ55QjPoyT20rz2b
         ZT6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=O9u2IZ6Ste0TYONcBvCvmJEB/0Vij1p1mXs5Yxikdas=;
        b=k96yM6thPYzYFVTu4NjhO5ePPq1Yzh/FXjbk9KJIl1aqy7D1fGIOCHXr2/zu8krT6Q
         KN+dY3DHfxks6BvW6LP8OudRMhwbBEeSEVpp1O0HFKz51DDIkfs5xqyCe78qC2+agDe6
         dZHou5pgkHG9ixy5PVMioZHWa/vVDJ2y7qJYWtLn3u92ff4pub2EKTU3uTrhj92f2hxj
         1cIPUzp11UFL5ixpFYZa1dcNWcuuf4RY4W7Xal2htNF6GsNSolARMZsve5AKwyLMrOXy
         OcYL8RpSodnqooPiXMmY85rMOrFpYIo5V6z36pGnBFqkoZBdfpjl9fS15D8uQz1G7olH
         1jPA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@cogentembedded-com.20150623.gappssmtp.com header.s=20150623 header.b=s0UfBmQ8;
       spf=pass (google.com: domain of sergei.shtylyov@cogentembedded.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sergei.shtylyov@cogentembedded.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@cogentembedded-com.20150623.gappssmtp.com header.s=20150623 header.b=s0UfBmQ8;
       spf=pass (google.com: domain of sergei.shtylyov@cogentembedded.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sergei.shtylyov@cogentembedded.com
X-Google-Smtp-Source: AG47ELsMetEWjv2K+YwiQ6FQ/CFU+c6tSeu89yrMcJ93o8C+uC3r5eZdl10MLQBlpbgZwvwU5WyXiw==
Subject: Re: [PATCH v2 1/1] usb: musb: gadget: misplaced out of bounds check
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Liu <b-liu@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180320022735.4548-1-xypron.glpk@gmx.de>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <51c311a2-45d9-03d5-a294-dd77c80c0fb0@cogentembedded.com>
Date: Tue, 20 Mar 2018 12:36:30 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180320022735.4548-1-xypron.glpk@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595421870996907648?=
X-GMAIL-MSGID: =?utf-8?q?1595448849665852689?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello!

On 3/20/2018 5:27 AM, Heinrich Schuchardt wrote:

> musb->endpoints[] has array size MUSB_C_NUM_EPS.
> We must check array bounds before accessing the array and not afterwards.
> 
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
> v2
> 	Only the 4 low bits of epnum are relevant for indexing.	
> ---
>   drivers/usb/musb/musb_gadget_ep0.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/musb/musb_gadget_ep0.c b/drivers/usb/musb/musb_gadget_ep0.c
> index 18da4873e52e..96b0fa12f729 100644
> --- a/drivers/usb/musb/musb_gadget_ep0.c
> +++ b/drivers/usb/musb/musb_gadget_ep0.c
> @@ -89,15 +89,20 @@ static int service_tx_status_request(
>   		}
>   
>   		is_in = epnum & USB_DIR_IN;
> +		epnum &= 0x0f;
> +		if (epnum >= MUSB_C_NUM_EPS) {
> +			handled = -EINVAL;
> +			break;
> +		}
> +
>   		if (is_in) {
> -			epnum &= 0x0f;
>   			ep = &musb->endpoints[epnum].ep_in;
>   		} else {
>   			ep = &musb->endpoints[epnum].ep_out;
>   		}

    Please remove the braces, they're not needed anymore.

[...]

MBR, Sergei
