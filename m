Return-Path: <stern+5aab093e@rowland.harvard.edu>
X-Google-Smtp-Source: AG47ELvJiMlFkm3Xl5XFKWiY7ug1wslmGG+9/SZpxC5yhpsh7lkGvMPgv3Pa0lf7ZsfgYfp1I8ro
ARC-Seal: i=1; a=rsa-sha256; t=1522088851; cv=none;
        d=google.com; s=arc-20160816;
        b=hFn2oWPJOOSkvdiyHU95/TjFx9kayGcOtihQnH6XnNxngiOKUfC35W1h8tPOILkUtO
         PCM5FkfdlXeK0F1QJKRVaQdH2JpbR29xa6D1LfDq/bWxSdRxE72OV6rbwAG1iUq+9rBb
         xVRkdOSIzb6+2HtBsuPV9qzy3qttn3G5fEjf8VeTkSihxwnC36IoGzf8YhQf02wA90p8
         wMBVDfHKOv1qcqZDL5JKaoGP8GQmOA0sHBQeCvje26zOvzN3JNFFpxTuXTdAAif55ZLz
         BfLCwkB9lBlHjKHG9kN6umF75oEF1gjSjjHER1xBraxdu6pJgCS8Y1snUmL8ynz0ku6h
         WVTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:in-reply-to:subject:cc:to:from:date
         :arc-authentication-results;
        bh=V44INgrAgUEmZ7kg9mdX3IL0Er73W27HpPsKgA7PLm4=;
        b=CU9g5xipLtfCK6fQO+yErM4oVwraYheLtLu4DGy8d+uClmI5msl+5htGZJkUZxQkSx
         j3cDes10oKmvhU5ne88owKEMwv8ARnuFgh14aBPBfnIIZY/zO+cO+e5JCIviJczYrzAX
         ROy+lZzSdhquXup+na4P/jDmztM6FVEy93Y3QCcMp7d2DJBNiUiRmbr3UEyOcx3Y4eRK
         +1V4gsdz2Jtz+RlAChiq5MPAN8SjTBstp/8tcQrB/Ns4ZgFnGpY/h+P74Tr7CyEwXTGw
         EPfpA7w7H1fgiJVRpGQWzFIJ31C4Vjfrnx1IEeLGMr1DptGBJWjZcv5Bb1jUBHOFKHaa
         HF6Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 192.131.102.54 is neither permitted nor denied by best guess record for domain of stern+5aab093e@rowland.harvard.edu) smtp.mailfrom=stern+5aab093e@rowland.harvard.edu
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 192.131.102.54 is neither permitted nor denied by best guess record for domain of stern+5aab093e@rowland.harvard.edu) smtp.mailfrom=stern+5aab093e@rowland.harvard.edu
Date: Mon, 26 Mar 2018 14:27:30 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Benson Leung <bleung@chromium.org>
cc: gregkh@linuxfoundation.org,  <linux-usb@vger.kernel.org>,
     <linux-kernel@vger.kernel.org>,  <achant@google.com>,
     <bleung@google.com>
Subject: Re: [PATCH v3] USB: announce bcdDevice as well as idVendor, idProduct.
In-Reply-To: <20180324174027.12522-1-bleung@chromium.org>
Message-ID: <Pine.LNX.4.44L0.1803261427200.1382-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595777100282268882?=
X-GMAIL-MSGID: =?utf-8?q?1596025840033153640?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, 24 Mar 2018, Benson Leung wrote:

> Print bcdDevice which is used by vendors to identify different versions
> of the same product (or different versions of firmware).
> 
> Adding this to the logs will be useful for support purposes.
> 
> Match the %2x.%02x formatting that's used by lsusb -v for this same value.
> 
> Signed-off-by: Benson Leung <bleung@chromium.org>
> ---
> 
> v3: Remove unnecessary whitespace changes.
> v2: Format for decimal output.
> 
>  drivers/usb/core/hub.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index aaeef03c0d83..779725836cf5 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -2192,9 +2192,13 @@ static void show_string(struct usb_device *udev, char *id, char *string)
>  
>  static void announce_device(struct usb_device *udev)
>  {
> -	dev_info(&udev->dev, "New USB device found, idVendor=%04x, idProduct=%04x\n",
> +	u16 bcdDevice = le16_to_cpu(udev->descriptor.bcdDevice);
> +
> +	dev_info(&udev->dev,
> +		"New USB device found, idVendor=%04x, idProduct=%04x, bcdDevice=%2x.%02x\n",
>  		le16_to_cpu(udev->descriptor.idVendor),
> -		le16_to_cpu(udev->descriptor.idProduct));
> +		le16_to_cpu(udev->descriptor.idProduct),
> +		bcdDevice >> 8, bcdDevice & 0xff);
>  	dev_info(&udev->dev,
>  		"New USB device strings: Mfr=%d, Product=%d, SerialNumber=%d\n",
>  		udev->descriptor.iManufacturer,

Acked-by: Alan Stern <stern@rowland.harvard.edu>
