Return-Path: <stern+5aab093e@rowland.harvard.edu>
X-Google-Smtp-Source: AG47ELu1k8M0RErrRJCidwVahVkCFJUjdpSP9YKY3Yu2Ketvy02Ji7A5IMejqHwRK7sC6jgnn4Uf
ARC-Seal: i=1; a=rsa-sha256; t=1521907581; cv=none;
        d=google.com; s=arc-20160816;
        b=h06w0zC0m6l7CDBkwOcclzc7iBL34FqFao6iUV3xlt9hBMVnzeVmmKZ37D14nlgP81
         c5Ic32+fAvKp9QSZcqst4cKN/hiGnWBj6RixoUInxBI6CGrTBNJTY0NeF4+HMXm8LvBW
         IfXssd3oK3Nkcbri7DoxbBZuWZymgWbf38iSiL4hLGeu3t4LmYYxFA95PBsZuflMV8Un
         f8TX8P7dhJcbfwyEgS1HwyW33ynSSqSOOY9v9kx9zYUbNEic41gvCK1E4T04vQfX6FAe
         Cq+QVhTAwKBJ/codwcaO2ThdmwG3bXTX+T1aWD6t+7Abi7ibhWjh1p2NebzWztCOsn72
         Pnug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:in-reply-to:subject:cc:to:from:date
         :arc-authentication-results;
        bh=sD2+6jw5nDiUOo6IMgnFkgWz+TX9Dq+5AW7AdmaUzvM=;
        b=ccHfD2R+FNKI3tMEF2tHJnPlOu0Z6RVGcuryvVSL848sO0J+F15qR3SRdpg9V1A3tj
         q7Yg8rJ4OgSQqz2tqE3xLasrncTPDNj0Q8TkXXH8qEw0yQxCXwGTMsi3fTkLp/nThH+G
         wDbNFZB3JesBv+dcomW9J804hH0acmGRLZbA6SRqe/4hqFFNBC6KKEOQoqWC0ECv3b+C
         jsUDP6aGXYPnKs96IyfaLJzq8XXTNF/m98I+mk6MK6MI6TnJkPccddHhqh6bht0jmEnq
         E8ocgtDnSrn0z4vX92jVp+zC82ETkIRfxmbkMMThPa2zsy7dsuXAQ44Fe0MkALsSrFtg
         VN6g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 192.131.102.5 is neither permitted nor denied by best guess record for domain of stern+5aab093e@rowland.harvard.edu) smtp.mailfrom=stern+5aab093e@rowland.harvard.edu
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 192.131.102.5 is neither permitted nor denied by best guess record for domain of stern+5aab093e@rowland.harvard.edu) smtp.mailfrom=stern+5aab093e@rowland.harvard.edu
Date: Sat, 24 Mar 2018 12:06:20 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Benson Leung <bleung@chromium.org>
cc: gregkh@linuxfoundation.org,  <linux-usb@vger.kernel.org>,
     <linux-kernel@vger.kernel.org>,  <achant@google.com>,
     <bleung@google.com>
Subject: Re: [PATCH v2] USB: announce bcdDevice as well as idVendor, idProduct.
In-Reply-To: <20180324013154.230119-1-bleung@chromium.org>
Message-ID: <Pine.LNX.4.44L0.1803241155560.30456-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595777100282268882?=
X-GMAIL-MSGID: =?utf-8?q?1595835763675371346?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 23 Mar 2018, Benson Leung wrote:

> Print bcdDevice which is used by vendors to identify different versions
> of the same product (or different versions of firmware).
> 
> Adding this to the logs will be useful for support purposes.
> 
> Match the %2x.%02x formatting that's used by lsusb -v for this same value.
> 
> Signed-off-by: Benson Leung <bleung@chromium.org>
> --
> v2: Format for decimal output.
> ---
>  drivers/usb/core/hub.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index aaeef03c0d83..624cde7ffcea 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -2192,14 +2192,19 @@ static void show_string(struct usb_device *udev, char *id, char *string)
>  
>  static void announce_device(struct usb_device *udev)
>  {
> -	dev_info(&udev->dev, "New USB device found, idVendor=%04x, idProduct=%04x\n",
> -		le16_to_cpu(udev->descriptor.idVendor),
> -		le16_to_cpu(udev->descriptor.idProduct));
> +	u16 bcdDevice;
> +
> +	bcdDevice = le16_to_cpu(udev->descriptor.bcdDevice);
> +	dev_info(&udev->dev,
> +		 "New USB device found, idVendor=%04x, idProduct=%04x, bcdDevice=%2x.%02x\n",
> +		 le16_to_cpu(udev->descriptor.idVendor),

Unnecessary and incorrect whitespace changes.

> +		 le16_to_cpu(udev->descriptor.idProduct),
> +		 bcdDevice >> 8, bcdDevice & 0xff);
>  	dev_info(&udev->dev,
> -		"New USB device strings: Mfr=%d, Product=%d, SerialNumber=%d\n",
> -		udev->descriptor.iManufacturer,
> -		udev->descriptor.iProduct,
> -		udev->descriptor.iSerialNumber);
> +		 "New USB device strings: Mfr=%d, Product=%d, SerialNumber=%d\n",
> +		 udev->descriptor.iManufacturer,
> +		 udev->descriptor.iProduct,
> +		 udev->descriptor.iSerialNumber);

Same here.

Alan Stern
